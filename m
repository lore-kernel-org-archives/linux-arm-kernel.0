From: yong.wu@mediatek.com (Yong Wu)
Date: Thu, 21 May 2015 14:16:30 +0800
Subject: [PATCH v2 4/6] soc: mediatek: Add SMI driver
In-Reply-To: <CABuKBeJvh2PGi3i6O0uu-7ggdBzKMb3tPE_XKhT1i-+tkKc5gg@mail.gmail.com>
References: <1431683009-18158-1-git-send-email-yong.wu@mediatek.com>
 <1431683009-18158-5-git-send-email-yong.wu@mediatek.com>
 <CABuKBeJvh2PGi3i6O0uu-7ggdBzKMb3tPE_XKhT1i-+tkKc5gg@mail.gmail.com>
Message-ID: <1432188990.5092.12.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias,
     Thanks very much for your suggestion.
     Abort the smi clock name, Could you help check below.
     The others I will improve in next time.

On Tue, 2015-05-19 at 13:14 +0200, Matthias Brugger wrote:
> 2015-05-15 11:43 GMT+02:00 Yong Wu <yong.wu@mediatek.com>:
> >     This patch add SMI(Smart Multimedia Interface) driver. This driver is
> > responsible to enable/disable iommu and control the clocks of each local arbiter.
> >
[snip]
> > +
> > +#define SMI_LARB_MMU_EN                (0xf00)
> > +#define F_SMI_MMU_EN(port)     (1 << (port))
> > +
> > +enum {
> > +       MTK_CLK_APB,
> > +       MTK_CLK_SMI,
> > +       MTK_CLK_MAX,
> 
> Maybe add something like:
> MTK_CLK_FIRST = MTK_CLK_APB,
> to make the for loops better readable.
> 
Then, Is it like this? : 
 enum {
        MTK_CLK_FIRST = MTK_CLK_APB,
        MTK_CLK_SMI,
        MTK_CLK_MAX,
 }
or the CLK_SMI also need MTK_CLK_SECOND = MTK_CLK_SMI.
> > +};
> > +
> > +struct mtk_smi_common {
> > +       void __iomem            *base;
> 
> That seems to be never used. Please delete it.
> 
> > +       struct clk              *clk[MTK_CLK_MAX];
> > +};
> > +
> > +struct mtk_smi_larb {
> > +       void __iomem            *base;
> > +       spinlock_t              portlock; /* lock for config port */
> > +       struct clk              *clk[MTK_CLK_MAX];
> > +       struct device           *smi;
> > +};
> > +
> Thanks,
> Matthias
