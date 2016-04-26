From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 26 Apr 2016 09:00:30 +0530
Subject: [PATCH V17 2/3] dmaengine: qcom_hidma: add debugfs hooks
In-Reply-To: <1460384473-5775-3-git-send-email-okaya@codeaurora.org>
References: <1460384473-5775-1-git-send-email-okaya@codeaurora.org>
 <1460384473-5775-3-git-send-email-okaya@codeaurora.org>
Message-ID: <20160426033029.GB2274@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 11, 2016 at 10:21:12AM -0400, Sinan Kaya wrote:

> +static int hidma_chan_stats(struct seq_file *s, void *unused)
> +{
> +	struct hidma_chan *mchan = s->private;
> +	struct hidma_desc *mdesc;
> +	struct hidma_dev *dmadev = mchan->dmadev;
> +
> +	pm_runtime_get_sync(dmadev->ddev.dev);

debug shouldn't power up device, why do you want to do that

-- 
~Vinod
