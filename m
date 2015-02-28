From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 28 Feb 2015 17:50:46 +0100
Subject: [PATCH] net: smc91x: use run-time configuration on all ARM
 machines
In-Reply-To: <2226303.iMQTNXSl1n@wuerfel> (Arnd Bergmann's message of "Wed, 25
 Feb 2015 16:31:57 +0100")
References: <2226303.iMQTNXSl1n@wuerfel>
Message-ID: <877fv22d5l.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> The smc91x driver traditionally gets configured at compile-time
> for whichever hardware it runs on. This no longer works on
> ARM as we continue to move to building all-in-one kernels.
>
> Most ARM configurations with this driver already use run-time
> configuration through DT or through platform_data, but a
> few have not been converted yet.
>
> I've checked all ARM boards that use this driver in their
> legacy board files, and converted the ones that were using
> compile-time configuration in smc91x.h to behave like the
> other ones and provide the interrupt polarity along with
> the MMIO configuration (width, stride) at platform device
> creation time.
>
> In particular, these combinations were previously selectable
> in Kconfig but in fact broken:
>
> - sa1100 assabet plus pleb
> - msm combined with any other armv6/v7 platform
> - pxa-idp combined with any non-DMA pxa variant
> - LogicPD PXA270 combined with any other pxa
> - nomadik combined with any other armv4/v5 platform,
>   e.g. versatile.
>
> None of these seem critical enough to warrant a backport
> to stable, but it would be nice to clean this up for good.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ----
> I would like the patch to get merged through netdev, after
> Robert and/or Linus have verified it on at least some hardware.
For lubbock (smcs 91c96) and zylonite (smcs 91c111) :
Tested-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert

PS: My mainstone is a bit uncooperative right now, I'll have to convince her to
boot in the near future ...
