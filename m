From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 26 Apr 2016 21:55:30 +0530
Subject: [PATCH V17 2/3] dmaengine: qcom_hidma: add debugfs hooks
In-Reply-To: <b068ead6474f2ffee5acef9ea799aba3@codeaurora.org>
References: <1460384473-5775-1-git-send-email-okaya@codeaurora.org>
 <1460384473-5775-3-git-send-email-okaya@codeaurora.org>
 <20160426033029.GB2274@localhost>
 <b068ead6474f2ffee5acef9ea799aba3@codeaurora.org>
Message-ID: <20160426162529.GK2274@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 26, 2016 at 08:08:16AM -0400, okaya at codeaurora.org wrote:
> On 2016-04-25 23:30, Vinod Koul wrote:
> >On Mon, Apr 11, 2016 at 10:21:12AM -0400, Sinan Kaya wrote:
> >
> >>+static int hidma_chan_stats(struct seq_file *s, void *unused)
> >>+{
> >>+	struct hidma_chan *mchan = s->private;
> >>+	struct hidma_desc *mdesc;
> >>+	struct hidma_dev *dmadev = mchan->dmadev;
> >>+
> >>+	pm_runtime_get_sync(dmadev->ddev.dev);
> >
> >debug shouldn't power up device, why do you want to do that
> 
> 
> Clocks are turned off while the hw is idle. I can?t reach hw
> registers without restoring power.

Hmm, have you thought about using regmap?

-- 
~Vinod
