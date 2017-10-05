From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 5 Oct 2017 15:59:48 +0100
Subject: undefined instruction d5380001 (arm64 mrs emulation)
In-Reply-To: <fb13bcdf-c97b-40c6-3815-30dce26bca8e@suse.com>
References: <CAJs94EZqdWJRTF+tLgGU=pcRoU5HvuV959Qq8nFB5yQ-sQyxzg@mail.gmail.com>
 <20171002112433.GM3611@e103592.cambridge.arm.com>
 <59D24906.4060104@arm.com>
 <20171002155638.GA18543@e107814-lin.cambridge.arm.com>
 <CAJs94EbvM6U5qQyAGGY7BEppC=dPo_LPzU4STDNU7muCZvLXmw@mail.gmail.com>
 <fb13bcdf-c97b-40c6-3815-30dce26bca8e@suse.com>
Message-ID: <20171005145948.GE5235@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias,

On Thu, Oct 05, 2017 at 04:54:09PM +0200, Matthias Brugger wrote:
> On 10/04/2017 11:11 AM, Matwey V. Kornilov wrote:
> >The patch helps to overcome the issue, Probably it should be applied
> >to all stable releases affected by this behaviour.
> >modprobe in initrd may load quite required things.
> >
> >2017-10-02 18:56 GMT+03:00 Suzuki K Poulose <Suzuki.Poulose@arm.com>:
> >>arm64: Enable MRS emulation early enough in the boot sequence
> >>
> >>Make sure the MRS emulation is enabled early enough that the
> >>early userspace applications (e.g, those run from initrd) could
> >>run without any trouble.
> >>
> >>Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> >>
> >>diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> >>index 9f9e0064c8c1..048f5469531f 100644
> >>--- a/arch/arm64/kernel/cpufeature.c
> >>+++ b/arch/arm64/kernel/cpufeature.c
> >>@@ -1294,4 +1294,4 @@ static int __init enable_mrs_emulation(void)
> >>         return 0;
> >>  }
> >>
> >>-late_initcall(enable_mrs_emulation);
> >>+arch_initcall(enable_mrs_emulation);
> >>---
> >>
> >>
> 
> I realized this patch did not land in v4.13.5
> Did it got forgotten or are there any concerns?

This patch wasn't a complete fix, and the issue is still being discussed
at:

http://lists.infradead.org/pipermail/linux-arm-kernel/2017-October/534396.html

Thanks,
Mark.
