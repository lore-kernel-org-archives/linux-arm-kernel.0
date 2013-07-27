From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 27 Jul 2013 21:49:16 +0200
Subject: [PATCH v3 1/3] ARM: BCM5301X: initial support for the
 BCM5301X/BCM470X SoCs with ARM CPU
In-Reply-To: <20130726165311.GH17886@mudshark.cambridge.arm.com>
References: <1374792135-30343-1-git-send-email-hauke@hauke-m.de>
 <51F28A20.7060105@hauke-m.de>
 <20130726165311.GH17886@mudshark.cambridge.arm.com>
Message-ID: <201307272149.17108.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 26 July 2013, Will Deacon wrote:
> > > At least, we need a pretty good explanation of what exactly is causing
> > > these spurious aborts before we start ignoring them unconditionally like
> > > this. You're effectively masking an extremely serious error indicator with
> > > this change.
> > 
> > This fault occurs once every boot sometime early in the boot process,
> > but the actual time this happens varies randomly.
> 
> Well that's interesting in itself. It sounds like we don't know *for sure*
> whether the abort is triggered by Linux. Since the abort is imprecise, the
> timing will vary.

It might be possible to find out the culprit if you just enter an endless loop
in the early kernel boot code. If you enter the loop before Linux does something
wrong, it won't crash, otherwise it will. After that, you could bisect the
boot process by moving the busy loop around.

If it even crashes at the point where Linux gets entered, it's a bug in the
boot loader.

	Arnd
