From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 22 Aug 2016 09:54:54 +0200
Subject: [PATCH v2 5/5] ARM: dts: sunxi: Use new sun7i-a20-mmc compatible
 on sun7i and newer
In-Reply-To: <9b6ed836-27ff-c8c8-d886-d86c787605fc@arm.com>
References: <1469888748-26085-1-git-send-email-hdegoede@redhat.com>
 <1469888748-26085-6-git-send-email-hdegoede@redhat.com>
 <9b6ed836-27ff-c8c8-d886-d86c787605fc@arm.com>
Message-ID: <20160822075454.GB7104@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 01, 2016 at 02:11:09PM +0100, Andre Przywara wrote:
> Hi Hans,
> 
> On 30/07/16 15:25, Hans de Goede wrote:
> > Use the new sun7i-a20-mmc compatible for the mmc controllers on sun7i
> > and newer.
> > 
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > ---
> > Changes in v2:
> > -New patch in v2 of this patch-set
> > ---
> >  arch/arm/boot/dts/sun6i-a31.dtsi     | 8 ++++----
> >  arch/arm/boot/dts/sun7i-a20.dtsi     | 8 ++++----
> >  arch/arm/boot/dts/sun8i-a23-a33.dtsi | 6 +++---
> >  arch/arm/boot/dts/sun8i-h3.dtsi      | 6 +++---
> >  4 files changed, 14 insertions(+), 14 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
> > index 1867af2..0d24f10 100644
> > --- a/arch/arm/boot/dts/sun6i-a31.dtsi
> > +++ b/arch/arm/boot/dts/sun6i-a31.dtsi
> > @@ -469,7 +469,7 @@
> >  		};
> >  
> >  		mmc0: mmc at 01c0f000 {
> > -			compatible = "allwinner,sun5i-a13-mmc";
> > +			compatible = "allwinner,sun7i-a20-mmc";
> 
> But that breaks systems with newer DTs on older kernels, which do not
> know about sun7i-a20-mmc.

That's not backward compatibility. That's the forward one, and that
has never been something we supported.

See https://www.kernel.org/doc/Documentation/devicetree/bindings/ABI.txt

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160822/a799407f/attachment.sig>
