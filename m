From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Tue, 28 Feb 2017 13:42:58 -0300
Subject: [PATCH] arm: exynos increase CONFIG_CMA_SIZE_MBYTES to 96
In-Reply-To: <20170228002353.3101-1-shuahkh@osg.samsung.com>
References: <20170228002353.3101-1-shuahkh@osg.samsung.com>
Message-ID: <28dfa72b-13f5-2674-92de-d5a264a89e1a@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shuah,

The subject line isn't consistent with what's used for exynos_defconfig
changes, please use instead:

ARM: exynos_defconfig: Increase CONFIG_CMA_SIZE_MBYTES to 96

On 02/27/2017 09:23 PM, Shuah Khan wrote:
> Current CMA size of 64 Mbytes is right on the edge of being too small
> for some display managers.  With the proposed s5p_mfc patch series that
> pre-allocate buffers, when display manager starts, it fails to get GEM
> buffers.  Increasing the CMA size to 96 solves the problem.
>
> Change CONFIG_CMA_SIZE_MBYTES to 96 in exynos_defconfig to address the
> problem.
>

As you mention, the problem is when a driver pre-allocates a lot of CMA
memory. So instead of mentioning an in-flight patch series, I would make
the commit message more generic. Something along the following lines:

Current CMA size is 64 Mbytes, but this may not be enough if different
drivers need to allocate big memory chunks.

For example, the s5p-mfc driver may need to do a pre-allocation of N MiB
to decode a H.264 1080p video, and there won't be enough CMA memory left
for others drivers, like the exynos-drm driver that may need to allocate
GEM buffers for the display manager.

Increasing the CMA size to 96 MiB should be enough for most use cases.

> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
> Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---

Patch looks good to me though.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
