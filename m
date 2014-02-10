From: nm@ti.com (Nishanth Menon)
Date: Mon, 10 Feb 2014 13:50:22 -0600
Subject: [PATCH] ARM: dts: OMAP2+: Fix boot with multi_v7_defconfig
In-Reply-To: <1392055835-6494-1-git-send-email-rogerq@ti.com>
References: <1392055835-6494-1-git-send-email-rogerq@ti.com>
Message-ID: <52F92D7E.9030304@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

$subject probably needs clarity.
On 02/10/2014 12:10 PM, Roger Quadros wrote:
> The OMAP EHCI controller is not compatible with the EHCI
> platform HCD driver so don't claim that we are.

might want to refer to the change in drivers/usb/host/ehci-platform.c
that created this regression as well.

we also probably want to make better explanation about this issue and
why we think this is the correct fix for it - for example, question
Kevin asked in [1]
> 
> This fixes boot on OMAP platforms with CONFIG_USB_EHCI_HCD_PLATFORM=y
> e.g. multi_v7_defconfig
> 
> Reported-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---

[1] http://marc.info/?t=139204803900004&r=1&w=2

-- 
Regards,
Nishanth Menon
