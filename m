From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 14 Sep 2013 14:30:45 +0200
Subject: [PATCH 3/3] arm: dts: socfpga: Add support for SD/MMC
In-Reply-To: <522E398F.3080100@wwwdotorg.org>
References: <1378740833-4883-1-git-send-email-dinguyen@altera.com>
 <1378740833-4883-4-git-send-email-dinguyen@altera.com>
 <522E398F.3080100@wwwdotorg.org>
Message-ID: <1963011.uUY4o6LRbA@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 09 of September 2013 15:11:43 Stephen Warren wrote:
> On 09/09/2013 09:33 AM, dinguyen at altera.com wrote:
> > From: Dinh Nguyen <dinguyen@altera.com>
> > 
> > Add bindings for SD/MMC for SOCFPGA.
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
> > b/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
> > 
> > +* Altera SOCFPGA specific extensions to the Synopsis Designware
> > Mobile
> > +  Storage Host Controller
> > +
> > +The Synopsis designware mobile storage host controller is used to
> > interface +a SoC with storage medium such as eMMC or SD/MMC cards.
> > This file documents +differences between the core Synopsis dw mshc
> > controller properties described +by synopsis-dw-mshc.txt and the
> > properties used by the SOCFPGA specific +extensions to the Synopsis
> > Designware Mobile Storage Host Controller. +
> > +Required Properties:
> > +
> > +* compatible: should be
> > +        - "altr,socfpga-dw-mshc": for controllers with Altera SOCFPGA
> > +          specific extensions.
> > +
> > +* samsung,dw-mshc-sdr-timing: See exynos-dw-mshc.txt for more
> > information about +	this binding.
> 
> s/binding/property/
> 
> It's odd that this isn't "synopsis," rather than "samsung," if the
> property is generic across all/some uses of the Synopsis core. But, I
> guess this is fine.

Just as a side note, correct name is Synopsys, not Synopsis. There are
multiple places around Documentation/devicetree where this typo is
present[1]. Should we consider correcting this or the typo will have
to stay?

[1] git grep -i synopsis Documentation/devicetree/
Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt:* Samsung Exynos specific extensions to the Synopsis Designware Mobile
Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt:The Synopsis designware mobile storage host controller is used to interface
Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt:differences between the core Synopsis dw mshc controller properties described
Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt:by synopsis-dw-mshc.txt and the properties used by the Samsung Exynos specific
Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt:extensions to the Synopsis Designware Mobile Storage Host Controller.
Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt:* Rockchip specific extensions to the Synopsis Designware Mobile
Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt:The Synopsis designware mobile storage host controller is used to interface
Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt:differences between the core Synopsis dw mshc controller properties described
Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt:by synopsis-dw-mshc.txt and the properties used by the Rockchip specific
Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt:extensions to the Synopsis Designware Mobile Storage Host Controller.
Documentation/devicetree/bindings/mmc/synopsis-dw-mshc.txt:* Synopsis Designware Mobile Storage Host Controller
Documentation/devicetree/bindings/mmc/synopsis-dw-mshc.txt:The Synopsis designware mobile storage host controller is used to interface
Documentation/devicetree/bindings/mmc/synopsis-dw-mshc.txt:properties used by the Synopsis Designware Mobile Storage Host Controller.
Documentation/devicetree/bindings/mmc/synopsis-dw-mshc.txt:     - snps,dw-mshc: for controllers compliant with synopsis dw-mshc.
Documentation/devicetree/bindings/pci/designware-pcie.txt:* Synopsis Designware PCIe interface

Best regards,
Tomasz
