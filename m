From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 21 May 2018 20:21:58 -0700
Subject: [PATCH 06/14] ARM: spectre-v2: harden branch predictor on context
 switches
In-Reply-To: <E1fKjFD-00063u-Q5@rmk-PC.armlinux.org.uk>
References: <20180521114238.GN17671@n2100.armlinux.org.uk>
 <E1fKjFD-00063u-Q5@rmk-PC.armlinux.org.uk>
Message-ID: <61e24c59-9905-8524-92ba-98cdbadb3011@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/21/2018 04:44 AM, Russell King wrote:
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
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
