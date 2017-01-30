From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 30 Jan 2017 16:35:09 -0300
Subject: [PATCH] ARM: exynos_defconfig: Enable DYNAMIC_DEBUG and get rid
 of old ext3
In-Reply-To: <20170130192749.3690-1-krzk@kernel.org>
References: <20170130192749.3690-1-krzk@kernel.org>
Message-ID: <fae36789-d016-8dee-12df-ff896a3373b9@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 01/30/2017 04:27 PM, Krzysztof Kozlowski wrote:
> DYNAMIC_DEBUG is quite useful for debugging kernels and should not cause
> noticeable performance regressions.  It makes the kernel noticeably
> bigger (around 4%) but this difference should not impact typical
> developer and reference usage of this defconfig.
>
> Sizes:
> zImage-old:       4641496 bytes
> zImage-new:       4811384 bytes
> 
>    text	   data	    bss	    dec	    hex	filename
> 7031229	2570916	 327016	9929161	 9781c9	vmlinux-old
> 7205921	2800052	 327016	10332989 9dab3d	vmlinux-new
>

Agreed, most people usually will end enabling this option when debugging
issues anyways so having enabled by default is quite convenient indeed.

> Additionally, remove the EXT3_FS symbol because it is entirely replaced
> by EXT4_FS.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
