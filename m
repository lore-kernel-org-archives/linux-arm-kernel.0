From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 16 May 2018 09:35:07 -0700
Subject: [PATCH 08/14] ARM: spectre-v2: harden user aborts in kernel space
In-Reply-To: <E1fIuBK-0003q7-9n@rmk-PC.armlinux.org.uk>
References: <20180516105949.GJ16141@n2100.armlinux.org.uk>
 <E1fIuBK-0003q7-9n@rmk-PC.armlinux.org.uk>
Message-ID: <cdcde1ef-afa0-cf7c-b680-829b54b03042@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/16/2018 04:01 AM, Russell King wrote:
> In order to prevent aliasing attacks on the branch predictor,
> invalidate the BTB or instruction cache on CPUs that are known to be
> affected when taking an abort on a address that is outside of a user
> task limit:
> 
> Cortex A8, A9, A12, A17, A73, A75: flush BTB.
> Cortex A15, Brahma B15: invalidate icache.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
