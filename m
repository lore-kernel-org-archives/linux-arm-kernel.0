From: hs@denx.de (Heiko Schocher)
Date: Fri, 27 Jan 2012 07:40:00 +0100
Subject: [RFC PATCH 6/7] ARM: mtd: nand: davinci: add OF support for
 davinci nand controller
In-Reply-To: <4F21B8AC.40002@freescale.com>
References: <1327308967-8092-1-git-send-email-hs@denx.de>
 <1327308967-8092-7-git-send-email-hs@denx.de> <4F1DF465.60206@freescale.com>
 <4F1E5C82.60108@denx.de> <4F1F0A3E.40805@freescale.com>
 <4F1FAAAE.2060007@denx.de> <4F21B8AC.40002@freescale.com>
Message-ID: <4F2246C0.6020905@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Scott,

Scott Wood wrote:
> On 01/25/2012 01:09 AM, Heiko Schocher wrote:
>> Scott Wood wrote:
>> I found the following used options:
>>
>> ecc_mode:
>> NAND_ECC_NONE
>> NAND_ECC_SOFT
>> NAND_ECC_HW
>> NAND_ECC_HW_SYNDROME
>>
>> bbt_options:
>> NAND_BBT_USE_FLASH
>>
>> ecc_bits:
>> 1
>> 4
>>
>> options:
>> NAND_BUSWIDTH_16
>>
>>>>> Do all of these properties really belong here?  I can see providing some
>>>> I think so, because this values come from existing platform code
>>>> (grep for struct davinci_nand_pdata)
>>> The standards are a bit stricter for the device tree, since it's a more
>>> stable interface across components -- at least that's how we've used it
>>> on a lot of powerpc targets.  I'm not sure if that's the intent here,
>>> but I have seen U-Boot patches for ARM hardware using them as well.
>> Ok, so, should I introduce instead properties for the above
>> needed parameters? 
> 
> Yes.

Ok, I change this.

>> (As this are not davinci specific parameters, are there somewhere such definitions for them?)
> 
> It's controller-specific which options are changeable, and whether
> there's a better source of information.  Most controllers don't seem to
> need this.  I'd keep the definitions davinci specific for now.  If
> there's enough of a common need, a common definition could be considered.

Ok, a proposal for the properties names and values:

>> ecc_mode:
>> NAND_ECC_NONE
>> NAND_ECC_SOFT
>> NAND_ECC_HW
>> NAND_ECC_HW_SYNDROME

"ti,davinci-nand-ecc-mode" = "none", "soft", "hw" or "hw_syndrome"

>> bbt_options:
>> NAND_BBT_USE_FLASH

"ti,davinci-nand-bbt-options" = "use_flash"

>> ecc_bits:
>> 1
>> 4

"ti,davinci-nand-ecc-bits" = "1" or "4"

>> options:
>> NAND_BUSWIDTH_16

"ti,davinci-nand-options" = "buswidth-16"

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
