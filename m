From: sre@kernel.org (Sebastian Reichel)
Date: Fri, 22 Apr 2016 15:16:26 +0200
Subject: [PATCH] ARM: dts: omap3: Fix ISP syscon register offset
In-Reply-To: <5719A9E3.1000902@gmail.com>
References: <1460787628-17316-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <5719A9E3.1000902@gmail.com>
Message-ID: <20160422131626.GA7534@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Apr 22, 2016 at 07:34:43AM +0300, Ivaylo Dimitrov wrote:
> On 16.04.2016 09:20, Ivaylo Dimitrov wrote:
> >According to the TRM, SCM CONTROL_CSIRXFE register is on offset 0x6c
> >
> >Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> >---
> >  arch/arm/boot/dts/omap34xx.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/arch/arm/boot/dts/omap34xx.dtsi b/arch/arm/boot/dts/omap34xx.dtsi
> >index 5cdba1f..e446562 100644
> >--- a/arch/arm/boot/dts/omap34xx.dtsi
> >+++ b/arch/arm/boot/dts/omap34xx.dtsi
> >@@ -46,7 +46,7 @@
> >  			       0x480bd800 0x017c>;
> >  			interrupts = <24>;
> >  			iommus = <&mmu_isp>;
> >-			syscon = <&scm_conf 0xdc>;
> >+			syscon = <&scm_conf 0x6c>;
> >  			ti,phy-type = <OMAP3ISP_PHY_TYPE_COMPLEX_IO>;
> >  			#clock-cells = <1>;
> >  			ports {
> >

You may want to add the hint, that 0xdc (the old, wrong "offset")
represents the last few bits of the register address. I guess
somebody didn't notice, that scm_conf does not start at a register
address ending with 00 (like most other modules).

Reviewed-By: Sebastian Reichel <sre@kernel.org>

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160422/c05cb73e/attachment.sig>
