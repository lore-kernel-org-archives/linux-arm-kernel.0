From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 2 Jan 2017 16:31:08 +0530
Subject: [PATCH v7 2/2] ARM: davinci: da8xx: Fix sleeping function called
 from invalid context
In-Reply-To: <1481302773-14181-2-git-send-email-abailon@baylibre.com>
References: <1481302773-14181-1-git-send-email-abailon@baylibre.com>
 <1481302773-14181-2-git-send-email-abailon@baylibre.com>
Message-ID: <2d523f79-e910-fe13-c4cd-1748b499095f@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 09 December 2016 10:29 PM, Alexandre Bailon wrote:
> Everytime the usb20 phy is enabled, there is a
> "sleeping function called from invalid context" BUG.
> In addition, there is a recursive locking happening
> because of the recurse call to clk_enable().
> 
> clk_enable() from arch/arm/mach-davinci/clock.c uses spin_lock_irqsave()
> before to invoke the callback usb20_phy_clk_enable().
> usb20_phy_clk_enable() uses clk_get() and clk_enable_prepapre()
> which may sleep.
> replace clk_prepare_enable() by davinci_clk_enable().
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> Suggested-by: David Lechner <david@lechnology.com>

Applied to 'fixes' branch.

Thanks,
Sekhar
