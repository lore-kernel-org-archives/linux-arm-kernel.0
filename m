From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 16 May 2018 09:33:18 -0700
Subject: [PATCH 07/14] ARM: spectre-v2: add Cortex A8 and A15 validation
 of the IBE bit
In-Reply-To: <E1fIuBF-0003q0-3d@rmk-PC.armlinux.org.uk>
References: <20180516105949.GJ16141@n2100.armlinux.org.uk>
 <E1fIuBF-0003q0-3d@rmk-PC.armlinux.org.uk>
Message-ID: <a3ea8562-40b1-88b8-8bba-f6de8f9ac8cb@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/16/2018 04:01 AM, Russell King wrote:
> When the branch predictor hardening is enabled, firmware must have set
> the IBE bit in the auxiliary control register.  If this bit has not
> been set, the Spectre workarounds will not be functional.
> 
> Add validation that this bit is set, and print a warning at alert level
> if this is not the case.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

I would be keen on updating arch/arm/kernel/head.S to to attempt setting
ACTRL[0]=1 on A15/B15, if the kernel executes at the appropriate
privilege level, this will succeed, if not, this should result in an
ignored write. What do you think?
-- 
Florian
