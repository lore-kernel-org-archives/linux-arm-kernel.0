From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 06 Feb 2013 15:29:52 +0100
Subject: [PATCH] OMAPDSS: enable omapdss for ARCH_MULTIPLATFORM
In-Reply-To: <5112659D.50808@ti.com>
References: <1358891160-9534-1-git-send-email-robdclark@gmail.com>
 <201302051631.40254.arnd@arndb.de> <5112659D.50808@ti.com>
Message-ID: <3969096.QosOfOb9QT@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 February 2013 16:15:57 Tomi Valkeinen wrote:
> 
> That would normally be me, but I've been on a long leave, and just came
> back. It'll take me some time to get back on track.
> 
> I don't think it makes sense to add ARCH_MULTIPLATFORM only for omapdss,
> like this patch does. I think we should add it for omapfb and the panel
> drivers also.
> 
> I did get a report of an omapdss build-break with allyesconfig. It seems
> to happen because omapdrm and omap_vout use "select" to enable omapdss,
> instead of depending on omapdss. This causes an illegal config to be
> created. Perhaps this is the problem that Rob mentions in his patch?

Yes, that is the one. It is one of three remaining build errors
we get for ARM allyesconfig, and the other two also have fixes
on their way into 3.8.

> Adding ARCH_MULTIPLATFORM for omapdss, as this patch does, removes
> (well, hides) the above mentioned problem and allyesconfig works ok. You
> can still break the config, but you need to manually select the Kconfig
> options the wrong way.
> 
> I have patches to add the ARCH_MULTIPLATFORM for omapdss, and to fix the
> omap_vout and omapdrm Kconfig files. Each of them changes only one line.
> Arnd, are you ok with queuing those patches via arm-soc/fixes? Or should
> I send them individually to respective maintainers?
>
> I can send the patches properly for review, but I've also attached them
> here so Rob can test.

The second and third attachment in your mail seem to contain identical
patches. I suggested a similar patch myself, but Rob thought his
version was nicer to give better build coverage. We only need either
Rob's patch or yours, but not both, as far as I can tell.

Olof can correct me, but I think we currently don't have any other
patches queued in arm-soc for 3.8 (after Linus announced he did
not want any of the less urgent ones), so I think it would be more
fitting if you send one of the patches to Linus, rather than having
an arm-soc pull request that only contains one patch in your domain.

	Arnd
