From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 7 Sep 2015 11:26:51 +0200
Subject: [PATCH 1/4] ARM: multi_v7_defconfig: Enable common Rockchip
 devices/busses
In-Reply-To: <1441570566-14001-2-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1441570566-14001-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <1441570566-14001-2-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <55ED585B.9030009@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Sjoerd,

On 09/06/2015 10:16 PM, Sjoerd Simons wrote:
> Enable Rockchip I2C, SPI, PWM, thermal drivers.
> 
> Builtin are:
>  * I2C as it often controls the pmic.

Having I2C as a module will cause more probe deferrals due missing
regulators and slow down the boot but it should not cause issues.
Or am I missing something?

In fact, I think even the PMIC could be built as a module.

But I don't have a strong opinion on this so patch looks good:

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
