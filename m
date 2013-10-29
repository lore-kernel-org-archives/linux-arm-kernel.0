From: oleg@redhat.com (Oleg Nesterov)
Date: Tue, 29 Oct 2013 20:59:20 +0100
Subject: [PATCH v2 05/13] uprobes: add arch write opcode hook
In-Reply-To: <20131028194914.GA15103@redhat.com>
References: <1381871068-27660-1-git-send-email-dave.long@linaro.org>
 <1381871068-27660-6-git-send-email-dave.long@linaro.org>
 <20131019165051.GC7837@redhat.com> <5268137F.3030809@linaro.org>
 <20131028194914.GA15103@redhat.com>
Message-ID: <20131029195920.GA4538@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/28, Oleg Nesterov wrote:
>
> Yes, yes, sorry for confusion. What I actually tried to suggest is
> something like the trivial patch below.
>
> Then arm can do:
>
> 	uprobe_opcode_t arch_uprobe_swbp_insn(struct arch_uprobe *auprobe)
> 	{
> 		return __opcode_to_mem_arm(auprobe->bpinsn);
> 	}
>
> No?
>
> > I notice there don't seem to be any alternative set_swbp functions
> > in the (rc6) kernel tree
>
> Yes... I think we should simply make it "static". And set_orig_insn()
> too.

Or. arm can actually reimplement set_swbp(). This doesn't mean the
duplication of write_opcode() code, we can simply export this helper.

Either way is imho better than this patch. Unless I missed something.

Oleg.
