From: sfking@fdwdc.com (Steven King)
Date: Sun, 6 May 2012 10:26:28 -0700
Subject: [PATCH 2/5] net: fec: adopt pinctrl API
In-Reply-To: <1336309094-18517-3-git-send-email-shawn.guo@linaro.org>
References: <1336309094-18517-1-git-send-email-shawn.guo@linaro.org>
 <1336309094-18517-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <201205061026.29238.sfking@fdwdc.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 06 May 2012 5:58:11 am Shawn Guo wrote:
> Cc: David S. Miller <davem@davemloft.net>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/net/ethernet/freescale/fec.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)

As the fec driver is also used by m68k/coldfire, perhaps a CC to the 
uclinux-dev at uclinux.org would be apropos.
>
> +	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
> +	if (IS_ERR(pinctrl)) {
> +		ret = PTR_ERR(pinctrl);
> +		goto failed_pin;
> +	}

What happens here if pinmux support isnt implemented yet as is the case for 
m68k/coldfire?
