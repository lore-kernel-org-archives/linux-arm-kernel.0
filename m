From: rjui@broadcom.com (Ray Jui)
Date: Mon, 27 Jul 2015 11:44:56 -0700
Subject: [PATCH v4 3/4] arm64: Add Broadcom iProc family support
In-Reply-To: <CAOesGMgM1_F3JRKmS3mYJJZUYUTHYLbYjCD1oOh0PNREMa3FKQ@mail.gmail.com>
References: <1437528583-855-1-git-send-email-rjui@broadcom.com>
 <1437528583-855-4-git-send-email-rjui@broadcom.com>
 <20150724085103.GA30410@arm.com> <55B25CF7.4070403@broadcom.com>
 <CAOesGMgM1_F3JRKmS3mYJJZUYUTHYLbYjCD1oOh0PNREMa3FKQ@mail.gmail.com>
Message-ID: <55B67C28.4010706@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On 7/27/2015 11:35 AM, Olof Johansson wrote:
> On Fri, Jul 24, 2015 at 5:42 PM, Ray Jui <rjui@broadcom.com> wrote:
>> Hi Will,
>>
>> On 7/24/2015 1:51 AM, Will Deacon wrote:
>>> (adding Olof)
>>>
>>> On Wed, Jul 22, 2015 at 02:29:42AM +0100, Ray Jui wrote:
>>>> This patch adds support to Broadcom's iProc family of arm64 based SoCs
>>>> in the arm64 Kconfig and defconfig files
>>>>
>>>> Signed-off-by: Ray Jui <rjui@broadcom.com>
>>>> Reviewed-by: Scott Branden <sbranden@broadcom.com>
>>>> ---
>>>>  arch/arm64/Kconfig           |    5 +++++
>>>>  arch/arm64/configs/defconfig |    2 ++
>>>>  2 files changed, 7 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>>> index 318175f..969ef4a 100644
>>>> --- a/arch/arm64/Kconfig
>>>> +++ b/arch/arm64/Kconfig
>>>> @@ -162,6 +162,11 @@ source "kernel/Kconfig.freezer"
>>>>
>>>>  menu "Platform selection"
>>>>
>>>> +config ARCH_BCM_IPROC
>>>> +    bool "Broadcom iProc SoC Family"
>>>> +    help
>>>> +      This enables support for Broadcom iProc based SoCs
>>>> +
>>>
>>> The arm-soc guys have a patch moving the platform-related config options
>>> out into Kconfig.platforms, so I think you need to co-ordinate with them.
>>>
>>
>> Thanks for letting me know. I see that those patches are already merged
>> into for-next under arm-soc. I guess I should generate a new patch
>> series based on for-next and move this config option to Kconfig.platform?
>>
>> Olof, any comment?
> 
> Yeah, please do that and send that series with arm at kernel.org on cc,
> we'll apply it from there!
> 
> 
> Thanks,
> 
> -Olof
> 

Note this patch series contains some iProc PCIe patches as per-requsite
that need to be applied before the ARCH_BCM_IPROC arm64 patch. Without
the PCIe patch, arm64 build out of defconfig would be broken.

Bjorn has acked the PCIe patches. I'll re-send the entire patch series
to you and arm at kernel.org and you can merge them there.

Thanks,

Ray
