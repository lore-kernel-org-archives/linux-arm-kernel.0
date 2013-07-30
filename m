From: will.deacon@arm.com (Will Deacon)
Date: Tue, 30 Jul 2013 14:36:01 +0100
Subject: [PATCH v3 1/3] ARM: BCM5301X: initial support for the
 BCM5301X/BCM470X SoCs with ARM CPU
In-Reply-To: <201307272149.17108.arnd@arndb.de>
References: <1374792135-30343-1-git-send-email-hauke@hauke-m.de>
 <51F28A20.7060105@hauke-m.de>
 <20130726165311.GH17886@mudshark.cambridge.arm.com>
 <201307272149.17108.arnd@arndb.de>
Message-ID: <20130730133601.GN11527@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 27, 2013 at 08:49:16PM +0100, Arnd Bergmann wrote:
> On Friday 26 July 2013, Will Deacon wrote:
> > > > At least, we need a pretty good explanation of what exactly is causing
> > > > these spurious aborts before we start ignoring them unconditionally like
> > > > this. You're effectively masking an extremely serious error indicator with
> > > > this change.
> > > 
> > > This fault occurs once every boot sometime early in the boot process,
> > > but the actual time this happens varies randomly.
> > 
> > Well that's interesting in itself. It sounds like we don't know *for sure*
> > whether the abort is triggered by Linux. Since the abort is imprecise, the
> > timing will vary.
> 
> It might be possible to find out the culprit if you just enter an endless loop
> in the early kernel boot code. If you enter the loop before Linux does something
> wrong, it won't crash, otherwise it will. After that, you could bisect the
> boot process by moving the busy loop around.
> 
> If it even crashes at the point where Linux gets entered, it's a bug in the
> boot loader.

Can you give Arnd's suggestion a go please Hauke?

Thanks,

Will
