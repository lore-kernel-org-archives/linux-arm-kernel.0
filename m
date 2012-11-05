From: omaplinuxkernel@gmail.com (Shubhrajyoti Datta)
Date: Mon, 5 Nov 2012 14:54:32 +0530
Subject: [PATCHv2 1/7] i2c: omap: Fix the revision register read
In-Reply-To: <20121105090412.GA2913@arwen.pp.htv.fi>
References: <1352025873-27492-1-git-send-email-shubhrajyoti@ti.com>
 <1352025873-27492-2-git-send-email-shubhrajyoti@ti.com>
 <20121105075026.GB32468@arwen.pp.htv.fi> <50977A30.6040907@ti.com>
 <20121105090412.GA2913@arwen.pp.htv.fi>
Message-ID: <CAM=Q2csb_9ryaZfURqv6QgsVuSRiVMDt=x=Adko2HH4GoiHnCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 5, 2012 at 2:34 PM, Felipe Balbi <balbi@ti.com> wrote:

> Hi,
>
> On Mon, Nov 05, 2012 at 02:04:56PM +0530, Shubhrajyoti wrote:
> > >> @@ -1155,7 +1187,7 @@ omap_i2c_probe(struct platform_device *pdev)
> > >>
> > >>            dev->fifo_size = (dev->fifo_size / 2);
> > >>
> > >> -          if (dev->rev < OMAP_I2C_REV_ON_3630_4430)
> > >> +          if (dev->rev < OMAP_I2C_REV_ON_3630)
> > >>                    dev->b_hw = 1; /* Enable hardware fixes */
> > > looks like this was applicable to 4430 too, what happened ?
> > No actually this can be deleted completely once the
> > start -> transaction -> stop sequence recommendation is followed.
>
> yes, but we're not there just yet and this patch is changing the
> behavior of the driver


No , earlier we were truncating the register for omap4 so
OMAP_I2C_REV_ON_3630_4430 was there if we read both hi and lo for
omap4 then we donot find 3630 and 4430 value to be similar.

In this case the behavior is same as earlier also it enabled this for lower
than 3630 and
the same holds good even now.

So in essence,
Earlier  OMAP_I2C_REV_ON_3630_4430 is named to OMAP_I2C_REV_ON_3630
and omap4 rev will have a 32bit value.




> in ways which don't belong to $SUBJECT.
>
> --
> balbi
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121105/a7c816f2/attachment-0001.html>
