From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 27 Jun 2015 14:34:17 -0300
Subject: imx: apf27: the board no longer boot with latest git kernel
In-Reply-To: <558EDCB2.9040603@gmail.com>
References: <558EA370.6020108@gmail.com>
 <CAOMZO5AcRd8UJQg9MpV6mXJKkB2JMriGHzzKYS95oWQYzMOsuw@mail.gmail.com>
 <558EDCB2.9040603@gmail.com>
Message-ID: <CAOMZO5DbL8etNQAb4vOwsXSQr2SBWMzCx0P7+TUWj54T9ZrSjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 27, 2015 at 2:26 PM, Philippe Reynes <tremyfr@gmail.com> wrote:

> I've looked the code in drivers/clocksource/timer-imx-gpt.c, in the
> definition
> of imx_gpt_type, there is :
>         GPT_TYPE_IMX21,         /* i.MX21/27 */
>
> So I've done a little change in your patch, I've used imx21_timer_init_dt
> for
> imx27 :
>
> --- a/drivers/clocksource/timer-imx-gpt.c
> +++ b/drivers/clocksource/timer-imx-gpt.c
> @@ -529,6 +529,7 @@ static void __init imx6dl_timer_init_dt(struct
> device_node *np)
>   CLOCKSOURCE_OF_DECLARE(imx1_timer, "fsl,imx1-gpt", imx1_timer_init_dt);
>  CLOCKSOURCE_OF_DECLARE(imx21_timer, "fsl,imx21-gpt", imx21_timer_init_dt);
> +CLOCKSOURCE_OF_DECLARE(imx27_timer, "fsl,imx27-gpt", imx21_timer_init_dt);
>  CLOCKSOURCE_OF_DECLARE(imx31_timer, "fsl,imx31-gpt", imx31_timer_init_dt);
>  CLOCKSOURCE_OF_DECLARE(imx25_timer, "fsl,imx25-gpt", imx31_timer_init_dt);
>  CLOCKSOURCE_OF_DECLARE(imx50_timer, "fsl,imx50-gpt", imx31_timer_init_dt);
>
> I've tested it, and it works fine, now my apf27 (imx27) boot without any
> issue.
> So good catch, thanks a lot for this patch.

Excellent :-)

>
> I may send a patch on lkml if you want.

Yes, please submit a formal patch.

I thought it was imx1_timer_init_dt because in imx27.dtsi we have:

compatible = "fsl,imx27-gpt", "fsl,imx1-gpt";

So I am wondering if this is correct or it should be

compatible = "fsl,imx27-gpt", "fsl,imx21-gpt"; instead?

Regards,

Fabio Estevam
