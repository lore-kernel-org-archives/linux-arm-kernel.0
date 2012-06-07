From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Thu, 07 Jun 2012 16:50:25 +0530
Subject: [alsa-devel] [PATCH v1 2/5] ASoC: mmp: add audio dma support
In-Reply-To: <CAMj5BkhtHaF=b=VDMoif_RxWR_Wdxc7qMpjH-SBO=yoA4W9LTA@mail.gmail.com>
References: <1338791851-21038-1-git-send-email-zhangfei.gao@marvell.com>
 <1338791851-21038-3-git-send-email-zhangfei.gao@marvell.com>
 <1339061042.1927.61.camel@vkoul-udesk3>
 <CAMj5Bkj+4qQqoDgz_d7eLK+QuVm41fnN5204tRpJ8NKrNsAjcg@mail.gmail.com>
 <1339063547.1927.63.camel@vkoul-udesk3>
 <CAMj5BkhtHaF=b=VDMoif_RxWR_Wdxc7qMpjH-SBO=yoA4W9LTA@mail.gmail.com>
Message-ID: <1339068025.1927.66.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-06-07 at 18:44 +0800, zhangfei gao wrote:
> Only exception is dmaengine_slave_config, since we have some specific config.
And why?

> +static bool filter(struct dma_chan *chan, void *param)
> +{
> +	struct mmp_dma_data *dma_data = param;
> +	bool found = false;
> +	char *devname;
> +
> +	devname = kasprintf(GFP_KERNEL, "%s.%d", dma_data->dma_res->name,
> +		dma_data->ssp_id);
> +	if ((strcmp(dev_name(chan->device->dev), devname) == 0) &&
> +		(chan->chan_id == dma_data->dma_res->start)) {
> +		chan->private = &dma_data->tdma_data;
chan->private is deprecated and should not be used 
> +		found = true;
> +	}
> +
> +	kfree(devname);
> +	return found;
> +}


-- 
~Vinod
