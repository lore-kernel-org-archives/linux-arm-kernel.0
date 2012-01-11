From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 11 Jan 2012 17:45:41 +0000
Subject: [PATCH] backlight: lcd: add driver for raster-type lcd's with
 gpio controlled panel reset
In-Reply-To: <CAJuYYwSuDzUWgnSJHO0vwjYH7zscC9=j_=JuOUuJy9shHpPUuA@mail.gmail.com>
References: <1325778146-27056-1-git-send-email-thomas.abraham@linaro.org>
 <4F05F509.6020405@metafoo.de>
 <20120106064929.GB3496@opensource.wolfsonmicro.com>
 <CAJuYYwRxuZAm_JpLw1fN2ypnFc6TocH6veRmCeuqENvZHSz3kg@mail.gmail.com>
 <20120107172826.GA355@opensource.wolfsonmicro.com>
 <CAJuYYwSuDzUWgnSJHO0vwjYH7zscC9=j_=JuOUuJy9shHpPUuA@mail.gmail.com>
Message-ID: <20120111174540.GE24213@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2012 at 04:21:57PM +0530, Thomas Abraham wrote:

> In the case of Exynos4 based Origen board, buck7 of max8997 supplies
> power to the lcd panel. buck7 is capable of supplying power at
> different voltage levels but for Origen board, it is required to
> supply only 3.3V. The constraints for buck7 can specify 'apply_uV' and
> this will ensure that buck7 is configured to supply 3.3V.

> But 'apply_uV' seems to be not ideal for regulators that supply power
> to lcd panels. It would be better to power lcd panels only when video
> data has to be displayed.

What makes you say this?  Enabling and disabling a regulator are
entirely orthogonal to setting the regulator voltage.
