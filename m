From: jarkko.nikula@bitmer.com (Jarkko Nikula)
Date: Sun, 2 Oct 2011 20:40:35 +0300
Subject: [PATCH 21/30] sound/soc/omap: limit to omap2plus
In-Reply-To: <1317566760-25681-22-git-send-email-arnd@arndb.de>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<1317566760-25681-22-git-send-email-arnd@arndb.de>
Message-ID: <20111002204035.2e5b98943ed5137fd689b9be@bitmer.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun,  2 Oct 2011 16:45:51 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> These drivers do not build correctly on omap1, so only allow
> selecting them on omap2 or higher.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>
> Cc: Liam Girdwood <lrg@ti.com>
> ---
Strange. I'm able to build them fine with omap1_defconfig and with two
supported OMAP1 ASoC machine drivers we have:

CONFIG_SND_OMAP_SOC_AMS_DELTA=y
CONFIG_SND_OMAP_SOC_OSK5912=y

What's the error you are seeing? I guess there might be some missing
dependency that doesn't get visible with omap1_defconfig.

I would like to get that fixed instead of disabling OMAP1 ASoC support
as the ams-delta in kernel is alive device thanks to active developer
Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>.

-- 
Jarkko
