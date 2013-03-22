From: timur@tabi.org (Timur Tabi)
Date: Fri, 22 Mar 2013 09:08:41 -0500
Subject: [PATCH V2] Sound: sgtl5000 Allow codec clock frequency to be set.
In-Reply-To: <20130322093344.20605.49509.stgit@localhost>
References: <20130322093344.20605.49509.stgit@localhost>
Message-ID: <CAOZdJXWi2pph-=vQg+FAty+yVVk9fJBU6rxYOf0J-J2f=Lwgxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 22, 2013 at 4:33 AM, Martin Fuzzey <mfuzzey@parkeon.com> wrote:

> diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
> index 424347e..71ce1f6 100644
> --- a/sound/soc/fsl/imx-sgtl5000.c
> +++ b/sound/soc/fsl/imx-sgtl5000.c
> @@ -128,18 +128,30 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
>                 goto fail;
>         }
>
> +       ret = of_property_read_u32(codec_np, "clock-frequency",
> +                                       &data->clk_frequency);

I just noticed that you assign 'ret' here, but you never check the
value.  So I think you should either:

1) Check the value of 'ret'
2) Remove the "ret = "
