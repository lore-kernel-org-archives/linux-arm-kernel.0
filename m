From: chen.zhong@mediatek.com (Chen Zhong)
Date: Tue, 29 Aug 2017 15:40:59 +0800
Subject: [PATCH v3 4/5] input: Add MediaTek PMIC keys support
In-Reply-To: <20170829073453.GB4469@gangnam>
References: <1503642753-12385-1-git-send-email-chen.zhong@mediatek.com>
 <CGME20170825063247epcas5p1df2f4440010dd55dada66e8764d18e50@epcas5p1.samsung.com>
 <1503642753-12385-5-git-send-email-chen.zhong@mediatek.com>
 <20170829073453.GB4469@gangnam>
Message-ID: <1503992459.15359.4.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andi,

Sorry for that, i deleted some prefix since the namings will be such
long. If this should be consistent, I'll check and modify them in the
next version.

Thank you.

On Tue, 2017-08-29 at 16:34 +0900, Andi Shyti wrote:
> Hi Chen,
> 
> what I would ask you is to be consistent with the naming, if your
> driver is called mtk-pmic, then all your functions and global
> variables should be named accordingly as mtk_pmic or MTK_PMIC.
> Please check in between the lines for real examples:
> 
> > +#define PWRKEY_RST_EN_MASK	0x1
> > +#define PWRKEY_RST_EN_SHIFT	6
> > +#define HOMEKEY_RST_EN_MASK	0x1
> > +#define HOMEKEY_RST_EN_SHIFT	5
> > +#define RST_DU_MASK		0x3
> > +#define RST_DU_SHIFT		8
> > +
> > +#define PMIC_PWRKEY_INDEX	0
> > +#define PMIC_HOMEKEY_INDEX	1
> > +#define PMIC_MAX_KEY_COUNT	2
> 
> #define MTK_PMIC_*
> 
> > +struct pmic_keys_regs {
> 
> struct mtk_pmic_keys_regs
> 
> > +	u32 deb_reg;
> > +	u32 deb_mask;
> > +	u32 intsel_reg;
> > +	u32 intsel_mask;
> > +};
> > +
> > +#define PMIC_KEYS_REGS(_deb_reg, _deb_mask, _intsel_reg, _intsel_mask)	\
> 
> MTK_PMIC_KEYS_REGS
> 
> > +{									\
> > +	.deb_reg		= _deb_reg,				\
> > +	.deb_mask		= _deb_mask,				\
> > +	.intsel_reg		= _intsel_reg,				\
> > +	.intsel_mask		= _intsel_mask,				\
> > +}
> > +
> > +struct pmic_regs {
> 
> mtk_pmic_regs
> 
> and so on... you got the point.
> 
> Andi
