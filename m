From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri, 20 Jan 2017 07:14:06 -0300
Subject: [PATCH v2 2/2] [media] exynos-gsc: Only reset the GSC HW on
 probe() if !CONFIG_PM
In-Reply-To: <1484865380-12651-2-git-send-email-javier@osg.samsung.com>
References: <1484865380-12651-1-git-send-email-javier@osg.samsung.com>
 <1484865380-12651-2-git-send-email-javier@osg.samsung.com>
Message-ID: <f2ccdd1d-0b70-ecd8-592a-6915164c661b@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 01/19/2017 07:36 PM, Javier Martinez Canillas wrote:
> Commit 15f90ab57acc ("[media] exynos-gsc: Make driver functional when
> CONFIG_PM is unset") removed the implicit dependency that the driver
> had with CONFIG_PM, since it relied on the config option to be enabled.
> 
> In order to work with !CONFIG_PM, the GSC reset logic that happens in
> the runtime resume callback had to be executed on the probe function.
> 
> But there's no need to do this if CONFIG_PM is enabled, since in this
> case the runtime PM resume callback will be called by VIDIOC_STREAMON
> ioctl, so the resume handler will call the GSC HW reset function.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 

Please ignore this patch as suggested by Marek in other thread.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
