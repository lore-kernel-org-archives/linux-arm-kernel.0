From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Feb 2012 05:50:42 +0000
Subject: [PATCH v2 03/11] ARM: EXYNOS: add clock part for EXYNOS5250 SoC
In-Reply-To: <CAJOA=zPujvu0WNmn8UPa4NogJ1w6UqEg-RDNEcnfBZQW3SS+eQ@mail.gmail.com>
References: <1328981685-8602-1-git-send-email-kgene.kim@samsung.com>
 <201202160522.35249.arnd@arndb.de>
 <CAJOA=zPujvu0WNmn8UPa4NogJ1w6UqEg-RDNEcnfBZQW3SS+eQ@mail.gmail.com>
Message-ID: <201202160550.42192.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 16 February 2012, Turquette, Mike wrote:
> >
> >> Ah, one more, would be better to us if arm-soc tree could provide
> >> the topic branch for 'common struct clk' working as a base.
> >
> > Good point. Mike, can you send a pull request for whatever you have
> > now as another staging branch for arm-soc?
> 
> Arnd, we discussed linux-next as the target for the common clk core
> code at Linaro Connect.  Are you now asking for that code in arm-soc?
> If so, I think it would be better to keep things simple only target
> linux-next once V5 has hit the lists after ELC.

I guess waiting for you to send out v5 is a good idea, but as Kgene
mentioned it would be nice to have the series in arm-soc in order
to base other branches on top of it, and we have now made it possible
to update branches like this one by declaring them "staging".

The main advantage that I see of putting your series into arm-soc
is that I can handle the dependencies: If you want to update the
series based to v6 after more review and send me a replacement pull
request, I can rebase the exynos5 patches (and other conversions)
on top of that. If you have a different tree in linux-next and plan
to rebase it, I cannot take any other patches into arm-soc that depend
on yours.

The alternative would be that I take the exynos5 patches in their
current shape into arm-soc and you put your patches into linux-next
based on the branch that I have, and with a patch to convert exynos5
to it on top.

> If you are instead referring to OMAP platform support for common clk,
> that code is very infantile and not yet ready for arm-soc, especially
> as it breaks OMAP2+ multi-boot.

I did not mean the omap specific parts.

	Arnd
