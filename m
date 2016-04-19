From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 19 Apr 2016 07:42:17 -0300
Subject: [PATCH 3/3] nvmem: imx-ocotp: handling clock
In-Reply-To: <1461054788-339-3-git-send-email-van.freenix@gmail.com>
References: <1461054788-339-1-git-send-email-van.freenix@gmail.com>
 <1461054788-339-3-git-send-email-van.freenix@gmail.com>
Message-ID: <CAOMZO5CBeMn_m79vUzmk21nA1s+COiFoqfywXUJ2mOS38wBAdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peng,

On Tue, Apr 19, 2016 at 5:33 AM, Peng Fan <van.freenix@gmail.com> wrote:

> @@ -46,11 +48,15 @@ static int imx_ocotp_read(void *context, const void *reg, size_t reg_size,
>         if (count > (priv->nregs - index))
>                 count = priv->nregs - index;
>
> +       clk_prepare_enable(priv->clk);

clk_prepare_enable() may fail, so you should better check its return
value and propagate it in the case of error.
