From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 22 Jul 2013 14:31:21 +0200
Subject: [PATCH v3 11/31] net: can: mscan: improve clock API use
In-Reply-To: <1374495298-22019-12-git-send-email-gsi@denx.de>
References: <1374166855-7280-1-git-send-email-gsi@denx.de>
 <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1374495298-22019-12-git-send-email-gsi@denx.de>
Message-ID: <51ED2619.5040107@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/22/2013 02:14 PM, Gerhard Sittig wrote:
> the .get_clock() callback is run from probe() and might allocate
> resources, introduce a .put_clock() callback that is run from remove()
> to undo any allocation activities

looks good

> use devm_get_clk() upon lookup (for SYS and REF) to have the clocks put
> upon driver unload

fine

> assume that resources get prepared but not necessarily enabled in the
> setup phase, make the open() and close() callbacks of the CAN network
> device enable and disable a previously acquired and prepared clock

I think you should call prepare_enable and disable_unprepare in the
open/close functions.

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
Size: 259 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130722/2eeb3687/attachment.sig>
