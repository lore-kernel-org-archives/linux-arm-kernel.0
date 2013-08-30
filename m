From: csd@broadcom.com (Christian Daudt)
Date: Fri, 30 Aug 2013 14:52:27 -0700
Subject: [PATCH v3 2/5] ARM: bcm4760: Add platform infrastructure
In-Reply-To: <20130830075312.GA2447@glitch>
References: <20130814221043.528864175@gmail.com>
 <20130814221237.350904818@gmail.com>
 <20130829231729.GA29606@quad.lixom.net> <20130830075312.GA2447@glitch>
Message-ID: <5221141B.5020105@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-08-30 12:53 AM, Domenico Andreoli wrote:
>>> Index: b/arch/arm/mach-bcm/Kconfig
>>> ===================================================================
>>> --- a/arch/arm/mach-bcm/Kconfig
>>> +++ b/arch/arm/mach-bcm/Kconfig
>>> @@ -17,3 +17,10 @@ config ARCH_BCM
>>>   	  It currently supports the 'BCM281XX' family, which includes
>>>   	  BCM11130, BCM11140, BCM11351, BCM28145 and
>>>   	  BCM28155 variants.
>>> +
>>> +config ARCH_BCM4760
>>> +	bool "Broadcom BCM4760 based SoCs (ARM11)" if ARCH_MULTI_V6
>>> +	select ARM_AMBA
>>> +	select ARM_VIC
>>> +	select CLKSRC_OF
>>> +	select SOC_BUS
>> So I think I mentioned this during previous discussions, but I think this
>> should be solved by having:
>>
>> config ARCH_BCM
>> 	bool "Broadcom platforms"
>> 	help
>> 	  This enables support for Broadcom based systems
>>
>> menu "Broadcom platform selection"
>> 	depends on ARCH_BCM
>>
>> config ARCH_BCM281XX
>> 	... current ARCH_BCM contents
>>
>> config ARCH_BCM4760
>> 	... above conents
>> endmenu
> got it.
>
> need to sync with Christian, the current owner of ARCH_BCM.
This is fine, but it is better to name it MOBILEBCM instead for our 
platform, as it plan to keep it single zImage. My plan was to switch the 
current usage of ARCH_BCM for chips to ARCH_MOBILEBCM, and then leave 
ARCH_BCM as a generic BCM menu option as above. I can send a patch to 
that effect if everyone is okay with that.

  thanks,
    csd
