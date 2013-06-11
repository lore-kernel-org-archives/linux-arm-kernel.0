From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 11 Jun 2013 19:18:38 +0900
Subject: [PATCH] ARM: dts: Removing pdma for SSDK5440
In-Reply-To: <51B6E49D.7000408@samsung.com>
References: <109601ce6679$fef2e410$fcd8ac30$%kim@samsung.com>
 <51B6E49D.7000408@samsung.com>
Message-ID: <10b101ce668d$0a341390$1e9c3ab0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sylwester Nawrocki wrote:
> 
Hi Sylwester,

> On 06/11/2013 10:02 AM, Kukjin Kim wrote:
> > From: Giridhar Maruthy <giridhar.m@samsung.com>
> >
> > Since the pdma works only in secure mode, accessing the same
> > in hypervisor mode gives an abort. As we are not using pdma
> > anywhere (including spi), removing the same.
> >
> > Signed-off-by: Giridhar Maruthy <giridhar.m@samsung.com>
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> 
> I was wondering, wouldn't it be sufficient to add status = "disabled";
> in those pdma nodes, to avoid re-adding them in future ?

Yeah, could be. But the pdma will not be used on exynos5440 in future and if
some guy use it in non-secure mode, it will cause problem, so I want to
remove that.

> As for the DMA properties in the spi device nodes, they should indeed
> be removed, as generic DMA bindings would be used instead.
> 
Yes, agreed. So I'd prefer to remove that :-)

Thanks,
Kukjin
