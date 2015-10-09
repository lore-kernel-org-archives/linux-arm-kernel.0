From: mw@semihalf.com (Marcin Wojtas)
Date: Fri, 9 Oct 2015 16:45:25 +0200
Subject: [PATCH v2 2/5] mmc: sdhci-pxav3: enable usage of DAT3 pin as HW
 card detect
In-Reply-To: <20151009201356.78488116@xhacker>
References: <1444352635-21965-1-git-send-email-mw@semihalf.com>
 <1444352635-21965-3-git-send-email-mw@semihalf.com>
 <20151009201356.78488116@xhacker>
Message-ID: <CAPv3WKddfCOSCCOSByAEzyZ3qnAX22TFi2acrNDcTgEvy+ioFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jisheng,


>>
>> When using DAT3-based detection Armada 38x SDIO IP expects its internal
>> clock to be always on, which had to be ensured twofold:
>
> What happen if runtime suspend disables its core clk and axi clk? I guess
> dat3-based detection isn't compatible with runtime pm. If so, do we also
> need to disable runtime pm in probe function?

Is runtime resume supposed to be triggered by card detection? Is there
a way to manually trigger runtime suspend and resume of sdhci? Anyway
coreclk is not a problem, as it's not used by A38x.

>
>> - Each time controller is reset by updating appropriate registers. On the
>>   occasion of adding new register @0x104, register @0x100 name is modified
>>   in order to the be aligned with Armada 38x documentation.
>> - Leaving the clock enabled despite power-down. For this purpose a new
>>   quirk had to be added to SDHCI subsystem - SDHCI_QUIRK2_KEEP_INT_CLK_ON.
>
> As seen from other mails, Ulf calls for no more quirks...
>

Ok, I'll try to find another solution.

Best regards,
Marcin
