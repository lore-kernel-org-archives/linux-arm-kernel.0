From: csd@broadcom.com (Christian Daudt)
Date: Tue, 4 Jun 2013 07:19:05 -0700
Subject: [PATCH V4 2/3] ARM: mmc: bcm281xx SDHCI driver
In-Reply-To: <201306012213.47386.arnd@arndb.de>
References: <1369860607-25572-1-git-send-email-csd@broadcom.com>
 <87d2s7ceh0.fsf@octavius.laptop.org> <51A93DA0.3070909@broadcom.com>
 <201306012213.47386.arnd@arndb.de>
Message-ID: <51ADF759.9000607@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-06-01 01:13 PM, Arnd Bergmann wrote:
> On Saturday 01 June 2013, Christian Daudt wrote:
>> I looked into it and it can replace just about everything that our own
>> dt parsing code is doing. The only problem is with cd_gpio. If I call
>> mmc_of_parse, then it will install its own irq handler for cd gpio, and
>> our driver needs a different handler. the mmc irq handler can call a
>> card_event callback, but that is already pointing to sdhci_card_event.
>> So the only way I can use mmc_of_parse that I can see is by adding a
>> flag to it to skip cd_gpio parsing which only this driver will then set
>> to true. Any other ideas ?
> Can't you add a callback handler into sdhci_card_event that can call
> a platform specific function?
>
>
I can add another layer of callbacks. I have to first check if I can 
rework our driver to fit into this callback model. I'll update this when 
I've tried it.

  thanks,
    csd
