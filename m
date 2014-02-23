From: simon.guinot@sequanux.org (Simon Guinot)
Date: Sun, 23 Feb 2014 22:44:47 +0100
Subject: [PATCH 21/21] ARM: Kirkwood: Remove DT support
In-Reply-To: <1563594.ZI2UdY7FPy@wuerfel>
References: <1391730137-14814-1-git-send-email-andrew@lunn.ch>
 <20140220232438.GT7862@titan.lakedaemon.net>
 <20140221165252.6eb12cbd@skate> <1563594.ZI2UdY7FPy@wuerfel>
Message-ID: <20140223214447.GC3793@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 21, 2014 at 05:36:47PM +0100, Arnd Bergmann wrote:
> On Friday 21 February 2014 16:52:52 Thomas Petazzoni wrote:
> > On Thu, 20 Feb 2014 18:24:38 -0500, Jason Cooper wrote:
> > 
> > > > We keep any system using -setup.c files, and remove the ability to
> > > > boot systems with a DT description. Thus mach-kirkwood becomes legacy,
> > > > and you should now be trying to only use mach-mvebu, compiled for v5
> > > > systems and a second compile for v7 systems.
> > > > 
> > > > There are four systems left in mach-kirkwood which don't have DT
> > > > equivalent. These are LaCie 2Big and 5Big, HP t5325 thin client and
> > > > Marvell OpenRD machines. I'm working on t5325 and Openrd. The sticking
> > > > point is audio support, which no other board has done with DT yet.
> > > > The two LeCie boards have a custom LED driver which needs a DT
> > > > binding. My gut feeling is that we won't get these four converted to
> > > > DT in time for 3.15.
> > > 
> > > Why not do like we did when we started the kirkwood dt conversion?
> > > Create dts files for the remaining boards, and do
> > > 
> > > if (of_machine_is_compatible(...))
> > >       legacy_audio_init()
> > > 
> > > in board-v5.c?
> > > 
> > > I suspect audio is going to take time to sort out.  I'd hate to delay
> > > this just for that.
> > 
> > Yes, I believe it's a good plan. Convert as much as possible to DT, and
> > only keep those few devices (audio and leds) probe in an old-style
> > fashion.
> > 
> > This way, we can progressively add the necessary missing DT bindings.
> 
> Makes sense.
> 
> I'm also adding Simon Guinot to Cc here. He contributed both the kernel
> support and the Debian support for the LaCie 2Big/5Big. He might also be
> able to verify that they work after the DT conversion, or even help
> implementing it. Since there is already someone who is looking into
> t5325, that would just leave the OpenRD reference design, right?

Hi Arnd,

I am quite busy this days but as soon I get some free time I will take
care of the DT conversion for the Lacie boards.

Basically, we need to fix some minor issues with the Thomas patches:

ARM: kirkwood: convert d2net_v2 to DT
ARM: kirkwood: convert LaCie Net{2, 5}Big v2 platforms to DT

And also a DT binding must be added to the LED driver leds-netxbig.

Regards,

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140223/839b53b7/attachment-0001.sig>
