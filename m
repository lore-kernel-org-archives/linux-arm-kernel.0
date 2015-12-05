From: jic23@kernel.org (Jonathan Cameron)
Date: Sat, 5 Dec 2015 18:50:59 +0000
Subject: [PATCH 5/5] iio: adc: New driver for Cirrus Logic EP93xx ADC
In-Reply-To: <565B437A.4030501@gmail.com>
References: <56558B23.4080506@gmail.com> <5655A0A5.20908@gmail.com>
 <565B23FB.9040405@kernel.org> <565B2A91.6050409@gmail.com>
 <565B33AC.40908@kernel.org> <565B437A.4030501@gmail.com>
Message-ID: <56633213.5010506@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/11/15 18:27, Alexander Sverdlin wrote:
> Hello Jonathan,
> 
> On 29/11/15 18:19, Jonathan Cameron wrote:
>>> High end models (EP9307, EP9312, EP9315) have TS controller, which can operate
>>>> in general purpose ADC mode. In this mode these names are just ball names on the
>>>> pinout. They are all the same. There is only one issue -- I have not found any
>>>> official numbering for these devices, therefore wanted to expose this naming to
>>>> user space. Low end devices (EP9301, EP9302) have same hw block where TS mode is
>>>> not advertised, and even though the balls/pins are still named as in TS controller,
>>>> they are also referred as ADC0-ADC4 in datasheet. But there are only 5 of them,
>>>> so we do not know the numbers for other 3 in the bigger devices.
>>>>
>>>> If this is not the purpose of extend_name, I'll drop them.
>> It's not.  We've had discussions about either exposing the datasheet names via
>> sysfs or perhaps allowing arbitrary labelling but nothing has come of it yet.
>>
>> Perhaps in this case clear documentation of the mapping is the way to go in 
>> documentation for the driver.
> 
> Do you think something like Documentation/ABI/testing/sysfs-bus-iio-adc-ep93xx is a right
> place?
Good question.  You could do it there by explicitly documenting how it ties up with the
sysfs attributes, but that's a bit messy.  I'd put a file
in Documentation/iio describing it.
> 
> Regards,
> Alexander.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
