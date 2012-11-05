From: balbi@ti.com (Felipe Balbi)
Date: Mon, 5 Nov 2012 12:01:05 +0200
Subject: [PATCHv2 1/7] i2c: omap: Fix the revision register read
In-Reply-To: <CAM=Q2csb_9ryaZfURqv6QgsVuSRiVMDt=x=Adko2HH4GoiHnCQ@mail.gmail.com>
References: <1352025873-27492-1-git-send-email-shubhrajyoti@ti.com>
 <1352025873-27492-2-git-send-email-shubhrajyoti@ti.com>
 <20121105075026.GB32468@arwen.pp.htv.fi> <50977A30.6040907@ti.com>
 <20121105090412.GA2913@arwen.pp.htv.fi>
 <CAM=Q2csb_9ryaZfURqv6QgsVuSRiVMDt=x=Adko2HH4GoiHnCQ@mail.gmail.com>
Message-ID: <20121105100105.GC3327@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Nov 05, 2012 at 02:54:32PM +0530, Shubhrajyoti Datta wrote:
> On Mon, Nov 5, 2012 at 2:34 PM, Felipe Balbi <balbi@ti.com> wrote:
> 
> > Hi,
> >
> > On Mon, Nov 05, 2012 at 02:04:56PM +0530, Shubhrajyoti wrote:
> > > >> @@ -1155,7 +1187,7 @@ omap_i2c_probe(struct platform_device *pdev)
> > > >>
> > > >>            dev->fifo_size = (dev->fifo_size / 2);
> > > >>
> > > >> -          if (dev->rev < OMAP_I2C_REV_ON_3630_4430)
> > > >> +          if (dev->rev < OMAP_I2C_REV_ON_3630)
> > > >>                    dev->b_hw = 1; /* Enable hardware fixes */
> > > > looks like this was applicable to 4430 too, what happened ?
> > > No actually this can be deleted completely once the
> > > start -> transaction -> stop sequence recommendation is followed.
> >
> > yes, but we're not there just yet and this patch is changing the
> > behavior of the driver
> 
> 
> No , earlier we were truncating the register for omap4 so
> OMAP_I2C_REV_ON_3630_4430 was there if we read both hi and lo for
> omap4 then we donot find 3630 and 4430 value to be similar.
> 
> In this case the behavior is same as earlier also it enabled this for
> lower than 3630 and the same holds good even now.
> 
> So in essence, Earlier  OMAP_I2C_REV_ON_3630_4430 is named to
> OMAP_I2C_REV_ON_3630 and omap4 rev will have a 32bit value.

it's not same behavior because before dev->b_hw was set for omap4430,
but now it won't be. This is the difference in behavior which I'm
pointing out.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121105/a9193efb/attachment.sig>
