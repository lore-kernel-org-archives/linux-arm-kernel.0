From: b-cousson@ti.com (Benoit Cousson)
Date: Thu, 6 Sep 2012 17:16:26 +0200
Subject: [PATCH 0/2] OMAP: hwmod: fix hardreset handling
In-Reply-To: <CALLhW=4GNagMQgn+W8muLz__sSRv6ZOt_FvzXHLcaQzw3N_3yg@mail.gmail.com>
References: <1345614150-25723-1-git-send-email-omar.luna@linaro.org>
 <CALLhW=4GNagMQgn+W8muLz__sSRv6ZOt_FvzXHLcaQzw3N_3yg@mail.gmail.com>
Message-ID: <5048BE4A.1000603@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Omar,

On 09/03/2012 04:29 PM, Omar Ramirez Luna wrote:
> On 22 August 2012 00:42, Omar Ramirez Luna <omar.luna@linaro.org> wrote:
>> From: Omar Ramirez Luna <omar.ramirez@ti.com>
>>
>> The patch to expose hwmod assert/deassert functions through omap_device
>> has been accepted and queued for 3.7[1], however these two patches are
>> needed to make the API functional. Hence a revised version is being sent
>> according to previous comments:
>>
>> - ARM: OMAP: hwmod: revise deassert sequence
>> Now it uses enable|disable_module to handle the configuration of the
>> modulemode inside CLKCTRL. As part of the cleanup of leaf clocks, the
>> one associated with ipu_mmu will be removed along with the iommu hwmod
>> migration[2].
>>
>> - ARM: OMAP: hwmod: partially un-reset hwmods might not be properly
>>   enabled
>> More infomation added in the patch description[3].
>>
>> [1] http://patchwork.kernel.org/patch/1266731/
>> [2] http://patchwork.kernel.org/patch/1201791/
>> [3] http://patchwork.kernel.org/patch/1201801/
>>
>> Omar Ramirez Luna (2):
>>   ARM: OMAP: hwmod: partially un-reset hwmods might not be properly
>>     enabled
>>   ARM: OMAP: hwmod: revise deassert sequence
>>
>>  arch/arm/mach-omap2/omap_hwmod.c |   74 ++++++++++++++++++++++++++++++--------
>>  1 file changed, 59 insertions(+), 15 deletions(-)
> 
> Ping.

Oops, sorry, I forgot your series.

Beside the concern about the duplication of code, that looks good to me.

I'll sync with Paul to see who will push that series.

Regards,
Benoit
