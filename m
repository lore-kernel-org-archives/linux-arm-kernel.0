From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 20 Mar 2015 21:53:32 +0100
Subject: [PATCH RFC 2/3] ARM: sun7i: Add A20 SRAM and SRAM controller
In-Reply-To: <5509CE0D.7000904@redhat.com>
References: <1426166024-24922-1-git-send-email-maxime.ripard@free-electrons.com>
 <1426166024-24922-3-git-send-email-maxime.ripard@free-electrons.com>
 <5509CE0D.7000904@redhat.com>
Message-ID: <20150320205332.GI4255@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 18, 2015 at 08:12:13PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 12-03-15 14:13, Maxime Ripard wrote:
> >The A20 has a few SRAM that can be mapped either to a device or to the CPU,
> >with the mapping being controlled by an SRAM controller.
> >
> >Since most of the time these SRAM won't be accessible by the CPU, we can't use
> >the mmio-sram driver and compatible.
> >
> >Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> >---
> >  arch/arm/boot/dts/sun7i-a20.dtsi | 31 ++++++++++++++++++++++++++++++-
> >  1 file changed, 30 insertions(+), 1 deletion(-)
> >
> >diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> >index a1ebd80e6f24..a249828a1df5 100644
> >--- a/arch/arm/boot/dts/sun7i-a20.dtsi
> >+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> >@@ -522,12 +522,41 @@
> >  		};
> >  	};
> >
> >-	soc at 01c00000 {
> >+	soc {
> 
> Please do not do this, this changes devicetree paths used by
> u-boot, see:
> 
> http://git.denx.de/?p=u-boot.git;a=blob;f=include/configs/sunxi-common.h#l232

Ah, I didn't think about that. That's unfortunate, since the SRAM
start lower than this address, but I guess we'll have to live with
that :)

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150320/499ed5f9/attachment.sig>
