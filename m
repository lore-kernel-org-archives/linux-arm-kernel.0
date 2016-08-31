From: robh@kernel.org (Rob Herring)
Date: Wed, 31 Aug 2016 10:26:25 -0500
Subject: [PATCH 6/8] arm: orion5x: Add DT-based support for Netgear WNR854T
In-Reply-To: <1472203264-21089-7-git-send-email-jm@lentin.co.uk>
References: <1468679348-10522-1-git-send-email-jm@lentin.co.uk>
 <1472203264-21089-1-git-send-email-jm@lentin.co.uk>
 <1472203264-21089-7-git-send-email-jm@lentin.co.uk>
Message-ID: <20160831152625.GA25415@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 26, 2016 at 10:21:02AM +0100, Jamie Lentin wrote:
> This is a router based on the mv88f5181 chipset.
> 
> http://www.netgear.com/support/product/WNR854T.aspx
> http://wiki.openwrt.org/toh/netgear/wnr854t
> 
> Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
> ---
>  .../bindings/arm/marvell/marvell,orion5x.txt       |   1 +
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/orion5x-netgear-wnr854t.dts      | 212 +++++++++++++++++++++

For the bindings,

Acked-by: Rob Herring <robh@kernel.org>

>  arch/arm/mach-orion5x/Kconfig                      |   6 +
>  arch/arm/mach-orion5x/Makefile                     |   1 +
>  arch/arm/mach-orion5x/board-wnr854t.c              |  78 ++++++++

This is all PCI setup it appears. The PCI driver should be converted to 
a modern PCI host driver before it is supported with DT IMO.

Rob
