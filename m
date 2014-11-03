From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 03 Nov 2014 21:49:38 +0100
Subject: [PATCH 1/7] can: m_can: fix possible sleep in napi poll
In-Reply-To: <5457CB6B.3080002@hartkopp.net>
References: <1414579527-31100-1-git-send-email-b29396@freescale.com>
 <5457B517.8030805@pengutronix.de> <5457CB6B.3080002@hartkopp.net>
Message-ID: <5457EA62.5040906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/03/2014 07:37 PM, Oliver Hartkopp wrote:
> you can omit the 'stable' tag as this driver just emerged in 3.18 - which is
> currently in 3.18-rc3 state.

Thanks! fixed.

> If possible I would suggest to push all 7 patches via can/master as it is
> pretty bad to say "M_CAN was introduced in 3.18 but M_CAN with CAN FD is
> working since 3.19".

Sorry, probably not, as CAN FD is a new feature. However we may talk to
David, as the m_can driver was introduced in 3.18 anyways, so it's
unlikely to break anything with this patch.

> This will produce confusion as the M_CAN core has built-in CAN FD support.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141103/999f18e9/attachment.sig>
