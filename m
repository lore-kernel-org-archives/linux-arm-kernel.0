From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 7 Apr 2014 19:50:38 +0200
Subject: [PATCH] i2c: cadence: fix Kconfig dependency
In-Reply-To: <dfab53fa-8b3c-4eb0-90b8-7df779ce68da@TX2EHSMHS036.ehs.local>
References: <1396811227-8851-1-git-send-email-wsa@the-dreams.de>
 <20140407063100.GN29751@pengutronix.de>
 <1396852656.682914397@f273.i.mail.ru>
 <dfab53fa-8b3c-4eb0-90b8-7df779ce68da@TX2EHSMHS036.ehs.local>
Message-ID: <20140407175038.GS29751@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello S?ren,

On Mon, Apr 07, 2014 at 08:36:29AM -0700, S?ren Brinkmann wrote:
> On Mon, 2014-04-07 at 10:37AM +0400, Alexander Shiyan wrote:
> > ARCH_ZYNC || (ARM && COMPILE_TEST)
> 
> Why would you add Zynq to the dependencies? This driver should work on
> all ARM platforms (more or less, given that the IP is implemented
> similarly). I think ARM, if it selects COMMON_CLK, is enough. Otherwise
> ARM && COMMON_CLK. I don't see a good reason to restrict the driver to
> Zynq only.
The idea is that if COMPILE_TEST is off you can only enable the driver
for machines where the device in question really exists to simplify
kernel configuration. Sometimes this isn't really possible, e.g. for i2c
devices that can be put on more or less every machine. I had the
impression that the cadence i2c bus device only exists on Zync? Ok, you
could implement this device on every SoC that has some programmable
hardware, but that is not the point.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
