From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 26 Jan 2016 09:23:45 +0100
Subject: [PATCH] rtc: mt6397: add IRQ domain dependency
In-Reply-To: <1453737892-1960479-1-git-send-email-arnd@arndb.de>
References: <1453737892-1960479-1-git-send-email-arnd@arndb.de>
Message-ID: <20160126082345.GD11740@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/01/2016 at 17:04:46 +0100, Arnd Bergmann wrote :
> The mt6397 RTC driver can be built either when the MFD_MT6397 driver
> is enabled (which selects IRQ_DOMAIN), or when compile testing.
> The latter however fails without IRQ domains:
> 
> drivers/rtc/rtc-mt6397.c: In function 'mtk_rtc_probe':
> drivers/rtc/rtc-mt6397.c:326:13: error: implicit declaration of function 'irq_create_mapping' [-Werror=implicit-function-declaration]
>   rtc->irq = irq_create_mapping(mt6397_chip->irq_domain, res->start);
> 
> This adds an explicit dependency for the COMPILE_TEST case.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
