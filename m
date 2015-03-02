From: mporter@konsulko.com (Matt Porter)
Date: Mon, 2 Mar 2015 15:50:30 -0500
Subject: [PATCH] ARM: dts: hummingboard: enable pcf8523 rtc for i2eX
In-Reply-To: <20150302204326.GV8656@n2100.arm.linux.org.uk>
References: <1425322206-30115-1-git-send-email-mporter@konsulko.com>
 <20150302190204.GR8656@n2100.arm.linux.org.uk>
 <20150302190616.GS8656@n2100.arm.linux.org.uk>
 <20150302192116.GA30263@beef>
 <20150302194908.GU8656@n2100.arm.linux.org.uk>
 <20150302202540.GB30263@beef>
 <20150302204326.GV8656@n2100.arm.linux.org.uk>
Message-ID: <20150302205030.GC30263@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 02, 2015 at 08:43:26PM +0000, Russell King wrote:
> On Mon, Mar 02, 2015 at 03:25:40PM -0500, Matt Porter wrote:
> > On Mon, Mar 02, 2015 at 07:49:08PM +0000, Russell King wrote:
> > > It's a bit like the MMC stuff, I'm still carrying Olof's solution for
> > > the SDIO wifi/bt power and reset control stuff, and I'm not at present
> > > intending to do anything with it other than continue forward-porting it.
> > > I'm not interested in wasting free time trying to re-work that to suit
> > > some other solution, especially as people couldn't settle on a solution
> > > when I /did/ have an interest in it (not that I have much interest in
> > > wifi or BT - I tend to prefer old fashioned wired connections.  It also
> > > doesn't help that the Broadcom driver seemed to be very flakey with
> > > brcm4329 hardware for quite some time.)
> > > 
> > > Anyway, you can find all my kernel patches in a suitably trimmed version
> > > of the above URL, and on http://ftp.arm.linux.org.uk/cgit/ is a huge pile
> > > of effort I put into an accelerated X server with etnaviv and /my/ kernel
> > > version of etnaviv drm, complete with Xv support.
> > 
> > Excellent, so I feel like you ultimately giving me mixed messages here.
> 
> Yes, I am - partly because I don't know what to do with many of the
> patches I seem to be endlessly carrying (which depresses me).  I look
> back to the days when I could be sure of completely emptying my tree
> at each merge window, something which /never/ happens anymore.
> 
> > You said you need to take care of this licensing issue and I think you
> > implied you'd take care of the audio and rtc stuff as you have that
> > patch in your backlog.
> 
> As you may have seen, I've mailed out the licensing patch, and I've
> also mailed out two patches - one for PWM stuff and the second one
> being the RTC change broken out from my sgtl5000 hacks patch.
> 
> I've also cut a v4.0-rc1 patch set, in the usual diff.bz2, tar.bz2,
> and separate patch forms which include those three patches.

Ok, caught up on those now, thanks.

> > However, sounds like you've given up on pushing
> > the bigger things upstream given the problem with getting agreement
> > on those pieces. Are you just going to be submitting the
> > less controversial portions like the audio and dts updates? My goal for
> > HB initially is just to have all the low-hanging fruit (like rtc and audio)
> > working on mainline...besides the stuff that's already there.
> 
> RTC is the easiest bit of the problem, as you've discovered it's just
> a matter of uncommenting the bit in DT.  (It's even better if you have
> a battery to plug into the little connector!)
> 
> Audio needs more than just DT changes, and there's recently been some
> SGTL5000 patches submitted which change the way power is controlled
> in the SGTL5000.  I don't yet know whether those patches solve the
> problems I was seeing with the kernel powering down the SGTL5000's
> internal regulator, thereby making the device totally inaccessible
> until the next power cycle or not.

Ok, I'll take a look at those here.

> Whether I'll get a chance to look at that this week or not, I don't
> know... (see my privately shared G+ status from yesterday, which
> people in my G+ circles should be able to see.)

Aha, ok, I only saw your last public mention of the 4.0-rc1 breakage
on the ethernet clock. Now I know why.

-Matt
