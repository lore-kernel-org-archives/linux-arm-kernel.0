From: punit.agrawal@arm.com (Punit Agrawal)
Date: Wed, 01 Feb 2017 17:02:43 +0000
Subject: [PATCH v4 3/4] arm64: Use __tlbi() macros in KVM code
In-Reply-To: <20170127135306.GK21144@arm.com> (Will Deacon's message of "Fri,
 27 Jan 2017 13:53:07 +0000")
References: <20170125155232.10277-1-cov@codeaurora.org>
 <20170125155232.10277-3-cov@codeaurora.org>
 <20170125193943.GW15850@cbox> <20170127135306.GK21144@arm.com>
Message-ID: <87lgtprgi4.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will Deacon <will.deacon@arm.com> writes:

> On Wed, Jan 25, 2017 at 08:39:43PM +0100, Christoffer Dall wrote:
>> On Wed, Jan 25, 2017 at 10:52:31AM -0500, Christopher Covington wrote:
>> > Refactor the KVM code to use the __tlbi macros, which will allow an errata
>> > workaround that repeats tlbi dsb sequences to only change one location.
>> > This is not intended to change the generated assembly and comparing before
>> > and after vmlinux objdump shows no functional changes.
>> > 
>> > Signed-off-by: Christopher Covington <cov@codeaurora.org>
>> 
>> Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
>
> Thanks, I'll queue this one via arm64.

I just noticed this patch but there's been a similar patch from Mark
that I've been carrying as part of the KVM TLB monitoring series[0].

[0] http://www.mail-archive.com/kvmarm at lists.cs.columbia.edu/msg09359.html

>
> Will
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
