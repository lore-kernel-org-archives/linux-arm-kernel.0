From: eric.auger@linaro.org (Eric Auger)
Date: Fri, 23 Oct 2015 16:10:59 +0200
Subject: [PATCH v3 3/7] vfio: platform: introduce
 module_vfio_reset_handler macro
In-Reply-To: <3721718.lcvGuESNdi@wuerfel>
References: <1445603835-14506-1-git-send-email-eric.auger@linaro.org>
 <1445603835-14506-4-git-send-email-eric.auger@linaro.org>
 <3721718.lcvGuESNdi@wuerfel>
Message-ID: <562A3FF3.5040004@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,
On 10/23/2015 03:09 PM, Arnd Bergmann wrote:
> On Friday 23 October 2015 14:37:11 Eric Auger wrote:
>> +static int __init reset ## _module_init(void)                  \
>> +{                                                              \
>> +       vfio_platform_register_reset(compat, reset);            \
>> +       return 0;                                               \
>> +};                                                             \
>>
> 
> I would make this 'return vfio_platform_register_reset(...)', so loading
> the driver fails if the handler cannot get registered. Alternatively,
> change the return type of vfio_platform_register_reset to 'void'
> so it can never fail.
I will turn __vfio_platform_register_reset to 'void' then since it has
no reason to fail now.

Thanks

Eric

> 
> 	Arnd
> 
