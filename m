From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 17 Oct 2017 19:52:55 +0200
Subject: [PATCH] arm64: dts: rockchip: fix typo in iommu nodes
In-Reply-To: <4123717.0VmPnCpUOn@diego>
References: <20171010085648.1339605-1-arnd@arndb.de> <4123717.0VmPnCpUOn@diego>
Message-ID: <35096146.J7tq43JfW1@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 10. Oktober 2017, 11:48:25 CEST schrieb Heiko St?bner:
> Hi Arnd,
> 
> Am Dienstag, 10. Oktober 2017, 10:56:01 CEST schrieb Arnd Bergmann:
> > The latest dtc warns about an extraneous cell in the interrupt
> > property of two of the iommu device nodes:
> > 
> > Warning (interrupts_property): interrupts size is (16), expected multiple of
> > 12 in /iommu at ff373f00 Warning (interrupts_property): interrupts size is
> > (16), expected multiple of 12 in /iommu at ff900800
> > 
> > This removes the typo.
> > 
> > Fixes: cede4c79de28 ("arm64: dts: rockchip: add rk3368 iommu nodes")
> > Fixes: 49c82f2b7c5d ("arm64: dts: rockchip: add rk3328 iommu nodes")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> looks like that got copy-pasted from rk3399 where we have 4 elements per irq.
> In any case the change looks good, so if you want to apply it directly to 
> armsoc-fixes here is a
> 
> Acked-by: Heiko Stuebner <heiko@sntech.de>
> 
> Depending on how you want to handle it I can also merge it, but
> Olof already picked up my 2 fixes for 4.14, so you applying it might
> save us the round-trip for a further 1-patch pull request :-)

as another (somewhat urgent) fix for 64bit dts has come up, I've now also
picked this change up for the following pull request.


Heiko
