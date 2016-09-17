From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 17 Sep 2016 18:30:57 +0200
Subject: [RFT] arm64 dts: exynos: Fix invalid GIC interrupt flags in
 exynos7
In-Reply-To: <57DD2AA8.9060507@samsung.com>
References: <1474056073-8071-1-git-send-email-krzk@kernel.org>
 <CGME20160917113730epcas3p42e26e92f5e72fa42e89967798dbbbecf@epcas3p4.samsung.com>
 <57DD2AA8.9060507@samsung.com>
Message-ID: <20160917163057.GA5859@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 17, 2016 at 05:06:08PM +0530, Alim Akhtar wrote:
> Hi Krzysztof,
> 
> On 09/17/2016 01:31 AM, Krzysztof Kozlowski wrote:
> >Interrupt of type IRQ_TYPE_NONE is not allowed for GIC interrupts and
> >generates an error:
> >	genirq: Setting trigger mode 0 for irq 16 failed (gic_set_type+0x0/0x68)
> >
> >The GIC requires shared interrupts to be edge rising or level high.
> >Platform declares support for both.  Choose level high everywhere.
> >
> >Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> >Reported-by: Alban Browaeys <alban.browaeys@gmail.com>
> >Cc: Marc Zyngier <marc.zyngier@arm.com>
> >Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> >---
> 
> This patch does resolve the error reported in commit.
> Have booted on exynos7 board, things looks fine (have not done a extensive
> testing though).
> With the _Typo_ fixed as pointed by you, feel free to add
> 
> Tested-by: Alim Akhtar <alim.akhtar@samsung.com>
> 
> On another note, please cc me if case you want to check/verify something on
> exynos7 platform. I almost missed this patch.

Great, thanks! I'll remember that.

Best regards,
Krzysztof
