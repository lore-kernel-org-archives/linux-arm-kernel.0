From: peter.griffin@linaro.org (Peter Griffin)
Date: Mon, 30 Mar 2015 11:33:26 +0100
Subject: [PATCH v2 3/8] mmc: sdhci-st: Add delay management functions for
 top registers (eMMC).
In-Reply-To: <54F5915C.6090707@st.com>
References: <1424956227-18258-1-git-send-email-peter.griffin@linaro.org>
 <1424956227-18258-4-git-send-email-peter.griffin@linaro.org>
 <54F5915C.6090707@st.com>
Message-ID: <20150330103326.GB21893@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On Tue, 03 Mar 2015, Maxime Coquelin wrote:
> 
> On 02/26/2015 02:10 PM, Peter Griffin wrote:
> >Due to the tight timing constriants in some UHS modes, it is required to have
> s/constriant/constraints/

Will fix.

<snip>
> >+
> >+static inline void st_mmcss_set_static_delay(void __iomem *ioaddr)
> >+{
> >+	if (ioaddr) {
> Maybe you could do:
>     if (!ioaddr)
>         return;

Yes good idea, I have made that change in V3.
> 
>     writel_relaxed....
> >+		writel_relaxed(0x0, ioaddr + ST_TOP_MMC_DLY_CTRL);
> >+		writel_relaxed(ST_TOP_MMC_DLY_MAX,
> >+				ioaddr + ST_TOP_MMC_TX_CLK_DLY);
> >+	}
> >+}
> >+
> >+static inline void st_mmcss_set_dll(void __iomem *ioaddr)
> >+{
> >+	if (ioaddr) {
> Ditto

regards,

Peter
