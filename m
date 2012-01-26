From: scottwood@freescale.com (Scott Wood)
Date: Thu, 26 Jan 2012 14:33:48 -0600
Subject: [RFC PATCH 6/7] ARM: mtd: nand: davinci: add OF support for
 davinci nand controller
In-Reply-To: <4F1FAAAE.2060007@denx.de>
References: <1327308967-8092-1-git-send-email-hs@denx.de>
 <1327308967-8092-7-git-send-email-hs@denx.de> <4F1DF465.60206@freescale.com>
 <4F1E5C82.60108@denx.de> <4F1F0A3E.40805@freescale.com>
 <4F1FAAAE.2060007@denx.de>
Message-ID: <4F21B8AC.40002@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/25/2012 01:09 AM, Heiko Schocher wrote:
> Scott Wood wrote:
> I found the following used options:
> 
> ecc_mode:
> NAND_ECC_NONE
> NAND_ECC_SOFT
> NAND_ECC_HW
> NAND_ECC_HW_SYNDROME
> 
> bbt_options:
> NAND_BBT_USE_FLASH
> 
> ecc_bits:
> 1
> 4
> 
> options:
> NAND_BUSWIDTH_16
> 
>>>> Do all of these properties really belong here?  I can see providing some
>>> I think so, because this values come from existing platform code
>>> (grep for struct davinci_nand_pdata)
>>
>> The standards are a bit stricter for the device tree, since it's a more
>> stable interface across components -- at least that's how we've used it
>> on a lot of powerpc targets.  I'm not sure if that's the intent here,
>> but I have seen U-Boot patches for ARM hardware using them as well.
> 
> Ok, so, should I introduce instead properties for the above
> needed parameters? 

Yes.

> (As this are not davinci specific parameters, are there somewhere such definitions for them?)

It's controller-specific which options are changeable, and whether
there's a better source of information.  Most controllers don't seem to
need this.  I'd keep the definitions davinci specific for now.  If
there's enough of a common need, a common definition could be considered.

-Scott
