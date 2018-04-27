From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Fri, 27 Apr 2018 09:21:38 +0200
Subject: [PATCH 0/3] can: fix ndo_start_xmit()'s return type
In-Reply-To: <20180426211339.30821-1-luc.vanoostenryck@gmail.com>
References: <20180426211339.30821-1-luc.vanoostenryck@gmail.com>
Message-ID: <62fdb875-0940-3396-612c-06ef7533399b@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/26/2018 11:13 PM, Luc Van Oostenryck wrote:
> ndo_start_xmit() is defined as returing an 'netdev_tx_t'.
> However, several can drivers use 'int' as the return type
> of their start_xmit() method.
> This series contains the fix for all three of them.
> 
> Luc Van Oostenryck (3):
>   can: janz-ican3: fix ican3_xmit()'s return type
>   can: sun4i: fix sun4ican_start_xmit()'s return type
>   can: xilinx: fix xcan_start_xmit()'s return type
> 
>  drivers/net/can/janz-ican3.c | 2 +-
>  drivers/net/can/sun4i_can.c  | 2 +-
>  drivers/net/can/xilinx_can.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Applied all 3 to linux-can-next, added similar patch for the flexcan driver.

Tnx,
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
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180427/35ebe084/attachment.sig>
