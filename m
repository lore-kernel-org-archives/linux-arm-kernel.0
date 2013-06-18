From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 18 Jun 2013 20:39:50 +0200
Subject: [PATCH v3 03/12] bus: mvebu-mbus: Add static window allocation to
 the DT binding
In-Reply-To: <51C0A5F8.8030300@gmail.com>
References: <1371554737-25319-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130618174622.GD2204@obsidianresearch.com> <51C0A5F8.8030300@gmail.com>
Message-ID: <201306182039.50736.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 June 2013, Sebastian Hesselbarth wrote:
> On 06/18/2013 07:46 PM, Jason Gunthorpe wrote:
> > On Tue, Jun 18, 2013 at 08:25:28AM -0300, Ezequiel Garcia wrote:
> >> +
> >> +IIAA0000
> >> +
> >> +Where:
> >> +  -- I = Marvell defined target ID for programmable windows
> >> +  -- A = Marvell defined target attributes for programmable windows
> >
> > I thought we agreed to something like:
> >
> > SIAA0000
> >
> > Where 'S' is the designator for the special items like PCI-E and
> > internal-regs. 0 = normal target ids, 0xF = special ids.
> >
> > The target is only 4 bits, the attr is 8, so a little doc update to
> > clarify this should be enough, no need to change the DTs.
> 
> +1 for SIAA0000, as it allows to use MBUS_ID also for those fake
> windows. It makes it more readable IMHO.

+1

> Also allows you to have up to 40b offset, which might be important
> with LPAE enabled.

Not with the current generation I think, since the mbus windows are
32 bit only, but it would avoid having to come up with a new format
for a potential future-generation mbus that has wider address.

	Arnd
