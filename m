From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 1 Jun 2013 22:13:47 +0200
Subject: [PATCH V4 2/3] ARM: mmc: bcm281xx SDHCI driver
In-Reply-To: <51A93DA0.3070909@broadcom.com>
References: <1369860607-25572-1-git-send-email-csd@broadcom.com>
 <87d2s7ceh0.fsf@octavius.laptop.org> <51A93DA0.3070909@broadcom.com>
Message-ID: <201306012213.47386.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 01 June 2013, Christian Daudt wrote:
> I looked into it and it can replace just about everything that our own 
> dt parsing code is doing. The only problem is with cd_gpio. If I call 
> mmc_of_parse, then it will install its own irq handler for cd gpio, and 
> our driver needs a different handler. the mmc irq handler can call a 
> card_event callback, but that is already pointing to sdhci_card_event. 
> So the only way I can use mmc_of_parse that I can see is by adding a 
> flag to it to skip cd_gpio parsing which only this driver will then set 
> to true. Any other ideas ?

Can't you add a callback handler into sdhci_card_event that can call
a platform specific function?

	Arnd
