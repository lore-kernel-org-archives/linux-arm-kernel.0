From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 13 Dec 2017 17:09:16 -0600
Subject: [PATCH 3/3] [v6] pinctrl: qcom: qdf2xxx: add support for new ACPI
 HID QCOM8002
In-Reply-To: <20171213230155.GS7997@codeaurora.org>
References: <1513189818-7384-1-git-send-email-timur@codeaurora.org>
 <1513189818-7384-4-git-send-email-timur@codeaurora.org>
 <20171213230155.GS7997@codeaurora.org>
Message-ID: <6ca3b4a6-90b9-0481-beb8-29a95c86f07c@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/13/2017 05:01 PM, Stephen Boyd wrote:
> Given that we have MAX_GPIOS, it would be better to declare a
> bitmap of available gpios of that size on the stack and then
> iterate through the bitmap and set bits for the available ones.
> In the QCOM8001 case, that would be setting all bits up to
> num_gpios, and in the QCOM8002 case it would be iterating through
> the list of gpios from the DSD property and setting the bit for
> that gpio number.  This avoids explicitly allocating a list of
> numbers that is freed almost immediately. Instead we just stack
> 256 / sizeof(unsigned long) words and set bits.

I'm not sure I understand.  The only think I'm allocating temporarily is 
the 'gpios' array, which is an array of shorts.  Each element stores the 
gpio number.  It's not a bit array, so "256 / sizeof(unsigned long)" 
doesn't apply.  I need that array to read the DSD.  You can't iterate 
through an DSD property without reading it completely first.

> Hopefully we could lift the same logic into the core pinctrl msm
> driver for usage on non-ACPI systems.

There is no new memory allocation being done in pinctrl-msm, so I don't 
understand this either.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
