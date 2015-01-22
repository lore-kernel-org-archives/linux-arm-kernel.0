From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 22 Jan 2015 07:44:58 +0000
Subject: [PATCH 1/2] ARM: ux500: Move struct
In-Reply-To: <1421881782-23716-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
References: <1421881782-23716-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Message-ID: <20150122074458.GL22024@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The subject line is not a good one.  Please elaborate.

> Move struct ab8500_ext_regulator_cfg to  the only file that is now used in.

                   Attention to detail --^

> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
> ---
>  drivers/regulator/ab8500-ext.c   |    6 ++++++
>  include/linux/regulator/ab8500.h |    5 -----
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/regulator/ab8500-ext.c b/drivers/regulator/ab8500-ext.c
> index 84c1ee3..a40c701 100644
> --- a/drivers/regulator/ab8500-ext.c
> +++ b/drivers/regulator/ab8500-ext.c
> @@ -25,6 +25,12 @@
>  #include <linux/mfd/abx500/ab8500.h>
>  #include <linux/regulator/ab8500.h>
>  
> +

Superfluous '\n'.

> +/* AB8500 external regulators */

No need for this commit now.

> +struct ab8500_ext_regulator_cfg {
> +	bool hwreq; /* requires hw mode or high power mode */
> +};
> +

Are you sure a struct is required at all now?  It only contains a
single bool after all.

>  /**
>   * struct ab8500_ext_regulator_info - ab8500 regulator information
>   * @dev: device pointer
> diff --git a/include/linux/regulator/ab8500.h b/include/linux/regulator/ab8500.h
> index d8ecefa..802529b 100644
> --- a/include/linux/regulator/ab8500.h
> +++ b/include/linux/regulator/ab8500.h
> @@ -300,11 +300,6 @@ enum ab8540_regulator_reg {
>  	AB8540_NUM_REGULATOR_REGISTERS,
>  };
>  
> -/* AB8500 external regulators */
> -struct ab8500_ext_regulator_cfg {
> -	bool hwreq; /* requires hw mode or high power mode */
> -};
> -
>  enum ab8500_ext_regulator_id {
>  	AB8500_EXT_SUPPLY1,
>  	AB8500_EXT_SUPPLY2,

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
