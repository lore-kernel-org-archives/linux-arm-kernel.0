From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 23 May 2011 10:23:15 +0200
Subject: [PATCH v4 1/1] can: add pruss CAN driver.
In-Reply-To: <4DD9FCFC.10803@hartkopp.net>
References: <1303474267-6344-1-git-send-email-subhasish@mistralsolutions.com>
	<4DCB88A4.2010901@grandegger.com> <4DCBF1B6.6000104@hartkopp.net>
	<201105221230.56243.arnd@arndb.de> <4DD9FCFC.10803@hartkopp.net>
Message-ID: <4DDA1973.4090309@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/23/2011 08:21 AM, Oliver Hartkopp wrote:

[...]

> In 'real world' CAN setups you'll never see 21.000 CAN frames per second (and
> therefore 21.000 irqs/s) - you are usually designing CAN network traffic with
> less than 60% busload. So interrupt rates somewhere below 1000 irqs/s can be
> assumed.
> 
> From what i've seen so far a 3-4 messages rx FIFO and NAPI support just make it.
> 
> @Marc/Wolfgang: Would this be also your recommendation for a CAN controller
> design that supports SocketCAN in the best way?

If you have a rx FIFO NAPI is the way to go. For a single mailbox it
adds overhead, if you can read the CAN frame in the interrupt handler.
The error messages should probably generated from NAPI, too. Especially
the I'm-the-only-CAN-node-on-the-net-and-get-no-ACK error message.

However IIRC David said that every new driver should implement NAPI.

> As the Linux network stack supports hardware timestamps too, this could be an
> additional (optional!) feature.

regards, Marc
-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 262 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110523/24c9c00f/attachment.sig>
