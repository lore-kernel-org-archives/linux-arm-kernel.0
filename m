From: w.sang@pengutronix.de (Wolfram Sang)
Date: Sat, 21 Jul 2012 17:41:53 +0200
Subject: [PATCH 2/2 V3] MXS: Implement DMA support into mxs-i2c
In-Reply-To: <201207211611.58956.marex@denx.de>
References: <1341850974-11977-1-git-send-email-marex@denx.de>
 <20120715081715.GA2429@S2100-06.ap.freescale.net>
 <20120721124406.GA9946@pengutronix.de>
 <201207211611.58956.marex@denx.de>
Message-ID: <20120721154153.GA25874@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > Yet, if I know the compatible property for the mxs I2C driver, and also
> > know the CPU type (be it MX23 or MX28), I can deduce from that a lot of
> > information, including DMA channel. That is fix. Why encode it?
> 
> You know the compatible and the "fallback compatible". From the later one, you 
> can deduce nothing if that happens to kick in.

Even if the driver was matched because of an MX23-I2C "compatible"
binding, both devicetree and runtime could provide data that it actually
runs on MX28. That shouldn't be a problem.

> btw. the PIO discussion on DT discuss is completely ignored. How shall we 
> proceed, this driver is stalled for too long.

IIRC I mentioned that a discussion about the bindings won't make the
next merge window. That's why I proposed either module_parameter or
dropping the binding entirely as possible inbetween options.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120721/384e3d24/attachment.sig>
