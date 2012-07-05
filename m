From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 05 Jul 2012 16:17:24 +0100
Subject: [PATCH] of: address: Don't fail a lookup just because a node
 has no reg property
In-Reply-To: <4FF5AB4D.6090500@gmail.com>
References: <1341498754-30445-1-git-send-email-lee.jones@linaro.org>
 <4FF5AB4D.6090500@gmail.com>
Message-ID: <4FF5B004.4080100@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/07/12 15:57, Rob Herring wrote:
> On 07/05/2012 09:32 AM, Lee Jones wrote:
>> Sometimes it doesn't make any sense for a node to have an address.
>> In this case device lookup will always be unsuccessful because we
>> currently assume every node will have a reg property. This patch
>> changes the semantics so that the resource address and the lookup
>> address will only be compared if one exists.
>>
>> Things like AUXDATA() rely on of_dev_lookup to return the lookup
>> entry of a particular device in order to do things like apply
>> platform_data to a device. However, this is currently broken for
>> nodes which do not have a reg property, meaning that platform_data
>> can not be passed in those cases.
>>
>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>> ---
>
> Acked-by: Rob Herring <rob.herring@calxeda.com>
>
> Do you have something dependent on this or want me to apply?

I have things that require this patch yes. Please apply.

Thanks Rob.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
