From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Thu, 12 Jan 2012 07:04:32 +0530
Subject: [PATCH] backlight: lcd: add driver for raster-type lcd's with
 gpio controlled panel reset
In-Reply-To: <20120111174540.GE24213@opensource.wolfsonmicro.com>
References: <1325778146-27056-1-git-send-email-thomas.abraham@linaro.org>
 <4F05F509.6020405@metafoo.de>
 <20120106064929.GB3496@opensource.wolfsonmicro.com>
 <CAJuYYwRxuZAm_JpLw1fN2ypnFc6TocH6veRmCeuqENvZHSz3kg@mail.gmail.com>
 <20120107172826.GA355@opensource.wolfsonmicro.com>
 <CAJuYYwSuDzUWgnSJHO0vwjYH7zscC9=j_=JuOUuJy9shHpPUuA@mail.gmail.com>
 <20120111174540.GE24213@opensource.wolfsonmicro.com>
Message-ID: <CAJuYYwRabVbUx7FWDjjRbQ2A8qowj1qHpN9unxXPgi3HfBVtuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 January 2012 23:15, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Jan 11, 2012 at 04:21:57PM +0530, Thomas Abraham wrote:
>
>> In the case of Exynos4 based Origen board, buck7 of max8997 supplies
>> power to the lcd panel. buck7 is capable of supplying power at
>> different voltage levels but for Origen board, it is required to
>> supply only 3.3V. The constraints for buck7 can specify 'apply_uV' and
>> this will ensure that buck7 is configured to supply 3.3V.
>
>> But 'apply_uV' seems to be not ideal for regulators that supply power
>> to lcd panels. It would be better to power lcd panels only when video
>> data has to be displayed.
>
> What makes you say this? ?Enabling and disabling a regulator are
> entirely orthogonal to setting the regulator voltage.

Sorry, I got this wrong. I will remove the regulator_set_voltage()
call from the driver.

Thanks,
Thomas.
