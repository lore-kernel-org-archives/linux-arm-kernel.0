From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 12 Mar 2015 10:39:06 +0000
Subject: [PATCH v5 1/9] arm64: dts: exynos: Add dts files for 64-bit
 Exynos5433 SoC
In-Reply-To: <54FE4957.7050904@samsung.com>
References: <1425533911-14800-2-git-send-email-cw00.choi@samsung.com>
 <20150305122459.GC14093@leverpostej>
 <CAGTfZH3Bf1ueFO25NXFbN+Mvb9TcGbErbSp=a+vQ0=A+E07mQA@mail.gmail.com>
 <20150305170450.GG14093@leverpostej>
 <CAGTfZH3nkCvnuu+fC1Gv5DrRQXEg6Y19tQnh+phj6c_jAFpbvg@mail.gmail.com>
 <20150305185407.GK14093@leverpostej> <54F9140B.3060109@samsung.com>
 <20150306114021.GF8700@leverpostej> <54F99B1A.3080600@samsung.com>
 <54FE4957.7050904@samsung.com>
Message-ID: <20150312103906.GB30145@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

> >>>> Do CPUs enter the kernel at EL2 or at EL1?
> >>>
> >>> Could you give me a tip how to check the kernel at EL2 or EL1?
> >>
> >> Hmm... I thought we logged this but it looks like we don't.
> >>
> >> You could hack in a check of is_hyp_mode_available() and
> >> is_hyp_mode_mismatched(). That will tell you if EL2/hyp is available,
> >> and whether all CPUs enter at the same mode (mandatory per the boot
> >> protocol).
> > 
> > OK, I'll try it.
> 
> I check the return value of is_hyp_mode_available() to catch whether EL1 or EL2. 
> 
> The is_hyp_mode_available() returns 'false' during kernel booting.
> - __boot_cpu_mode[0]: 0xe11 (BOOT_CPU_MODE_EL1)
> - __boot_cpu_mode[1]: 0x0

Thanks for taking a look.

It's unfortunate that CPUs aren't booted at EL2 (especially given that
booting them at EL1N means the FW is doing more work to be less helpful
to the OS), but at least they seem to be booted in consistent modes.

Thanks,
Mark.
