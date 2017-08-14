From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 14 Aug 2017 09:26:43 +0200
Subject: [PATCH v2 1/5] reset: add reset-simple to unify socfpga, stm32,
 sunxi, and zx2967
In-Reply-To: <0d8e5468-866a-eac8-d9ec-b23f47df8bf3@adaptrum.com>
References: <20170811130618.3676-1-p.zabel@pengutronix.de>
 <20170811130618.3676-2-p.zabel@pengutronix.de>
 <0d8e5468-866a-eac8-d9ec-b23f47df8bf3@adaptrum.com>
Message-ID: <1502695603.2287.3.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-08-11 at 10:47 -0700, Alexandru Gagniuc wrote:
> Hi Philipp,
> 
> On 08/11/2017 06:06 AM, Philipp Zabel wrote:
> [snip]
> 
> > diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> > index 52d5251660b9b..f7ba01a71daee 100644
> > --- a/drivers/reset/Kconfig
> > +++ b/drivers/reset/Kconfig
> > @@ -68,6 +68,16 @@ config RESET_PISTACHIO
> > ?	help
> > ?	??This enables the reset driver for ImgTec Pistachio SoCs.
> > 
> > +config RESET_SIMPLE
> > +	bool "Simple Reset Controller Driver" if COMPILE_TEST
> 
> Another question. Is there a reason this is depended on COMPILE_TEST
> ?

The idea is that if compile test is disabled, you are not presented
with the option, but it is set to the correct value via the default
mechanism. That way it is normally not possible to disable necessary
reset controller drivers for enabled architectures, but the driver can
still be built even on other architectures.

It's a workaround for selecting the driver from the arch, which
currently can't be done because of the encasing menuconfig.

regards
Philipp
