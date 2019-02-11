Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970FDC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:20:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65809218D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nNKDynNa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65809218D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ECFt/yiAUMkwa2ognxXl4jWelgLpwGzRFDYQ7GgZeDw=; b=nNKDynNaVkZO0M
	l28pV2YcBQV8AVs6rsipIGLLCpg6aw2kzicbX1mGKbxnp8Vx2TkPlvFqfVfXJxGRUd7goEuu2gV2v
	MTW81SReS584F2yOxv03Fxq47JugpWY9vObKq5Ndg3xDxzQQ1E33qgdEkIxOWZZc39Hj8pg/ApbkW
	1BRD1lVhAQEBNDTUXX9MsPT1DyQxfW+vocXJuR8/o10eCEqO8Gsv1Wj6xCdGPdbudJuqjN9o1cXwK
	dn4lWz/5D7sxNemigemS39KaQAq66ocMEZUGN7/E1jtxhoS1dotxQM2sKNVotV+XfBYHHNgufSoCl
	URJ1PUBWzUrDyrsdFgvg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtBV6-0007IK-4S; Mon, 11 Feb 2019 13:19:56 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtBUo-0006wF-FY; Mon, 11 Feb 2019 13:19:45 +0000
X-UUID: 1a1385c932f34761aeaf98e4ecd52eb9-20190211
X-UUID: 1a1385c932f34761aeaf98e4ecd52eb9-20190211
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw01.mediatek.com
 (envelope-from <andrew-sh.cheng@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1371641642; Mon, 11 Feb 2019 05:19:33 -0800
Received: from MTKMBS01N2.mediatek.inc (172.21.101.79) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 11 Feb 2019 05:19:32 -0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 11 Feb 2019 21:19:29 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 11 Feb 2019 21:19:29 +0800
Message-ID: <1549891169.12454.2.camel@mtksdaap41>
Subject: Re: [PATCH 1/3] cpufreq: mediatek: add mt8183 cpufreq support
From: andrew-sh.cheng <andrew-sh.cheng@mediatek.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 11 Feb 2019 21:19:29 +0800
In-Reply-To: <20190129101348.7oxqerszhcopanzr@vireshk-i7>
References: <1548743704-16821-1-git-send-email-andrew-sh.cheng@mediatek.com>
 <1548743704-16821-2-git-send-email-andrew-sh.cheng@mediatek.com>
 <20190129101348.7oxqerszhcopanzr@vireshk-i7>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 1DEE257C42183176579582A2891D2D39F0DC3E5C2351E5A46744F96782A38CD22000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_051939_113715_87D1DF5A 
X-CRM114-Status: GOOD (  19.74  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 srv_heupstream@mediatek.com, linux-pm@vger.kernel.org,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Rob
 Herring <robh+dt@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 MyungJoo Ham <myungjoo.ham@samsung.com>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, fan.chen@mediatek.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 2019-01-29 at 15:43 +0530, Viresh Kumar wrote:
> On 29-01-19, 14:35, Andrew-sh Cheng wrote:
> > From: "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
> > 
> > For new mediatek chip mt8183,
> > cci and little cluster share the same buck,
> > so need to modify the attribute of regulator from exclusive to optional
> > 
> > Intermediate clock is not always enabled by ccf in different projects,
> > so cpufreq should always enable it by itself.
> > 
> > Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> > ---
> >  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
> >  drivers/cpufreq/mediatek-cpufreq.c   | 7 ++++++-
> >  2 files changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> > index b1c5468..5a1c588 100644
> > --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> > +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> > @@ -117,6 +117,7 @@
> >  	{ .compatible = "mediatek,mt817x", },
> >  	{ .compatible = "mediatek,mt8173", },
> >  	{ .compatible = "mediatek,mt8176", },
> > +	{ .compatible = "mediatek,mt8183", },
> >  
> >  	{ .compatible = "nvidia,tegra124", },
> >  
> > diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> > index eb8920d..e956248 100644
> > --- a/drivers/cpufreq/mediatek-cpufreq.c
> > +++ b/drivers/cpufreq/mediatek-cpufreq.c
> > @@ -355,7 +355,7 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
> >  		goto out_free_resources;
> >  	}
> >  
> > -	proc_reg = regulator_get_exclusive(cpu_dev, "proc");
> > +	proc_reg = regulator_get_optional(cpu_dev, "proc");
> >  	if (IS_ERR(proc_reg)) {
> >  		if (PTR_ERR(proc_reg) == -EPROBE_DEFER)
> >  			pr_warn("proc regulator for cpu%d not ready, retry.\n",
> > @@ -385,6 +385,9 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
> >  		goto out_free_resources;
> >  	}
> >  
> > +	ret = clk_prepare_enable(inter_clk);
> > +	if (ret)
> > +		goto out_free_resources;
> 
> Add a blank line here please.
> 
> Also out_free_resources isn't enough here and you need to free OPP table as
> well.
I will modify these in next patch.
> 
> 
> >  	/* Search a safe voltage for intermediate frequency. */
> >  	rate = clk_get_rate(inter_clk);
> >  	opp = dev_pm_opp_find_freq_ceil(cpu_dev, &rate);
> > @@ -412,6 +415,7 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
> >  
> >  out_free_opp_table:
> >  	dev_pm_opp_of_cpumask_remove_table(&info->cpus);
> > +	clk_disable_unprepare(inter_clk);
> 
> Clock was enabled after adding the table, and so it must be disabled before
> removing the table. Just the opposite sequence.
I will modify this in next patch.
> 
> >  
> >  out_free_resources:
> >  	if (!IS_ERR(proc_reg))
> > @@ -551,6 +555,7 @@ static int mtk_cpufreq_probe(struct platform_device *pdev)
> >  	{ .compatible = "mediatek,mt817x", },
> >  	{ .compatible = "mediatek,mt8173", },
> >  	{ .compatible = "mediatek,mt8176", },
> > +	{ .compatible = "mediatek,mt8183", },
> >  
> >  	{ }
> >  };
> > -- 
> > 1.8.1.1.dirty
> 



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
