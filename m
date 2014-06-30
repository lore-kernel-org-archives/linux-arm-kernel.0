From: will.deacon@arm.com (Will Deacon)
Date: Mon, 30 Jun 2014 11:17:25 +0100
Subject: [PATCH v7 1/6] pci: Introduce pci_register_io_range() helper
 function.
In-Reply-To: <53AD98B9.2020109@gmail.com>
References: <1394811272-1547-1-git-send-email-Liviu.Dudau@arm.com>
 <20140626085926.GB11244@arm.com>
 <CAL_JsqKCHf6VXR3FFcBSu1xuhP54dYsAJCZwT-X9p5iTZAOJfQ@mail.gmail.com>
 <6381366.2IfqZj1r0B@wuerfel> <20140627124949.GR26276@arm.com>
 <53AD98B9.2020109@gmail.com>
Message-ID: <20140630101724.GB25779@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

Nice work!

On Fri, Jun 27, 2014 at 05:15:53PM +0100, Rob Herring wrote:
> On 06/27/2014 07:49 AM, Will Deacon wrote:
> > On Fri, Jun 27, 2014 at 12:03:34PM +0100, Arnd Bergmann wrote:
> >> On Thursday 26 June 2014 19:44:21 Rob Herring wrote:
> >>> I don't agree arm32 is harder than microblaze. Yes, converting ALL of
> >>> arm would be, but that is not necessary. With Liviu's latest branch
> >>> the hacks I previously needed are gone (thanks!), and this is all I
> >>> need to get Versatile PCI working (under QEMU):
> >>
> >> I meant converting all of arm32 would be harder, but I agree we don't
> >> have to do it. It would be nice to convert all of the drivers/pci/host
> >> drivers though, iow all multiplatform-enabled ones, and leaving the
> >> current arm32 pci implementation for the platforms we don't want to
> >> convert to multiplatform anyway (footbridge, iop, ixp4xx, ks8695 (?),
> >> pxa, sa1100).
> > 
> > I'm more than happy to convert the generic host controller we merged
> > recently, but I'd probably want the core changes merged first so that I
> > know I'm not wasting my time!
> 
> Something like this untested patch...
> 
> Another issue I found still present is pci_ioremap_io needs some work 
> to unify with the arm implementation. That's a matter of changing the 
> function from an offset to i/o resource. That should be a pretty 
> mechanical change.
> 
> Also, there is a potential for memory leak because there is no undo 
> for of_create_pci_host_bridge.

Once Liviu reposts his series, I'll take a look at
of_create_pci_host_bridge, as I'm not sure that it provides all the
behaviour that we get from gen_pci_parse_request_of_pci_ranges right now
(e.g. required a non-prefetchable mem resource).

Will
