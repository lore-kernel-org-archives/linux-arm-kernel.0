From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 10 Jul 2018 15:30:40 +0200
Subject: Vibrations on Droid 4?
In-Reply-To: <20180710101147.lyu65ro4czvrs2da@earth.universe>
References: <20180709081534.GA6799@amd>
 <20180709214910.tes6u4ivxomd3aja@earth.universe>
 <20180709220211.GA7760@amd>
 <20180710101147.lyu65ro4czvrs2da@earth.universe>
Message-ID: <20180710133040.GA4391@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2018-07-10 12:11:47, Sebastian Reichel wrote:
> Hi,
> 
> On Tue, Jul 10, 2018 at 12:02:11AM +0200, Pavel Machek wrote:
> > Hi!
> > 
> > > > Do you have vibrations on d4 working?
> > > > I believe I have required drivers enabled, but no luck:
> > > > 
> > > > user at devuan:/sys/bus/platform/drivers$ ls pwm-vibrator/
> > > > bind  uevent  unbind
> > > > user at devuan:/sys/bus/platform/drivers$ ls omap-dmtimer-pwm/
> > > > bind  uevent  unbind
> > > 
> > > Have you checked probe deferrals?
> > 
> > Not really. Is there easier way to do that than adding printks in the
> > probe function? (I can go through dmesg tommorow).
> 
> Option 1: https://lkml.org/lkml/2018/7/8/63

I tried this methodq, and no luck.

static int pwm_omap_dmtimer_probe(struct platform_device *pdev)

does not seem to be called.

Its parent is gpio at 4805d000 , and that one seems to be present.

user at devuan:/sys/bus/platform/devices$ ls 4805d000.gpio
driver				       driver_override  gpio
gpiochip5  modalias  of_node  power  subsystem  uevent

So I'm now confused.

Best regards,
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180710/834d56de/attachment.sig>
