From: b-cousson@ti.com (Cousson, Benoit)
Date: Wed, 3 Aug 2011 18:27:04 +0200
Subject: Shouldn't DT preserve pdev name and id to allow platform_match
	to work?
In-Reply-To: <CAC63_iRa1qc7pO9Eub1A+cC+R=tSkwzigVPDHqcbvOngACYWqQ@mail.gmail.com>
References: <4E396361.3060307@ti.com>
	<CAC63_iRa1qc7pO9Eub1A+cC+R=tSkwzigVPDHqcbvOngACYWqQ@mail.gmail.com>
Message-ID: <4E3976D8.20602@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Manju,

On 8/3/2011 6:17 PM, G, Manjunath Kondaiah wrote:
> Hi Benoit,
>
> On Wed, Aug 3, 2011 at 8:34 PM, Cousson, Benoit<b-cousson@ti.com>  wrote:
>> Hi Grant,
>>
>> Going further with the usage of OF_DEV_AUXDATA_ID, I realized that this is is not doing what I was expecting. My expectation might be silly, but in order to make platform_match to work without DT matching mechanism, you need to have the driver name in the pdev->name field:
>>
>>         /* fall-back to driver name match */
>>         return (strcmp(pdev->name, drv->name) == 0);
>>
>> Except that the of_device_add function is doing that:
>>         pdev->name = dev_name(&ofdev->dev);
>>         pdev->id = -1;
>
> This is taken here:
> http://git.secretlab.ca/?p=linux-2.6.git;a=commitdiff;h=04f51955dc690666467252015a931d71d5c56696
>
> and it is pending for upstream.
>
> With the above patch, both pdev->name and pdev->id can be set as per
> hwmod requirement through aux_data lookup table.

Mmm, but I'm already using that patch, and it is only taking care of the 
pdev->id, hence my email. Did I miss something?

> we might have to append pdev->id to pdev->name so that
> it can used for device look up in the hwmod
> device list.

I'm not sure to get your point here.

Benoit
