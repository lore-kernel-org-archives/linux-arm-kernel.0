From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 23 Jan 2013 14:49:36 +0100
Subject: [PATCH 1/2] misc/at24: Add at24c512b eeprom support
In-Reply-To: <CA+8Hj80=Mk1gMSC9gcRT_XPFrEdRxifaB9FNMtkn3BkUkv9bGA@mail.gmail.com>
References: <1358922764-31654-1-git-send-email-Ying.Liu@freescale.com>
 <CACRpkdbQcyO82Z7+v61VmJBOHuPVT2ZphQQT7OpZ9edYbho5YQ@mail.gmail.com>
 <20130123125001.GG16264@pengutronix.de>
 <CA+8Hj80=Mk1gMSC9gcRT_XPFrEdRxifaB9FNMtkn3BkUkv9bGA@mail.gmail.com>
Message-ID: <20130123134936.GH16264@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> There are some difference between 24c512 and 24c512b about the system
> reset procedure, according to the two devices' spec:
> 24c512b:(a) Create a start bit condition, (b)clock 9 cycles, (c)
> create another start bit followed by stop bit condition.
> 24c512:(a) Clock up to 9 cycles, (b) look for SDA high in each cycle
> while SCL is high and then, (c) create a start condition as SDA is
> high.
> Could this be a reason to add an entry for 24c512b?

Since the entries in at24_ids[] are the same, no. If they would differ,
that is a reason.

> Now, I think the correct vendor name should be "at" or "atmel".

"atmel" would be better, but the MX28EVK doesn't even have an I2C eeprom
by default IIRC? But that is unrelated to your patch.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130123/dab379ec/attachment.sig>
