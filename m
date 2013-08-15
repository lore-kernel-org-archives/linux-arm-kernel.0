From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 15 Aug 2013 10:12:16 +0100
Subject: [PATCH v8 0/2] TWL6030, TWL6032 GPADC driver
In-Reply-To: <1374758813-6539-1-git-send-email-oleksandr.kozaruk@ti.com>
References: <1374758813-6539-1-git-send-email-oleksandr.kozaruk@ti.com>
Message-ID: <20130815091216.GB28366@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

apologies for the late reply.

On Thu, Jul 25, 2013 at 02:26:51PM +0100, Oleksandr Kozaruk wrote:
> Hello,
> 
> v8 - removed unused test channels completely, removed die
>      temperature channels, as it is not known how to convert ADC code
>      to temperature. There if formula for twl6030, but no formula
>      for twl6032.
> v7 - addressed clean up comments, removed test channels
> v6 - addressed comments about trim bits, checkpatch clean up
> v5 - gpadc DT node renamed from "gpadc" to generic "adc", added
>      temperature channels; raw code is corracted with calibration
>      data.
> v4 - addressed comments: fixed style violation, bug in freeing memory,
>      added comments explaining calibration method, removed test network
>      channels from exposing to userspace, error handling for 
>      wait_for_complition
> v3 - fixed compiler warning
> v2 - the driver put in drivers/iio, and
> converted using iio facilities as suggested by Graeme.
> 
> TWL603[02] GPADC is used to measure battery voltage,
> battery temperature, battery presence ID, and could
> be used to measure twl603[02] die temperature.
> This is used on TI blaze, blaze tablet platforms.
> 
> The TWL6030/TWL6032 is a PMIC that has a GPADC with 17/19
> channels respectively. Some channels have current
> source and are used for measuring voltage drop
> on resistive load for detecting battery ID resistance,
> or measuring voltage drop on NTC resistors for external
> temperature measurements, other channels measure voltage,
> (i.e. battery voltage), and have inbuilt voltage dividers,
> thus, capable to scale voltage. Some channels are dedicated
> for measuring die temperature.
> 
> Some channels could be calibrated in 2 points, having
> offsets from ideal values in trim registers.
> 
> The difference between GPADC in TWL6030 and TWL6032:
> - 10 bit vs 12 bit ADC;
> - 17 vs 19 channels;
> - channels have different purpose(i. e. battery voltage
>   channel 8 vs channel 18);
> - trim values are interpreted differently.
> 
> The driver is derived from git://git.omapzoom.org/kernel/omap.git
> The original driver's authors and contributors are Balaji T K,
> Graeme Gregory, Ambresh K, Girish S Ghongdemath.
> 
> The changes to the original driver:
> - device tree adaptation;

I couldn't see a binding document in this series or in mainline. Have I
looked in the wrong places?

Mark.
