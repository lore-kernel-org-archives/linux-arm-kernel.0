From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 28 Aug 2017 18:01:21 +0200
Subject: [RESEND PATCH v5 00/16] eeprom: at24: Add OF device ID table
In-Reply-To: <CABxcv=mdbE0QGjoi3aLzxRqM3-MbkQ_Ai6fShcGVUGSNNqqrqw@mail.gmail.com>
References: <20170615185418.13980-1-javier@dowhile0.org>
 <20170731153009.xkjknygpmckv2pfp@ninjato>
 <CABxcv=mdbE0QGjoi3aLzxRqM3-MbkQ_Ai6fShcGVUGSNNqqrqw@mail.gmail.com>
Message-ID: <20170828160121.gu4wf7jqu4ditksc@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > But there is a dependency, no? If I apply the driver patch,
> > non-converted device trees will not find their eeproms anymore. So, I
> 
> I don't think that's correct. If you apply this patch before the DTS
> changes, the driver will still match using the I2C device ID table
> like it has been doing it until today.

My tests do not confirm this. If I add a node with a "renesas,24c01"
compatible to my board, it works before your patch, but not after. If I
change it to "atmel,24c01" it works even after your patch. I haven't
looked into it, though, maybe i2c_of_match_device_sysfs() is stepping on
our foots here?

Did you test and did it work for you?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170828/a9aba751/attachment.sig>
