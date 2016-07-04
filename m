From: ray.jui@broadcom.com (Ray Jui)
Date: Mon, 4 Jul 2016 09:34:35 -0700
Subject: [PATCH 6/7] dt-bindings: net: bgmac: add bindings documentation
 for bgmac
In-Reply-To: <6488341.IDGze89kcW@wuerfel>
References: <1467327554-22074-1-git-send-email-jon.mason@broadcom.com>
 <29091648.CIZSyGWL7u@wuerfel>
 <CAC3K-4qfb3JQ3i8nEo2AOobb1ExB=d=dSZUrdype+z9eHi1FwQ@mail.gmail.com>
 <6488341.IDGze89kcW@wuerfel>
Message-ID: <e8ba3130-38ff-3d67-da64-f7c15ec27ded@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 7/1/2016 8:42 AM, Arnd Bergmann wrote:
> On Friday, July 1, 2016 11:17:25 AM CEST Jon Mason wrote:
>> On Fri, Jul 1, 2016 at 5:46 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>>> On Thursday, June 30, 2016 6:59:13 PM CEST Jon Mason wrote:
>>>> +
>>>> +Required properties:
>>>> + - compatible: "brcm,bgmac-nsp"
>>>> + - reg:                Address and length of the GMAC registers,
>>>> +               Address and length of the GMAC IDM registers
>>>> + - reg-names:  Names of the registers.  Must have both "gmac_base" and
>>>> +               "idm_base"
>>>> + - interrupts: Interrupt number
>>>> +
>>>
>>>
>>> "brcm,bgmac-nsp" sounds a bit too general. As I understand, this is a family
>>> of SoCs that might not all have the exact same implementation of this
>>> ethernet device, as we can see from the long lookup table in bgmac_probe().
>>
>> The Broadcom iProc family of SoCs contains:
>> Northstar
>> Northstar Plus
>> Cygnus
>> Northstar 2
>> a few SoCs that are under development
>> and a number of ethernet switches (which might never be officially supported)
>>
>> Each one of these SoCs could have a different revision of the gmac IP
>> block, but they should be uniform within each SoC (though there might
>> be a A0/B0 change necessary).  The Northstar Plus product family has a
>> number of different implementations, but the SoC is unchanged.  So, I
>> think this might be too specific, when we really need a general compat
>> string.
>
> Ok, thanks for the clarification, that sounds good enough.
>
>> Broadcom has a history of sharing IP blocks amongst the different
>> divisions.  So, this driver might be used on other SoC families (as it
>> apparently has been done in the past, based on the code you
>> reference).  I do not know of any way to know what legacy, non-iProc
>> chips have used this IP block.  I can make this "brcm,iproc-bgmac",
>> and add "brcm,iproc-nsp-bgmac" as an alternative compatible string in
>> this file (which I believe you are suggesting), but there might be
>> non-iProc SoCs that use this driver.  Is this acceptable?
>
> If it is also used outside of iProc, then I see no need for the
> extra compatible string, although it would not do any harm either.
>
> Ideally we should name it whatever the name for this IP block is
> inside of the company, with "nsp" as the designation for the variant
> in Northstar Plus. A lot of Broadcom IP blocks themselves seem to have
> some four-digit or five-digit number, maybe this one does too?
>
> 	Arnd
>

Note this IP block has an official IP controller name of "amac" from the 
ASIC team.

Thanks,

Ray
