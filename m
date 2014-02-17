From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 17 Feb 2014 09:26:58 +0000
Subject: [PATCH 1/2] mfd: palmas: support IRQ inversion at the board level
In-Reply-To: <1392415108-4365-1-git-send-email-swarren@wwwdotorg.org>
References: <1392415108-4365-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20140217092658.GC17875@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Stephen Warren <swarren@nvidia.com>
> 
> Some boards or SoCs have an inverter between the PMIC IRQ output pin and
> the IRQ controller input signal.
> 
> The IRQ specifier in DT is meant to represent the IRQ flags at the input
> to the IRQ controller.
> 
> The Palmas HW's IRQ output has configurable polarity. The driver
> currently selects the output polarity by querying the input polarity at
> the IRQ controller. This works fine if the IRQ signal is routed directly
> from the PMIC to the IRQ controller with no intervening logic. However,
> if the signal is inverted between the two, this automatic polarity
> selection gets the wrong answer.
> 
> Add an additional optional DT and platform data parameter which indicates
> that such an inversion occurs. If this option is enabled, the Palmas
> driver will configure its IRQ output to the opposite polarity of the IRQ
> controller's input.
> 
> An alternative would have been to add a new non-optional DT parameter to
> indicate the exact desired output polarity. However, this would have been
> an incompatible change to the DT binding.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> If this patch could be applied to its own branch (w/ signed tag) in the
> MFD tree, that would great; then I can pull patch 1/2 into the Tegra tree
> so that I can apply patch 2/2 to the Tegra tree. Thanks.
> ---
>  Documentation/devicetree/bindings/mfd/palmas.txt | 6 ++++++
>  drivers/mfd/palmas.c                             | 4 ++++
>  include/linux/mfd/palmas.h                       | 1 +
>  3 files changed, 11 insertions(+)

For the core changes:
  Acked-by: Lee Jones <lee.jones@linaro.org>

NB: The DT guys prefer documentation to be submitted in a separate
patch these days.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
