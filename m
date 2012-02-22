From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 22 Feb 2012 17:38:04 +0100
Subject: [PATCH 0/7] share sa1100 rtc driver to arch-mmp
In-Reply-To: <CAN1soZxTutYQ=uU0y_AvBTn37es+8tBU=1L6eKtJDUNONgwHFw@mail.gmail.com>
 (Haojian Zhuang's message of "Wed, 22 Feb 2012 23:37:27 +0800")
References: <1329815096-6200-1-git-send-email-haojian.zhuang@marvell.com>
 <201202221239.54321.arnd@arndb.de>
 <CAN1soZwgtxR7pNGBQuMHZS0URXM7U6ZABD4disNmvRarZnjwxA@mail.gmail.com>
 <201202221350.00100.arnd@arndb.de>
 <CAN1soZxTutYQ=uU0y_AvBTn37es+8tBU=1L6eKtJDUNONgwHFw@mail.gmail.com>
Message-ID: <87r4xmygb7.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Haojian Zhuang <haojian.zhuang@gmail.com> writes:

> I can remove the rtc-pxa support entirely. I still want to leave this
> since this may be the only one choice in the future silicons.
>
> Since some boards with pxa27x/pxa3xx are accessing RCNR (the old rtc
> wrapper) directly, I use rtc-sa1100 to keep consistently. In pxa95x,
> nobody is using the old rtc wrapper directly. So I only use it in
> pxa95x.

No, I don't agree there.

The PXA RTC silicon support 2 different set of registers to access time :
 - RCNR (rtc-sa1100)
 - RYCR/RDCR (rtc-pxa)

The rtc-pxa driver was created to provide support for boards using the RYCR/RDCR
rather than RCNR.

Therefore I'm against removing rtc-pxa, unless there is a driver for pxa, which
provides RTC using RYCR/RDCR registers.

We had that discussion a long time ago, in [1].

Cheers.

--
Robert

[1] Linux Arm Kernel Mailing List, 2008/09/30
    http://lists.arm.linux.org.uk/lurker/message/20080930.193554.96feb95f.en.html
