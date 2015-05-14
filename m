From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 14 May 2015 17:41:56 +0200
Subject: [PATCH v2 5/5] can: flexcan: Add support for non RX-FIFO mode
In-Reply-To: <1431603215-25546-6-git-send-email-bhupesh.sharma@freescale.com>
References: <1431603215-25546-1-git-send-email-bhupesh.sharma@freescale.com>
 <1431603215-25546-6-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <5554C244.80809@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/14/2015 01:33 PM, Bhupesh Sharma wrote:
> This patch adds support for non RX-FIFO (legacy) mode in
> the flexcan driver.
> 
> On certain SoCs, the RX-FIFO support might be broken, as
> a result we need to fall-back on the legacy (non RX-FIFO)
> mode to receive CAN frames.
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
> Signed-off-by: Sakar Arora <Sakar.Arora@freescale.com>

The non FIFO mode doesn't guarantee the order of the incoming frames,
not does not even try to...this is not acceptable. I'm currently working
on a patch by David Jander that brings in non FIFO mode, but tries to
keep the order of the frames.

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
Size: 801 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150514/f269ccab/attachment.sig>
