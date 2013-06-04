From: B35083@freescale.com (Lu Jingchang-B35083)
Date: Tue, 4 Jun 2013 03:02:25 +0000
Subject: [PATCH v6] tty: serial: add Freescale lpuart driver support
In-Reply-To: <CAOMZO5BNbbbX0wycis_3nyg-B76kJYrQu-e+D1SpGLs10Zp3yw@mail.gmail.com>
References: <1370309270-21019-1-git-send-email-b35083@freescale.com>
 <CAOMZO5BNbbbX0wycis_3nyg-B76kJYrQu-e+D1SpGLs10Zp3yw@mail.gmail.com>
Message-ID: <B56CDBE15CE27145A4B77D2D24263E851CEFD9@039-SN1MPN1-003.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



>-----Original Message-----
>From: Fabio Estevam [mailto:festevam at gmail.com]
>Sent: Tuesday, June 04, 2013 10:55 AM
>To: Lu Jingchang-B35083
>Cc: linux-serial at vger.kernel.org; gregkh at linuxfoundation.org;
>s.hauer at pengutronix.de; shawn.guo at linaro.org; linux-arm-
>kernel at lists.infradead.org
>Subject: Re: [PATCH v6] tty: serial: add Freescale lpuart driver support
>
>On Mon, Jun 3, 2013 at 10:27 PM, Jingchang Lu <b35083@freescale.com> wrote:
>
>> +config SERIAL_FSL_LPUART
>> +       tristate "Freescale lpuart serial port support"
>> +       select SERIAL_CORE
>> +       help
>> +         Support for the on-chip lpuart on some Freescale SOCs.
>> +
>> +config SERIAL_FSL_LPUART_CONSOLE
>> +       bool "Console on Freescale lpuart serial port"
>
>It is better yo use tristate here as well.
>
>I have just sent the same fix for imx serial.
>
>Keeping it bool may lead to build error when SERIAL_FSL_LPUART=m and
>SERIAL_FSL_LPUART_CONSOLE=y
[Lu Jingchang-B35083] 
  SERIAL_FSL_LPUART_CONSOLE depends on SERIAL_FSL_LPUART=y in the patch as below, when SERIAL_FSL_LPUART is configured as module, it can't be configured as console. Thanks!

+config SERIAL_FSL_LPUART_CONSOLE
+       bool "Console on Freescale lpuart serial port"
+       depends on SERIAL_FSL_LPUART=y
