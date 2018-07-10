From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 10 Jul 2018 16:19:40 +0200
Subject: [PATCH V4 3/5] mailbox: imx: add imx mu support
In-Reply-To: <1531061817-1980-4-git-send-email-aisheng.dong@nxp.com>
References: <1531061817-1980-1-git-send-email-aisheng.dong@nxp.com>
 <1531061817-1980-4-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20180710141940.oed3kwhbplnykl36@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Jul 08, 2018 at 10:56:55PM +0800, Dong Aisheng wrote:
> This is used for i.MX multi core communication.
> e.g. A core to SCU firmware(M core) on MX8.
> 
> Tx is using polling mode while Rx is interrupt driven and
> schedule a hrtimer to receive remain words if have more than
> 4 words.

You told us that using interrupts is not possible due to miserable
performance, we then provided you a way with which you could poll.  Why
are you using interrupts now?

We also suggested a way how the SCU mode could be integrated into the
generic MU support driver Oleksij posted and now you send a driver which
uses the same name as Oleksijs driver, but it only and exclusively works
in SCU mode. This doesn't bring us forward.

We suggested a binding that allows coexisting of the SCU mode and the
generic mode of the MU by putting the mode information into the second
mbox-cell. Why don't you use this?

I don't think it's necessary to rewrite Oleksijs driver, instead it
should rather be extended with the code I already provided as an
example. With that we could make both of us happy since we can both
have a suitable driver and even share most of the MU code.

Regards,
Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
