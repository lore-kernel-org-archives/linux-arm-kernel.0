From: fabioestevam@yahoo.com (Fabio Estevam)
Date: Tue, 16 Nov 2010 18:58:55 -0800 (PST)
Subject: [PATCH] ARM: imx: fix ehci-mxc build.
In-Reply-To: <1289959040-5056-1-git-send-email-jiejing.zhang@freescale.com>
Message-ID: <69664.13831.qm@web51001.mail.re2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jiejing,

--- On Tue, 11/16/10, Zhang Jiejing <jiejing.zhang@freescale.com> wrote:

> From: Zhang Jiejing <jiejing.zhang@freescale.com>
> Subject: [PATCH] ARM: imx: fix ehci-mxc build.
> To: linux-arm-kernel at lists.infradead.org
> Cc: "Liu Hui" <b29976@freescale.com>, "Sascha Hauer" <s.hauer@pengutronix.de>, "Zhang Jiejing" <jiejing.zhang@freescale.com>, "Daniel Mack" <daniel@caiaq.de>, "Matthieu CASTET" <matthieu.castet@parrot.com>
> Date: Tuesday, November 16, 2010, 11:57 PM
> The ehci-mxc.c is broken by commit:
> 65fd42724aee31018b0bb53f4cb04971423be664
> 
> ? CHK? ???include/linux/version.h
> ? CHK?
> ???include/generated/utsrelease.h
> make[1]: `include/generated/mach-types.h' is up to date.
> ? CALL? ? scripts/checksyscalls.sh
> ? CHK?
> ???include/generated/compile.h
> ? CC? ? ? drivers/serial/imx.o
> ? LD? ? ? drivers/serial/built-in.o
> ? CC? ? ? drivers/usb/host/ehci-hcd.o
> In file included from drivers/usb/host/ehci-hcd.c:1165:
> drivers/usb/host/ehci-mxc.c: In function
> 'ehci_mxc_drv_probe':
> drivers/usb/host/ehci-mxc.c:192: error: 'ehci' undeclared
> (first use in this function)
> drivers/usb/host/ehci-mxc.c:192: error: (Each undeclared
> identifier is reported only once
> drivers/usb/host/ehci-mxc.c:192: error: for each function
> it appears in.)
> drivers/usb/host/ehci-mxc.c:117: warning: unused variable
> 'temp'
> make[3]: *** [drivers/usb/host/ehci-hcd.o] Error 1
> make[2]: *** [drivers/usb/host] Error 2
> make[1]: *** [drivers/usb] Error 2
> make: *** [drivers] Error 2
> 
> This patch is fix this by reuse old code.

Uwe has already sent a fix for this issue: http://git.pengutronix.de/?p=imx/linux-2.6.git;a=commitdiff;h=1cbc09fe2e64ccfb33a4d0e85c46c90a9167a53c

Regards,

Fabio Estevam


      
