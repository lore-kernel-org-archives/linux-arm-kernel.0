From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 25 May 2015 13:54:39 +0800
Subject: [PATCH v3 1/6] rtc: arm: imx: snvs: change use syscon to access
 register
In-Reply-To: <20150522080749.GI3244@piout.net>
References: <1432225012-20598-1-git-send-email-Frank.Li@freescale.com>
 <1432225012-20598-2-git-send-email-Frank.Li@freescale.com>
 <20150522080749.GI3244@piout.net>
Message-ID: <20150525055438.GC3264@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 22, 2015 at 10:07:49AM +0200, Alexandre Belloni wrote:
> Hi,
> 
> This looks good to me, a few nits below
> 
> On 22/05/2015 at 00:16:47 +0800, Frank.Li at freescale.com wrote :
> > -	spin_unlock_irqrestore(&data->lock, flags);
> > +	regmap_update_bits(data->regmap, data->offset + SNVS_LPCR,
> > +			  (SNVS_LPCR_LPTA_EN | SNVS_LPCR_LPWUI_EN),
> That line is not properly aligned (missing one space)
> 
> [...]
> 
> > +	if (of_device_is_compatible(snvs_np, "syscon")) {
> > +		data->regmap = syscon_node_to_regmap(snvs_np);
> > +		data->offset = 0x34;
> > +	} else {
> > +		pr_warning("snvs rtc: you use old dts file, please update it\n");
> 
> This should be pr_warn()

It should be dev_warn().

Shawn
