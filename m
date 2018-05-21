From: t-kristo@ti.com (Tero Kristo)
Date: Mon, 21 May 2018 09:57:54 +0300
Subject: [RFC 12/13] ARM: dts: ti: add dra71-evm FIT description file
In-Reply-To: <20180417144913.GD5669@atomide.com>
References: <1523956215-28154-1-git-send-email-t-kristo@ti.com>
 <1523956215-28154-13-git-send-email-t-kristo@ti.com>
 <20180417092924.GB20335@flint.armlinux.org.uk>
 <ad5ef67d-d566-0034-a7cd-09a549cbd6d7@ti.com>
 <20180417144913.GD5669@atomide.com>
Message-ID: <43ff3894-a287-1558-687c-40f50712735c@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/04/18 17:49, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [180417 09:36]:
>> In typical setup, you can boot a large number of different configs via:
>>
>> bootm 0x82000000#dra71-evm#nand#lcd-auo-g101evn01.0
>>
>> ... assuming the configs were named like that, and assuming they would be
>> compatible with each other. The am57xx-evm example provided is better, as
>> you can chain the different cameras to the available evm configs.
> 
> Why not just do it in the bootloader to put together the dtb?
> 
> Then for external devices, you could just pass info on the
> kernel cmdline with lcd=foo camera=bar if they cannot be
> detected over I2C.

(Added Linux ARM list to CC, this was not part of the original delivery.)

Ok trying to resurrect this thread a bit. Is there any kind of consensus 
how things like this should be handled? Should we add the DT overlay 
files to kernel tree or not?

Should we add any kind of build infra to kernel tree, and at what level 
would this be? Just DT overlay file building support, and drop the FIT 
build support as was proposed in this RFC series or...?

U-boot can obviously parse the base DTB + overlay DTB:s into a single 
DTB, but this is somewhat clumsy approach and is relatively error prone 
to get it right.

Building the FIT image post kernel build would also be possible, but who 
would be doing this, is there any need to get this done in generic 
manner or shall we just add SoC vendor specific tools for this?

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
