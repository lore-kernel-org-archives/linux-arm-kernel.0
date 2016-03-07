From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sun, 6 Mar 2016 17:15:52 -0800
Subject: [PATCH] pwm: bcm7038: fix check of error code returned by
 devm_ioremap_resource()
In-Reply-To: <1457227306-3142-1-git-send-email-vz@mleia.com>
References: <1457227306-3142-1-git-send-email-vz@mleia.com>
Message-ID: <56DCD648.5000600@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 05/03/2016 17:21, Vladimir Zapolskiy a ?crit :
> The change fixes potential oops while accessing iomem on invalid
> address, if devm_ioremap_resource() fails due to some reason.
> 
> The devm_ioremap_resource() function returns ERR_PTR() and never
> returns NULL, which makes useless a following check for NULL.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> Fixes: 3a9f5957020f ("pwm: Add Broadcom BCM7038 PWM controller support")

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Using pwm: brcmstb for the subject might be a better fit to match the
filename, but this is bike shedding.
-- 
Florian
