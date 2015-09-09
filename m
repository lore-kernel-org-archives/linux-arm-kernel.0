From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 8 Sep 2015 17:44:35 -0700
Subject: [PATCH] ARM: qcom: add memory node to IPQ806x/AP148
In-Reply-To: <1439936804-15138-1-git-send-email-mathieu@codeaurora.org>
References: <1439936804-15138-1-git-send-email-mathieu@codeaurora.org>
Message-ID: <20150909004435.GT15099@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/18, Mathieu Olivari wrote:
> On recent bootloaders, the bootloader patches the DT blob with memory
> information. However, with old bootloader, this operation doesn't
> happen, which leads the board to freeze in the early init code.
> 
> This patch adds the memory node to the AP148 dts explicitly to cover all
> boot cases.
> 
> Signed-off-by: Mathieu Olivari <mathieu@codeaurora.org>

Does the old bootloader pass atags? If so we can just enable
CONFIG_ARM_ATAG_DTB_COMPAT and then we don't need to add anything
to dts files.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
