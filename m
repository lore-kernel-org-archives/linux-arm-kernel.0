From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 28 Feb 2012 09:52:50 +0800
Subject: [PATCH 5/6] ASoC: fsl: use platform_device_id table to match
 p1022_ds device
In-Reply-To: <4F4BF805.60807@freescale.com>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-6-git-send-email-shawn.guo@linaro.org>
 <4F4BF805.60807@freescale.com>
Message-ID: <20120228015248.GB13886@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 27, 2012 at 03:39:17PM -0600, Timur Tabi wrote:
> Shawn Guo wrote:
> 
> > -
> > -	/*
> > -	 * Check if we're actually running on a P1022DS.  Older device trees
> > -	 * have a model of "fsl,P1022" and newer ones use "fsl,P1022DS", so we
> > -	 * need to support both.  The SSI driver uses that property to link to
> > -	 * the machine driver, so have to match it.
> > -	 */
> 
> Please retain this paragraph somewhere.  It's important to explain why
> we're checking for both strings.
> 

Ok, it will be something like the following.

/*
 * Check if we're actually running on a P1022DS.  Older device trees
 * have a model of "fsl,P1022" and newer ones use "fsl,P1022DS", so we
 * need to support both.  The SSI driver uses that property to link to
 * the machine driver, so have to match it.
 */
static struct platform_device_id p1022_ds_ids[] = {
	{ .name = "snd-soc-p1022ds", },
	{ .name = "snd-soc-p1022", },
	{ /* sentinel */ }
};
MODULE_DEVICE_TABLE(platform, p1022_ds_ids);

-- 
Regards,
Shawn
