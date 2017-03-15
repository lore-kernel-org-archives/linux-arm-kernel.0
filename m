From: timur@codeaurora.org (Timur Tabi)
Date: Tue, 14 Mar 2017 19:12:06 -0500
Subject: [PATCH] pinctrl: qcom: add get_direction function
In-Reply-To: <20170314234140.GI10239@codeaurora.org>
References: <1486768860-18237-1-git-send-email-timur@codeaurora.org>
 <8652c018-4051-5c77-3126-2d41d150518a@codeaurora.org>
 <CACRpkdaoHTZa+XjEBAMtO2dS1jevi5h-QYe90SrZDuJghQSyYw@mail.gmail.com>
 <13b19c7f-9440-ab8e-8a2f-d1796a9b3dde@codeaurora.org>
 <CACRpkdZFzYStyPfK1DwkZfvtd7wX9HtD1bnCy+i9h-7xowOz4g@mail.gmail.com>
 <e209d18d-dc53-c0e9-448c-8a88264cac74@codeaurora.org>
 <20170314233040.GH10239@codeaurora.org>
 <c40b0ee7-6d8c-8c5d-d4c5-9ecf8076e44f@codeaurora.org>
 <20170314234140.GI10239@codeaurora.org>
Message-ID: <f1152d48-004e-71bc-16a1-3a25990ba9e4@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Boyd wrote:

>> > The idea is to notify drivers with an error code when they make a
>> > mistake. Perhaps the device tree or the ACPI table has an error?

> In general the kernel isn't a firmware validator. At least that's
> the way I view it. Others may have different opinions here.

I would be okay with wrapping that check around #ifdef CONFIG_DEBUG_GPIO.

>> > I could add that, but I still think returning an error code is
>> > appropriate.  On the TLMM, we know for sure that the pin must be set
>> > to function 0 in order for the read/write routines to operate
>> > correctly.

> On ACPI we could make the gpio_get() path fail if the pin isn't
> in GPIO mode?

Did you mean the gpio_chip.request callback?  Currently that points to 
gpiochip_generic_request in pinctrl-msm.c.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
