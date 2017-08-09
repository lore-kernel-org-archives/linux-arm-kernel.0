From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 9 Aug 2017 14:02:42 -0500
Subject: [PATCH 2/3] [v3] pinctrl: qcom: disable GPIO groups with no pins
In-Reply-To: <CACRpkdZj+tnMcEpic6PrQS-qMJDodmc_uFJVudxc=USCTXpyKg@mail.gmail.com>
References: <1501179565-26466-1-git-send-email-timur@codeaurora.org>
 <1501179565-26466-3-git-send-email-timur@codeaurora.org>
 <CACRpkdZj+tnMcEpic6PrQS-qMJDodmc_uFJVudxc=USCTXpyKg@mail.gmail.com>
Message-ID: <d0b16753-b202-5756-1cba-1cd083af52ed@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/31/2017 08:36 AM, Linus Walleij wrote:
>> To support sparse GPIO maps, pinctrl-msm client drivers can specify
>> that a given GPIO has a pin count of zero.  These GPIOs will be
>> considered "hidden".  Any attempt to claim the GPIO will fail, and they
>> will not be listed in debugfs.
>>
>> During a kexec shutdown, machine_kexec_mask_interrupts() will attempt
>> to disable all IRQs, even those that aren't enabled.  This includes
>> GPIOs that are unavailable (npins == 0), so add a check to the irq mask
>> and unmask functions.
>>
>> Signed-off-by: Timur Tabi<timur@codeaurora.org>

> I'm waiting for Bj?rn's review of the two remaining patches.

Bj?rn, do you have time to review these patches?  I'm hoping to get them 
into 4.14.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
