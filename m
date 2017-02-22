From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 22 Feb 2017 11:30:09 +0100
Subject: linux-next build regressions, Re: next build: 208 builds: 2 failed,
 206 passed, 39 warnings (next-20170222)
In-Reply-To: <58ad2e38.0d57190a.e5f64.04d6@mx.google.com>
References: <58ad2e38.0d57190a.e5f64.04d6@mx.google.com>
Message-ID: <2483588.cUC69WWsNF@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, February 21, 2017 10:22:48 PM CET kernelci. org bot wrote:
> next build: 208 builds: 2 failed, 206 passed, 39 warnings (next-20170222)

>From last week's 9, four patches got merged into linux-next, two new
ones came in (drm/sti), three have pending patches and two are waiting
for me to come up with a proper solution.

> --------------------------------------------------------------------------------
> allmodconfig (arm) ? PASS, 0 errors, 9 warnings, 0 section mismatches
> 
> Warnings:
>     drivers/gpu/drm/sti/sti_vtg.c:392:22: warning: unused variable 'np' [-Wunused-variable]
>     drivers/gpu/drm/sti/sti_drv.c:120:13: warning: 'sti_drm_dbg_cleanup' defined but not used [-Wunused-function]

I sent two patches for these yesterday, and Vincent also sent these
already, 

>     drivers/iio/adc/rcar-gyroadc.c:429:27: warning: 'num_channels' may be used uninitialized in this function [-Wmaybe-uninitialized]
>     drivers/iio/adc/rcar-gyroadc.c:426:22: warning: 'sample_width' may be used uninitialized in this function [-Wmaybe-uninitialized]
>     drivers/iio/adc/rcar-gyroadc.c:428:23: warning: 'channels' may be used uninitialized in this function [-Wmaybe-uninitialized]
>     drivers/iio/adc/rcar-gyroadc.c:398:26: warning: 'adcmode' may be used uninitialized in this function [-Wmaybe-uninitialized]

An old one, Jonathan Cameron said he'd send this one for 4.11-rc2,
but it has not appeared in linux-next yet.

Jonathan, any update?

>     drivers/media/platform/coda/imx-vdoa.c:333:181: warning: passing argument 1 of '__platform_driver_register' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>     drivers/media/platform/coda/imx-vdoa.c:333:625: warning: passing argument 1 of 'platform_driver_unregister' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]

Hans Verkuil said he'd take care of this if he remembers.

>     drivers/usb/gadget/udc/atmel_usba_udc.c:632:550: warning: 'ept_cfg' may be used uninitialized in this function [-Wmaybe-uninitialized]

Sent a patch on 2017-02-01. No reply since last update, resending now.

> --------------------------------------------------------------------------------
> cavium_octeon_defconfig (mips) ? PASS, 0 errors, 1 warning, 0 section mismatches
> 
> Warnings:
>     drivers/staging/octeon/ethernet-rx.c:339:28: warning: unused variable 'priv' [-Wunused-variable]

I sent a patch on 2017-02-17, no reply yet.

> --------------------------------------------------------------------------------
> defconfig+CONFIG_KASAN=y (x86) ? PASS, 0 errors, 5 warnings, 0 section mismatches
> 
> Warnings:
>     net/wireless/nl80211.c:1415:1: warning: the frame size of 2232 bytes is larger than 2048 bytes [-Wframe-larger-than=]
>     net/wireless/nl80211.c:4443:1: warning: the frame size of 2232 bytes is larger than 2048 bytes [-Wframe-larger-than=]
>     net/wireless/nl80211.c:5743:1: warning: the frame size of 2064 bytes is larger than 2048 bytes [-Wframe-larger-than=]
>     net/wireless/nl80211.c:1904:1: warning: the frame size of 3784 bytes is larger than 2048 bytes [-Wframe-larger-than=]
>     drivers/tty/vt/keyboard.c:1470:1: warning: the frame size of 2344 bytes is larger than 2048 bytes [-Wframe-larger-than=]

I have patches, but it's tricky. Expect a long set of patches in the next
few days. Unlike the others, this is not a regression compared to 4.9, but
a long-standing issue.

	Arnd
