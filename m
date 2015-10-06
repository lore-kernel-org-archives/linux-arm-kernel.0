From: mw@semihalf.com (Marcin Wojtas)
Date: Tue, 6 Oct 2015 17:08:29 +0200
Subject: [PATCH 4/8] mmc: sdhci-pxav3: enable proper resuming on Armada
 38x SoC
In-Reply-To: <877fn09hjw.fsf@free-electrons.com>
References: <1444094562-31165-1-git-send-email-mw@semihalf.com>
 <1444094562-31165-5-git-send-email-mw@semihalf.com>
 <877fn09hjw.fsf@free-electrons.com>
Message-ID: <CAPv3WKcPMk4pZPaUR9GG0-nFKtb1gB-G3DS2NY257dsPp4ZFQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gregory,

2015-10-06 16:51 GMT+02:00 Gregory CLEMENT <gregory.clement
>> +     if (of_device_is_compatible(np, "marvell,armada-380-sdhci"))
>> +             ret = mv_conf_mbus_windows(dev, pxa->mbus_win_regs,
>> +                                        mv_mbus_dram_info());
>
> I would find it cleaner to not rely on the device tree outise the probe
> function. What about just testing pxa->mbus_win_regs ? As it is set only
> if we need it, it should be a good test.
>

Sure, it will ease calling the function.

Thanks,
Marcin
