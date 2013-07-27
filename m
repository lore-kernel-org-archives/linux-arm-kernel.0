From: david@gibson.dropbear.id.au (David Gibson)
Date: Sun, 28 Jul 2013 01:19:49 +1000
Subject: [Ksummit-2013-discuss] DT bindings as ABI [was: Do we have
 people interested in device tree janitoring / cleanup?]
In-Reply-To: <20130726142140.GR24642@n2100.arm.linux.org.uk>
References: <20130725182920.GA24955@e106331-lin.cambridge.arm.com>
 <20130725184834.GA8296@netboy>
 <20130725213753.GC17616@obsidianresearch.com>
 <20130726080115.GA5436@netboy>
 <1374831744.2923.42.camel@shinybook.infradead.org>
 <20130726130927.GC4219@netboy>
 <20130726132709.GH29916@titan.lakedaemon.net>
 <1374846070.14574.92.camel@i7.infradead.org>
 <CAKON4OzrkHzUzKkULWCgiEpAtJ5gLxUm78R5ctd7p6trqq_gCA@mail.gmail.com>
 <20130726142140.GR24642@n2100.arm.linux.org.uk>
Message-ID: <20130727151949.GA29970@voom.fritz.box>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 26, 2013 at 03:21:40PM +0100, Russell King - ARM Linux wrote:
> On Fri, Jul 26, 2013 at 10:14:32AM -0400, jonsmirl at gmail.com wrote:
> > Yes, yes - that's why the schema should be written down and used as a
> > validation input to dtc. Then dtc can spit out errors for non-standard
> > items. There would be two versions - the standard one and a legacy one
> > that includes the standard one plus the hacks that can't be undone.
> > 
> > But more importantly it provides a framework for people creating new
> > node definitions. Now they can't work in a vacuum and come up with
> > random names and structure for everything.
> > 
> > Most of the problems express in the thread would go away if the schema
> > was written down and discussed. The rule going forward would be no new
> > nodes that aren't part of the standard schema.
> 
> So this is why I'm seeing patches just a short time ago removing existing
> compatible strings from the DT descriptions and associated driver, and
> replacing them with new ones... meaning that the old DT files won't work
> with newer kernels.
> 
> What that means is using the descriptions as the schema won't catch that
> because they're changing those as well to match.
> 
> There's a solution to that: dtc becomes a separate project external to
> the kernel which also contains the schemas that it verifies against.

dtc has always been a separate project external to the kernel.  Though
we do have to keep reminding people to send their patches to upstream
first.

It's had minimal support for validation of the tree contents for a
long time.  It has no more than minimal support (including "schemas"
as such for bindings), simply because no-one's implemented it yet.

> That way, if you want to make changes such as that above, you need to
> get it past not only kernel people but also past dtc maintainers -
> which increases the chances of such stuff being caught.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130728/d749095c/attachment.sig>
