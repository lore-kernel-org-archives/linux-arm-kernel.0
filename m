From: tony@atomide.com (Tony Lindgren)
Date: Tue, 22 May 2018 11:27:34 -0700
Subject: [PATCH 06/14] ARM: spectre-v2: harden branch predictor on
 context switches
In-Reply-To: <E1fKjFD-00063u-Q5@rmk-PC.armlinux.org.uk>
References: <20180521114238.GN17671@n2100.armlinux.org.uk>
 <E1fKjFD-00063u-Q5@rmk-PC.armlinux.org.uk>
Message-ID: <20180522182734.GL98604@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King <rmk+kernel@armlinux.org.uk> [180521 12:06]:
> Harden the branch predictor against Spectre v2 attacks on context
> switches for ARMv7 and later CPUs.  We do this by:
> 
> Cortex A9, A12, A17, A73, A75: invalidating the BTB.
> Cortex A15, Brahma B15: invalidating the instruction cache.
> 
> Cortex A57 and Cortex A72 are not addressed in this patch.
> 
> Cortex R7 and Cortex R8 are also not addressed as we do not enforce
> memory protection on these cores.

Not seeing regressions so:

Tested-by: Tony Lindgren <tony@atomide.com>
