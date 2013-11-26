From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 25 Nov 2013 19:49:01 -0500
Subject: [PATCH 1/3] usb: dwc3: Add Keystone specific glue layer
In-Reply-To: <20131125203956.GI18046@saruman.home>
References: <1385410581-12148-1-git-send-email-w-kwok2@ti.com>
 <1385410581-12148-2-git-send-email-w-kwok2@ti.com>
 <20131125203956.GI18046@saruman.home>
Message-ID: <5293EFFD.9000508@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 25 November 2013 03:39 PM, Felipe Balbi wrote:
> Hi,
> 

[...]

> 
>> +	kdwc3_dma_mask = dma_get_mask(dev);
>> +	dev->dma_mask = &kdwc3_dma_mask;
>> +
>> +	error = kdwc3_enable(kdwc);
> 
> I would drop this function and just add your clk_prepare() here, then
> move clk_enable()/clk_disable() to ->runtime_resume/->runtime_suspend()
> respectively. Then you could just call pm_runtime_get_sync() when you
> need to access your registers and pm_runtime_put() when you want to drop
> the clock reference.
> 
> this will even make PM implementation a lot easier for you going
> forward.
> 
Just to make the PM runtime part clear, there are few issues with PM
core clock layer [1], hence drivers is using clock layer. Its trivial
to update the driver though once the issue is sorted out.

Meanwhile driver development continue to be with clock calls. 

Regards,
Santosh

[1] https://groups.google.com/forum/#!msg/linux.kernel/w5gFxFsIK-c/jYcnRET_EdAJ
