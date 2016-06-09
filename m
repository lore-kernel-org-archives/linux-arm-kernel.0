From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 8 Jun 2016 22:33:57 -0400
Subject: [PATCH V6 5/8] vfio: platform: call _RST method when using ACPI
In-Reply-To: <CAJZ5v0iHxtL3cZVymfz0BqCGjBeBAuEyMXwj5sNBvMQQXgm8rg@mail.gmail.com>
References: <1464472878-27176-1-git-send-email-okaya@codeaurora.org>
 <1464472878-27176-6-git-send-email-okaya@codeaurora.org>
 <CAJZ5v0iHxtL3cZVymfz0BqCGjBeBAuEyMXwj5sNBvMQQXgm8rg@mail.gmail.com>
Message-ID: <5758D595.5090006@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/8/2016 6:31 PM, Rafael J. Wysocki wrote:
> On Sun, May 29, 2016 at 12:01 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
>> The device tree code checks for the presence of a reset driver and calls
>> the of_reset function pointer by looking up the reset driver as a module.
>>
>> ACPI defines _RST method to perform device level reset. After the _RST
>> method is executed, the OS can resume using the device. _RST method is
>> expected to stop DMA transfers and IRQs.
>>
>> This patch checks the presence of _RST method and calls the _RST
>> method when reset is requested.
> 
> You could check if _RST is present at probe time and store the ACPI
> handle of it instead of the HID pointer.
> 
> This way you wouldn't need to repeat that check every time reset is used.
> 

Makes sense. I'll give it a shot.

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
