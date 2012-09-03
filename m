From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 03 Sep 2012 08:56:35 +0200
Subject: [PATCH 1/2] ARM: Kirkwood: ehci-orion: Add device tree binding
In-Reply-To: <1346491586-23480-1-git-send-email-andrew@lunn.ch>
References: <1346491586-23480-1-git-send-email-andrew@lunn.ch>
Message-ID: <504454A3.1090702@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/01/2012 11:26 AM, Andrew Lunn wrote:
> Based on previous work by Michael Walle and Jason Cooper.
>
> Made their work actually work, which required added interrupt from DT
> and auxdata, along with setting the dma_mask, which DT does not
> currently do.

Andrew,

you can add a

Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

for DT-enabled Dove on both ehci controllers.

One thing iI stumbled upon is that drivers/usb/Kconfig is missing
PLAT_ORION for USB_ARCH_HAS_EHCI. I think it just worked until now
because there is also PCI in this config option. IIRC it can be
disabled now and therefore there should be an entry for PLAT_ORION.

Sebastian
