From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 11 Mar 2016 11:16:44 +0000
Subject: Tons of "no unit name" spam with make dtbs
In-Reply-To: <CAL_JsqJswSBTf+5Vdv2gg05nUg1008vPeh5MYDO_7WHAc=Dndw@mail.gmail.com>
References: <20160310180745.GD9329@atomide.com>
 <CAL_JsqJswSBTf+5Vdv2gg05nUg1008vPeh5MYDO_7WHAc=Dndw@mail.gmail.com>
Message-ID: <20160311111644.GQ5783@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 10, 2016 at 07:23:23PM -0600, Rob Herring wrote:
> On Thu, Mar 10, 2016 at 12:07 PM, Tony Lindgren <tony@atomide.com> wrote:
> > Hey Rob,
> >
> > I'm seeing tons of dtc spam with make dtbs (about 23k lines
> > with multi_v7_defconfig!) with commit fa38a82096a1 ("scripts/dtc:
> > Update to upstream version 53bf130b1cdd").
> >
> > Introducing something like this few days with merge window
> > about to open seems to be in the "a bit intrusive" category
> > to me :)
> >
> > Probably some of these changes should be reverted?
> 
> It is in -next, but I'm not planning to send to Linus this cycle.

Then it shouldn't be in -next.  -next is a tree for integration testing
and conflict discovery for the upcoming merge window, and should only
contain code targetted at that merge window.  Here's a reminder of
sfr's boilerplate which lays this out:

  Thanks for adding your subsystem tree as a participant of linux-next.  As
  you may know, this is not a judgment of your code.  The purpose of
  linux-next is for integration testing and to lower the impact of
  conflicts between subsystems in the next merge window.

  You will need to ensure that the patches/commits in your tree/series have
  been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and
     * destined for the current or next Linux merge window.

It seems it doesn't satisfy the last point there.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
