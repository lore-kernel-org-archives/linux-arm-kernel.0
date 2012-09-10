From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Mon, 10 Sep 2012 10:54:04 +0200 (CEST)
Subject: [Workshop-2011] Notes from the KS/2012 Media Workshop - part1
In-Reply-To: <50475E46.3020702@redhat.com>
References: <5040C7E7.9040107@redhat.com>
 <201209031329.42150.hverkuil@xs4all.nl>
 <5044E9A6.3060800@redhat.com> <201209032350.53687.hverkuil@xs4all.nl>
 <Pine.LNX.4.64.1209051304231.16676@axis700.grange>
 <50475E46.3020702@redhat.com>
Message-ID: <Pine.LNX.4.64.1209100938480.26171@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(Arnd: sorry for not cc-ing you on v5 of our with Sylwester V4L2 DT RFC. 
An archive link is below, I'm also CCing ALKML in this mail, as you 
requested. You might actually also have the RFC in your mail archives from 
the devicetree-discuss list)

On Wed, 5 Sep 2012, Mauro Carvalho Chehab wrote:

> Em 05-09-2012 08:50, Guennadi Liakhovetski escreveu:
> > On Mon, 3 Sep 2012, Hans Verkuil wrote:
> > 
> >> On Mon September 3 2012 19:32:22 Mauro Carvalho Chehab wrote:

[snip]

> >>> While not officially at the workshop's agenda, it would be valuable if you could add the
> >>> DT x V4L2 notes also there (sorry, at the end, I couldn't went there - got busy with some
> >>> other unrelated stuff).
> >>
> >> It would be best if Guennadi would do that: I was too unfamiliar with DT to
> >> give a good report of that meeting. Guennadi made some notes of the meeting
> >> as well.
> > 
> > Is this my recent post of v5 of the RFC
> > 
> > http://www.mail-archive.com/linux-media at vger.kernel.org/msg51420.html
> > 
> > sufficient or would you like me to prepare a text, suitable for direct 
> > inclusion in the workshop notes?
> 
> It would be nice to have a text for inclusion at workshop notes. It can point to the
> RFC proposal in order to provide more details.

How about this:

An RFC to add Device Tree bindings to the V4L2 subsystem has been 
discussed. Version 4 of that RFC has been developed jointly by Sylwester 
Nawrocki and Guennadi Liakhovetski and posted to the linux-media mailing 
list shortly before the conference. Both V4L2 developers and developers 
from other areas of the kernel with rich experience in designing 
device-tree bindings took part in the discussion and provided their 
valuable comments.

The high-level design of the V4L2 DT implementation defines DT nodes of 
multiple types: camera sensors, TV decoders and encoders and similar 
devices, typically controlled over I2C or a similar bus, should also 
reside on their respective (control) busses. Video bridge engines and 
other data processing units, typically implemented in respective SoCs, are 
also each represented by a separate DT node. An important part of the 
media hardware representation is a description of data links between all 
the above parts, especially between the SoCs and external components. Such 
links are represented by child nodes of both receiver and transmitter DT 
nodes.

During the conference the general concept has been approved. Multiple 
improvement suggestions have been provided for clock bindings within media 
DT nodes, property naming, location of the bus-width property and similar 
properties, describing the data bus topology. An important amendment to 
the RFC is the addition of a "port" DT node level. Now the afore mentioned 
link sub-nodes should be placed under these port nodes.
 
As a result of the discussion, version 5 of the RFC has been designed and 
posted: 
http://www.mail-archive.com/linux-media at vger.kernel.org/msg51420.html 
After further cosmetic improvements it should lead to a proper patch, 
adding V4L2 DT bindings to the kernel documentation and their 
implementation in the media drivers.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
