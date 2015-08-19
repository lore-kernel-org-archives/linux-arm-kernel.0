From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed, 19 Aug 2015 21:28:36 +0200
Subject: [PATCH] ARM: exynos_defconfig: Enable CROS_EC_PROTO for ChromeOS
 EC mfd driver
In-Reply-To: <1439881281-22054-1-git-send-email-javier@osg.samsung.com>
References: <1439881281-22054-1-git-send-email-javier@osg.samsung.com>
Message-ID: <55D4D8E4.2090003@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 08/18/2015 09:01 AM, Javier Martinez Canillas wrote:
> The ChromeOS mfd driver (MFD_CROS_EC) select the CROS_EC_PROTO config
> symbol because the driver uses some communication helper functions in
> drivers/platform/chrome/cros_ec_proto.c but other drivers depends on
> CROS_EC_PROTO instead. Mixing select and depends can lead to circular
> Kconfig dependencies so the MFD_CROS_EC select should be changed to a
> depends on CROS_EC_PROTO instead.
> 
> But doing so will break git bisect-ability since MFD_CROS_EC will not
> be enabled anymore unless the default configs first explicitly enable
> the CROS_EC_PROTO dependency.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

This patch has been superseded by the "[PATCH 0/6] ChromeOS EC
Kconfig cleanups" series: https://lkml.org/lkml/2015/8/19/194

Please just ignore it.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
