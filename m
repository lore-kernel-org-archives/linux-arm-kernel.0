From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 1 Sep 2016 18:12:01 +0200
Subject: [RESEND PATCH 1/3] ARM: dts: Add TOPEET itop core board SCP
 package version
In-Reply-To: <5477278.USWYFxDPfA@amdc1976>
References: <a35686c3-294b-a16a-2b0e-0ef2fd460244@kernel.org>
 <1472648307-3818-1-git-send-email-ayaka@soulik.info>
 <5477278.USWYFxDPfA@amdc1976>
Message-ID: <20160901161201.GA10971@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 01, 2016 at 03:03:51PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> On Wednesday, August 31, 2016 08:58:27 PM Randy Li wrote:
> > The TOPEET itop is a samsung exnynos 4412 core board, which have
> > two package versions. This patch add the support for SCP version.
> > 
> > Currently supported are USB3503A HSIC, USB OTG, eMMC, rtc and
> > PMIC. The future features are in the based board. Also MFC and
> > watchdog have been enabled.
> > 
> > Signed-off-by: Randy Li <ayaka@soulik.info>
> > ---
> >  arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi | 490 ++++++++++++++++++++++++
> >  1 file changed, 490 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
> 
> [...]
> 
> > +		s5m8767_osc: clocks {
> 
> Don't you also need:
> 
> 			compatible = "samsung,s5m8767-clk";
> 
> here?

No specific need... It is confusing but it is the same as with
regulators. The parent MFD driver creates children devices and match
drivers. The children (e.g. clk or regulator driver) look for hard-coded
subnode - clocks/regulators.

The compatible is actually not used in current form.

> BTW Does anyone know why there are no users of
> "samsung,s2mps11-clk" compatible in the tree
> (commit 53c31b3437a6400c6ffc2c9315680217ad84cb6d
> "mfd: sec-core: Add of_compatible strings for
> clock MFD cells" added it in March 2014)?

That is partially my fault. I got convinced by Lee Jones to add
compatibles even there are no users of them. The compatibles could be
added - for Arndale Octa and XU3/XU4. I think the only benefit of that
would be attaching the clock driver to the of_node.

Best regards,
Krzysztof
