From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Mon, 20 Jun 2016 17:34:49 +0100
Subject: [PATCH] arm64: defconfig: enable Generic on-chip SRAM driver
In-Reply-To: <1466437295-30553-1-git-send-email-sudeep.holla@arm.com>
References: <1466437295-30553-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1466440489.2833.41.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-06-20 at 16:41 +0100, Sudeep Holla wrote:
> Most of the ARM SoCs have small SRAM memory used for various purposes
> that require faster access to data compared to normal DDR.
> 
> This patch enables the Generic on-chip SRAM driver on ARM64.

Would this cause things in the kernel to automatically start using SRAM
found in device-tree, or would each use need to be added explicitly?
I'm just wondering if we might start seeing new bugs caused by firmware
using SRAM for special purposes but that memory not being properly
reserved or hidden from the kernel.

-- 
Tixy
