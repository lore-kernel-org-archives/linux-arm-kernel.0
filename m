From: oleg@redhat.com (Oleg Nesterov)
Date: Sat, 2 Nov 2013 15:03:39 +0100
Subject: [PATCH v2 05/13] uprobes: add arch write opcode hook
In-Reply-To: <52747280.7040708@linaro.org>
References: <1381871068-27660-1-git-send-email-dave.long@linaro.org>
 <1381871068-27660-6-git-send-email-dave.long@linaro.org>
 <20131019165051.GC7837@redhat.com> <5268137F.3030809@linaro.org>
 <20131028194914.GA15103@redhat.com> <20131029195920.GA4538@redhat.com>
 <52747280.7040708@linaro.org>
Message-ID: <20131102140339.GA17575@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/01, David Long wrote:
>
> On 10/29/13 15:59, Oleg Nesterov wrote:
>>
>> Or. arm can actually reimplement set_swbp(). This doesn't mean the
>> duplication of write_opcode() code, we can simply export this helper.
>>
>
> That actually looks to me like the cleanest approach.  I have changed
> the static write_opcode() to a global uprobe_write_opcode(), and now
> call it from an arm set_swbp().

OK, great.

> Please do *not* make set_swbp() (and set_orig_insn()) static's.  It
> looks like we now have a use for at least one of them.

I am not sure... it still seems to me it makes sense to cleanup this
interface...

But. I am not going to do this until we merge your changes. We will
see then.

Oleg.
