From: mfuzzey@gmail.com (Martin Fuzzey)
Date: Thu, 15 Nov 2012 11:08:15 +0100
Subject: [PATCH 6/6] usb: chipidea: usbmisc: add post handling and errata
 fix for mx25
In-Reply-To: <1352894137-2050-7-git-send-email-m.grzeschik@pengutronix.de>
References: <1352894137-2050-1-git-send-email-m.grzeschik@pengutronix.de>
 <1352894137-2050-7-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <CALBypN6U=np93ZwnEZqbh=j0Vb_-x630GaktEiv+4K26eYp4Pg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Nov 14, 2012 at 12:55 PM, Michael Grzeschik
<m.grzeschik@pengutronix.de> wrote:
> @@ -213,6 +216,15 @@ static int __devinit ci13xxx_imx_probe(struct platform_device *pdev)
>                 goto put_np;
>         }
>
> +       if (usbmisc_ops && usbmisc_ops->post) {
> +               ret = usbmisc_ops->post(&pdev->dev);
> +               if (ret) {
> +                       dev_err(&pdev->dev,
> +                               "usbmisc post failed, ret=%d\n", ret);
> +                       goto err;
> +               }
> +       }
> +
>         data->ci_pdev = plat_ci;
>         platform_set_drvdata(pdev, data);
>
This hunk fails to apply for me on 3.7-rc5:
error: while searching for:
		goto put_np;
	}

	data->ci_pdev = plat_ci;
	platform_set_drvdata(pdev, data);

Regards,

Martin
