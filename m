From: andi.shyti@samsung.com (Andi Shyti)
Date: Wed, 13 Jul 2016 21:44:16 +0900
Subject: [PATCH v3 7/7] clk: exynos5433: remove CLK_IGNORE_UNUSED flag from
 SPI clocks
In-Reply-To: <146836184696.73491.9452469757415968654@resonance>
References: <1468317736-18841-1-git-send-email-andi.shyti@samsung.com>
 <1468317736-18841-8-git-send-email-andi.shyti@samsung.com>
 <CGME20160712222323epcas1p4020f224ba47b193243867ab41bc109c8@epcas1p4.samsung.com>
 <146836184696.73491.9452469757415968654@resonance>
Message-ID: <20160713124416.GN18237@samsunx.samsung>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

> > Because the Exynos5433 SPI driver supports the ioclk handling and
> > the following patch:
> > 
> >   http://marc.info/?l=linux-kernel&m=146787645626318&w=2
> > 
> > fixes a synchronus abort issue, none of the SPI clocks require
> > any critical handling: remove, then, the CLK_IGNORE_UNUSED flag
> > for the SPI related clocks.
> > 
> > Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> > Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > Reviewed-by: Michael Turquette <mturquette@baylibre.com>
> > Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> 
> Do you want these patches to go through same tree? If not, I can take
> this patch into clk-next.

oh yes, as Krzysztof and Sylwester pointed out, the dependency is
not that strict as there is no exynos5433 dts yet, so that we
wouldn't break anything if patch 7/7 gets in before the others.

If you want to take in your branch the 7/7, please feel free to
do so. Only the patches on the drivers/spi/spi-s3c64xx.c file
have some dependencies on some previous patches I sent to Mark.

Andi
