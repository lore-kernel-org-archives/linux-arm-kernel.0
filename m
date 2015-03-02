From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 2 Mar 2015 19:49:08 +0000
Subject: [PATCH] ARM: dts: hummingboard: enable pcf8523 rtc for i2eX
In-Reply-To: <20150302192116.GA30263@beef>
References: <1425322206-30115-1-git-send-email-mporter@konsulko.com>
 <20150302190204.GR8656@n2100.arm.linux.org.uk>
 <20150302190616.GS8656@n2100.arm.linux.org.uk>
 <20150302192116.GA30263@beef>
Message-ID: <20150302194908.GU8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 02, 2015 at 02:21:16PM -0500, Matt Porter wrote:
> [added Rabeeh]
> 
> On Mon, Mar 02, 2015 at 07:06:16PM +0000, Russell King wrote:
> > On Mon, Mar 02, 2015 at 07:02:04PM +0000, Russell King - ARM Linux wrote:
> > > On Mon, Mar 02, 2015 at 01:50:06PM -0500, Matt Porter wrote:
> > > > The PCF8523 RTC is populated on the i2eX boards so
> > > > enable the i2c1 controller and enable the device on
> > > > that bus.
> > > 
> > > Hmm, I wonder where my update patches went... oh, they're still sitting
> > > in my excessive backlog of patches in my tree as part of my "sgtl5000
> > > hacks" patch...
> > 
> > Also note that before we accept patches to the SolidRun stuff, we should
> > first re-license the file as GPLv2/X11.
> 
> Hi Russell,
> 
> Given that there's no license information at all on any of these three
> dts files I think that's a good idea. I just realized I didn't copy
> Rabeeh on this and he's apparently the original submitter based on
> your work. Ideally Rabeeh should send a license update but I could do
> so if you'd like and gather some acks.

It's more up to me, as I ended up being the initial author of the
mainline files - and if you look at:

http://www.home.arm.linux.org.uk/~rmk/cubox/hummingboard-cubox-i-v3.16-rc2-20140624/0041-sgtl5000-hacks.patch

you'll see the patch I refer to above, which is my own work, and it's
hardly changed to the 3.18 patch:

http://www.home.arm.linux.org.uk/~rmk/cubox/hummingboard-cubox-i-v3.18-20141216/0113-sgtl5000-hacks.patch

> OTOH, did you already have a license update somewhere in your backlog
> of patches?

Well, I do now. :)

I had dropped the ball on a load of kernel stuff as it seemed to be going
nowhere, no one seemed interested in it, and my massive backlog of patches
(especially things like the ethernet driver) just became far too difficult
both to merge into mainline and to keep forward-porting.

In any case, anyone who is serious about using the SolidRun hardware runs
Jon Nettleton's fully featured kernel (which is the basis for SR's kernel)
- sadly something which mainline likely is never going to be.

It's a bit like the MMC stuff, I'm still carrying Olof's solution for
the SDIO wifi/bt power and reset control stuff, and I'm not at present
intending to do anything with it other than continue forward-porting it.
I'm not interested in wasting free time trying to re-work that to suit
some other solution, especially as people couldn't settle on a solution
when I /did/ have an interest in it (not that I have much interest in
wifi or BT - I tend to prefer old fashioned wired connections.  It also
doesn't help that the Broadcom driver seemed to be very flakey with
brcm4329 hardware for quite some time.)

Anyway, you can find all my kernel patches in a suitably trimmed version
of the above URL, and on http://ftp.arm.linux.org.uk/cgit/ is a huge pile
of effort I put into an accelerated X server with etnaviv and /my/ kernel
version of etnaviv drm, complete with Xv support.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
