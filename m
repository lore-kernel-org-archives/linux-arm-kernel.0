From: marex@denx.de (Marek Vasut)
Date: Mon, 16 Jul 2012 14:24:24 +0200
Subject: [PATCH 12/12] USB: chipidea: add imx usbmisc support
In-Reply-To: <1342076512-19207-13-git-send-email-richard.zhao@freescale.com>
References: <1342076512-19207-1-git-send-email-richard.zhao@freescale.com>
 <1342076512-19207-13-git-send-email-richard.zhao@freescale.com>
Message-ID: <201207161424.24873.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Richard Zhao,

[...]

> +static int imx6q_usbmisc_init(struct usbmisc *usbmisc, int id)
> +{
> +	u32 reg;
> +
> +	if (usbmisc->dis_oc) {
> +		reg = readl_relaxed(usbmisc->base + id * 4);
> +		writel_relaxed(reg | (1 << 7), usbmisc->base + id * 4);


1<< 7 ? This yearns for fixing with proper #defined value.

[...]

The rest of the patches looks OK, you can add my Reviewed-By: <marex@denx.de> to 
those. This one though will need further investigation.

Best regards,
Marek Vasut
