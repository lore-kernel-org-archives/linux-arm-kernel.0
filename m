From: kim.phillips@freescale.com (Kim Phillips)
Date: Thu, 5 Jul 2012 18:28:29 -0500
Subject: [PATCH v2] rtc: snvs: add Freescale rtc-snvs driver
In-Reply-To: <1341416294-3194-1-git-send-email-shawn.guo@linaro.org>
References: <1341416294-3194-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120705182829.d13d6992406e02e1024552e3@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 4 Jul 2012 23:38:14 +0800
Shawn Guo <shawn.guo@linaro.org> wrote:

> +static const struct of_device_id __devinitconst snvs_dt_ids[] = {
> +	{ .compatible = "fsl,sec-v4.0-mon-rtc-lp", },

the driver should be compatible with "fsl,sec-v4.0-mon", and its
probe function search for "fsl,sec-v4.0-mon-rtc-lp" sub-compatibles
(and possibly "fsl,sec-v4.0-mon-rtc-hp" in the future?).

Kim
