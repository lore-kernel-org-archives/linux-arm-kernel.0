From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 04 Mar 2011 16:29:38 +0900
Subject: [PATCH] ARM: EXYNOS4: Add ARMLEX4210 Board support file
In-Reply-To: <AANLkTimd0frTRpmwf+0OQ2HjYTOqD3NMEEZQovqGVYH1@mail.gmail.com>
References: <10012655.143611299137229715.JavaMail.weblogic@epml15>
	<AANLkTimd0frTRpmwf+0OQ2HjYTOqD3NMEEZQovqGVYH1@mail.gmail.com>
Message-ID: <028401cbda3d$eb0dc700$c1295500$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> On Thu, Mar 3, 2011 at 4:27 PM, ALIM AKHTAR <alim.akhtar@samsung.com>
wrote:
> > This patch is based on 'for-next' ?branch of kgene tree.
> >
> > This patch adds Samsung ARMLEX4210 ?board support file
> > which is based on Exynos4210.
> >
> > Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> > ---
> > ?arch/arm/mach-exynos4/Kconfig ? ? ? ? ? | ? 13 ++
> > ?arch/arm/mach-exynos4/Makefile ? ? ? ? ?| ? ?1 +
> > ?arch/arm/mach-exynos4/mach-armlex4210.c | ?213
> +++++++++++++++++++++++++++++++
> > ?3 files changed, 227 insertions(+), 0 deletions(-)
> > ?create mode 100644 arch/arm/mach-exynos4/mach-armlex4210.c

(snip)

> > +static struct s3c_sdhci_platdata armlex4210_hsmmc3_pdata __initdata = {
> > + ? ? ? .cd_type ? ? ? ? ? ? ? ?= S3C_SDHCI_CD_PERMANENT,
> > + ? ? ? .max_width ? ? ? ? ? ? ?= 4,
> maybe you missed the clk_type. It's required for exynos4 series.
> clk_type ? ? ? ? ? ? ? = S3C_SDHCI_CLK_DIV_EXTERNAL,

Right :)
The clk_type(..._EXTERNAL) should be added for Exynos4210.

Hi Alim,

Others, looks ok.
So applied with fixing above.

If any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
