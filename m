From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 22 Jul 2013 14:28:36 +0200
Subject: [PATCH v3 08/31] fs_enet: cleanup clock API use
In-Reply-To: <1374495298-22019-9-git-send-email-gsi@denx.de>
References: <1374166855-7280-1-git-send-email-gsi@denx.de>
 <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1374495298-22019-9-git-send-email-gsi@denx.de>
Message-ID: <51ED2574.9020105@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/22/2013 02:14 PM, Gerhard Sittig wrote:
> make the Freescale ethernet driver get, prepare and enable the FEC clock
> during probe(); disable, unprepare and put the clock upon remove(); hold
> a reference to the clock over the period of use; use devm_{get,put}_clk()

There's no need for devm_clk_put(), devm will take care of this.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130722/3ac63ea1/attachment.sig>
