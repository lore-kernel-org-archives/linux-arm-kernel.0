From: olof@lixom.net (Olof Johansson)
Date: Sat, 3 Dec 2016 21:10:12 -0800
Subject: [GIT PULL 2/10] firmware: Add Tegra IVC and BPMP support
In-Reply-To: <20161121082959.GE25171@ulmo.ba.sec>
References: <20161118161719.24153-1-thierry.reding@gmail.com>
 <20161118161719.24153-2-thierry.reding@gmail.com>
 <20161119023138.GL2543@localhost>
 <20161121082959.GE25171@ulmo.ba.sec>
Message-ID: <20161204051012.GA4995@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 21, 2016 at 09:29:59AM +0100, Thierry Reding wrote:
> On Fri, Nov 18, 2016 at 06:31:38PM -0800, Olof Johansson wrote:
> > On Fri, Nov 18, 2016 at 05:17:11PM +0100, Thierry Reding wrote:
> > > Hi ARM SoC maintainers,
> > > 
> > > The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
> > > 
> > >   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
> > > 
> > > are available in the git repository at:
> > > 
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.10-firmware
> > > 
> > > for you to fetch changes up to b704ed8095ee91af5f3f7343bb3be23aae1cb26d:
> > > 
> > >   dt-bindings: firmware: Allow child nodes inside the Tegra BPMP (2016-11-18 14:33:44 +0100)
> > > 
> > > Thanks,
> > > Thierry
> > > 
> > > ----------------------------------------------------------------
> > > firmware: Add Tegra IVC and BPMP support
> > > 
> > > IVC is an inter-processor communication protocol that uses shared memory
> > > to exchange data between processors. The BPMP driver makes use of this
> > > to communicate with the Boot and Power Management Processor (BPMP) and
> > > uses an additional hardware synchronization primitive from the HSP block
> > > to signal availability of new data (doorbell).
> > > 
> > > Firmware running on the BPMP implements a number of services such as the
> > > control of clocks and resets within the system, or the ability to ungate
> > > or gate power partitions.
> > > 
> > > ----------------------------------------------------------------
> > > Dan Carpenter (1):
> > >       mailbox: tegra-hsp: Use after free in tegra_hsp_remove_doorbells()
> > > 
> > > Joseph Lo (3):
> > >       soc/tegra: Add Tegra186 support
> > >       dt-bindings: mailbox: Add Tegra HSP binding
> > >       dt-bindings: firmware: Add bindings for Tegra BPMP
> > > 
> > > Stephen Warren (2):
> > >       dt-bindings: Add power domains to Tegra BPMP firmware
> > >       dt-bindings: firmware: Allow child nodes inside the Tegra BPMP
> > > 
> > > Thierry Reding (5):
> > >       Merge branch 'for-4.10/soc' into for-4.10/mailbox
> > >       mailbox: Add Tegra HSP driver
> > >       Merge branch 'for-4.10/mailbox' into for-4.10/firmware
> > >       firmware: tegra: Add IVC library
> > >       firmware: tegra: Add BPMP support
> > 
> > Hi,
> > 
> > Again the format of the pull request here is a little confusing, since it's
> > a cumulative shotlog and diffstat, while you already sent the bulk of this
> > as part of the driver branch (1/10). It'd have been better to use that branch
> > as the base when you generate the pull request since that's the delta we see
> > when we merge it in.
> 
> In the past there had been occasions where it hadn't been clear what a
> given branch was going to pull in as additional dependencies, so adding
> the complete shortlog seemed like a good way to document this in a more
> explicit way.
> 
> If you prefer working things out yourself I can tweak the scripts to
> generate the pull requests on top of their respective dependencies.

It's really about the order we'll merge the patches and the diffstat that
git merge will generate and display (which is the one I usually verify
against).

So being clear is definitely useful, but doing the diffstat on the incremental
changes is still preferred.

> > Also, I can't seem to find the key you use to sign these tags with, it isn't
> > uploaded on pgp.mit.edu. Can you remedy that please, and get it signed as
> > needed?
> 
> Works for me:
> 
> 	http://pgp.mit.edu/pks/lookup?op=get&search=0xDD23ACD77F3EB3A1

Odd, I searched for it and didn't find it. But yeah, it's there.


-Olof
