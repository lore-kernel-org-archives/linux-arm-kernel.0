From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 7 Mar 2017 21:03:17 +0200
Subject: [PATCH v2] ARM: exynos_defconfig: increase
 CONFIG_CMA_SIZE_MBYTES to 96
In-Reply-To: <20170228191221.18135-1-shuahkh@osg.samsung.com>
References: <20170228191221.18135-1-shuahkh@osg.samsung.com>
Message-ID: <20170307190317.5gbxy4nmj67tvimi@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 28, 2017 at 12:12:21PM -0700, Shuah Khan wrote:
> Current CMA size of 64 Mbytes is right on the edge of being small when
> several drivers need to allocate large CMA buffers.
> 
> For example, if the s5p-mfc driver needs to pre-allocate N MiB CMA memory
> to decode a H.264 1080p video, then there won't be enough CMA memory left
> for other drivers, such as the exynos-drm driver that may need to allocate
> GEM buffers for the display manager.
> 
> Increasing CMA size to 96 Mbytes in exynos_defconfig addresses use-cases
> such as these.
> 
> Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
> 
> Changes since v1:
> Fix short and long commit log.
> 
> Reason for this patch:
> With the proposed s5p_mfc patch series that pre-allocate buffers, when
> display manager starts, it fails to get GEM buffers.  Increasing the CMA
> size to 96 solved the problem.
> 
>  arch/arm/configs/exynos_defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Thanks, applied with slightly changed commit msg.

Best regards,
Krzysztof
