From: andy.gross@linaro.org (Andy Gross)
Date: Wed, 6 Apr 2016 01:05:27 -0500
Subject: [PATCH v2 3/5] dmaengine: qcom: bam_dma: add controlled remotely
 dt property
In-Reply-To: <20160405234425.GD11586@vkoul-mobl.iind.intel.com>
References: <1459896982-30171-1-git-send-email-stanimir.varbanov@linaro.org>
 <1459896982-30171-4-git-send-email-stanimir.varbanov@linaro.org>
 <20160405234425.GD11586@vkoul-mobl.iind.intel.com>
Message-ID: <20160406060527.GC3873@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 05, 2016 at 04:44:25PM -0700, Vinod Koul wrote:
> On Wed, Apr 06, 2016 at 01:56:20AM +0300, Stanimir Varbanov wrote:
> >  Documentation/devicetree/bindings/dma/qcom_bam_dma.txt | 2 ++
> >  drivers/dma/qcom/bam_dma.c                             | 7 +++++++
> 
> The binding should be a separate patch..
> 
> >  
> > +	bdev->controlled_remotely = of_property_read_bool(pdev->dev.of_node,
> > +						"qcom,controlled-remotely");
> > +
> 
> we need some defaults here, how will this work with boards withe older DT.

By default the bam driver should assume that it can access the registers.  It is
only in specific cases where we have trustzone locking down these registers and
assigning them to other remote processors.
