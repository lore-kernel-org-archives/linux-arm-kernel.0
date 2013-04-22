From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 22 Apr 2013 09:58:02 +0200
Subject: [PATCH 1/3] iio: Add Nuvoton NAU7802 ADC driver
In-Reply-To: <5172B68B.4010506@free-electrons.com>
References: <1366299536-18353-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1366299536-18353-2-git-send-email-alexandre.belloni@free-electrons.com>
 <51726541.6060304@kernel.org> <5172B68B.4010506@free-electrons.com>
Message-ID: <5174ED8A.5090802@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre, Jonathan,

Le 20/04/2013 17:38, Alexandre Belloni a ?crit :
> On 20/04/2013 11:52, Jonathan Cameron wrote:
>>> +	&iio_dev_attr_gain.dev_attr.attr,
>>> +	&iio_const_attr_gain_available.dev_attr.attr,
>>> +	&iio_dev_attr_min_conversions.dev_attr.attr,
>> What governs this?  Looks to me more like it should be hidden away
>> in the device tree than be here.
> 
> I guess it will depend on what you connect to your adc. Do we want to
> fix that in the DT or to be able to change it at runtime ?

I don't think so. Unless I misunderstood it, this attribute is the
number of conversions that must occur when switching from one channel to
another to get a good-enough precision for the ADC, right?

So I don't really see 1) why it could be changed by the user through
sysfs in the first place 2) this is not hardware configuration at all,
more some black magic within the driver, so it shouldn't be at all in
the device tree anyway.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
