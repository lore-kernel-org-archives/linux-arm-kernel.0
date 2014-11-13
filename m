From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 13 Nov 2014 17:17:40 +0100
Subject: [PATCH] ARM: dts: tegra: move serial aliases to per-board
In-Reply-To: <20141113112706.GC23422@ulmo>
References: <1415738970-7963-1-git-send-email-olof@lixom.net>
 <20141112122017.GC30821@ulmo.nvidia.com>
 <CAOesGMjmVJuaiFZf6msFtsGiQn6TOPatZ7V3p-KfaPqpXnrYmA@mail.gmail.com>
 <20141113112706.GC23422@ulmo>
Message-ID: <20141113161738.GB3613@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 13, 2014 at 12:27:07PM +0100, Thierry Reding wrote:
> On Wed, Nov 12, 2014 at 09:07:20AM -0800, Olof Johansson wrote:
> > Hi Thierry,
> > 
> > 
> > 
> > On Wed, Nov 12, 2014 at 4:20 AM, Thierry Reding
> > <thierry.reding@gmail.com> wrote:
> > > On Tue, Nov 11, 2014 at 12:49:30PM -0800, Olof Johansson wrote:
> > >> There are general changes pending to make the /aliases/serial* entries
> > >> number the serial ports on the system. On tegra, so far the ports have been
> > >> just numbered dynamically as they are configured so that makes them change.
> > >>
> > >> To avoid this, add specific aliases per board to keep the old numbers. This
> > >> allows us to change the numbering by default on future SoCs while keeping the
> > >> numbering on existing boards.
> > >>
> > >> Signed-off-by: Olof Johansson <olof@lixom.net>
> > >> ---
> > >>
> > >> Stephen/Thierry/Alex, as noticed this week we really should try to get
> > >> this in before the 3.19 merge window so that the global aliases change
> > >> can happen there without regression.
> > >>
> > >> If you have more fixes queued up, feel free to add this to the next pull
> > >> request. If not, a review and ack would be appreciated.
> > >>
> > >>  arch/arm/boot/dts/tegra114-dalmore.dts        |    1 +
> > >>  arch/arm/boot/dts/tegra114-roth.dts           |    4 ++++
> > >>  arch/arm/boot/dts/tegra114-tn7.dts            |    4 ++++
> > >>  arch/arm/boot/dts/tegra114.dtsi               |    7 -------
> > >>  arch/arm/boot/dts/tegra124-jetson-tk1.dts     |    1 +
> > >>  arch/arm/boot/dts/tegra124-nyan-big.dts       |    1 +
> > >>  arch/arm/boot/dts/tegra124-venice2.dts        |    1 +
> > >>  arch/arm/boot/dts/tegra124.dtsi               |    7 -------
> > >>  arch/arm/boot/dts/tegra20-harmony.dts         |    1 +
> > >>  arch/arm/boot/dts/tegra20-iris-512.dts        |    5 +++++
> > >>  arch/arm/boot/dts/tegra20-medcom-wide.dts     |    4 ++++
> > >>  arch/arm/boot/dts/tegra20-paz00.dts           |    2 ++
> > >>  arch/arm/boot/dts/tegra20-seaboard.dts        |    1 +
> > >>  arch/arm/boot/dts/tegra20-tamonten.dtsi       |    1 +
> > >>  arch/arm/boot/dts/tegra20-trimslice.dts       |    1 +
> > >>  arch/arm/boot/dts/tegra20-ventana.dts         |    1 +
> > >>  arch/arm/boot/dts/tegra20-whistler.dts        |    1 +
> > >>  arch/arm/boot/dts/tegra20.dtsi                |    8 --------
> > >>  arch/arm/boot/dts/tegra30-apalis-eval.dts     |    4 ++++
> > >>  arch/arm/boot/dts/tegra30-beaver.dts          |    1 +
> > >>  arch/arm/boot/dts/tegra30-cardhu.dtsi         |    2 ++
> > >>  arch/arm/boot/dts/tegra30-colibri-eval-v3.dts |    3 +++
> > >>  arch/arm/boot/dts/tegra30.dtsi                |    8 --------
> > >>  23 files changed, 39 insertions(+), 30 deletions(-)
> > >
> > > I have applied this to the for-3.19/dt branch.
> > 
> > Maybe I wasn't entirely clear -- I was proposing to include this in
> > the next batch of fixes for 3.18 so that the aliases processing code
> > can go in for 3.19. If we hold this until the merge window we run the
> > risk of having largeish parts of the merge window unbisectable (more
> > than if we merge this as part of the next/dt contents).
> 
> Alex sent out two patches today that should go into 3.18, so let me
> prepare a pull request include those and your patch.

In addition to the three patches I had to pull in a partial version of
Lucas' patch to add the DT labels on Tegra124 that your patch references
in the aliases node.

I've sent out a pull request, let me know if that doesn't match what you
had expected.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141113/15cf7d62/attachment-0001.sig>
