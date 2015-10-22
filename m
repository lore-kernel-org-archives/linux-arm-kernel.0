From: eric.auger@linaro.org (Eric Auger)
Date: Thu, 22 Oct 2015 14:29:02 +0200
Subject: [PATCH v2 3/6] vfio: platform: reset: calxedaxgmac: add reset
 function registration
In-Reply-To: <43557523.izmYB5ybOS@wuerfel>
References: <1445506922-6005-1-git-send-email-eric.auger@linaro.org>
 <4810974.apRDTjc3oB@wuerfel> <5628CE82.7090105@linaro.org>
 <43557523.izmYB5ybOS@wuerfel>
Message-ID: <5628D68E.5020009@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/22/2015 02:09 PM, Arnd Bergmann wrote:
> On Thursday 22 October 2015 13:54:42 Eric Auger wrote:
>> On 10/22/2015 12:13 PM, Arnd Bergmann wrote:
>>> On Thursday 22 October 2015 11:41:59 Eric Auger wrote:
>>>> This patch adds the reset function registration/unregistration.
>>>>
>>>> Signed-off-by: Eric Auger <eric.auger@linaro.org>
>>>
>>> Looks good, except one thing:
>>>> @@ -70,6 +69,8 @@ int vfio_platform_calxedaxgmac_reset(struct vfio_platform_device *vdev)
>>>>                      return -ENOMEM;
>>>>      }
>>>>  
>>>> +    pr_info("VFIO reset of %s\n", vdev->name);
>>>> +
>>>>      /* disable IRQ */
>>>>      writel(0, reg.ioaddr + XGMAC_DMA_INTR_ENA);
>>>>  
>>>
>>> This probably slipped in from debugging, please remove it.
>> Well actually this is not an oversight but some unappropriate tracing
>> attempt I am afraid. I wanted to add a trace useful for the end-user to
>> make sure the VFIO reset function was called. Do you forbid that or do
>> recommend to use another tracing mechanism/level? In the past I tried
>> dynamic tracing but with module loading mechanism I found it not that handy.
> 
> If you think it's useful to have in the long run, it should be a separate
> patch with a description what it's good for, rather than a side-effect of
> an unrelated patch. It just looked to me like it's something you do
> while debugging the reset code, rather than while using it.
> 
> Implementation-wise, you should use dev_info() instead of pr_info() where
> possible, and it probably makes sense to put this into the vfio_platform
> driver before calling the reset function, for consistency between the
> drivers.
OK thanks

Best Regards

Eric
> 
> 	Arnd
> 
