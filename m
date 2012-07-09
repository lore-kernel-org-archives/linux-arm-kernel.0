From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 09 Jul 2012 16:24:34 -0400 (EDT)
Subject: [PATCH 00/15] PCI io.h cleanups
In-Reply-To: <4FFB25FE.8090806@gmail.com>
References: <1341600040-30993-1-git-send-email-robherring2@gmail.com>
 <201207091628.37975.arnd@arndb.de> <4FFB25FE.8090806@gmail.com>
Message-ID: <alpine.LFD.2.02.1207091622390.31100@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 9 Jul 2012, Rob Herring wrote:

> On 07/09/2012 11:28 AM, Arnd Bergmann wrote:
> > On Friday 06 July 2012, Rob Herring wrote:
> >> From: Rob Herring <rob.herring@calxeda.com>
> >>
> >> I've finally gotten back to this after several months. This is the 2nd
> >> part of mach/io.h removals. This series removes io.h on platforms with
> >> PCI by creating a fixed virtual I/O mapping and a common __io() macro.
> >>
> >> As several platforms have 2 1MB I/O windows, I've changed the fixed
> >> mapping to 2MB (vs. 1MB in the prior posting) and allow platforms to
> >> control the size. This also allows using a single 1MB section mapping
> >> rather than 4KB pages.
> > 
> > Looks really good, feel free to add my Reviewed-by on patches 2-15, since
> > I've done a line-by-line walkthrough and could not find anything besides the
> > trivial comments I gave.
> 
> Thanks for the review. It's going to change a bit with using
> ioremap_page_range. Hope to have new version out soon.

Beware the fact that you can't use ioremap_page_range() early on during 
the boot as it uses the standard page allocator.


Nicolas
