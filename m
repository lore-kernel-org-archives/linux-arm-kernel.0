From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 7 Jan 2012 17:28:28 +0000
Subject: [PATCH] backlight: lcd: add driver for raster-type lcd's with
 gpio controlled panel reset
In-Reply-To: <CAJuYYwRxuZAm_JpLw1fN2ypnFc6TocH6veRmCeuqENvZHSz3kg@mail.gmail.com>
References: <1325778146-27056-1-git-send-email-thomas.abraham@linaro.org>
 <4F05F509.6020405@metafoo.de>
 <20120106064929.GB3496@opensource.wolfsonmicro.com>
 <CAJuYYwRxuZAm_JpLw1fN2ypnFc6TocH6veRmCeuqENvZHSz3kg@mail.gmail.com>
Message-ID: <20120107172826.GA355@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 07, 2012 at 04:34:34PM +0530, Thomas Abraham wrote:
> On 6 January 2012 12:19, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> > In principle it should be specified in both places to account for shared
> > supplies though for all practical purposes for an LCD panel I can't see
> > multiple users sharing the same regulator and varying the voltage at
> > runtime.

> It is assumed here that the boot loader as not set the output voltage
> of the regulator that supports variable voltage ranges. So these
> values help in setting up the regulator for LCD display.

Remember that the regulator API won't allow consumers to configure
voltages unless there are constraints granting permission.  Users will
need to set both the LCD vales and the regulator constraints values to
actually allow configuration to happen.
