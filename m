From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 5 Sep 2017 17:54:43 +0100
Subject: [PATCH v2 05/18] firmware: arm_scmi: add initial support for
 performance protocol
In-Reply-To: <534bae20-9f80-e79b-42a5-93d838732720@arm.com>
References: <1501857104-11279-1-git-send-email-sudeep.holla@arm.com>
 <1501857104-11279-6-git-send-email-sudeep.holla@arm.com>
 <2690239b-27a7-dce3-88a6-d53808e8e93c@arm.com>
 <534bae20-9f80-e79b-42a5-93d838732720@arm.com>
Message-ID: <b7303424-d63f-5ea7-866a-bda6d1f93ff2@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Julien,

On 05/09/17 16:56, Julien Thierry wrote:
> 
> 
> On 05/09/17 16:04, Julien Thierry wrote:

[...]


>>
>> This seems odd, shouldn't it be the following?
>> le64_to_cpu(attr->stats_addr_low | (__le64)attr->stats_addr_high << 32)
>>
> 
> After further reflexion, I think you are right. If I understood the
> specification, the address seems to be split into upper and lower 32bits
> and each one is stored as a uint32, which fits what you are doing to
> obtain the address.
> 
> You can ignore my previous comment.
> 

Sorry I am checking this bit late, you have figured out yourself
already. All the 64 bit values need to be dealt similarly as SCMI
specification restricts so. It's basically done so as the firmware
running is mostly 32-bit little endian system.

-- 
Regards,
Sudeep
