From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Thu, 04 Dec 2014 10:30:36 +0530
Subject: [PATCH v4 1/2] soc: samsung: add exynos chipid driver support
In-Reply-To: <19026872.NZqUJn3Abb@wuerfel>
References: <1417594658-2931-1-git-send-email-pankaj.dubey@samsung.com>
 <1417594658-2931-2-git-send-email-pankaj.dubey@samsung.com>
 <19026872.NZqUJn3Abb@wuerfel>
Message-ID: <547FEA74.1010900@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Wednesday 03 December 2014 04:13 PM, Arnd Bergmann wrote:
>> Exynos SoCs have Chipid, for identification of product IDs
>> and SoC revisions. This patch intendes to provide initialization
>> code for all these functionalites, at the same time it provides some
>> sysfs entries for accessing these information to userspace.
>>
>> This driver usese existing binding for exnos-chipid.
>
> Nice!

Thanks for review.

>
> On Wednesday 03 December 2014 13:47:37 Pankaj Dubey wrote:
>
>> +       soc_dev_attr->soc_id = exynos_product_id_to_name(soc_product_id);
>> +
>> +       soc_dev = soc_device_register(soc_dev_attr);
>> +       if (IS_ERR(soc_dev))
>> +               goto free_rev;
>> +
>> +       device_create_file(soc_device_to_device(soc_dev), &exynos_product_attr);
>> +       device_create_file(soc_device_to_device(soc_dev),
>> +                               &exynos_main_rev_attr);
>> +       device_create_file(soc_device_to_device(soc_dev), &exynos_sub_rev_attr);
>> +
>
> I don't like the idea of having three extra nonstandard properties here,
> especially when you are not using the machine field for anything useful.
>

I did not get you here. Any suggestions how we can use 'machine' field 
more useful way.

> Also, all three of these just come from the same register, why expose
> them all as the machine and revision standard properties.
>

Agreed. These properties are basically giving same information but with 
small modification.
As you said these are getting exposed via standard properties as well, 
so I have no issue to drop them. Just waiting for more review from 
Samsung folks, will take care of this in next version.


Thanks,
Pankaj Dubey
> 	Arnd
>
