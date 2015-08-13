From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 13 Aug 2015 12:11:18 +0200
Subject: [PATCH] can: at91: move at91_can_data to at91_can.c
In-Reply-To: <1439217894-15230-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1439217894-15230-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <55CC6D46.8020202@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10/2015 04:44 PM, Alexandre Belloni wrote:
> struct at91_can_data is now only used inside the driver, move it to
> its c file.

It was supposed to be the interface between the board and the CAN
driver. In commit 4403ac46edcdb51e92d36ad9f00ea3bbb766342e the
at91sam9263 board was removed. As the driver has no support for DT
transceiver switch, this functionality was lost. We should either remove
the transceiver support or add a DT regulator for this.

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 455 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150813/726599ba/attachment.sig>
