From: sebastian.hesselbarth@googlemail.com (Sebastian Hesselbarh)
Date: Tue, 19 Jun 2012 00:10:16 +0200
Subject: Dove clock support
In-Reply-To: <20120618214143.GA20040@schnuecks.de>
References: <1339978054-8464-1-git-send-email-mkl@blackshift.org>
 <20120618074258.GI4799@lunn.ch> <4FDEDEAE.30502@blackshift.org>
 <20120618080449.GK4799@lunn.ch> <4FDEE6C6.2060101@blackshift.org>
 <20120618084300.GL4799@lunn.ch> <20120618214143.GA20040@schnuecks.de>
Message-ID: <4FDFA748.10905@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/18/2012 11:41 PM, Simon Baatz wrote:
> This is not potentially a problem, this is definitively a problem (on kirkwood):
>
> [   12.280783] sata_mv sata_mv.0: cannot get optional clkdev
> [   12.286314] sata_mv sata_mv.0: slots 32 ports 2
> ...
> [   12.665882] ata1: SATA link down (SStatus 0 SControl F300)
> [   13.015881] ata2: SATA link down (SStatus 0 SControl F300)

Is this because of some bug in kirkwood soc or missing code in
sata_mv.c?

According to the functional specification of kirkwood there is a
PhyShutdown bit in it's registers. Dove also has this register bit.

Up to now it looks like the SATA PHY can only be disabled in code,
but there should be an phy_enable, too.

What repository your kernel is based on?

Sebastian
