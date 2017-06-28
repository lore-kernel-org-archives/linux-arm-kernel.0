From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 28 Jun 2017 16:14:56 -0700
Subject: [PATCH] rtc: brcmstb-waketimer: fix settime function
In-Reply-To: <20170628200839.3114345-1-arnd@arndb.de>
References: <20170628200839.3114345-1-arnd@arndb.de>
Message-ID: <e8c1c77c-dd16-afa8-509a-417e0ab7535c@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/28/2017 01:07 PM, Arnd Bergmann wrote:
> gcc warns about an unused variable in the new driver:
> 
> drivers/rtc/rtc-brcmstb-waketimer.c: In function 'brcmstb_waketmr_settime':
> drivers/rtc/rtc-brcmstb-waketimer.c:142:6: error: unused variable 'ret' [-Werror=unused-variable]
> 
> The same function also doesn't handle overflow correctly, this makes
> it return -EINVAL when passed a time that doesn't fit within the
> range of the register.

Yes, thanks for doing that.

> 
> Fixes: 9f4ad359c801 ("rtc: brcmstb-waketimer: Add Broadcom STB wake-timer")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
