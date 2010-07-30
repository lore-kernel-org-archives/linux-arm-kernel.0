From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 30 Jul 2010 10:18:15 +0900
Subject: [PATCH 2/6] S5PC210: OneNAND: Use the correct DMA address range
In-Reply-To: <AANLkTim6Sq5U+maJevV0qwXqO+F7QnVFRWzdy_hbxAkf@mail.gmail.com>
References: <20100728101146.GA21333@july>
	<007001cb2eb5$c26ef140$474cd3c0$%kim@samsung.com>
	<AANLkTim6Sq5U+maJevV0qwXqO+F7QnVFRWzdy_hbxAkf@mail.gmail.com>
Message-ID: <015701cb2f85$1a2ec660$4e8c5320$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> On Thu, Jul 29, 2010 at 9:34 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > Kyungmin Park wrote:
> >>
> >> From: Kyungmin Park <kyungmin.park@samsung.com>
> >>
> >> OneNAND DMA SFR requires the 8KiB mapping.
> >>
> > It would be helpful if you could add the reason why should change.
> >
> > Just fix the DMA address range? Or for support further SoCs?...
> 
> Of course DMA address range.
> 
> In the spec, the final address is INTC_ONENAND_STATUS 0xB060_1068
> 
I meant should being the reason in the commit message.
Could not know correct reason by your comment. Ok...

> Thank you,
> Kyungmin Park
> 
> >
> >> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> >> ---
> >> ?arch/arm/plat-s5p/dev-onenand.c | ? ?2 +-
> >> ?1 files changed, 1 insertions(+), 1 deletions(-)
> >>
> >> diff --git a/arch/arm/plat-s5p/dev-onenand.c
> > b/arch/arm/plat-s5p/dev-onenand.c
> >> index 08b3a3f..4d3eddb 100644
> >> --- a/arch/arm/plat-s5p/dev-onenand.c
> >> +++ b/arch/arm/plat-s5p/dev-onenand.c
> >> @@ -30,7 +30,7 @@ static struct resource s5pc110_onenand_resources[] =
{
> >> ? ? ? },
> >> ? ? ? [1] = {
> >> ? ? ? ? ? ? ? .start ?= S5PC110_PA_ONENAND_DMA,
> >> - ? ? ? ? ? ? .end ? ?= S5PC110_PA_ONENAND_DMA + SZ_2K - 1,
> >> + ? ? ? ? ? ? .end ? ?= S5PC110_PA_ONENAND_DMA + SZ_8K - 1,
> >> ? ? ? ? ? ? ? .flags ?= IORESOURCE_MEM,
> >> ? ? ? },
> >> ?};
> >> --
> >
> >


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
