From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 20 May 2014 16:14:28 +0100
Subject: [PATCH 4/7] mfd: twl4030-power: Add recommended idle configuration
In-Reply-To: <1400031250-29542-5-git-send-email-tony@atomide.com>
References: <1400031250-29542-1-git-send-email-tony@atomide.com>
 <1400031250-29542-5-git-send-email-tony@atomide.com>
Message-ID: <20140520151428.GZ24991@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> These settings are based on the "Recommended Sleep Sequences for
> the Zoom Platform" pdf at:
> 
> http://omappedia.com/wiki/File:Recommended_Sleep_Sequences_Zoom.pdf
> 
> These settings assume most of the regulators are under control of
> Linux, and twl4030 only cuts off VDD1 and VDD2 during off-idle as
> Linux cannot do it.
> 
> For any board specific changes to these, let's patch them in as
> changes to the generic data in the follow-up patches. This keeps
> the board specific changes small.
> 
> Note that this does not consider the twl5030 errata 27 and 28.
> That can be added later on after it has been tested. For more
> information about errata 27 and 28, please see:
> 
> https://github.com/openembedded/openembedded/blob/master/recipes/linux/linux-omap-2.6.39/mfd/0012-MFD-TWL4030-workaround-changes-for-Erratum-27.patch
> 
> Cc: Peter De Schrijver <pdeschrijver@nvidia.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  .../devicetree/bindings/mfd/twl4030-power.txt      |   4 +
>  drivers/mfd/twl4030-power.c                        | 103 +++++++++++++++++++++
>  2 files changed, 107 insertions(+)

Assuming the magic numbers are replaced by transparent #defines:

  Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
