From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 10 Sep 2014 14:45:21 +0100
Subject: ARM bigendian cpuhotplug
In-Reply-To: <CAMQ1t3q22P7UDXUhoJiThjnrS_GMdAFaSaDxRzUi8KM=pa9QQw@mail.gmail.com>
References: <CAMQ1t3q22P7UDXUhoJiThjnrS_GMdAFaSaDxRzUi8KM=pa9QQw@mail.gmail.com>
Message-ID: <541055F1.2060604@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/09/14 13:59, Hemanth Kumar wrote:
>> Are you referring to ARM Vexpress platform with TC2/CA15_A7 card ?
>> If yes, idle doesn't work with CONFIG_MTD_CFI irrespective of
>> endianness, it's platform limitation.
>
>> Regards,
>> Sudeep
>
>
> Thanks for the reply what is the hardware limitation for this card (VE
> CA-15_A7) when we enable CONFIG_MTD_CFI
>

The cpu resume path should ideal be on some sram or on-chip memory, but
on TC2 we use the NOR flash @0x0. When you enable NOR flash in Linux,
you can't expect it to be in read-mode always as other cpus might put
the NOR device is any mode based on its interaction. As a result when a
suspended cpu resumes it might not find the resume code if NOR was not
in read mode resulting in unpredicted behaviour. As I said before it's
purely a platform firmware limitation.

Regards,
Sudeep
