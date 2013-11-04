From: dave.long@linaro.org (David Long)
Date: Mon, 04 Nov 2013 16:25:40 -0500
Subject: [PATCH] uprobes: introduce arch_uprobe->ixol
In-Reply-To: <20131104194901.GA28022@redhat.com>
References: <1381871068-27660-1-git-send-email-dave.long@linaro.org>
 <1381871068-27660-4-git-send-email-dave.long@linaro.org>
 <20131019163627.GA7837@redhat.com> <52671265.2020107@linaro.org>
 <20131029154006.GA22344@redhat.com> <20131104194901.GA28022@redhat.com>
Message-ID: <527810D4.2060109@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/04/13 14:49, Oleg Nesterov wrote:
> On 10/29, Oleg Nesterov wrote:
>>
>> David. Perhaps we can avoid the new hook altogether? What if we do
>> the simple change below (it ignores powerpc) ?
>>
>> Then arm can add "unsigned long ixol[2]" into its arch_uprobe, and
>> arch_uprobe_analyze_insn() can initialize this member correctly.
>>
>> What do you think?
>
> Seriouly, how about the patch below?
>
> In fact, given that you are going to reimplement set_swbp/orig_insn,
> the new member is not strictly needed (afaics). But it looks more
> clear this way, and we need s/MAX_UINSN_BYTES/sizeof()/ anyway.
>
> Oleg.
>


Sorry for the delay, have not quite been successful in getting this to 
work yet.  Hopefully will have better results shortly.

-dl
