From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 05 Nov 2014 15:29:37 +0100
Subject: [PATCH V3 3/3] can: m_can: workaround for transmit data less
 than 4 bytes
In-Reply-To: <1415193393-30023-3-git-send-email-b29396@freescale.com>
References: <1415193393-30023-1-git-send-email-b29396@freescale.com>
 <1415193393-30023-3-git-send-email-b29396@freescale.com>
Message-ID: <545A3451.2090302@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/05/2014 02:16 PM, Dong Aisheng wrote:
> At least on the i.MX6SX TO1.2 with M_CAN IP version 3.0.1, an issue with
> the Message RAM was discovered. Sending CAN frames with dlc less
> than 4 bytes will lead to bit errors, when the first 8 bytes of
> the Message RAM have not been initialized (i.e. written to).
> To work around this issue, the first 8 bytes are initialized in open()
> function.
> 
> Without the workaround, we can easily see the following errors:
> root at imx6qdlsolo:~# ip link set can0 up type can bitrate 1000000
> [   66.882520] IPv6: ADDRCONF(NETDEV_CHANGE): can0: link becomes ready
> root at imx6qdlsolo:~# cansend can0 123#112233
> [   66.935640] m_can 20e8000.can can0: Bit Error Uncorrected
> 
> Signed-off-by: Dong Aisheng <b29396@freescale.com>

Applied to can/master

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141105/ba1fc85e/attachment.sig>
