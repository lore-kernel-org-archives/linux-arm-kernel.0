From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 27 Apr 2012 16:59:36 +0200
Subject: possible MXS-i2c bug
In-Reply-To: <201204270110.21377.marex@denx.de>
References: <201204261326.29388.marex@denx.de>
 <20120426114201.GC3548@pengutronix.de>
 <201204270110.21377.marex@denx.de>
Message-ID: <20120427145936.GD16504@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> I've been thinking about the DMA approach. The problem I found out is that we 
> need to transfer all messages we're given at time in one DMA chain ... at least 
> that's how I understand it from the FSL manual (see Fig. 27-10 in the mx28 
> manual).

I can't follow you:  mxs_i2c_xfer() gets a list of messages, yet they
are iterated over in mxs_i2c_xfer_msg(). A single I2C message is
unscattered and can't be bigger than 64KB, so that should be doable?

Am I missing something by already being in weekend-mode? :)

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120427/115b71e8/attachment.sig>
