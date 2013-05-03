From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Fri, 03 May 2013 11:53:47 +0200
Subject: [PATCH,
 RFC 01/22] can: move CONFIG_HAVE_CAN_FLEXCAN out of CAN_DEV
In-Reply-To: <1367507786-505303-2-git-send-email-arnd@arndb.de>
References: <1367507786-505303-1-git-send-email-arnd@arndb.de>
 <1367507786-505303-2-git-send-email-arnd@arndb.de>
Message-ID: <5183892B.8020400@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/02/2013 05:16 PM, Arnd Bergmann wrote:
> CONFIG_HAVE_CAN_FLEXCAN is a silect symbol that is meant to be selected
> by platforms that support this driver, but that is not possible without
> also selecting CAN_DEV, unless we move it out of the "if CAN_DEV"
> section of the Kconfig file.
> 
> warning: (SOC_IMX28 && SOC_IMX25 && SOC_IMX35 &&
>  IMX_HAVE_PLATFORM_FLEXCAN && SOC_IMX53 && SOC_IMX6Q) selects HAVE_CAN_FLEXCAN
>  which has unmet direct dependencies (NET && CAN && CAN_DEV)

With the advent of multi platform kernels I like to get rid of
HAVE_CAN_FLEXCAN completely.

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
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130503/0c3ea060/attachment.sig>
