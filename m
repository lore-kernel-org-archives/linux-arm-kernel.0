From: daniel@caiaq.de (Daniel Mack)
Date: Mon, 23 Nov 2009 18:58:47 +0100
Subject: [PATCH] MX27: Add USB platform devices and resources
In-Reply-To: <37367b3a0911230825y55c443d3ga4e70c583a179ff6@mail.gmail.com>
References: <eedb5540907150626m3dbf815bif92ff179b6ebfe58@mail.gmail.com>
	<20090716081235.GQ2714@pengutronix.de>
	<37367b3a0911230436i5d44cd80y182316ef056d6b31@mail.gmail.com>
	<37367b3a0911230718s3dd16d99n1b2ce858b79218ca@mail.gmail.com>
	<20091123153111.GM14091@buzzloop.caiaq.de>
	<37367b3a0911230825y55c443d3ga4e70c583a179ff6@mail.gmail.com>
Message-ID: <20091123175847.GO14091@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 23, 2009 at 02:25:22PM -0200, Alan Carvalho de Assis wrote:
> On 11/23/09, Daniel Mack <daniel@caiaq.de> wrote:
> > On Mon, Nov 23, 2009 at 01:18:03PM -0200, Alan Carvalho de Assis wrote:
> >> > What do we need now to get USB working on i.MX27?
> >> >
> >>
> >> (replying myself)
> >> I think this Daniel Mack's patch will be necessary:
> >>
> >> http://lists.infradead.org/pipermail/linux-arm-kernel/2009-June/002972.html
> >
> > The patch you refer to only contains the relevant bits for MX31, you
> > would need to tweak it a little to make MX27 work as well. I think this
> > has been done already by someone, but I can't remember exactly.
> >
> 
> Thank you Daniel.
> 
> I will try to modify it myself. Case you remember someone who already
> do that, please let me know.

Should be easy to add. All you need to do is modify the parts which are
SoC specific, ie, not part of the EHCI spec. See mxc_set_usbcontrol()
and check if PORTSC needs some modifications (which I don't believe).

Please also note that there is an amendment patch queued that adds
support for MX35; if you file a patch for your platform, it should
cleanly apply on top of that one.

For the board specific code, have a look at
arch/arm/mach-mx3/mx31lilly.c in Sascha's mxc-master tree and take that
as an example.

> > The patch above and some others are already queued for 2.6.33. The ARM
> > specific things are in Sascha's mxc-master, the rest in the USB tree.
> >
> 
> Great! I think i.MX support on mainline kernel is getting better!

Help improve it :)

Daniel
