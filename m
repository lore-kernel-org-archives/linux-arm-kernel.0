From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 04 Jan 2014 22:47:08 +0100
Subject: [PATCH v2 2/4] ARM: sunxi: Add ahci-sunxi driver for the
 Allwinner SUNXi SoCs sata
In-Reply-To: <4502242.kKUgLAVDcb@wuerfel>
References: <1388826878-5602-1-git-send-email-hdegoede@redhat.com>
 <1388826878-5602-3-git-send-email-hdegoede@redhat.com>
 <4502242.kKUgLAVDcb@wuerfel>
Message-ID: <3250214.yUrU0CPosZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 04 January 2014 22:39:50 Arnd Bergmann wrote:
> > +Required properties:
> > +- compatible : compatible list, contains "allwinner,sun4i-a10-ahci"
> > +- reg                : <registers mapping>
> > +- interrupts : <interrupt mapping for AHCI IRQ>
> > +- clocks     : clocks for ACHI
> > +- clock-names        : clock names for AHCI
> 
> The binding needs to specify the required names for the clocks.

fwiw, the imx driver uses "ahb" and "sata_ref" as the clock names.
I would strongly suggest using the same names here, and documenting
them in the ahci binding as optional.

	Arnd
