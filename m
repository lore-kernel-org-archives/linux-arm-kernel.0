From: pmeerw@pmeerw.net (Peter Meerwald)
Date: Wed, 8 Jan 2014 12:42:47 +0100 (CET)
Subject: Information about Atmel MXT224
In-Reply-To: <52CD04F1.8090100@gmail.com>
References: <52CD04F1.8090100@gmail.com>
Message-ID: <alpine.DEB.2.01.1401081228580.1454@pmeerw.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> I have tried atmel_mxt_ts driver (original driver from kernel 3.6.0 and 
> driver from linux-next/master branch copied to kernel 3.6.0) on i.MX27 
> board. The capacitive glass used is a "GE Touch" 
> SMT-F-057G007-B011-4:3-NP. It has 16 pads in X and 14 pads in Y. It is 
> correctly detected (with one warning/error).

> Does someone has some informations or the protocol guide, please ?

you need to request them from the distributor I guess, they docs are 
pretty good

> /* TSP */
> static struct mxt_platform_data mxt_platform_data = {
> 	.x_line			= 18,
> 	.y_line			= 11,
> 	.x_size			= 480,

shouldn't this be 16/14?

> 	.y_size			= 640,
> 	.blen			= 0x1,
> 	.threshold		= 0x28,
> 	.voltage		= 2800000,		/* 2.8V */
> 	.orient			= MXT_DIAGONAL_COUNTER,
> 	.irqflags		= IRQF_TRIGGER_FALLING,
> };

> atmel_mxt_ts 0-004b: No cfg data defined, skipping reg init
> atmel_mxt_ts 0-004b: Invalid object type

something goes wrong in the initialization; the object table of the 
chip doesn't match the register data fed in -- the mxt224 can be a bitch 
and play dead

regards, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
