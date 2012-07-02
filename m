From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 2 Jul 2012 13:36:27 +0200
Subject: [PATCH v5 3/9] arm: mach-mvebu: add source files
In-Reply-To: <20120627153652.GE29702@lunn.ch>
References: <1340805290-9051-1-git-send-email-gregory.clement@free-electrons.com>
 <1340805290-9051-4-git-send-email-gregory.clement@free-electrons.com>
 <20120627153652.GE29702@lunn.ch>
Message-ID: <20120702133627.4f7baec0@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Wed, 27 Jun 2012 17:36:52 +0200,
Andrew Lunn <andrew@lunn.ch> a ?crit :

> > +void mvebu_restart(char mode, const char *cmd)
> > +{
> > +	if (!system_controller_base) {
> > +		pr_warn("Cannot restart, system-controller not available\n");
> 
> Does pr_warn() get shown by default? I would of probably gone for
> BUG_ON() or WARN_ON(), to make it clearer what has happened. It may
> not be a kernel bug, but a DT description bug, but it still a bug...

>From my testing, pr_warn() messages are shown by default, but I've
turned this message into a pr_err() to be sure, and we've expanded the
message a bit to make it clear that the problem comes from the DT.

> I tested this on a Kirkwood QNAP with DT property:
> 
>                 system-controller at 20000 {
>                         compatible = "marvell,orion-system-controller";
>                         reg = <0x20000 0x1000>;
>                 };
> 
> and it works. So:
> 
> Tested-by: Andrew Lunn <andrew@lunn.ch>
> 
> However Orion5x has a slightly different variant, so i would like to
> test it on that SoC as well. However, we don't have DT on Orion5x yet,
> so i need to simulate it.

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
