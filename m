From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Mar 2016 15:07:01 +0200
Subject: [PATCH v3 00/18] Add Initial support for PLX Technology OX810SE
In-Reply-To: <1458838215-23314-1-git-send-email-narmstrong@baylibre.com>
References: <1458838215-23314-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <3251151.7G7VuWMkWK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 24 March 2016 17:49:57 Neil Armstrong wrote:
> This serie adds initial support (IRQ, Timer, GPIO, Reset, Serial, Clocks) for
> the PLX Technology OX810SE used in the well-known Western Digital My Book
> World Edition Network Attached Storage device.
> 
> Extended support for SATA, DMA and Ethernet will come in further patches.
> 
> Upstream support for following devices like the OX820SE is welcome !
> 

Looks good to me overall. When you have addressed the remaining comments,
please send a pull request for the parts that should go into arm-soc
to arm at kernel.org, and address any future issues with add-on patches.

Anything that has significant driver changes (pinctrl, clk, clocksource)
including the respective DT binding changes should go through the subsystem
maintainer trees.

The one-line irqchip change can stay with the mach-oxnas/Kconfig change
in one pull request, and the dt-binding and dts changes should be in
a separate pull request, so we can group them into our next/* branches
accordingly.

Please also add a patch for the MAINTAINERS file to list yourself as the
maintainer, this one again can go into the same pull request as the 
mach-oxnas patch.

	Arnd
