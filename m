Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FED3C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:42:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F07B4218AF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lfxfrT/e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F07B4218AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4bip4WNcl+pabceTBRFuu37SKkBV94llOvMs1AxfVSU=; b=lfxfrT/eZqBaBR
	EI7Wx5Uw9J64zWooxHFTNvrV25QV2vleeyScMrkTZMM2w+G3sGhOx7krM5vB1mRJNTPkeqIePZm6Y
	zpjsBs2pThK6c2uEAFp6uCCMDb85rmxHMD2BwQff8WGg6/KthRwLmXw2sW/paj7Bz+xlZ620edIYU
	9lffAMGHsGxtRMsgMOQSus/hDrtIjl/cLqNtLnjHZI2RHiOr2id/womUgGCRWo1w4IhA6PhOYIJb9
	/8Lt0jqts26yasd01YR0eUAKZmxxGodHZf4Sm2TSfsbH/k7jXHn+4Z3Sff8cedGA+MKplBSPGGnaw
	LwyQKRrpuANxyGTZH17A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp3Fd-0002vV-IN; Thu, 31 Jan 2019 03:42:53 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp3FZ-0002ub-S1; Thu, 31 Jan 2019 03:42:51 +0000
X-UUID: 3b1b74d80bb843c6af62ab37237a3dcd-20190130
X-UUID: 3b1b74d80bb843c6af62ab37237a3dcd-20190130
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1809021718; Wed, 30 Jan 2019 19:42:45 -0800
Received: from MTKMBS31N1.mediatek.inc (172.27.4.69) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 30 Jan 2019 19:42:44 -0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Thu, 31 Jan 2019 11:42:41 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 31 Jan 2019 11:42:41 +0800
Message-ID: <1548906161.19710.47.camel@mhfsdcap03>
Subject: Re: [PATCH v5 15/20] memory: mtk-smi: Invoke pm runtime_callback to
 enable clocks
From: Yong Wu <yong.wu@mediatek.com>
To: Evan Green <evgreen@chromium.org>
Date: Thu, 31 Jan 2019 11:42:41 +0800
In-Reply-To: <CAE=gft6XDC3YGe20iDOpCO0ASg99hucu7rKJwt+5i+3vgrEFvg@mail.gmail.com>
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
 <1546314952-15990-16-git-send-email-yong.wu@mediatek.com>
 <CAE=gft6XDC3YGe20iDOpCO0ASg99hucu7rKJwt+5i+3vgrEFvg@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_194249_910760_1FD585FD 
X-CRM114-Status: GOOD (  28.75  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: youlin.pei@mediatek.com, "open
 list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Nicolas Boichat <drinkcat@chromium.org>,
 Arnd Bergmann <arnd@arndb.de>, srv_heupstream@mediatek.com,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
 LKML <linux-kernel@vger.kernel.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 yingjoe.chen@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 2019-01-30 at 11:05 -0800, Evan Green wrote:
> On Mon, Dec 31, 2018 at 7:59 PM Yong Wu <yong.wu@mediatek.com> wrote:
> >
> > This patch only move the clk_prepare_enable and config_port into the
> > runtime suspend/resume callback. It doesn't change the code content
> > and sequence.
> >
> > This is a preparing patch for adjusting SMI_BUS_SEL for mt8183.
> > (SMI_BUS_SEL need to be restored after smi-common resume every time.)
> > Also it gives a chance to get rid of mtk_smi_larb_get/put which could
> > be a next topic.
> >
> > CC: Matthias Brugger <matthias.bgg@gmail.com>
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> 
> I believe this refactoring is a no-op as described, because the order is still:
> 1) mtk_smi_clk_enable(common)
> 2) mtk_smi_clk_enable(larb)
> 3) larb_gen->config_port()
> 
> And teardown still happens in the opposite order, except for

Thanks your confirm.

> config_port, which they seem not to do in suspend.

After suspend, the HW engine should not work. config_port is not
helpful. At that time, use the HW default value.

> So, looks good to me.
> 
> Reviewed-by: Evan Green <evgreen@chromium.org>

Thanks.

> 
> > ---
> >  drivers/memory/mtk-smi.c | 113 ++++++++++++++++++++++++++++++-----------------
> >  1 file changed, 72 insertions(+), 41 deletions(-)
> >
> > diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> > index a430721..9790801 100644
> > --- a/drivers/memory/mtk-smi.c
> > +++ b/drivers/memory/mtk-smi.c
> > @@ -86,17 +86,13 @@ struct mtk_smi_larb { /* larb: local arbiter */
> >         u32                             *mmu;
> >  };
> >
> > -static int mtk_smi_enable(const struct mtk_smi *smi)
> > +static int mtk_smi_clk_enable(const struct mtk_smi *smi)
> >  {
> >         int ret;
> >
> > -       ret = pm_runtime_get_sync(smi->dev);
> > -       if (ret < 0)
> > -               return ret;
> > -
> >         ret = clk_prepare_enable(smi->clk_apb);
> >         if (ret)
> > -               goto err_put_pm;
> > +               return ret;
> >
> >         ret = clk_prepare_enable(smi->clk_smi);
> >         if (ret)
> > @@ -118,59 +114,28 @@ static int mtk_smi_enable(const struct mtk_smi *smi)
> >         clk_disable_unprepare(smi->clk_smi);
> >  err_disable_apb:
> >         clk_disable_unprepare(smi->clk_apb);
> > -err_put_pm:
> > -       pm_runtime_put_sync(smi->dev);
> >         return ret;
> >  }
> >
> > -static void mtk_smi_disable(const struct mtk_smi *smi)
> > +static void mtk_smi_clk_disable(const struct mtk_smi *smi)
> >  {
> >         clk_disable_unprepare(smi->clk_gals1);
> >         clk_disable_unprepare(smi->clk_gals0);
> >         clk_disable_unprepare(smi->clk_smi);
> >         clk_disable_unprepare(smi->clk_apb);
> > -       pm_runtime_put_sync(smi->dev);
> >  }
> >
> >  int mtk_smi_larb_get(struct device *larbdev)
> >  {
> > -       struct mtk_smi_larb *larb = dev_get_drvdata(larbdev);
> > -       const struct mtk_smi_larb_gen *larb_gen = larb->larb_gen;
> > -       struct mtk_smi *common = dev_get_drvdata(larb->smi_common_dev);
> > -       int ret;
> > +       int ret = pm_runtime_get_sync(larbdev);
> >
> > -       /* Enable the smi-common's power and clocks */
> > -       ret = mtk_smi_enable(common);
> > -       if (ret)
> > -               return ret;
> > -
> > -       /* Enable the larb's power and clocks */
> > -       ret = mtk_smi_enable(&larb->smi);
> > -       if (ret) {
> > -               mtk_smi_disable(common);
> > -               return ret;
> > -       }
> > -
> > -       /* Configure the iommu info for this larb */
> > -       larb_gen->config_port(larbdev);
> > -
> > -       return 0;
> > +       return (ret < 0) ? ret : 0;
> >  }
> >  EXPORT_SYMBOL_GPL(mtk_smi_larb_get);
> >
> >  void mtk_smi_larb_put(struct device *larbdev)
> >  {
> > -       struct mtk_smi_larb *larb = dev_get_drvdata(larbdev);
> > -       struct mtk_smi *common = dev_get_drvdata(larb->smi_common_dev);
> > -
> > -       /*
> > -        * Don't de-configure the iommu info for this larb since there may be
> > -        * several modules in this larb.
> > -        * The iommu info will be reset after power off.
> > -        */
> > -
> > -       mtk_smi_disable(&larb->smi);
> > -       mtk_smi_disable(common);
> > +       pm_runtime_put_sync(larbdev);
> >  }
> >  EXPORT_SYMBOL_GPL(mtk_smi_larb_put);
> >
> > @@ -385,12 +350,52 @@ static int mtk_smi_larb_remove(struct platform_device *pdev)
> >         return 0;
> >  }
> >
> > +static int __maybe_unused mtk_smi_larb_resume(struct device *dev)
> > +{
> > +       struct mtk_smi_larb *larb = dev_get_drvdata(dev);
> > +       const struct mtk_smi_larb_gen *larb_gen = larb->larb_gen;
> > +       int ret;
> > +
> > +       /* Power on smi-common. */
> > +       ret = pm_runtime_get_sync(larb->smi_common_dev);
> > +       if (ret < 0) {
> > +               dev_err(dev, "Failed to pm get for smi-common(%d).\n", ret);
> > +               return ret;
> > +       }
> > +
> > +       ret = mtk_smi_clk_enable(&larb->smi);
> > +       if (ret < 0) {
> > +               dev_err(dev, "Failed to enable clock(%d).\n", ret);
> > +               pm_runtime_put_sync(larb->smi_common_dev);
> > +               return ret;
> > +       }
> > +
> > +       /* Configure the basic setting for this larb */
> > +       larb_gen->config_port(dev);
> > +
> > +       return 0;
> > +}
> > +
> > +static int __maybe_unused mtk_smi_larb_suspend(struct device *dev)
> > +{
> > +       struct mtk_smi_larb *larb = dev_get_drvdata(dev);
> > +
> > +       mtk_smi_clk_disable(&larb->smi);
> > +       pm_runtime_put_sync(larb->smi_common_dev);
> > +       return 0;
> > +}
> > +
> > +static const struct dev_pm_ops smi_larb_pm_ops = {
> > +       SET_RUNTIME_PM_OPS(mtk_smi_larb_suspend, mtk_smi_larb_resume, NULL)
> > +};
> > +
> >  static struct platform_driver mtk_smi_larb_driver = {
> >         .probe  = mtk_smi_larb_probe,
> >         .remove = mtk_smi_larb_remove,
> >         .driver = {
> >                 .name = "mtk-smi-larb",
> >                 .of_match_table = mtk_smi_larb_of_ids,
> > +               .pm             = &smi_larb_pm_ops,
> >         }
> >  };
> >
> > @@ -489,12 +494,38 @@ static int mtk_smi_common_remove(struct platform_device *pdev)
> >         return 0;
> >  }
> >
> > +static int __maybe_unused mtk_smi_common_resume(struct device *dev)
> > +{
> > +       struct mtk_smi *common = dev_get_drvdata(dev);
> > +       int ret;
> > +
> > +       ret = mtk_smi_clk_enable(common);
> > +       if (ret) {
> > +               dev_err(common->dev, "Failed to enable clock(%d).\n", ret);
> > +               return ret;
> > +       }
> > +       return 0;
> > +}
> > +
> > +static int __maybe_unused mtk_smi_common_suspend(struct device *dev)
> > +{
> > +       struct mtk_smi *common = dev_get_drvdata(dev);
> > +
> > +       mtk_smi_clk_disable(common);
> > +       return 0;
> > +}
> > +
> > +static const struct dev_pm_ops smi_common_pm_ops = {
> > +       SET_RUNTIME_PM_OPS(mtk_smi_common_suspend, mtk_smi_common_resume, NULL)
> > +};
> > +
> >  static struct platform_driver mtk_smi_common_driver = {
> >         .probe  = mtk_smi_common_probe,
> >         .remove = mtk_smi_common_remove,
> >         .driver = {
> >                 .name = "mtk-smi-common",
> >                 .of_match_table = mtk_smi_common_of_ids,
> > +               .pm             = &smi_common_pm_ops,
> >         }
> >  };
> >
> > --
> > 1.9.1
> >



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
