From: briannorris@chromium.org (Brian Norris)
Date: Thu, 14 Jul 2016 20:09:00 -0700
Subject: [PATCH] spi: rockchip: limit transfers to (64K - 1) bytes
In-Reply-To: <b855036c-86b3-3515-86ae-24de820564ff@rock-chips.com>
References: <1468546259-136659-1-git-send-email-briannorris@chromium.org>
 <131afa39-4287-0fb8-61f4-146283dc7cf0@rock-chips.com>
 <20160715023152.GA145248@google.com>
 <b855036c-86b3-3515-86ae-24de820564ff@rock-chips.com>
Message-ID: <20160715030859.GA3360@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 15, 2016 at 10:42:55AM +0800, Shawn Lin wrote:
> ? 2016/7/15 10:31, Brian Norris ??:
> >So maybe there's a driver bug in the PIO path that gives us an
> >off-by-one error. I poked around a bit and couldn't figure out anything,
> >so I sent this. Technically, this patch is still valid (even if not
> >optimal) for the DMA case too...
> 
> Huibing is using pio to test this case, and we still achieve it
> successfully?

Are you saying Huibing has tested PIO with 64KB transfers, or is that a
question? If the former, it'd be great if he can publish the differences
between his kernel and upstream to produce this.

> That means there may be some minor diff for the pio
> path between your chromium repo and my local branch.

This is an upstream kernel mailing list. I'd expect we can agree to test
on an upstream kernel...

> >want to unnecessarily limit the DMA case, then a last resort hack could
> >be to say:
> >
> 
> Could you get spi-rockchip.c of rockchip local kernel 4.4 from Caesar
> to see if you could transfer 64KB with the one we're using?

I just compared with some (possibly old) copy of your vendor-kernel
driver, and there are a few moderate differences. I didn't test it yet.
I'd think the onus is on you to publish your changes though, if you
think you've fixed things in your own private tree...but I'm willing to
test any changes you recommend.

Brian
