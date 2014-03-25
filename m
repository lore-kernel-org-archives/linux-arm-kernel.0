From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 25 Mar 2014 10:11:48 +0100
Subject: [PATCH v3] i2c: new bus driver for efm32
In-Reply-To: <20140325090700.GL23076@pengutronix.de>
References: <1395414236-22647-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20140324170131.GB7524@katana>
 <20140325090700.GL23076@pengutronix.de>
Message-ID: <20140325091148.GA2570@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 25, 2014 at 10:07:00AM +0100, Uwe Kleine-K?nig wrote:
> Hello,
> 
> On Mon, Mar 24, 2014 at 06:01:31PM +0100, Wolfram Sang wrote:
> > And checkpatch said:
> > 
> > WARNING: braces {} are not necessary for any arm of this statement
> > #345: FILE: drivers/i2c/busses/i2c-efm32.c:239:
> > +		if (cur_msg->flags & I2C_M_RD) {
> > ...
> hmm the whole block reads:
> 
>         case REG_STATE_STATE_DATA:
>                 if (cur_msg->flags & I2C_M_RD) {
>                         efm32_i2c_recv_next_byte(ddata);
>                 } else {
>                         /* wait for Ack or Nack of slave */
>                 }
>                 break;
> 
> so just removing the braces does the wrong thing. Is this a false
> positive checkpatch warning? Andy? Joe?
> 
> I can make it:
> 
> 		if (cur_msg->flags & I2C_M_RD)
> 			efm32_i2c_recv_next_byte(ddata);
> 		/* in the write case wait for Ack or Nack of slave */
> 
> but I consider the version above more readable.

Well, OK, I let you decide.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140325/5ba78bba/attachment.sig>
