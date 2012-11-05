From: balbi@ti.com (Felipe Balbi)
Date: Mon, 5 Nov 2012 11:04:12 +0200
Subject: [PATCHv2 1/7] i2c: omap: Fix the revision register read
In-Reply-To: <50977A30.6040907@ti.com>
References: <1352025873-27492-1-git-send-email-shubhrajyoti@ti.com>
 <1352025873-27492-2-git-send-email-shubhrajyoti@ti.com>
 <20121105075026.GB32468@arwen.pp.htv.fi> <50977A30.6040907@ti.com>
Message-ID: <20121105090412.GA2913@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Nov 05, 2012 at 02:04:56PM +0530, Shubhrajyoti wrote:
> >> @@ -1155,7 +1187,7 @@ omap_i2c_probe(struct platform_device *pdev)
> >>  
> >>  		dev->fifo_size = (dev->fifo_size / 2);
> >>  
> >> -		if (dev->rev < OMAP_I2C_REV_ON_3630_4430)
> >> +		if (dev->rev < OMAP_I2C_REV_ON_3630)
> >>  			dev->b_hw = 1; /* Enable hardware fixes */
> > looks like this was applicable to 4430 too, what happened ?
> No actually this can be deleted completely once the
> start -> transaction -> stop sequence recommendation is followed.

yes, but we're not there just yet and this patch is changing the
behavior of the driver in ways which don't belong to $SUBJECT.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121105/a8bb6ef4/attachment.sig>
