From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 28 Feb 2018 15:58:11 +0000
Subject: [PATCH] arm64: dts: juno: fix size of GICv2m MSI frames
In-Reply-To: <36126393-ee37-40f1-9d5d-1c7f25c648dc@arm.com>
References: <20180207143255.17003-3-marc.zyngier@arm.com>
 <1519832935-7338-1-git-send-email-sudeep.holla@arm.com>
 <36126393-ee37-40f1-9d5d-1c7f25c648dc@arm.com>
Message-ID: <f4ce910b-f263-a4e1-710c-875ac152d4bf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 28/02/18 15:51, Robin Murphy wrote:
> Hi Sudeep,
> 
> Cheers for sorting it out...
> 
> On 28/02/18 15:48, Sudeep Holla wrote:
>> Currently the size of GICv2m MSI frames are listed as 4kB while the
>> Juno TRM specifies 64kB for each of these MSI frames.
>>
>> Though the devices connected themself might just use the first 4kB,
> 
> s/themself/themselves/
> 
>> to be consistent with the genaral practice of 64kB boundary alignment
> 
> s/genaral/general/
> 

Fixed those now.

>> to all the devices, lets keep the size as 64kB. This might also help
>> in avoiding any surprise when passing the device to a VM.
>>
>> This patch increase the size of each GICv2m MSI frames from 4kB to 64kB
>> as per the specification.
> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> 

Thanks.

-- 
Regards,
Sudeep
