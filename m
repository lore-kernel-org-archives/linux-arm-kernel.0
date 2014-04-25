From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 25 Apr 2014 15:15:50 +0100
Subject: [PATCH 000/222] The *Full* Cubox-i series
In-Reply-To: <20140425135048.GA7388@ulmo>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
 <20140425135048.GA7388@ulmo>
Message-ID: <20140425141550.GQ26756@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 25, 2014 at 03:50:49PM +0200, Thierry Reding wrote:
> On Fri, Apr 25, 2014 at 12:29:51PM +0100, Russell King - ARM Linux wrote:
> > So that people can see what kind of a patch nightmare I'm in, and
> > hopefully start being more co-operative towards getting patches into
> > mainline, here is the *full* patch set for CuBox-i support that I'm
> > presently sitting on.
> > 
> > Anything that can be done to make this easier would be very helpful,
> > so I'm not spending lots of time tweaking some random patch and then
> > having to remerge all these different sub-series.
> 
> Do you happen to have a branch that I can pull to test this on Tegra? Is
> there anything that I should be paying special attention to when
> testing?

One of the issues I'm _most_ concerned about is the L2C code.  I only
have a very limited number of platforms I can test that stuff out on.

The L2C code that I've now dumped into linux-next is there in an attempt
to get more testing coverage, and it has resulted in that - Kevin's
boot test revealed that it breaks on a Broadcom platform.  I'm hoping
Kevin will investigate further as per my emails, but I've no idea at the
moment whether that's going to happen or not.  I can't do it because I
don't have access to any Broadcom hardware, neither do I have much idea
as to its cause.

This is one of the big problems of the arm-soc automatic testing.  It's
all very well setting up some automatic testing facility, but it's
utterly useless if you can't get at information needed to debug issues
that it reports.

I know that various patches in there need squashing together or deleting
(eg, whether we enable the power management via DT, or whether we always
enable it) depending on the results of testing...

I'm at the end of knowing what to do with any of that stuff right now.
The way I'm currently feeling, I might just as well delete the entire
L2 cache changes branch because I'm *not* getting the support needed to
make progress with it.

The same is true of the mmc stuff.  It's a big patch set, and it's
conflicting with other people's changes.  That patch set is over two
months old now, and it's received very little in the way of testing so
far...

And as you can see from this patch set, I also have a whole load of
changes to the Freescale FEC driver which haven't yet been properly
posted (and as I found out yesterday from one of DaveM's review comments
for a different driver, it already requires some changes.)

What I would like to do is to get some of these patches into a "finished"
state (iow, reviewed and tested) and properly queued up for the next merge
window so I don't have to mess around with soo many in-flux patches, as
I have been for the last two to three months.

At the moment, the rate at which I seem to be able to get patches into
the mainline kernel is down around 40 per cycle (basically the imx-drm
debacle), which is piss poor when dealing with such a big backlog - a
backlog which has taken just four months to build up.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
