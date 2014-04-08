From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 08 Apr 2014 13:18:29 +0200
Subject: [PATCH v2 09/12] ARM: config: append hip04_defconfig
In-Reply-To: <1396944052-9887-10-git-send-email-haojian.zhuang@linaro.org>
References: <1396944052-9887-1-git-send-email-haojian.zhuang@linaro.org>
 <1396944052-9887-10-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <4838811.gr7KVNHrSc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 08 April 2014 16:00:49 Haojian Zhuang wrote:
> Select HiP04 SoC configuration by hip04_defconfig.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> ---
>  arch/arm/configs/hip04_defconfig | 67 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 arch/arm/configs/hip04_defconfig

Is it necessary to have a separate defconfig for this?

Since this is a fairly generic platform, I'd prefer to only enable
it in the standard defconfigs like multi_v7_defconfig.

It's probably time now to add a multi_v7_lpae_defconfig though.
Maybe someone has other ideas, we have talked about the split
between the defconfigs before. I think the latest suggestion
was to remove multi_v7_defconfig and replace it with one that
enables both v6 and v7, and another one that only enables
v7 with LPAE (omap5, exynos5, mvebu, sunxi, hip04, vexpress,
shmobile, highbank, keystone, qcom)

	Arnd
