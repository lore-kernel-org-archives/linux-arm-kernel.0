From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 13 Mar 2015 21:30:56 +0100
Subject: [PATCH] ARM: at91: force CPU selection
In-Reply-To: <6645156.Abd4ZAJv10@wuerfel>
References: <1425970798-14015-1-git-send-email-computersforpeace@gmail.com>
 <2279482.Ohk2PcyWHV@wuerfel> <20150313183200.GK4329@piout.net>
 <6645156.Abd4ZAJv10@wuerfel>
Message-ID: <20150313203056.GL4329@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/03/2015 at 20:50:59 +0100, Arnd Bergmann wrote :
> > 
> > Actually, I had a closer look today and there is already just one level
> > in my current version of patches.
> > 
> > I can put everything under menuconfig ARCH_AT91 but I can't remove
> > SOC_SAM_V7 and SOC_SAM_V4_V5 because that is what is used to select
> > which dtb should be compiled.
> > 
> > This would also break sama5_defconfig. This is a simple fix but that
> > means that it makes it difficult to migrate an existing .config.
> > 
> > I'd say let's keep it that way as this is not broken, unless you really
> > want to see SOC_SAM_V7 and SOC_SAM_V4_V5 being removed.
> > 
> 
> I'm not sure what the latest version looks like, but I think it's fine
> to have SOC_SAM_V4_V5 automatically selected when CONFIG_AT91 and
> CONFIG_MULTI_V4 || CONFIG_MULTI_V5 are turned on, or selected by
> AT91SAM9 and AT91RM9200.
> 

OK, I'm doing that. I'll send v3 in a few minutes.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
