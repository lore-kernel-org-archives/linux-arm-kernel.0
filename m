Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881C7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 11:06:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 576742147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 11:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lX4/QLud"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 576742147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3glakA+EXTAvxU7AKGO1TsdOBcFEzeUCb9ex6EzeGWQ=; b=lX4/QLudAtkn/6
	oStdjvX/h0Q7JGtcqSR3owpNzEISFTg3m8/NAJXJ0HI2eLssW/9hInsFnQTBIqCHgfacGt2ZjYhPQ
	gJIcM1Yga0eVnZ1Q3BiRK/mW6KIFLV3ZWPejittWN/TNECSOlWJ6sNmuyLD1ZT5vnbj89OXVfEzWg
	Aft/nxWnJ4gzdKwkN8cIISMJfjzb3cXsftb6HV/qV9v36cbA+apGY0BhPabDYYa5k27wrF1tZBnkf
	yu6Y1dIW4A4uXq5uZv97oQHxjdL2EnbATPrC0VKBqxS8DpGbDjUf3n9zvzrZQDTl0QnsShl42MUgR
	1H0j7lFEjHL3gxhtj8Qg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggSkB-0003o0-M2; Mon, 07 Jan 2019 11:06:55 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggSk7-0003nD-3x; Mon, 07 Jan 2019 11:06:52 +0000
X-UUID: 065b0abeaee1445d9de291162925437f-20190107
X-UUID: 065b0abeaee1445d9de291162925437f-20190107
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw01.mediatek.com
 (envelope-from <henryc.chen@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 522841601; Mon, 07 Jan 2019 03:06:37 -0800
Received: from MTKMBS01N1.mediatek.inc (172.21.101.68) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 7 Jan 2019 03:06:35 -0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 7 Jan 2019 19:06:34 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 7 Jan 2019 19:06:34 +0800
Message-ID: <1546859194.6818.129.camel@mtksdaap41>
Subject: Re: [RFC RESEND PATCH 3/7] soc: mediatek: add support for the
 performance state
From: Henry Chen <henryc.chen@mediatek.com>
To: Stephen Boyd <sboyd@kernel.org>
Date: Mon, 7 Jan 2019 19:06:34 +0800
In-Reply-To: <154655622671.15366.9695869469694306752@swboyd.mtv.corp.google.com>
References: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com>
 <1546438198-1677-4-git-send-email-henryc.chen@mediatek.com>
 <154655622671.15366.9695869469694306752@swboyd.mtv.corp.google.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_030651_173045_69E2454E 
X-CRM114-Status: GOOD (  13.83  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, James Liao <jamesjj.liao@mediatek.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Kees Cook <keescook@chromium.org>,
 Weiyi Lu <weiyi.lu@mediatek.com>, linux-pm@vger.kernel.org,
 Viresh Kumar <vireshk@kernel.org>, linux-kernel@vger.kernel.org,
 Fan Chen <fan.chen@mediatek.com>, devicetree@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 2019-01-03 at 14:57 -0800, Stephen Boyd wrote:
> Quoting Henry Chen (2019-01-02 06:09:54)
> > @@ -187,6 +190,18 @@ struct scp_soc_data {
> >         bool bus_prot_reg_update;
> >  };
> >  
> > +BLOCKING_NOTIFIER_HEAD(scpsys_notifier_list);
> 
> static?
OK
> 
> > +
> > +int register_scpsys_notifier(struct notifier_block *nb)
> > +{
> > +       return blocking_notifier_chain_register(&scpsys_notifier_list, nb);
> > +}
> > +
> > +int unregister_scpsys_notifier(struct notifier_block *nb)
> > +{
> > +       return blocking_notifier_chain_unregister(&scpsys_notifier_list, nb);
> > +}
> 
> What is the notifier for?
It used to notifier the DVFSRC driver that performance stat was changed.
> 
> > +
> >  static int scpsys_domain_is_on(struct scp_domain *scpd)
> >  {
> >         struct scp *scp = scpd->scp;
> > @@ -536,6 +551,48 @@ static void init_clks(struct platform_device *pdev, struct clk **clk)
> >                 clk[i] = devm_clk_get(&pdev->dev, clk_names[i]);
> >  }
> >  
> > +static int mtk_pd_set_performance(struct generic_pm_domain *genpd,
> > +                                 unsigned int state)
> > +{
> > +       int i;
> > +       struct scp_domain *scpd =
> > +               container_of(genpd, struct scp_domain, genpd);
> > +       struct scp_event_data scpe;
> > +       struct scp *scp = scpd->scp;
> > +       struct genpd_onecell_data *pd_data = &scp->pd_data;
> > +
> > +       for (i = 0; i < pd_data->num_domains; i++) {
> > +               if (genpd == pd_data->domains[i]) {
> > +                       dev_dbg(scp->dev, "%d. %s = %d\n",
> > +                               i, genpd->name, state);
> > +                       break;
> > +               }
> > +       }
> > +
> > +       scpe.event_type = MTK_SCPSYS_PSTATE;
> > +       scpe.genpd = genpd;
> > +       scpe.domain_id = i;
> > +       blocking_notifier_call_chain(&scpsys_notifier_list, state, &scpe);
> > +
> > +       return 0;
> > +}
> > +
> > +static unsigned int mtk_pd_get_performance(struct generic_pm_domain *genpd,
> > +                                          struct dev_pm_opp *opp)
> > +{
> > +       struct device_node *np;
> > +       unsigned int state;
> > +
> > +       np = dev_pm_opp_get_of_node(opp);
> > +
> > +       if (of_property_read_u32(np, "mtk,level", &state))
> > +               return 0;
> > +
> > +       of_node_put(np);
> 
> The generic API that Rajendra is adding I guess will become even more
> generic by assuming some sort of property like 'opp-level' or
> 'performance-state' that is just some raw number.
ok, I will follow the new property from Rajendra.

> > +
> > +       return state;
> > +}
> > +
> >  static struct scp *init_scp(struct platform_device *pdev,
> >                         const struct scp_domain_data *scp_domain_data, int num,
> >                         const struct scp_ctrl_reg *scp_ctrl_reg,



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
