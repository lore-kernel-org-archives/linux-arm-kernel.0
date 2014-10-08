From: sbranden@broadcom.com (Scott Branden)
Date: Wed, 8 Oct 2014 15:16:55 -0700
Subject: [PATCH 1/6] ARM: cygnus: Initial support for Broadcom Cygnus SoC
In-Reply-To: <34012512.W8VifyXY4H@wuerfel>
References: <1412746025-11998-2-git-send-email-sbranden@broadcom.com>
 <10762659.VISiZ3vSSN@wuerfel> <543565DC.8010704@broadcom.com>
 <34012512.W8VifyXY4H@wuerfel>
Message-ID: <5435B7D7.1030904@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14-10-08 11:12 AM, Arnd Bergmann wrote:
> On Wednesday 08 October 2014 09:27:08 Scott Branden wrote:
>> On 14-10-08 06:28 AM, Arnd Bergmann wrote:
>>> On Wednesday 08 October 2014 05:27:24 Scott Branden wrote:
>>>>>
>>>>> I don't think you need per-board config options. The main option
>>>>> above should be enough.
>>>> This is not a per-board config option.  This is actually a per-SoC
>>>> uArchtecture selection.  More major uArchectures will be added to the
>>>> IPROC.  Will Change comment to "Support Broadcom Cygnus SoC"
>>>
>>> Ok, sounds fine, but remove ARCH_BCM_IPROC then. There should be
>>> no need for a three-level deep hierarchy (BCM -> IPROC -> CYGNUS)
>>>
>> I do not need a 3-deep hierarchy, I need a 2-deep hierarchy for IPROC
>> and CYGNUS (and future SoCs that have IPROC Architecture in common).  I
>> can move IPROC out of the mach-bcm directory if you like a create a new
>> directory?  But it looks like the purpose of mach-bcm is to consolidate
>> all Broadcom chipsets in it?
>
> Yes, better leave it all in mach-bcm. You really shouldn't need much
> code at all that is soc specific, so adding new directories is not
> encouraged. We have some platforms that need no code at all, and on
> arm64 that is required.
>
> Isn't Northstar also IPROC? That one didn't seem to need the symbol.
>
> Could you make ARCH_BCM_IPROC a silent symbol that is just selected
> by each SoC family specific symbol?
It looks like I will also be able to add Northstar under the 
ARCH_BCM_IPROC.  This will be good momentum to cleaning up and 
consolidate support going forward.
I will change the Kconfig such that ARCH_BCM_5301X selects ARCH_BCM_IPROC.

Thanks.
>
> 	Arnd
>
