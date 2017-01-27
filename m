From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 27 Jan 2017 11:04:57 +0100
Subject: [PATCH v5 05/12] dt: bindings: Add bindings for Marvell Xenon SD
 Host Controller
In-Reply-To: <CAPDyKFrCxk37uVZ4wM-=iwX3-Cn9j+uh1KneJoopVzia2nKTVA@mail.gmail.com>
 (Ulf Hansson's message of "Thu, 26 Jan 2017 11:49:52 +0100")
References: <cover.8527229dae6c124f24c5e637430c2cdc86f80392.1484154449.git-series.gregory.clement@free-electrons.com>
 <89c95d0084da6ad7132caa54ca66eb619d8a5090.1484154449.git-series.gregory.clement@free-electrons.com>
 <CAPDyKFrCxk37uVZ4wM-=iwX3-Cn9j+uh1KneJoopVzia2nKTVA@mail.gmail.com>
Message-ID: <87fuk4yg1i.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf,
 
 On jeu., janv. 26 2017, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> On 11 January 2017 at 18:19, Gregory CLEMENT
> <gregory.clement@free-electrons.com> wrote:
>> From: Hu Ziji <huziji@marvell.com>
>>
>> Marvell Xenon SDHC can support eMMC/SD/SDIO.
>> Add Xenon-specific properties.
>> Also add properties for Xenon PHY setting.
>>
>> Signed-off-by: Hu Ziji <huziji@marvell.com>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>
> An overall comment. Please run a spell-checking as I noticed some
> simple errors that needs to be fixed.

I though I already run a spell-checking before submitting the patch, but
I will do it again.

>
> Optional Properties:
>> +- mmccard:
>> +  mmccard child node must be provided when current SDHC is for eMMC.
>> +  Xenon SDHC often can support both SD and eMMC. This child node indicates that
>> +  current SDHC is for eMMC card. Thus Xenon eMMC specific configuration and
>> +  operations can be enabled prior to eMMC init sequence.
>> +  Please refer to Documentation/devicetree/bindings/mmc/mmc-card.txt.
>> +  This child node should not be set if current Xenon SDHC is for SD/SDIO.
>> +
>> +- bus-width:
>> +  When 8-bit data bus width is in use for eMMC, this property should be
>> +  explicitly provided and set as 8.
>> +  It is optional when data bus width is 4-bit or 1-bit.
>> +
>> +- mmc-ddr-1_8v:
>> +  Select this property when eMMC HS DDR is supported on SDHC side.
>> +
>> +- mmc-hs400-1_8v:
>> +  Select this property when eMMC HS400 is supported on SDHC side.
>
> All the above properties is already specified as common mmc bindings.
> Let's not do that again, but instead just refer to mmc.txt as how
> other documentations looks like.

OK, but maybe we could keep the part about the mmcard for the eMMC to
emphasize that we need to setup this option for the controller.

>> +
>> +- no-1-8-v:
>> +  Select this property when 1.8V signaling voltage supply is unavailable.
>> +  When this property is enabled, both mmc-ddr-1_8v and mmc-hs400-1_8v should be
>> +  cleared.
>
> Please don't use this sdhci property, unless really needed.

Actually this is a mmc property, at least it is described in this the
mmc binding:
Documentation/devicetree/bindings/mmc/mmc.txt

The description of this optional property is:
"no-1-8-v: when present, denotes that 1.8v card voltage is not supported on
  this system, even if the controller claims it is."

So as it is also part of the mmc binding we can remove it from our
bindings as we are going to do it for the other mmc property.

But I am curious to know why do you think we could use it without any
need. Are you aware of some abuse of this property?

>
> Perhaps you can elaborate exactly why it makes sense for your case. Or
> perhaps we already discussed this, in either case, please re-fresh my
> mind.

For instance we need it now on the 7040DB board which does not have the
1.8V signal voltage available.

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
