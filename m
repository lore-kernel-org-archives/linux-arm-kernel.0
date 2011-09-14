From: siarhei.siamashka@gmail.com (Siarhei Siamashka)
Date: Wed, 14 Sep 2011 10:43:56 +0300
Subject: [PATCH] ARM: EXYNOS4: Enable double linefill in PL310 Prefetch
	Control Register
In-Reply-To: <CAH9JG2VFSwL7hCmGpHXx_UKKwK3dbhNRGQB1bwvcD-YC1Qj-AQ@mail.gmail.com>
References: <1315894031-9579-1-git-send-email-siarhei.siamashka@gmail.com>
	<CAH9JG2VFSwL7hCmGpHXx_UKKwK3dbhNRGQB1bwvcD-YC1Qj-AQ@mail.gmail.com>
Message-ID: <CACY+gR2TX35XaVLiN7s_PkY4r=G1i3LMhHzSJJiaAOSoYDGwfg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 14, 2011 at 9:08 AM, Kyungmin Park <kmpark@infradead.org> wrote:
> Hi Siarhei,
>
> Interesting feature, and it's not samsung soc issue, so add the arm
> mailing list.
> It checked and the see the read performance improvement from 868MiB/s
> to 981MiB/s with lmbench.

Maybe lmbench does not try very hard to get the best out of the
hardware? On my origenboard, I'm getting ~1.15GB/s performance for the
standard LDM/STM based memcpy from libc-ports, which is ~2.3GB/s
memory bandwidth if both reads and writes are accounted separately.

> It's helpful to test other SoC., e.g., OMAP4, STE and so on.

The current (?) state of the support for this feature in OMAP4 is
explained here by Richard Woodruff:
    http://groups.google.com/group/pandaboard/msg/dfd2d2e1336d435b

> BTW, why do you set the 27-bit? In my PL310 Spec., it's reserved bit
> and should be zero (SBZ).

This PL310 thing seems to have been renamed to "CoreLink Level 2 Cache
Controller L2C-310" in later revisions, and its Prefetch Control
Register is described here:
    http://infocenter.arm.com/help/topic/com.arm.doc.ddi0246f/CHDHIECI.html

Sorry for the confusing subject.

Regarding bit 27 ('Double linefill on WRAP read disable'), it seems to
reduce the impact of enabling double linefill on the random access
latency as measured by my self-written simple memory benchmark
program:
    http://github.com/downloads/ssvb/ssvb-membench/ssvb-membench-0.1.tar.gz

-- 
Best regards,
Siarhei Siamashka
