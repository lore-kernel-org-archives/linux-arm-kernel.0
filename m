From: tony@atomide.com (Tony Lindgren)
Date: Wed, 25 Nov 2015 10:37:09 -0800
Subject: am35xx memory management issues
In-Reply-To: <56546CAD.4060007@nomovok.com>
References: <5644AD53.3020303@nomovok.com> <20151112170659.GL3218@atomide.com>
 <5645E026.9010002@nomovok.com> <56546CAD.4060007@nomovok.com>
Message-ID: <20151125183709.GL2517@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Markku Ahvenj?rvi <markku.ahvenjarvi@nomovok.com> [151124 05:57]:
> On 13.11.2015 15:05, Markku Ahvenj?rvi wrote:
> > On 12.11.2015 19:06, Tony Lindgren wrote:
> >>
> >> Also please check if leaving out CONFIG_SMP_ON_UP affects things.
> > 
> > Alright, will do.
> 
> We've been testing omap2plus defconfig without other omaps and without CONFIG_SMP_ON_UP. So far we haven't seen any panics, but I've had only a few units testing it.

OK

> Meanwhile we've been testing our custom board with a configuration that is quite close to omap2plus, including other omaps and CONFIG_SMP_ON_UP. We've had couple of panics, so it seems that these doesn't affect the problem. We had 15 units running stress-ng and it took ~8 days until we saw first panic, so if omap2plus is affected it is quite rare.

Hmm so to confirm.. Is omap2plus_defconfig stable on all boards including your custom
board?

> Any other suggestions?

Maybe provide output of what changes make the problem happen with your custom
.config if you have not already done:

$ make savedefconfig
$ cp defconfig arch/arm/configs/omap2plus_defconfig
$ git diff

Regards,

Tony
