From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Mar 2017 19:16:22 +0000
Subject: [PATCH v4 0/3] ARM: l2c: add l2c support for RZ/A1
In-Reply-To: <SG2PR06MB11654EAEFECB3AE8849B28BD8A2E0@SG2PR06MB1165.apcprd06.prod.outlook.com>
References: <20170216161742.29320-1-chris.brandt@renesas.com>
 <20170216164424.GR27312@n2100.armlinux.org.uk>
 <CAK8P3a1ri2o4An0svxSG4iSvwTkdpM5jiC=SzBq7mE6TpbdhKQ@mail.gmail.com>
 <20170216172128.GS27312@n2100.armlinux.org.uk>
 <SG2PR06MB11654EAEFECB3AE8849B28BD8A2E0@SG2PR06MB1165.apcprd06.prod.outlook.com>
Message-ID: <20170308191622.GA21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 08, 2017 at 06:53:37PM +0000, Chris Brandt wrote:
> On Thursday, February 16, 2017, Russell King wrote:
> > On Thu, Feb 16, 2017 at 05:57:53PM +0100, Arnd Bergmann wrote:
> > > On Thu, Feb 16, 2017 at 5:44 PM, Russell King - ARM Linux
> > > <linux@armlinux.org.uk> wrote:
> > > > On Thu, Feb 16, 2017 at 11:17:39AM -0500, Chris Brandt wrote:
> > > >> The PL310 in the Renesas RZ/A1 SoC (R7S72100) does not have the
> > > >> sideband signals connected between the CPU and L2C. According the
> > > >> PL310 TRM, sideband signals are optional.
> > > >>
> > > >> If a PL310 is added to a system, but the sideband signals are not
> > > >> connected, some Cortex A9 optimizations cannot be used. In
> > > >> particular, enabling Full Line Zeros in the CA9 without sidebands
> > > >> connected will crash the system since the CA9 will expect the L2C
> > > >> to perform operations, yet the L2C never gets the commands.
> > > >>
> > > >> This series adds the option to not enable anything in the PL310
> > > >> that uses sidebands, and then adds L2C support to the RZ/A1 DT.
> > > >>
> > > >> v4:
> > > >> * changed l2x0_bresp_dis to l2x0_bresp_disable
> > > >> * changed l2x0_flz_dis to l2x0_flz_disable
> > > >
> > > > Looks good, thanks.
> > > >
> > > > I'll want to merge patch 1, but I suspect the other two patches need
> > > > to go through arm-soc, which will cause a problem due to being
> > > > merged independently...  Arnd?
> > >
> > > I just checked what we have queued up in next/dt for this platform,
> > > and I'm fairly sure that there are no conflicts, so you can pick up
> > > all three and add
> > >
> > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > Chris, can you put all three in the patch system, preferably with Arnd's
> > ack for the last two please?
> > 
> > Thanks.
> 
> 
> These are still sitting in the patch system.

Exactly right.

> Was there something wrong with them that they would not go into 4.11?

They were submitted way too late.

* The merge window opened on Sunday, 19th February.

* The patches were submitted on Thursday, 16th February just before 6pm
  my local time.

* The last linux-next grab of trees before the merge window happened
  occured around 11pm my local time on Thursday, 16th February.

There's a general requirement that everything for a merge window should
be in linux-next before the merge window.

I generally want material for the merge window to be ready a week before
the merge window opens to allow for proper testing and any re-work that
comes out of that testing.

In any case, anything submitted from Thursday through to the Sunday when
the merge window opens _definitely_ is not going to get queued for the
merge window unless there are exceptional (eg, important bug fix) reasons
to do so.

So, it basically missed the time slot for merging new material, sorry.

I'll re-open my tree for new material in the next few days.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
