From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 23 Feb 2012 09:52:34 +0100
Subject: [PATCH 0/7] share sa1100 rtc driver to arch-mmp
In-Reply-To: <CAN1soZx84dmAVz-Kyv18+fjOJyzvun7fpbXA+rYb6xeEhQbXtQ@mail.gmail.com>
 (Haojian Zhuang's message of "Thu, 23 Feb 2012 08:51:47 +0800")
References: <1329815096-6200-1-git-send-email-haojian.zhuang@marvell.com>
 <201202221239.54321.arnd@arndb.de>
 <CAN1soZwgtxR7pNGBQuMHZS0URXM7U6ZABD4disNmvRarZnjwxA@mail.gmail.com>
 <201202221350.00100.arnd@arndb.de>
 <CAN1soZxTutYQ=uU0y_AvBTn37es+8tBU=1L6eKtJDUNONgwHFw@mail.gmail.com>
 <87r4xmygb7.fsf@free.fr>
 <CAN1soZx84dmAVz-Kyv18+fjOJyzvun7fpbXA+rYb6xeEhQbXtQ@mail.gmail.com>
Message-ID: <87booqx771.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Haojian Zhuang <haojian.zhuang@gmail.com> writes:

> Hi Robert,
>
> I hadn't any plan to remove rtc-pxa driver. I only disabled it for
> pxa27x/pxa3xx. Please check the code of
> arch/arm/mach-pxa/sharpsl_pm.c. If we only enable rtc-pxa on pxa27x,
> we'll break the behavior on sharpsl since it's using rtc-sa1100. In
> order to keep code consistently, I disable rtc-pxa on pxa27x/pxa3xx.

Then you'll break mioa701 board, which is pxa270 based. The RYCR/RDCR were
introduced on PXA27x chips, so the rtc-pxa driver should work on pxa27x SoCs.

The behaviour should be as before, the config should be able to choose between
rtc-pxa and rtc-sa1100 for a pxa27x based board. For sharpsl_pm, I suppose the
rtc-sa1100 will be chosen in the .config, and for mioa701, it will be
rtc-pxa.

Just to clear, I'm against removing "resources, clock" from pxa27x platform code
which would break rtc-pxa driver on pxa27x. Now I don't care if you're talking
about changing some "defconfigs".

Cheers.

-- 
Robert
