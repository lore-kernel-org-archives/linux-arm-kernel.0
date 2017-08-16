From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 16 Aug 2017 22:59:15 +0200
Subject: [PATCH] nokia n900: update dts with camera support
In-Reply-To: <20170816205332.rqcuenvuxfs5jvuw@earth>
References: <20170810204923.GA18442@amd>
 <20170814201950.sbtyuksn3ntuigyp@valkosipuli.retiisi.org.uk>
 <20170815220349.GA15441@amd>
 <20170816205332.rqcuenvuxfs5jvuw@earth>
Message-ID: <20170816205915.GA5386@atrey.karlin.mff.cuni.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Hi,
> 
> On Wed, Aug 16, 2017 at 12:03:49AM +0200, Pavel Machek wrote:
> > diff --git a/Documentation/devicetree/bindings/media/video-interfaces.txt b/Documentation/devicetree/bindings/media/video-interfaces.txt
> > index 852041a..aade681 100644
> > --- a/Documentation/devicetree/bindings/media/video-interfaces.txt
> > +++ b/Documentation/devicetree/bindings/media/video-interfaces.txt
> > @@ -119,6 +119,8 @@ Optional endpoint properties
> >    as 0 (normal). This property is valid for serial busses only.
> >  - strobe: Whether the clock signal is used as clock (0) or strobe (1). Used
> >    with CCP2, for instance.
> > +- clock-inv: polarity of clock/strobe signal. 0 - not inverted, 1 - inverted
> > +- crc: crc is in use
> 
> booleans in DT are not done with <0> and <1>, but as properties without
> values. True = property exists, False = property does not exist.

Well, strobe property above already uses = <0>/<1> format, as do
others.

Problem with "false = property does not exist" is that you don't know
if it is "someone forgot to define it" or "someone made a typo" or
"dts is too old to know about this property" or "the property indeed
should be false"...
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
