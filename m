From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 03 Nov 2014 17:52:11 +0100
Subject: [PATCH 4/7] can: m_can: add a bit delay after setting CCCR_INIT
 bit
In-Reply-To: <1414579527-31100-4-git-send-email-b29396@freescale.com>
References: <1414579527-31100-1-git-send-email-b29396@freescale.com>
 <1414579527-31100-4-git-send-email-b29396@freescale.com>
Message-ID: <5457B2BB.9050807@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/29/2014 11:45 AM, Dong Aisheng wrote:
> The spec mentions there may be a delay until the value written to
> INIT can be read back due to the synchronization mechanism between the
> two clock domains. But it does not indicate the exact clock cycles needed.
> The 5us delay is a test value and seems ok.
> 
> Without the delay, CCCR.CCE bit may fail to be set and then the
> initialization fail sometimes when do repeatly up and down.
> 
> Signed-off-by: Dong Aisheng <b29396@freescale.com>

Applied to can/master.

Thanks,
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
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141103/634797a0/attachment.sig>
