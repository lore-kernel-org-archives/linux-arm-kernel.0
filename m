From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 16 Sep 2015 17:21:57 +0100
Subject: [PATCH] irqchip: bcm2835: Add FIQ support
In-Reply-To: <87613a31jb.fsf@eliezer.anholt.net>
References: <1434130016-26574-1-git-send-email-noralf@tronnes.org>
 <87d1zj6fq2.fsf@eliezer.anholt.net> <55F5CD80.3020700@tronnes.org>
 <20150914090853.GF21084@n2100.arm.linux.org.uk>
 <87wpvtjcka.fsf@eliezer.anholt.net>
 <20150914143459.GN21084@n2100.arm.linux.org.uk>
 <87613a31jb.fsf@eliezer.anholt.net>
Message-ID: <20150916162157.GB21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 16, 2015 at 10:02:32AM -0400, Eric Anholt wrote:
> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> 
> > On Mon, Sep 14, 2015 at 07:33:09AM -0700, Eric Anholt wrote:
> >> So, while FIQ isn't used in upstream, I think it's worthwhile to merge.
> >> It is another step to bringing the downstream developers into the fold.
> >
> > I want to see the code _first_.  Until then, I'm sorry, this patch can't
> > go in.
> 
> If you just want to see "Yes, GPL-compatible code using this is
> available", then that is:

It's got nothing to do with "GPL-compatible code".  I want to audit
_all_ code that makes use of FIQ.  It disgusts me that you're trying
to dress this up as a licensing issue.  It isn't.

> https://github.com/raspberrypi/linux/blob/rpi-4.1.y/drivers/usb/host/dwc_otg/dwc_otg_fiq_stub.S
> https://github.com/raspberrypi/linux/blob/rpi-4.1.y/drivers/usb/host/dwc_otg/dwc_otg_fiq_fsm.c
> 
> If not, I'm curious what exactly is the reason the patch can't go in.

In any case, I'm not going to say yes to code which provides a new
internal kernel facility for mainline kernels, but with no mainline
kernel users.  Such code can only be to make external tree maintanence
easlier, but it has the unintended effect of making mainline kernel
maintanence harder.

Such facilities _should_ always come with a user of that new facility.

It's nothing personal, it's sane policy from experience.  I've had stuff
like this in the past, where people have sent new facilities without any
users, years have gone by without that facility being used.  The facility
has eventually been removed from the mainline kernel _because_ it doesn't
have any users.

Moreover, there are people who audit the kernel looking for facilities
which have no users and propose patches to remove them.

So, if you want some new facility to be merged into mainline kernels,
and for it to remain in the kernel, always accompany it with a user.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
