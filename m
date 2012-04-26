From: wcohen@redhat.com (William Cohen)
Date: Thu, 26 Apr 2012 11:16:27 -0400
Subject: [PATCH] Add the Performance Monitoring Unit to the Trimslice
 device tree
In-Reply-To: <4F9597B4.5020208@redhat.com>
References: <1330740413-29260-1-git-send-email-wcohen@redhat.com>
 <20120305103245.GC31189@mudshark.cambridge.arm.com>
 <4F9597B4.5020208@redhat.com>
Message-ID: <4F9966CB.6090504@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/23/2012 01:56 PM, William Cohen wrote:
> On 03/05/2012 05:32 AM, Will Deacon wrote:
>> On Sat, Mar 03, 2012 at 02:06:53AM +0000, William Cohen wrote:
>>> The tegra processor has a performance monitoring unit. However, this
>>> was not listed on the board-trimslice.c devices. This patch adds
>>> it to the list of devices and allows one to use hardware performance
>>> monitoring events on the trimslice machine.
>>>
>>> Signed-off-by: William Cohen <wcohen@redhat.com>
>>> ---
>>>  arch/arm/mach-tegra/board-trimslice.c |    1 +
>>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-tegra/board-trimslice.c b/arch/arm/mach-tegra/board-trimslice.c
>>> index cd52820..0484903 100644
>>> --- a/arch/arm/mach-tegra/board-trimslice.c
>>> +++ b/arch/arm/mach-tegra/board-trimslice.c
>>> @@ -82,6 +82,7 @@ static struct platform_device trimslice_audio_device = {
>>>  
>>>  static struct platform_device *trimslice_devices[] __initdata = {
>>>  	&debug_uart,
>>> +	&tegra_pmu_device,
>>>  	&tegra_sdhci_device1,
>>>  	&tegra_sdhci_device4,
>>>  	&tegra_i2s_device1,
>>> -- 
>>> 1.7.5.2
>>
>> Olof - would you be able to pick this up please? I've not been able to test
>> it, but since the device is already defined I'm assuming the IRQ numbers are
>> correct.
>>
>> Cheers,
>>
>> Will
> 
> Hi Will and Olof,
> 
> Has this patch been pulled into the git tree?  -Will (Cohen)


This patch pretty much duplicates what is already done for in board-seaboard.c:

http://lxr.linux.no/#linux+v3.3.3/arch/arm/mach-tegra/board-seaboard.c#L147

I have tested the patch out with oprofile, papi, and perf. Things seem to function properly with the patch on a trimslice.

-Will
