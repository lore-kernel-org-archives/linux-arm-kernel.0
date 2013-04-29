From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 29 Apr 2013 15:34:10 +0200
Subject: [PATCH 21/21] mtd: omap2: allow bulding as a module
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73E9BCFAE@DBDE04.ent.ti.com>
References: <1366734653-488286-1-git-send-email-arnd@arndb.de>
 <20130423180320.GJ10155@atomide.com>
 <20980858CB6D3A4BAE95CA194937D5E73E9BCFAE@DBDE04.ent.ti.com>
Message-ID: <201304291534.10539.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 24 April 2013, Gupta, Pekon wrote:
> [Pekon]: 
> ELM module is required in for Hardware based ECC correction for 
> NAND devices. And this driver has a very small foot-print.
> 
> The only cases this drives would not be used are:
> (a) Using S/W based ECC scheme, which have vey high CPU utilization
> (b) Using single bit ECC scheme, which are becoming obsolete due to
>  increasing NAND densities.
> For most of the cases ELM module will be used with nand-driver. So
> there should be no harm in having this module as built-in, if not used
> in 10% of the use-cases.
> 
> Thus I think it's better to keep this module tied to GPMC module, 
> rather than independent control via KConfig.
> And user should just selects which ECC scheme he would like to
> use via DT, without worrying about KConfig options.

Sorry, I'm lost here and have no idea what you are actually suggesting
we do. Can you phrase that as a patch?

Unless you come up with a better solution, I would still like to queue
up my patch since it fixes an annoying bug and seems to have no downsides.
 
> I'm working in cleaning up omap2-nand driver to remove some 
> redundancies. So would like to know your feedback on same..

Sure, just Cc me on your patches.

	Arnd
