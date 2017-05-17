From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 17 May 2017 17:48:13 +0200
Subject: [PATCH-RFT 2/2] pinctrl: samsung: Split Exynos drivers per ARMv7
 and ARMv8
In-Reply-To: <98c7c565-ba52-406b-2c9c-87ade2847880@samsung.com>
References: <20170516200649.4730-1-krzk@kernel.org>
 <CGME20170516200714epcas1p37ff93d9362e8cb794308396871cca153@epcas1p3.samsung.com>
 <20170516200649.4730-3-krzk@kernel.org>
 <98c7c565-ba52-406b-2c9c-87ade2847880@samsung.com>
Message-ID: <20170517154813.kygdzdkobitquhdg@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 17, 2017 at 07:43:51AM +0200, Marek Szyprowski wrote:
> Hi Krzysztof,
> 
> On 2017-05-16 22:06, Krzysztof Kozlowski wrote:
> > Exynos pinctrl drivers contain pretty big per-SoC data structures.  The
> > pinctrl-exynos object file contained code and data for both ARMv7 and
> > ARMv8 SoCs thus it grew big.  There will not be a shared image between
> > ARMv7 and ARMv8 so there is no need to combine all of this into one
> > driver.
> > 
> > Splitting the data allows to make it more granular (e.g. code related to
> > ARMv8 Exynos is self-contained), slightly speed up the compilation and
> > reduce the effective size of compiled kernel.
> > 
> > The common data structures and functions reside still in existing
> > pinctrl-exynos.c.  Only the SoC-specific parts were moved out to new
> > files.  Except marking few functions non-static and adding them to
> > header, there were no functional changes in the code.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> > 
> > Not tested on ARMv8 (Exynos5433, Exynos7).
> 
> Works fine on TM2 (Exynos5433).
> 
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Great, thanks! Much appreciated.

Best regards,
Krzysztof
