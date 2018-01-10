From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 10 Jan 2018 12:31:02 +0100
Subject: [PATCH] dt-bindings: Nokia N9 audio support
In-Reply-To: <20180110093930.wq5darjgtuugc6ad@paasikivi.fi.intel.com>
References: <20171227091828.GA3307@amd>
 <20171227180000.6ejpbqmr736nqx5i@kekkonen.localdomain>
 <20171227200147.GB16799@amd>
 <20171227211643.nnwtm4j6cyftlm66@kekkonen.localdomain>
 <20180102124450.GA18659@amd>
 <20180105160137.nr7oqvpbp2oao5fm@rob-hp-laptop>
 <20180108222054.GA17452@amd> <20180110085315.GA17841@amd>
 <20180110093930.wq5darjgtuugc6ad@paasikivi.fi.intel.com>
Message-ID: <20180110113102.GA26812@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> On Wed, Jan 10, 2018 at 09:53:15AM +0100, Pavel Machek wrote:
> > From: Filip Matijevi? <filip.matijevic.pz@gmail.com>
> > 
> > Add bindings for Nokia N9 audio components.
> > 
> > Signed-off-by: Filip Matijevi? <filip.matijevic.pz@gmail.com>
> > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> > 
> > diff --git a/Documentation/devicetree/bindings/media/ti-wl1273.txt b/Documentation/devicetree/bindings/media/ti-wl1273.txt
> > new file mode 100644
> > index 0000000..21db389
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/ti-wl1273.txt
> > @@ -0,0 +1,36 @@
> > +Texas Instruments - wl1273 radio/bluetooth module
> > +
> > +Required properties:
> > +
> > +- compatible - "ti,wl1273-core"
> > +- reg - I2C slave address
> > +- interrupts       - The interrupt output from the device.
> > +- interrupt-parent - The parent interrupt controller.
> > +- power-gpio       - gpio pin to power the device.
> > +
> > +- wl1273radio child - compatible = "ti,wl1273-fm-radio";
> 
> I'd document this under a separate section, as the compatible property for
> the other child node.
> 
> You use "property - description" here but "property: description" in the
> file below. It'd be nice to be consistent, albeit it's separate
> files.

Heh. If we want to do consistency, it should be consistent in whole
documentation. I looked at cec-gpio.txt and it uses both
styles. Sampled few more files, and seems ":" is more common here.

> > +
> > +Optional properties:
> > +
> > +- wl1273codec child - compatible = "ti,wl1273codec";
> 
> "ti,wl1273-codec"

Ok.

> > diff --git a/Documentation/devicetree/bindings/sound/nokia,n9.txt b/Documentation/devicetree/bindings/sound/nokia,n9.txt
> > new file mode 100644
> > index 0000000..230b1eb
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/nokia,n9.txt
> > @@ -0,0 +1,32 @@
> > +* Nokia N9/N950 audio setup
> > +
> 
> A small description saying what this really is would be nice.

I'm actually not sure what to say here. Suggestions?

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180110/534a2a80/attachment.sig>
