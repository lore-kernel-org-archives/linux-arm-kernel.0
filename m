From: zonque@gmail.com (Daniel Mack)
Date: Wed, 03 Oct 2012 13:16:39 +0200
Subject: [alsa-devel] [PATCH 0/3] ASoC: Davinci: McASP: add support new
 McASP IP Variant
In-Reply-To: <1BAFE6F6C881BF42822005164F1491C33EA99A40@DBDE01.ent.ti.com>
References: <1346417459-30042-1-git-send-email-gururaja.hebbar@ti.com>
 <506B6A9D.3090100@gmail.com>
 <1BAFE6F6C881BF42822005164F1491C33EA99A40@DBDE01.ent.ti.com>
Message-ID: <506C1E97.1070700@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03.10.2012 09:16, Hebbar, Gururaja wrote:
> On Wed, Oct 03, 2012 at 03:58:45, Daniel Mack wrote:
>> On 31.08.2012 14:50, Hebbar, Gururaja wrote:
>>> The OMAP2+ variant of McASP is different from Davinci variant w.r.to some
>>> register offset and missing generic SRAM APIs support
>>>
>>> Changes
>>> - Add new MCASP_VERSION_3 to identify new variant. New DT compatible
>>>   "ti,omap2-mcasp-audio" to identify version 3 controller.
>>> - The register offsets are handled depending on the version.
>>> - Provide a config option to indicate missing SRAM API support.
>>
>> Could you give some insight which hardware this was tested on? I'm
>> trying to get this up and running on a AM33xx board, and the patches
>> look all reasonable to me. My problem is that I can't make the DMA
>> engine move forward, I fail to receive a single interrupt on this
>> peripheral after the stream starts. I will continue searching for the
>> reason of this tomorrow, but maybe you can give me some hint by
>> explaining your setup?
>>
>> Note that I'm using your patches together with Matt's from this series:
>>
>>   https://github.com/ohporter/linux/tree/edma-dmaengine-am33xx-rfc-v1
>>
>> ... but it doesn't work without those either.
> 
> 
> When I started working on adding DT support to McASP driver, Matt Porter 
> EDMA port was not yet ready. 
> 
> So 
> 1. I took existing edma driver from AM335x Arago release [1] (driver + edma 
>    device init). 
> 2. Added this to Vaibhav's Local (linux-next + AM335x patches) tree [2] 
> 
> 3. Added DT support to McASP driver.
> 
> I tested this on AM335x EVM board. 

Hmm, so I think there's a tiny bit missing for the EDMA conversion on DT
kernels.

> If you need the code, I can share it as a patch (I will send the patch as a 
> private mail since the patch is huge).

Please do :) Or just push your entire tree somewhere.


Thanks,
Daniel
