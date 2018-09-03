From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 3 Sep 2018 11:44:04 +0200
Subject: [PATCH v3 20/30] iio: adc: sun4i-gpadc-iio: rework: device
 specific suspend & resume
In-Reply-To: <ddd06c43-026e-2801-dc36-053d469e43f3@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-21-embed3d@gmail.com>
 <20180831090915.agbldint76ngj5jf@flea>
 <ddd06c43-026e-2801-dc36-053d469e43f3@gmail.com>
Message-ID: <20180903094404.ih2fsqsetz6oo7ie@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 31, 2018 at 02:05:59PM +0200, Philipp Rossak wrote:
> 
> 
> On 31.08.2018 11:09, Maxime Ripard wrote:
> > > +static int sun4i_ths_suspend(struct sun4i_gpadc_iio *info)
> > suspend is already a hook in the kernel, which hasn't the same meaning
> > than runtime_suspend (and the same applies to resume), so we'd rather
> > pick a better name. And all the functions (and the driver) use gpadc,
> > please continue to use that prefix.
> 
> I agree.
> For the newer sensors (from H3) the Sensor is referenced in the datasheets
> as Thermal Sensor short THS. So I would like to use for the newer sensors
> that prefix. Is that ok?

Not really. The consistency within the driver is more important.

Maxiem

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180903/76496641/attachment.sig>
