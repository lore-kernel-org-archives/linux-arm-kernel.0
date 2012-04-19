From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 19 Apr 2012 22:39:15 +0200
Subject: [PATCH v4] i2c: Add device tree support to i2c-pnx.c
In-Reply-To: <4F903E0C.6010604@antcom.de>
References: <1334850612-24151-1-git-send-email-stigge@antcom.de>
 <20120419160715.GD24987@pengutronix.de>
 <4F903E0C.6010604@antcom.de>
Message-ID: <20120419203915.GB28005@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 19, 2012 at 06:32:12PM +0200, Roland Stigge wrote:
> Hi,
> 
> On 04/19/2012 06:07 PM, Wolfram Sang wrote:
> >> + - clock-frequency: desired I2C bus clock frequency in Hz,
> >> Default: 100000 Hz + - pnx,timeout: I2C bus timeout in
> >> milliseconds, Default: 10 ms
> > 
> > I'd like to repeat my question to the devicetree folks here: Can we
> > have timeout generic? It doesn't make sense to me to have that per
> > vendor again and again.
> 
> Sounds completely reasonable.
> 
> To help make the devicetree conversion into 3.5, I would prefer to
> integrate the "vendor,timeout" as-is if a longish standardization
> process would block this, considering that we luckily only have 2-3 of
> such timeout definitions currently.

The "blocking" argument will be true for most dt-conversions. Only thing
that might change is that the argument will then be "we already have
9-10 of such timeouts, so we can have another one" ;)

I've been there before, if you make one exception once, other people
will nail you on that. I'd like to avoid that.

Let's just hope we can agree on "timeout" quickly and all will be fine.

> I'd volunteer to clean up later by preparing a patch when there is a
> standard timeout defined.

The problem with bindings is that you must support them forever once
introduced. Old device-trees should still work with newer kernels.
 
> If we have a solution soon, I will prepare a new version of the patch,
> of course, in the next days.

Thanks. One question, though: Will it really block dt-conversion? The
whole conversion should not be depending on the i2c-driver?

> > Did you change this, too? Timeouts are better readable in dec :)
> 
> Right. But even when removing the "0x" in the timeout line above, it's
> still hex, see Documentation/devicetree/booting-without-of.txt
> 
> Or did I get sth. wrong?

I think the document is probably outdated :( "clock-frequency" is also
without 0x and dec.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120419/eb09c00a/attachment.sig>
