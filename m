From: jamesjj.liao@mediatek.com (James Liao)
Date: Wed, 30 Dec 2015 18:18:12 +0800
Subject: [PATCH 4/4] soc: mediatek: Add MT2701/MT7623 scpsys driver
In-Reply-To: <CAGS+omCwxB+4VFOA1hA9Rg-ekWCVM8Y_c7woTEXnvX6FG1y9mQ@mail.gmail.com>
References: <1451457706-14798-1-git-send-email-jamesjj.liao@mediatek.com>
 <1451457706-14798-5-git-send-email-jamesjj.liao@mediatek.com>
 <CAGS+omCwxB+4VFOA1hA9Rg-ekWCVM8Y_c7woTEXnvX6FG1y9mQ@mail.gmail.com>
Message-ID: <1451470692.22426.11.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Wed, 2015-12-30 at 17:01 +0800, Daniel Kurtz wrote:
> On Wed, Dec 30, 2015 at 2:41 PM, James Liao <jamesjj.liao@mediatek.com> wrote:
> >
> > From: Shunli Wang <shunli.wang@mediatek.com>
> >
> > Add scpsys driver for MT2701 and MT7623.
> >
> > Signed-off-by: Shunli Wang <shunli.wang@mediatek.com>
> > Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> > ---
> >  drivers/soc/mediatek/Kconfig             |  11 +++
> >  drivers/soc/mediatek/Makefile            |   1 +
> >  drivers/soc/mediatek/mtk-scpsys-mt2701.c | 161 +++++++++++++++++++++++++++++++
> >  3 files changed, 173 insertions(+)
> >  create mode 100644 drivers/soc/mediatek/mtk-scpsys-mt2701.c
> >
> > diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
> > index eca6fb7..92cf838 100644
> > --- a/drivers/soc/mediatek/Kconfig
> > +++ b/drivers/soc/mediatek/Kconfig
> > @@ -39,3 +39,14 @@ config MTK_SCPSYS_MT8173
> >           driver.
> >           The System Control Processor System (SCPSYS) has several power
> >           management related tasks in the system.
> > +
> > +config MTK_SCPSYS_MT2701
> > +       bool "SCPSYS Support MediaTek MT2701 and MT7623"
> > +       depends on ARCH_MEDIATEK || COMPILE_TEST
> > +       select MTK_SCPSYS
> > +       default ARCH_MEDIATEK
> > +       help
> > +         Say yes here to add support for the MT2701/MT7623 SCPSYS power
> > +         domain driver.
> > +         The System Control Processor System (SCPSYS) has several power
> > +         management related tasks in the system.
> 
> I don't think we really want different drivers and Kconfig options.
> 
> Can we just use different compatibles to select the appropriate scp_domain_data?

Yes, we can. All scpsys drivers are built-in by default, and they will
be activate by specific compatible string.

But some projects don't want to build unused drivers into kernel to save
code size. Use different Kconfig options for each SoC so that these
projects can disable unused drivers.


Best regards,

James
