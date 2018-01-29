From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 30 Jan 2018 00:33:01 +0100
Subject: [PATCH] sound/tlv320dac33: Add device tree support
In-Reply-To: <20180129232031.GA7695@lenoch>
References: <20180129230539.GA18280@amd>
 <20180129232031.GA7695@lenoch>
Message-ID: <20180129233301.GA18104@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2018-01-30 00:20:31, Ladislav Michl wrote:
> On Tue, Jan 30, 2018 at 12:05:39AM +0100, Pavel Machek wrote:
> > 
> > This adds device tree support to tlv320dac33.c.
> > 
> > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/tlv320dac33.txt b/Documentation/devicetree/bindings/sound/tlv320dac33.txt
> > new file mode 100644
> > index 0000000..6cbd311
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/tlv320dac33.txt
> > @@ -0,0 +1,32 @@
> > +Texas Instruments - tlv320dac33 Codec module
> > +
> > +The tlv320dac33 serial control bus communicates through I2C protocols.
> > +
> > +Required properties:
> > +
> > +- compatible - "ti,tlv320dac33"
> > +- reg - I2C slave address
> > +
> > +Optional properties:
> > +
> > +- power-gpios - gpio pin to power the device, active high
> 
> While driver used gpio in platform data, isn't it more likely
> regulator which powers device?

                power-gpios = <&gpio2 28 0>; /* gpio_60 */

Looks like GPIO to me -- example is from Nokia N9. So this appears to
be correct.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180130/a8d14f82/attachment.sig>
