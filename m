Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C17C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 22:57:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45A18206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 22:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Kidz/l1n";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9TTGFEE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45A18206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Message-ID:References:From:
	In-Reply-To:To:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CRoRxPgRXkJN1Xcqv8A45GR/mkkE4rUgGwV9Cz/4T30=; b=Kidz/l1nkHLN6p
	MHleBspCEUvcdeatoDAKphQD6I/kPl3jNLivEK32qUrQlZuxjlMOxeXAQKw9/IHRyFVrgt0CMfaPy
	tGC2luhdW4nHCO+pf9oX9LdcZhrYH4yCen+c3Qqyvhx27viUfm3tjrDO+gKDo/V2/TWQbNRDToMoN
	YgsHeVr7SPMGFrpbFYI80SfJG2fcGUJs7RTgHqGeQ+1G2NpfGqjCGXQQeO4k2sQUUxsE1gEtlQMaG
	+nIH9eymbOkI5TUSVPpbACMmv7ONsah2rhv7c0+SqFvLdpRr0ZvUnO/79D8NNaeYLu/mksABUVNo1
	+deZBdYrORfWt4TOsl4A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfBvK-0007lX-N1; Thu, 03 Jan 2019 22:57:10 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfBvI-0007l6-FV; Thu, 03 Jan 2019 22:57:09 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9FFBC21479;
 Thu,  3 Jan 2019 22:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546556227;
 bh=sVYZSZnSZtHY9vTnHtjEpk8aBl6O5BQi9VAoiasp9aA=;
 h=Subject:Cc:To:In-Reply-To:From:References:Date:From;
 b=Z9TTGFEE74nC8MmHYmkPzvzDaE078+CdpAopt+L+1lEx9PHiXuxmCkdvCdbO5A/rD
 oadF2rmkcQT5V/W6SlbCQDiYof5Q0t1KEOH4SHioxEgg/umOyVle4FJZyByGSxfIG2
 YH7MbaWB1ZpSDh+EO9ZgDANrSRPjHK7HI24ACDAs=
MIME-Version: 1.0
Subject: Re: [RFC RESEND PATCH 3/7] soc: mediatek: add support for the
 performance state
To: Henry Chen <henryc.chen@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Viresh Kumar <vireshk@kernel.org>
In-Reply-To: <1546438198-1677-4-git-send-email-henryc.chen@mediatek.com>
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
References: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com>
 <1546438198-1677-4-git-send-email-henryc.chen@mediatek.com>
Message-ID: <154655622671.15366.9695869469694306752@swboyd.mtv.corp.google.com>
Date: Thu, 03 Jan 2019 14:57:06 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_145708_547111_DFDB45EB 
X-CRM114-Status: GOOD (  11.71  )
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
 Kees Cook <keescook@chromium.org>, Weiyi Lu <weiyi.lu@mediatek.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Henry Chen <henryc.chen@mediatek.com>, Fan Chen <fan.chen@mediatek.com>,
 devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Henry Chen (2019-01-02 06:09:54)
> @@ -187,6 +190,18 @@ struct scp_soc_data {
>         bool bus_prot_reg_update;
>  };
>  
> +BLOCKING_NOTIFIER_HEAD(scpsys_notifier_list);

static?

> +
> +int register_scpsys_notifier(struct notifier_block *nb)
> +{
> +       return blocking_notifier_chain_register(&scpsys_notifier_list, nb);
> +}
> +
> +int unregister_scpsys_notifier(struct notifier_block *nb)
> +{
> +       return blocking_notifier_chain_unregister(&scpsys_notifier_list, nb);
> +}

What is the notifier for?

> +
>  static int scpsys_domain_is_on(struct scp_domain *scpd)
>  {
>         struct scp *scp = scpd->scp;
> @@ -536,6 +551,48 @@ static void init_clks(struct platform_device *pdev, struct clk **clk)
>                 clk[i] = devm_clk_get(&pdev->dev, clk_names[i]);
>  }
>  
> +static int mtk_pd_set_performance(struct generic_pm_domain *genpd,
> +                                 unsigned int state)
> +{
> +       int i;
> +       struct scp_domain *scpd =
> +               container_of(genpd, struct scp_domain, genpd);
> +       struct scp_event_data scpe;
> +       struct scp *scp = scpd->scp;
> +       struct genpd_onecell_data *pd_data = &scp->pd_data;
> +
> +       for (i = 0; i < pd_data->num_domains; i++) {
> +               if (genpd == pd_data->domains[i]) {
> +                       dev_dbg(scp->dev, "%d. %s = %d\n",
> +                               i, genpd->name, state);
> +                       break;
> +               }
> +       }
> +
> +       scpe.event_type = MTK_SCPSYS_PSTATE;
> +       scpe.genpd = genpd;
> +       scpe.domain_id = i;
> +       blocking_notifier_call_chain(&scpsys_notifier_list, state, &scpe);
> +
> +       return 0;
> +}
> +
> +static unsigned int mtk_pd_get_performance(struct generic_pm_domain *genpd,
> +                                          struct dev_pm_opp *opp)
> +{
> +       struct device_node *np;
> +       unsigned int state;
> +
> +       np = dev_pm_opp_get_of_node(opp);
> +
> +       if (of_property_read_u32(np, "mtk,level", &state))
> +               return 0;
> +
> +       of_node_put(np);

The generic API that Rajendra is adding I guess will become even more
generic by assuming some sort of property like 'opp-level' or
'performance-state' that is just some raw number.

> +
> +       return state;
> +}
> +
>  static struct scp *init_scp(struct platform_device *pdev,
>                         const struct scp_domain_data *scp_domain_data, int num,
>                         const struct scp_ctrl_reg *scp_ctrl_reg,

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
