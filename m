From: olof@lixom.net (Olof Johansson)
Date: Sat, 3 Dec 2016 21:25:08 -0800
Subject: [GIT PULL 1/10] mailbox: Add Tegra HSP driver
In-Reply-To: <20161121081752.GC25171@ulmo.ba.sec>
References: <20161118161719.24153-1-thierry.reding@gmail.com>
 <20161119022742.GK2543@localhost>
 <20161121081752.GC25171@ulmo.ba.sec>
Message-ID: <20161204052508.GC4995@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 21, 2016 at 09:17:52AM +0100, Thierry Reding wrote:
> On Fri, Nov 18, 2016 at 06:27:42PM -0800, Olof Johansson wrote:
> > Hi,
> > 
> > On Fri, Nov 18, 2016 at 05:17:10PM +0100, Thierry Reding wrote:
> > > Hi ARM SoC maintainers,
> > > 
> > > The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
> > > 
> > >   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
> > > 
> > > are available in the git repository at:
> > > 
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.10-mailbox
> > > 
> > > for you to fetch changes up to 68050eb6c611527232fe5574c7306e97e47499ef:
> > > 
> > >   mailbox: tegra-hsp: Use after free in tegra_hsp_remove_doorbells() (2016-11-18 14:32:13 +0100)
> > > 
> > > Thanks,
> > > Thierry
> > > 
> > > ----------------------------------------------------------------
> > > mailbox: Add Tegra HSP driver
> > > 
> > > This contains the device tree bindings and a driver for the Tegra HSP, a
> > > hardware block that provides hardware synchronization primitives and is
> > > the foundation for inter-processor communication between CPU and BPMP.
> > > 
> > > ----------------------------------------------------------------
> > > Dan Carpenter (1):
> > >       mailbox: tegra-hsp: Use after free in tegra_hsp_remove_doorbells()
> > > 
> > > Joseph Lo (2):
> > >       soc/tegra: Add Tegra186 support
> > 
> > I don't think you really needed to merge this in here, since all you need it
> > for is to fulfill the kconfig dependency and enable the driver, right? That'd
> > happen when the driver and soc branch is merged at the toplevel anyway.
> 
> The reason I did this is that I wanted each branch to be buildable as a
> way to confirm that the dependencies are correct. In order to do that I
> need the Kconfig symbol to enable the driver.

Good point, but that's more of a local setup thing for you, and not something
that necessarily needs to go upstream.

> I suppose there are other ways I could've done that, though. Maybe in
> the future new SoC Kconfig symbols should just be introduced way ahead
> of time, so that they're already in a release or two before actual code
> starts to emerge.

That'd work too!

> > Anyhow, no damage done, I've merged this in. I would say that it'd be a little
> > more logical to send the SoC branch before the driver branch given this
> > dependency though.
> 
> The reason that the SoC branch was sent after is because only the first
> commit in that branch was pulled into the mailbox branch.
> 
> In retrospect, I think perhaps a better approach would've been to have a
> separate branch with only the Kconfig symbol addition and pull that in
> where needed.

That could work, but the whole branch-merge-features-then-enable it workflow is
quite acceptable as well.


-Olof
