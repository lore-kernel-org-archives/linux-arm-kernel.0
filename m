From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 7 Feb 2012 16:11:58 +0100
Subject: [PATCH v5] I2C: add CSR SiRFprimaII on-chip I2C controllers driver
In-Reply-To: <CAGsJ_4yJOg8XNfD=tgwPU_57BroBOBGvA428tG6_eUnYX2v8OQ@mail.gmail.com>
References: <1327846668-3053-1-git-send-email-21cnbao@gmail.com>
 <20120205223757.GA10680@nekote.pengutronix.de>
 <CAGsJ_4yHn1M3s6CPezaW_jwOcsX6NuaZRHcNWX0qnSfhx30AHQ@mail.gmail.com>
 <20120206224714.GB25703@pengutronix.de>
 <CAGsJ_4yJOg8XNfD=tgwPU_57BroBOBGvA428tG6_eUnYX2v8OQ@mail.gmail.com>
Message-ID: <20120207151117.GJ2539@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Barry,

> if ACK is not received, an interrupt will be got and related register
> status can show this error. that is just a common feature in almost
> all i2c controllers? so the naming is confused. i just copied it from
> the spec.

Yes, this is common and yes, the naming is confusing :) This is why I
asked if it really does what I believed it does. All is fine, no need
for a change.

> the mail webpages and clients really fails to show the difference. i

Not all of them. gmane looks OK both in web-interface and via NNTP.

> >> >> + ? ? siic->irq = platform_get_irq(pdev, 0);
> >> >> + ? ? if (siic->irq < 0) {
> >> >> + ? ? ? ? ? ? err = -EINVAL;
> >> >> + ? ? ? ? ? ? goto out;
> >> >> + ? ? }
> >> >
> >> > return the error code here?
> >>
> >> out lable will free resources and return error code.
> >
> > Sorry, I meant the error code you received which is in siic->irq.
> 
> ok. err = -ENXIO

err = ssic->irq?

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120207/194e1c40/attachment.sig>
