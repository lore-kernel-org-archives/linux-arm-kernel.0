From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 24 Jan 2012 10:33:18 +0100
Subject: [PATCH RFC 1/2] watchdog : omap_wdt : Implement
 WDIOC_GETBOOTSTATUS for omap3+
In-Reply-To: <B5906170F1614E41A8A28DE3B8D12143317902D6@DBDE01.ent.ti.com>
References: <1327317188-14782-1-git-send-email-shubhrajyoti@ti.com>
 <1327317188-14782-2-git-send-email-shubhrajyoti@ti.com>
 <B5906170F1614E41A8A28DE3B8D12143317901B9@DBDE01.ent.ti.com>
 <CAM=Q2ctL_Z5P6=NwAWBHD2bR=xqHMCF15g6v0Ap=hJMPdgXwyQ@mail.gmail.com>
 <B5906170F1614E41A8A28DE3B8D12143317902D6@DBDE01.ent.ti.com>
Message-ID: <20120124093318.GA2609@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Just returning the register content does not help much and looking at other
> implementations, like Blackfin, I am guessing this IOCTL is supposed to give
> a yes/no sort of result.

It needs to return WDIOF_* flags as defined in include/linux/watchdog.h.
Check also Documentation/watchdog/watchdog-api.txt for further info.
Yes, not all drivers follow this style, sadly.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120124/f1918c62/attachment.sig>
