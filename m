From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 17 Nov 2010 21:25:15 +0100
Subject: [PATCH] ARM: imx: fix ehci-mxc build.
In-Reply-To: <69664.13831.qm@web51001.mail.re2.yahoo.com>
References: <1289959040-5056-1-git-send-email-jiejing.zhang@freescale.com>
	<69664.13831.qm@web51001.mail.re2.yahoo.com>
Message-ID: <20101117202515.GD8942@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 16, 2010 at 06:58:55PM -0800, Fabio Estevam wrote:
> Hi Jiejing,
> 
> --- On Tue, 11/16/10, Zhang Jiejing <jiejing.zhang@freescale.com> wrote:
> 
> > From: Zhang Jiejing <jiejing.zhang@freescale.com>
> > Subject: [PATCH] ARM: imx: fix ehci-mxc build.
> > To: linux-arm-kernel at lists.infradead.org
> > Cc: "Liu Hui" <b29976@freescale.com>, "Sascha Hauer" <s.hauer@pengutronix.de>, "Zhang Jiejing" <jiejing.zhang@freescale.com>, "Daniel Mack" <daniel@caiaq.de>, "Matthieu CASTET" <matthieu.castet@parrot.com>
> > Date: Tuesday, November 16, 2010, 11:57 PM
> > The ehci-mxc.c is broken by commit:
> > 65fd42724aee31018b0bb53f4cb04971423be664
> > 
> > ? CHK? ???include/linux/version.h
> > ? CHK?
> > ???include/generated/utsrelease.h
> > make[1]: `include/generated/mach-types.h' is up to date.
> > ? CALL? ? scripts/checksyscalls.sh
> > ? CHK?
> > ???include/generated/compile.h
> > ? CC? ? ? drivers/serial/imx.o
> > ? LD? ? ? drivers/serial/built-in.o
> > ? CC? ? ? drivers/usb/host/ehci-hcd.o
> > In file included from drivers/usb/host/ehci-hcd.c:1165:
> > drivers/usb/host/ehci-mxc.c: In function
> > 'ehci_mxc_drv_probe':
> > drivers/usb/host/ehci-mxc.c:192: error: 'ehci' undeclared
> > (first use in this function)
> > drivers/usb/host/ehci-mxc.c:192: error: (Each undeclared
> > identifier is reported only once
> > drivers/usb/host/ehci-mxc.c:192: error: for each function
> > it appears in.)
> > drivers/usb/host/ehci-mxc.c:117: warning: unused variable
> > 'temp'
> > make[3]: *** [drivers/usb/host/ehci-hcd.o] Error 1
> > make[2]: *** [drivers/usb/host] Error 2
> > make[1]: *** [drivers/usb] Error 2
> > make: *** [drivers] Error 2
> > 
> > This patch is fix this by reuse old code.
> 
> Uwe has already sent a fix for this issue: http://git.pengutronix.de/?p=imx/linux-2.6.git;a=commitdiff;h=1cbc09fe2e64ccfb33a4d0e85c46c90a9167a53c
In the meantime gregkh has taken the fix (e.g
724c85251f78f1332e0a28f80cead0cee5b7c906 in current next)

(BTW, your colleague Nguyen Dinh-R00091 tested that patch :-)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
