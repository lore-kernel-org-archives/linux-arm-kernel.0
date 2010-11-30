From: cyril@ti.com (Cyril Chemparathy)
Date: Tue, 30 Nov 2010 18:56:18 -0500
Subject: Forced HW_BREAKPOINT
Message-ID: <4CF58F22.6070803@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am running an ARM1176JZ-S based SoC, on which HW breakpoints do not
seem to function for some reason.

Unfortunately the current Kconfig forces HW_BREAKPOINT if PERF_EVENTS is
enabled on ARMV6 (commit 19852e59002fbba1c2c6ba0f154095a37ad2ac03):

> +       select HAVE_HW_BREAKPOINT if (PERF_EVENTS && (CPU_V6 || CPU_V7))

As a result, I am unable to use the PMU for OProfile, without having hw
breakpoints barf at boot.  Is there any dependency between h/w
breakpoints and PMU that I am missing?  If not, does H/W breakpoints
have be forced here?

Regards
Cyril.
