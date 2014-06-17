From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Jun 2014 15:57:15 +0200
Subject: [PATCH] ARM: omap: rework platform selection
In-Reply-To: <CABGGisxdKznLzR+0b0oYrN+aiWM0gNFbzYwfPtAZF=AiapU=eQ@mail.gmail.com>
References: <5701099.0P1SIXsHc1@wuerfel> <20140616141712.GL17845@atomide.com>
 <CABGGisxdKznLzR+0b0oYrN+aiWM0gNFbzYwfPtAZF=AiapU=eQ@mail.gmail.com>
Message-ID: <201406171557.15819.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 16 June 2014, Rob Herring wrote:
> > So far I have not come up with no great ideas on fixing this
> > properly short of requiring all omap .config files to add
> > CONFIG_ARCH_OMAP=y manually. Anybody got good ideas for that?
> 
> I've failed to come up with anything...
> 

I have two ideas, but neither is great:

a) we leave the individual per-soc options in the top-level menu
   and move the sub-options under those. This is a bit or a problem
   for options concerning all of OMAP, but I'm not sure how many of
   those are actually required.

b) We go back to Rob's version and make CONFIG_ARCH_OMAP the
   user-selectable option, and then find another solution for
   building a kernel with ARCH_OMAP set but none of individual
   options. This will work for anybody who has a full .config
   file, but still break the 'make savedefconfig' generated ones.

	Arnd
