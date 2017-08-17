From: sre@kernel.org (Sebastian Reichel)
Date: Thu, 17 Aug 2017 02:08:45 +0200
Subject: [PATCH] nokia n900: update dts with camera support
In-Reply-To: <20170816212343.hfd4azb4dq2qrlkc@valkosipuli.retiisi.org.uk>
References: <20170810204923.GA18442@amd>
 <20170814201950.sbtyuksn3ntuigyp@valkosipuli.retiisi.org.uk>
 <20170815220349.GA15441@amd>
 <20170816205332.rqcuenvuxfs5jvuw@earth>
 <20170816205915.GA5386@atrey.karlin.mff.cuni.cz>
 <20170816212343.hfd4azb4dq2qrlkc@valkosipuli.retiisi.org.uk>
Message-ID: <20170817000845.agkcuvqaheejm33j@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Aug 17, 2017 at 12:23:44AM +0300, Sakari Ailus wrote:
> On Wed, Aug 16, 2017 at 10:59:15PM +0200, Pavel Machek wrote:
> > > On Wed, Aug 16, 2017 at 12:03:49AM +0200, Pavel Machek wrote:
> > > > diff --git a/Documentation/devicetree/bindings/media/video-interfaces.txt b/Documentation/devicetree/bindings/media/video-interfaces.txt
> > > > index 852041a..aade681 100644
> > > > --- a/Documentation/devicetree/bindings/media/video-interfaces.txt
> > > > +++ b/Documentation/devicetree/bindings/media/video-interfaces.txt
> > > > @@ -119,6 +119,8 @@ Optional endpoint properties
> > > >    as 0 (normal). This property is valid for serial busses only.
> > > >  - strobe: Whether the clock signal is used as clock (0) or strobe (1). Used
> > > >    with CCP2, for instance.
> > > > +- clock-inv: polarity of clock/strobe signal. 0 - not inverted, 1 - inverted
> > > > +- crc: crc is in use
> > > 
> > > booleans in DT are not done with <0> and <1>, but as properties without
> > > values. True = property exists, False = property does not exist.
> 
> Now that you mention it, I remember that now.
> 
> > Well, strobe property above already uses = <0>/<1> format, as do
> > others.
>
> > Problem with "false = property does not exist" is that you don't know
> > if it is "someone forgot to define it" or "someone made a typo" or
> > "dts is too old to know about this property" or "the property indeed
> > should be false"...
>
> As this is an established practice, I think we should follow it for bool
> properties.

Yes it's common practice, there is also device_property_read_bool()
to get the value.

> We could change the existing ones, too, and leave some extra checks in
> place to handle old dtbs.

The following should be downward compatible:

var = read_bool();
if (var && !read_int())
    var = false;

Btw. DT people should be CC'd for DT binding additions/changes.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170817/a2106f21/attachment.sig>
