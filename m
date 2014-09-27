From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 27 Sep 2014 15:20:59 +0200
Subject: [PATCH 2/3] clk: samsung: remove unnecessary CONFIG_OF from clk.c
In-Reply-To: <1411796519-19417-3-git-send-email-pankaj.dubey@samsung.com>
References: <1411796519-19417-1-git-send-email-pankaj.dubey@samsung.com>
 <1411796519-19417-3-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <5426B9BB.90606@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pankaj,

On 27.09.2014 07:41, Pankaj Dubey wrote:
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>

Missing patch description.

> ---
>  drivers/clk/samsung/clk.c |    2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
> index deab84d..31bf391 100644
> --- a/drivers/clk/samsung/clk.c
> +++ b/drivers/clk/samsung/clk.c
> @@ -281,7 +281,6 @@ void __init samsung_clk_register_gate(struct samsung_clk_provider *ctx,
>   * obtain the clock speed of all external fixed clock sources from device
>   * tree and register it
>   */
> -#ifdef CONFIG_OF

We still have non-DT platforms which use this code, i.e. s3c24xx and
s3c64xx. Have you checked if this compiles fine on them with CONFIG_OF
disabled?

Best regards,
Tomasz
