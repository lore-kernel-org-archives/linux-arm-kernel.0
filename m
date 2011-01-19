From: david@gibson.dropbear.id.au (David Gibson)
Date: Thu, 20 Jan 2011 09:47:55 +1000
Subject: RFC: Host-endian device tree format
In-Reply-To: <AANLkTim7F8PBd_4zmQY7717N7CoiGvvyX473CL=6qCaj@mail.gmail.com>
References: <AANLkTi=AdwaW5vvm1TzNxcNrjYiJ3dOEjwoZrm-koxuw@mail.gmail.com>
	<AANLkTikoZj1WSpE8QNSRiF3oFL4qAb68kNnCKdExvBz7@mail.gmail.com>
	<AANLkTi=xdJ_c3LvCFkeqBRNDf6TSC40Fjxihm9eSeMmf@mail.gmail.com>
	<alpine.LFD.2.00.1101191031481.8580@xanadu.home>
	<AANLkTi==KLWXAv79u32ioQ9eSr7JEii7fW93WPPNdAez@mail.gmail.com>
	<AANLkTim7F8PBd_4zmQY7717N7CoiGvvyX473CL=6qCaj@mail.gmail.com>
Message-ID: <20110119234755.GA20128@yookeroo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 19, 2011 at 04:09:39PM +0000, Dave Martin wrote:
> On Wed, Jan 19, 2011 at 3:52 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> > On Wed, Jan 19, 2011 at 8:41 AM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> >> On Wed, 19 Jan 2011, Dave Martin wrote:
> >>> On Wed, Jan 19, 2011 at 1:41 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> >>> > The dtb isn't so much bigendian as it is network byte order.
> >>>
> >>> (For me, "network byte order" is a euphemism ... <insert
> >>> unconstructive rant here>)
> >>
> >> I concur.
> >
> > meh. it's all about conventions. ?When talking about external data, it
> > is far more important for everyone to agree on the same representation
> > than it is to tailor to each platforms preferences. ?That said, rant
> > away! ?I love a good tangent.
> 
> I guess a good example of what I mean is ELF - the endianness of an
> ELF image is discoverable, and cross tools do exist -- but because ELF
> images are strongly bound to their target platform, running the image
> takes precedence over the simplicity of the tools: so the images are
> specified in such a way that they can always be host-endian for the
> machine they run on, without creating format ambiguities.

Yes, there's no technical impediment to making a little-endian dtb
format.  In fact dtc and libfdt were written with this possibility in
mind, to the extent that there are hooks / functions in the right
places to make this reasonably straightforward.

The fact that there are actually two questions here - the endianness
of the framing dtb format, and the endianness of the property values
themselves complicates the issue.

> Of course, it's stretching things rather a lot to claim that fdt
> parsing is performance critical ... or that ELF cross tools work well
> in all host/target combinations ... rather it's a niggle.

But, there is just no point in creating a variant format.  The
performance cost is completely negligible (even using the rather
stupid conversion macros from libfdt which gcc generates horrible code
for).

The simplicity of having only one variant for tools to deal with wins,
no contest.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
