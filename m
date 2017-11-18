From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sat, 18 Nov 2017 08:20:47 +0000
Subject: [PATCH 2/3 v2] Input: twl4030_keypad: Fix platform_get_irq's
 error checking
In-Reply-To: <d5ca46d63a41f47411b94c6035d3b8c46bbe8503.1510951446.git.arvind.yadav.cs@gmail.com>
References: <f317ec56b23b11b79284c29d12a7004575aa35db.1510951446.git.arvind.yadav.cs@gmail.com>
 <d5ca46d63a41f47411b94c6035d3b8c46bbe8503.1510951446.git.arvind.yadav.cs@gmail.com>
Message-ID: <20171118082047.GZ31757@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 18, 2017 at 02:28:49AM +0530, Arvind Yadav wrote:
> The platform_get_irq() function returns negative if an error occurs.
> zero or positive number on success. platform_get_irq() error checking
> for zero is not correct.

IRQ 0 is not a valid interrupt.  The correct test here is <= 0.
Please rework your patches for this.

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync@8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
