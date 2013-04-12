From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 12 Apr 2013 17:13:25 +0100
Subject: [PATCH 3/8] dmaengine: ste_dma40: Actually write the runtime
 configuration to registers
In-Reply-To: <CAH+eYFB_fYmCjvh5PXKRhd-FnaWfeu+LtH+q3VywhCk-PYhHVQ@mail.gmail.com>
References: <1365532783-27425-1-git-send-email-lee.jones@linaro.org>
 <1365532783-27425-3-git-send-email-lee.jones@linaro.org>
 <CAH+eYFB_fYmCjvh5PXKRhd-FnaWfeu+LtH+q3VywhCk-PYhHVQ@mail.gmail.com>
Message-ID: <20130412161325.GB18459@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 12 Apr 2013, Rabin Vincent wrote:

> 2013/4/9 Lee Jones <lee.jones@linaro.org>:
> > Someone has spent a fair amount of effort writing a runtime configuration
> > changing algorithm for DMA clients. However, the config appears to never
> > actually make it to hardware. In order for the configuration to take hold
> > we need to issue a d40_config_write(), as this is the routine which writes
> > it into the hardware's registers.
> 
> No, it's not.  This function is only for initial configuration which
> should only be written when the channel is allocated.  In fact, by
> calling it here in runtime_config, you are introducing a serious bug:
> other logical channels on the same physical channel will stop because of
> the SSLNK/SDLNK of the physical channel being zeroed.
> 
> The runtime config already makes it the hardware in the existing code,
> via d40_*_cfg().

Ah, I see. I'll move it all back and investigate my bug further then.

Thanks for taking the time to write such a well written review.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
