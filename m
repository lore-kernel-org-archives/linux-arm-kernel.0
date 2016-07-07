From: andi.shyti@samsung.com (Andi Shyti)
Date: Thu, 07 Jul 2016 22:27:38 +0900
Subject: [PATCH v4 1/2] clk: exynos5433: do not use CLK_IGNORE_UNUSED for
 SPI clocks
In-Reply-To: <577E4F1C.8070004@samsung.com>
References: <1467893637-12573-1-git-send-email-andi.shyti@samsung.com>
 <1467893637-12573-2-git-send-email-andi.shyti@samsung.com>
 <CGME20160707124623epcas1p2452001bf48f03cb47c7f7db437130e6d@epcas1p2.samsung.com>
 <577E4F1C.8070004@samsung.com>
Message-ID: <20160707132738.GI23620@samsunx.samsung>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

> > The CLK_IGNORE_UNUSED flag has to be avoided whenever possible.
> > Use the CLK_IS_CRITICAL flag instead for critical SPI1 clocks,
> > which enables the clock line during boot time.
> 
> I don't agree. Both flags should be avoided. Clk is critical does not
> solve the problem. It is just a better workaround for lack of proper
> clock consumers.
> 
> The IOCLK is not a critical clock. It can be disabled (e.g. when SoC is
> used on a board without any SPI device connected).

As we discussed offline there is no driver which is requesting
this clock. We cannot ask to the spi driver to handle three
clocks because the exynos5433 has its own peculiarities.

If we want this on the spi driver's side, we need to add a new
compatible and check it everytime. To me it looks uglier than
just keep it alive.

Thanks,
Andi
