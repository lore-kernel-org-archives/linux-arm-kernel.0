From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 28 Oct 2013 10:03:13 +0800
Subject: [PATCH v3 3/5] usb: chipidea: imx: set CI_HDRC_IMX28_WRITE_FIX
 for imx28
In-Reply-To: <201310271725.37175.marex@denx.de>
References: <1382680943-9258-1-git-send-email-peter.chen@freescale.com>
 <1382680943-9258-3-git-send-email-peter.chen@freescale.com>
 <201310271725.37175.marex@denx.de>
Message-ID: <20131028020311.GB2839@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 27, 2013 at 05:25:36PM +0100, Marek Vasut wrote:
> > +static const struct of_device_id ci_hdrc_imx_dt_ids[] = {
> > +	{ .compatible = "fsl,imx28-usb", .data = &imx28_usb_data},
> > +	{ .compatible = "fsl,imx27-usb", .data = &imx27_usb_data},
> 
> Just a nit-pick, but the order here is wrong ;-)

Oh, no.  Before of_match_device() gets improved to find the best match,
we have to sort the table from the most specific entry to the most
generic one.

Shawn
