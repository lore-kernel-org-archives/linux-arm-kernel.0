From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 04 Dec 2013 09:33:26 +0100
Subject: [PATCH v3 10/10] usb: chipidea: imx: Enable CI_HDRC_IMX_EHCI_QUIRK
In-Reply-To: <F281D0F91ED19E4D8E63A7504E8A6498041427E5@039-SN2MPN1-021.039d.mgd.msft.net>
References: <1383616525-10769-1-git-send-email-peter.chen@freescale.com>
 <1383616525-10769-11-git-send-email-peter.chen@freescale.com>
 <529E5215.5000107@pengutronix.de>
 <F281D0F91ED19E4D8E63A7504E8A6498041427E5@039-SN2MPN1-021.039d.mgd.msft.net>
Message-ID: <529EE8D6.2030600@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/04/2013 02:40 AM, Peter Chen wrote:
> There are some re-work for this serial, I will do it.
> But I don't get your mean why it needs to squash into another patch?

Let's look at the code again:

> -	if (imx_platform_flag->flags & CI_HDRC_IMX_SUPPORT_RUNTIME_PM)
> +	if (imx_platform_flag->flags & CI_HDRC_IMX_SUPPORT_RUNTIME_PM) {
>  		pdata.flags |= CI_HDRC_SUPPORTS_RUNTIME_PM;
>  		data->supports_runtime_pm = true;
>  	}

Without that patch, the driver will not compile.

before:

if ()
	/* code */
}

after:

if () {
	/* code */
}

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131204/38456ffe/attachment.sig>
