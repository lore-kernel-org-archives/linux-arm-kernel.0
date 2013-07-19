From: cavokz@gmail.com (Domenico Andreoli)
Date: Fri, 19 Jul 2013 03:36:47 +0200
Subject: [PATCH] bcm53xx: initial support for the BCM5301/BCM470X SoC
 with ARM CPU
In-Reply-To: <51E56839.8010205@hauke-m.de>
References: <1373982727-5492-1-git-send-email-hauke@hauke-m.de>
 <20130716172023.64337690@skate> <51E56839.8010205@hauke-m.de>
Message-ID: <20130719013646.GA16615@glitch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 16, 2013 at 05:35:21PM +0200, Hauke Mehrtens wrote:
> On 07/16/2013 05:20 PM, Thomas Petazzoni wrote:
> > 
> >> diff --git a/arch/arm/mach-bcm53xx/Kconfig b/arch/arm/mach-bcm53xx/Kconfig
> >> new file mode 100644
> >> index 0000000..1e16e87
> >> --- /dev/null
> >> +++ b/arch/arm/mach-bcm53xx/Kconfig
> >> @@ -0,0 +1,10 @@
> >> +config ARCH_BCM53XX
> >> +	bool "Broadcom BCM47XX / BCM53XX ARM SoC"
> > 
> > So the directory is named mach-bcm53xx, but you also handle BCM47xx
> > SoCs. This doesn't sound really easy to follow.

At the time of the BCM281XX merge we considered that such directories would
mostly contain board files only, being these new entries DT based. Hence
the choice of mach-bcm to collect all of them.

I think you should then put this stuff there.

> Yes the BCM53XX and BCM47XX SoCs are technically from the same line. I
> do not know why there are two different names, probably marketing.
>
> Earlier versions of these SoC lines (also BCM47XX and BCM53XX) used a
> MIPS core and they are supported by arch/mips/bcm47xx/. I use BCM53XX to
> not conflict with the MIPS part now. I know this could still cause
> problems and people will get confused, but I do not know a better name.

I'll throw also BCM476x (bcm4760 and bcm4761) on the table. These are ARM11,
single-core SoCs.

Can we agree on a nice naming so that we actually clarify this silliness?

Regards,
Domenico
