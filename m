From: balbi@ti.com (Felipe Balbi)
Date: Mon, 2 Jul 2012 14:33:15 +0300
Subject: [PATCH v2 05/17] i2c: omap: split out [XR]DR and [XR]RDY
In-Reply-To: <4FE991DA.5070301@ti.com>
References: <1339691067-919-1-git-send-email-balbi@ti.com>
 <1339691067-919-6-git-send-email-balbi@ti.com>
 <4FE991DA.5070301@ti.com>
Message-ID: <20120702113314.GA2730@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 26, 2012 at 04:11:30PM +0530, Shubhrajyoti wrote:
> Hi Felipe,
> On Thursday 14 June 2012 09:54 PM, Felipe Balbi wrote:
> >  			return IRQ_HANDLED;
> >  		}
> >  
> > -		if (stat & (OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR)) {
> > +		if (stat & OMAP_I2C_STAT_RDR) {
> >  			u8 num_bytes = 1;
> >  
> > +			if (dev->fifo_size)
> > +				num_bytes = dev->fifo_size;
> In case of a draining interrupt. The byte count may not be the fifo size.
> Do you agree?

hmm... indeed, that should be dev->buf_len... can you fix that up or
want me to resend ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120702/5923dc39/attachment.sig>
