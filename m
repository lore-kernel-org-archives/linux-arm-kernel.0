From: B35083@freescale.com (Lu Jingchang-B35083)
Date: Tue, 4 Jun 2013 04:55:38 +0000
Subject: [PATCH v6] tty: serial: add Freescale lpuart driver support
In-Reply-To: <CAOMZO5Bo58Qa0Rmz+oKt0ZOUjYDDskBsPykCVc79j4mybcG8rA@mail.gmail.com>
References: <1370309270-21019-1-git-send-email-b35083@freescale.com>
 <CAOMZO5BNbbbX0wycis_3nyg-B76kJYrQu-e+D1SpGLs10Zp3yw@mail.gmail.com>
 <B56CDBE15CE27145A4B77D2D24263E851CEFD9@039-SN1MPN1-003.039d.mgd.msft.net>
 <CAOMZO5DzVhh4REj5S=cVVVrGzxmTxY9s_h_6ZQ-G8wOxi+KG=A@mail.gmail.com>
 <CAOMZO5Bo58Qa0Rmz+oKt0ZOUjYDDskBsPykCVc79j4mybcG8rA@mail.gmail.com>
Message-ID: <B56CDBE15CE27145A4B77D2D24263E851CF068@039-SN1MPN1-003.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



>-----Original Message-----
>From: Fabio Estevam [mailto:festevam at gmail.com]
>Sent: Tuesday, June 04, 2013 11:09 AM
>To: Lu Jingchang-B35083
>Cc: linux-serial at vger.kernel.org; gregkh at linuxfoundation.org;
>s.hauer at pengutronix.de; shawn.guo at linaro.org; linux-arm-
>kernel at lists.infradead.org
>Subject: Re: [PATCH v6] tty: serial: add Freescale lpuart driver support
>
>On Tue, Jun 4, 2013 at 12:08 AM, Fabio Estevam <festevam@gmail.com> wrote:
>> On Tue, Jun 4, 2013 at 12:02 AM, Lu Jingchang-B35083
>> <B35083@freescale.com> wrote:
>>
>>> [Lu Jingchang-B35083]
>>>   SERIAL_FSL_LPUART_CONSOLE depends on SERIAL_FSL_LPUART=y in the patch
>as below, when SERIAL_FSL_LPUART is configured as module, it can't be
>configured as console. Thanks!
>>
>> Why to prevent using the console of the driver is built as module?
>
>I meant "if the driver is built as module"
[Lu Jingchang-B35083] 
  From your patch of " serial: imx: Allow module build", I think the code between #ifdef CONFIG_SERIAL_IMX_CONSOLE ... #else in imx.c won't be built because the configuration is CONFIG_SERIAL_IMX_CONSOLE_MODULE now. So it is the same as if disable CONFIG_SERIAL_IMX_CONSOLE when built the driver as a module, isn't it?
 On other hand, if enable CONFIG_SERIAL_X_CONSOLE option when the driver is configured as module, the build will fail with message like ERROR: "uart_console_device" [drivers/tty/serial/**.ko] undefined! Stephen Rothwel gives the solution once at url:
http://www.linuxhorizon.com/9-linux/42b33a65f64d95a2.htm
  I have checked drivers/tty/serial/Kconfig to make sure that other serial drivers indeed did this way. 
  Thanks!
