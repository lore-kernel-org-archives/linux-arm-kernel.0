From: embed3d@gmail.com (Philipp Rossak)
Date: Fri, 31 Aug 2018 14:05:59 +0200
Subject: [PATCH v3 20/30] iio: adc: sun4i-gpadc-iio: rework: device
 specific suspend & resume
In-Reply-To: <20180831090915.agbldint76ngj5jf@flea>
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-21-embed3d@gmail.com>
 <20180831090915.agbldint76ngj5jf@flea>
Message-ID: <ddd06c43-026e-2801-dc36-053d469e43f3@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 31.08.2018 11:09, Maxime Ripard wrote:
>> +static int sun4i_ths_suspend(struct sun4i_gpadc_iio *info)
> suspend is already a hook in the kernel, which hasn't the same meaning
> than runtime_suspend (and the same applies to resume), so we'd rather
> pick a better name. And all the functions (and the driver) use gpadc,
> please continue to use that prefix.

I agree.
For the newer sensors (from H3) the Sensor is referenced in the 
datasheets as Thermal Sensor short THS. So I would like to use for the 
newer sensors that prefix. Is that ok?

Philipp
