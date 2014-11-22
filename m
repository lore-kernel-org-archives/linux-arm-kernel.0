From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 22 Nov 2014 19:14:06 +0100
Subject: [PATCH 2/3] i2c: slave-eeprom: add eeprom simulator driver
In-Reply-To: <20141121141624.GT27002@pengutronix.de>
References: <1416326695-13083-1-git-send-email-wsa@the-dreams.de>
 <1416326695-13083-3-git-send-email-wsa@the-dreams.de>
 <20141121071941.GK27002@pengutronix.de>
 <20141121141624.GT27002@pengutronix.de>
Message-ID: <20141122181406.GC9698@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

please don't quote so much :)

> > > +	case I2C_SLAVE_REQ_READ_END:
> > > +		eeprom->buffer_idx++;
> > You don't check here for buffer_idx >= ARRAY_SIZE(buffer)?
> > Ditto in the I2C_SLAVE_REQ_WRITE_END case.
> I just noticed that buffer_idx is an u8, so it overflows at 255+1. So
> the probe routine should error out if size is bigger than 256.

But size is currently fixed to 256, so all is fine. Yes, if we extend it
for bigger sizes, all that stuff needs to be taken care of, right.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141122/40053468/attachment-0001.sig>
