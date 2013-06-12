From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 12 Jun 2013 18:36:21 -0300
Subject: [PATCH 04/14] bus: mvebu-mbus: Add static window allocation to
 the DT binding
In-Reply-To: <20130612212641.GB8625@obsidianresearch.com>
References: <1370623671-7748-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <4160363.LWJuHATm2F@wuerfel> <20130612111441.E6D603E0A56@localhost>
 <201306122245.55960.arnd@arndb.de>
 <20130612211221.GB23012@localhost>
 <20130612212641.GB8625@obsidianresearch.com>
Message-ID: <20130612213620.GC23012@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 12, 2013 at 03:26:42PM -0600, Jason Gunthorpe wrote:
> On Wed, Jun 12, 2013 at 06:12:22PM -0300, Ezequiel Garcia wrote:
> 
[...]
> > 
> > This departs considerably from what I'm aiming right now.
> > 
> > Are you suggesting to not put *any* mapping in the mbus 'ranges' node in
> > the DT (other than internal-regs)?
> 
> My view is that the ranges should be respected. If an address is
> present, it should be used, unless there is a conflict.
> 
> If no address is present (unclear why anyone would do this, but OK)
> then demand allocate via the linux resource allocator through the
> of_bus stuff seems reasonable to me..
> 
> Just to re-iterate Arnd's earlier comment: The DT representation
> must handle dynamic allocation, but we can defer implementing the
> kernel side until there is a need.
> 
> It isn't clear to me there is a need.....
> 

Right. And just to confirm: this kernel side dynamic implementation
will be completely independent of the MBus DT layout proposal.
So I think it's best to agree on this binding first.

I'll post a v2 with the progress I've made using the preprocessor.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
