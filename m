From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 26 Jan 2017 22:09:53 +0200
Subject: [PATCH v2 6/8] mfd: exynos-lpass: Add support for clocks
In-Reply-To: <1485419634-28331-7-git-send-email-m.szyprowski@samsung.com>
References: <1485419634-28331-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170126083404eucas1p132ce7a0792505367f6a001f21e9d1632@eucas1p1.samsung.com>
 <1485419634-28331-7-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20170126200953.sfyd64qk34th4suh@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2017 at 09:33:52AM +0100, Marek Szyprowski wrote:
> Exynos LPASS requires some clocks to be enabled to make any access to its
> registers. This patch adds code for handling such clocks. For current set
> of registers it is enough to keep sfr0_ctrl clock enabled. Till now it
> worked only because those clocks were enabled by bootloader and driver
> probe() happened before they were disabled by clock core because of lack
> of users. Handling those clocks is also needed to make it possible to
> enable support for audio power domain.
> 
> This patch requires adding sfr0_ctrl clock to device tree.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  .../devicetree/bindings/mfd/samsung,exynos5433-lpass.txt       |  6 ++++++
>  drivers/mfd/exynos-lpass.c                                     | 10 ++++++++++
>  2 files changed, 16 insertions(+)
>

Thanks for changes. Looks good now.
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
