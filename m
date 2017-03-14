From: timur@codeaurora.org (Timur Tabi)
Date: Tue, 14 Mar 2017 18:34:42 -0500
Subject: [PATCH] pinctrl: qcom: add get_direction function
In-Reply-To: <20170314233040.GH10239@codeaurora.org>
References: <1486768860-18237-1-git-send-email-timur@codeaurora.org>
 <8652c018-4051-5c77-3126-2d41d150518a@codeaurora.org>
 <CACRpkdaoHTZa+XjEBAMtO2dS1jevi5h-QYe90SrZDuJghQSyYw@mail.gmail.com>
 <13b19c7f-9440-ab8e-8a2f-d1796a9b3dde@codeaurora.org>
 <CACRpkdZFzYStyPfK1DwkZfvtd7wX9HtD1bnCy+i9h-7xowOz4g@mail.gmail.com>
 <e209d18d-dc53-c0e9-448c-8a88264cac74@codeaurora.org>
 <20170314233040.GH10239@codeaurora.org>
Message-ID: <c40b0ee7-6d8c-8c5d-d4c5-9ecf8076e44f@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Boyd wrote:
> I don't see any problem with failing msm_gpio_set() when the
> function is "not gpio", but I also wonder why it matters. Drivers
> shouldn't be doing that, because if the gpio is muxed to some
> other functionality they shouldn't be treating it as a gpio in
> the first place.

The idea is to notify drivers with an error code when they make a mistake. 
Perhaps the device tree or the ACPI table has an error?

> Perhaps we can have some sort of gpio validation debug option
> that the check goes under. Then we could fail and print a big
> warning if this happens, but if we aren't debugging then we don't
> do any checking and rely on drivers to do the right thing.

I could add that, but I still think returning an error code is appropriate.  On 
the TLMM, we know for sure that the pin must be set to function 0 in order for 
the read/write routines to operate correctly.

I guess I should propose a patch and we can vote on it.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
