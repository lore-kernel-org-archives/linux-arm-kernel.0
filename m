From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 12 Dec 2009 18:53:27 +0100
Subject: tree with htc dream support
In-Reply-To: <20091212112536.GA2302@elf.ucw.cz>
References: <20091205221100.GA32522@elf.ucw.cz>
	<1260054737.23633.35.camel@desktop>
	<a55d774e0912051638u7858878cg7cf62905c3c005c1@mail.gmail.com>
	<d6200be20912112142r7bdf8f18o31edd4457aa64998@mail.gmail.com>
	<20091212112536.GA2302@elf.ucw.cz>
Message-ID: <20091212175327.GA5819@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat 2009-12-12 12:25:36, Pavel Machek wrote:
> On Fri 2009-12-11 21:42:07, Arve Hj?nnev?g wrote:
> > On Sat, Dec 5, 2009 at 4:38 PM, Brian Swetland <swetland@google.com> wrote:
> > > Arve's about to take our common and msm trees and rebase them over the .32,
> > > which may be useful for reference -- at least as a snapshot of a fully
> > > functional set of patches that android donut and eclair run on, on
> > > production hardware.? We'll make that available as soon as we have something
> > > that's bootable.
> > >
> > > Brian
> > >
> > >
> > 
> > A first pass of this is available in the android-msm-2.6.32-test1
> > branch at git://android.git.kernel.org/kernel/experimental.git.
> 
> According to some docs, i2c_detach can be just removed, so...?
> 
> Then I got this:

And then I got it to boot. Good! (And a bit after that, probably
watchdog kicked and phone rebooted back into .27.)

On the second try -- with ramdisk.img -- I got it to boot to GUI, but
the GUI did not show up. I can hear the background sounds but not see
anything. I probably need to turn off
CONFIG_FRAMEBUFFER_CONSOLE... Yes, now it boots to the GUI and I can
actually see that. (It would be nice to make GUI work with
FRAMEBUFFER_CONSOLE on; it should not be that hard...).

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
