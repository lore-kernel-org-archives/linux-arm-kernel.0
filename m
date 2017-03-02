From: timur@codeaurora.org (Timur Tabi)
Date: Thu, 2 Mar 2017 08:38:51 -0600
Subject: [PATCH v2] efi/libstub/arm*: Set default address and size cells
 values for an empty dtb
In-Reply-To: <20170302102328.GB1746@linaro.org>
References: <1486502360-18071-1-git-send-email-jhugo@codeaurora.org>
 <20170224153644.GE417@leverpostej> <20170302102328.GB1746@linaro.org>
Message-ID: <e170874b-2af7-b594-a804-c089e75b7e25@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AKASHI Takahiro wrote:
> Since the values of *-cells under root node should reflect the hardware,
> the kernel has no way to determine whether they be 1 or 2 here.

It's safe to set the *-cells to 2 on all platforms, as long as everyone who 
reads/writes from/to the device tree respects those values (which is what 
they're supposed to do anyway).

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
