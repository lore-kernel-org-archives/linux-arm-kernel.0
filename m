From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 14 Apr 2016 19:38:55 +0100
Subject: [Question] refcount of DT node
In-Reply-To: <20160414095957.GB10273@leverpostej>
References: <CAK7LNATFUW2KXUpFas6C_SJ0C7Qb1DWU0njLg-FCYciK2U6Oag@mail.gmail.com>
 <20160414084849.GT19428@n2100.arm.linux.org.uk>
 <20160414095957.GB10273@leverpostej>
Message-ID: <20160414183855.GU19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 14, 2016 at 10:59:57AM +0100, Mark Rutland wrote:
> On Thu, Apr 14, 2016 at 09:48:49AM +0100, Russell King - ARM Linux wrote:
> > On Thu, Apr 14, 2016 at 04:47:57PM +0900, Masahiro Yamada wrote:
> > > Hi experts.
> > > 
> > > My understanding of refcount of DT node is poor.
> > 
> > The message from DT people is... don't worry about DT node refcounting.
> > Do whatever you want with it, they don't care whether you have correct
> > refcounting or not.
> > 
> > The background behind that is that I've tried to fix the refcounting,
> > and even had the coccinelle people generate some stuff to work on this
> > issue, but DT people's attitude towards it is "don't bother".
> > 
> > So yes, people may get it wrong, but it seems it's something that DT
> > people want ignored.
> 
> I'm not sure that's quite fair; the last discussion I recall about this
> ended up concluding that we need a better API, rather than papering over
> problems.

Sorry, but I started out trying to get the of_node_put() stuff
correct, and sparked Julia into doing coccinelle patches, and I
was told by Rob that we shouldn't care about of_node_put() being
wrong, and the feeling is as I stated it: DT folk don't care
enough to fix the existing places, even though a great many can
be sorted via the coccinelle approach.

Their stance is not something I agree with - if we have something,
it should be correct, even if it's not what we would ultimately
desire, _or_ it should be removed.  This half-way house that we
have today is total madness to me.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
