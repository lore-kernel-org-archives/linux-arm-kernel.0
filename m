From: timur@codeaurora.org (Timur Tabi)
Date: Tue, 19 Dec 2017 16:56:45 -0600
Subject: [PATCH 3/3] [v6] pinctrl: qcom: qdf2xxx: add support for new ACPI
 HID QCOM8002
In-Reply-To: <20171219023935.GA17456@codeaurora.org>
References: <1513189818-7384-1-git-send-email-timur@codeaurora.org>
 <1513189818-7384-4-git-send-email-timur@codeaurora.org>
 <20171213230155.GS7997@codeaurora.org>
 <6ca3b4a6-90b9-0481-beb8-29a95c86f07c@codeaurora.org>
 <615426d4-7c46-9671-87ef-790fb5733385@codeaurora.org>
 <20171219023935.GA17456@codeaurora.org>
Message-ID: <735d4316-9b18-2903-aabd-46ead1db5233@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/18/2017 08:39 PM, Stephen Boyd wrote:
> +		if (gpios && gpios[j] != i)
> +			continue;
...
 > +		j++;

Doesn't this assume that the available GPIOs are listed in numerical 
order in the ACPI table?  If so, then this patch won't work because that 
order is not guaranteed.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
