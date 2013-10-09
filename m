From: bcousson@baylibre.com (Benoit Cousson)
Date: Wed, 09 Oct 2013 10:19:01 +0200
Subject: [PATCH 3/3] ARM: OMAP2+: Let DT say what devices should not to
 idled or reset
In-Reply-To: <525507A4.9010308@ti.com>
References: <1376983966-16490-1-git-send-email-rnayak@ti.com>
 <1376983966-16490-4-git-send-email-rnayak@ti.com>
 <alpine.DEB.2.02.1310090720230.30199@utopia.booyaka.com>
 <525507A4.9010308@ti.com>
Message-ID: <52551175.3070705@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rajendra,

On 09/10/2013 09:37, Rajendra Nayak wrote:
> On Wednesday 09 October 2013 12:54 PM, Paul Walmsley wrote:
>> Hi Beno?t, Rajendra,
>>
>> On Tue, 20 Aug 2013, Rajendra Nayak wrote:
>>
>>> Now that we have DT bindings to specify which devices on the SoC should not
>>> be reset or idled, get rid of the same information existing as part of the
>>> hwmod data files and pass this info from DT instead.
>>>
>>> For GPMC, the HWMOD_INIT_NO_RESET flag seems to be added in hwmod not due to
>>> any errata around the GPMC IP, but rather because any timings
>>> set by the bootloader are not being correctly programmed by the kernel.
>>> This seems like something that needs to be fixed as part of GPMC driver
>>> in the kernel, and hence the flag is left as is in hwmod, which can be
>>> removed once the driver does what its expected to.
>>>
>>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>>> ---
>>>   arch/arm/boot/dts/am33xx.dtsi              |    2 ++
>>>   arch/arm/boot/dts/omap4.dtsi               |    3 +++
>>>   arch/arm/boot/dts/omap5.dtsi               |    2 ++
>>>   arch/arm/mach-omap2/omap_hwmod_33xx_data.c |    4 ++--
>>>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    4 +---
>>>   arch/arm/mach-omap2/omap_hwmod_54xx_data.c |    2 --
>>>   6 files changed, 10 insertions(+), 7 deletions(-)
>>
>> Looking at this one, maybe the best thing for this patch is for Rajendra
>> to split it into two patches.  Beno?t can merge the DTS patch first, then
>> I can merge the hwmod side as a cleanup once the first one goes in.  That
>> will avoid conflicts from other DTS and hwmod changes going into the tree.
>>
>> Rajendra, when you do the split, please add in the DT documentation part
>> from patch 2.  Am going to strip that out from the second patch and just
>> merge the hwmod changes.
>>
>> Sound good?
>
> Sure Paul, I'll repost the complete series with proper splits such that its
> easier for you and Benoit to pick them up independently.

If you could do it soon, I'm about to send an early pull request to Tony 
to avoid the trouble we had last time.

Thanks,
Benoit
