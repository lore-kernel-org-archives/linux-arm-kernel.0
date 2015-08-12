From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 11 Aug 2015 17:38:17 -0700
Subject: [PATCH v4 0/4] clk: hisilicon: support stub clock
In-Reply-To: <1438673249-6051-1-git-send-email-leo.yan@linaro.org>
References: <1438673249-6051-1-git-send-email-leo.yan@linaro.org>
Message-ID: <20150812003817.GI26614@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/04, Leo Yan wrote:
> This series adds support for hisilicon stub clock driver. On hi6220,
> the bootloader needs load the firmware image and set info for OPPs;
> after run into kernel, the stub clock driver is used to communicate
> w/t firmware for cpu dynamic frequency scaling.
> 
> In patch series v1/v2, the stub clock driver simply writes request in
> sram and send ipc to firmware; For patch series v3, the firmware has
> been upgraded to use mailbox, so stub clock driver will call standard
> mailbox APIs to request mailbox channel and send message to firmware.
> 
> Patch 4 adds stub clock node into dts and it references mailbox with
> phandle, so patch 4 will depend on mailbox driver's patch series [1].
> These patches have been tested on 96board hikey and is used by cpufreq
> driver.

The To: list is everyone, so I'm not sure who is supposed to
apply these patches. I'd like to take patches 1, 2, and 3 through
the clk tree though.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
