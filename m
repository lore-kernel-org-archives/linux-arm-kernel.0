From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 4 Jul 2013 14:41:51 +0800
Subject: mx6q boot on linux-next 20130703
In-Reply-To: <CAOMZO5AvXJJHmoEu3BMN=EYCxS4O1-2ivsSzS2eCuyPeiw_brQ@mail.gmail.com>
References: <CAOMZO5DgAu2-cknESp4a675KP5gDrJxM2A_FqUgAZav83Db=fw@mail.gmail.com>
 <CAOMZO5AvXJJHmoEu3BMN=EYCxS4O1-2ivsSzS2eCuyPeiw_brQ@mail.gmail.com>
Message-ID: <20130704064149.GD14617@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 04, 2013 at 01:08:13AM -0300, Fabio Estevam wrote:
> On Wed, Jul 3, 2013 at 8:52 PM, Fabio Estevam <festevam@gmail.com> wrote:
> > Hi,
> >
> > I am running linux-next 20130703 on a mx6q board, and seeing a strange
> > behaviour.
> >
> > Only if I enable DEBUG_LL + earlyprintk and disable

Yes, I see the issue here too, and turning on earlyprintk can remove the
issue.

> > CONFIG_SERIAL_FSL_LPUART (serial driver for the FSL Vybrid SoC), I am

This is irrelevant according to my test.

> > able to boot the kernel until the prompt.
> >
> > Does anyone have any suggestion?
> 

I do not get time to track it down.  But it does not seems to be an imx
specific problem.

> Ok, I managed to boot the default imx_v6_v7_defconfig on my mx6q board if I do:
> 
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1652,7 +1652,7 @@ static void __exit imx_serial_exit(void)
>         uart_unregister_driver(&imx_reg);
>  }
> 
> -module_init(imx_serial_init);
> +arch_initcall(imx_serial_init);
>  module_exit(imx_serial_exit);
> 
>  MODULE_AUTHOR("Sascha Hauer");
> 
> Is this the correct approach?

Without knowing the root cause of the problem, we can not tell.

Shawn
