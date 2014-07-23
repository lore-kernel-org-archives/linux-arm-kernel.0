From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 23 Jul 2014 17:26:26 +0100
Subject: [PATCH v6 6/7] drivers: cpuidle: initialize big.LITTLE driver
 through DT
In-Reply-To: <1405958786-17243-7-git-send-email-lorenzo.pieralisi@arm.com>
References: <1405958786-17243-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1405958786-17243-7-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20140723162626.GE20966@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 21, 2014 at 05:06:25PM +0100, Lorenzo Pieralisi wrote:
> With the introduction of DT based idle states, CPUidle drivers for ARM
> can now initialize idle states data through properties in the device tree.
> 
> This patch adds code to the big.LITTLE CPUidle driver to dynamically
> initialize idle states data through the updated device tree source file.
> 
> Cc: Chander Kashyap <chander.kashyap@linaro.org>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

I think for this patch (and the exynos one) we should still allow the
driver to work fine with old DT. Basically if the information is not in
DT, fall back to the original static definitions.

-- 
Catalin
