Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A00C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:13:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 505F52081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OccSncgV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 505F52081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CSNyZgxMy4bMcYtig2knJzY/mYMs14dP2thDLlbAdp8=; b=OccSncgVWeQAOp
	34T/ti2jlmpPtZ5NsDegLnPuAviewT28BWl6yC6IH18rKzjPqIwr01Aohr3Wz31zJmt98K7Qu5bDS
	HAIl8DvPDbyOGo/l3SE3P2lIyr5FPkyNQCZ2PcIkACh+KBVbCvwpr/UZ6B0BCOQYkVTZwBREDGVdg
	6bRsXf8/Er9N+U+IbEXOWOwSvMttCYr0fhFAqgaLIyeB3SQs9hBJK+OTDuiPhJ5PMuwrBQb9l3bWU
	OY6vlNHmXVk0vhdke+xuzRs1qvfqTtQjT8rlrBJDCN8a+PLSN3R0xn1BGlAyF82P4mHsV/5rui9iS
	aFd69YAhI4fTUvMOWtyA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grKCv-0006v8-U5; Wed, 06 Feb 2019 10:13:29 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grKCs-0006ua-GF; Wed, 06 Feb 2019 10:13:27 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0590680D;
 Wed,  6 Feb 2019 02:13:23 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 965863F719;
 Wed,  6 Feb 2019 02:13:20 -0800 (PST)
Date: Wed, 6 Feb 2019 10:13:18 +0000
From: Quentin Perret <quentin.perret@arm.com>
To: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH 2/2] cpufreq: mediatek: Register an Energy Model
Message-ID: <20190206101316.fr7z4ffr4ck4l4aj@queper01-lin>
References: <20190205175225.25923-1-mka@chromium.org>
 <20190205175225.25923-2-mka@chromium.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190205175225.25923-2-mka@chromium.org>
User-Agent: NeoMutt/20171215
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_021326_540106_7478A7A6 
X-CRM114-Status: GOOD (  15.64  )
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
Cc: Taniya Das <tdas@codeaurora.org>, Nicolas Boichat <drinkcat@chromium.org>,
 linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 Douglas Anderson <dianders@chromium.org>, CK Hu <ck.hu@mediatek.com>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 Eddie Huang <eddie.huang@mediatek.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Matthias,

On Tuesday 05 Feb 2019 at 09:52:25 (-0800), Matthias Kaehlcke wrote:
> Try and register an Energy Model from mediatek-cpufreq to allow
> interested subsystems like the task scheduler to use the provided
> information.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/cpufreq/mediatek-cpufreq.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index eb8920d398181..e6168ee582783 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -460,6 +460,8 @@ static int mtk_cpufreq_init(struct cpufreq_policy *policy)
>  		return ret;
>  	}
>  
> +	dev_pm_opp_of_register_em(policy->cpus);

I'm not familiar with the mediatek-cpufreq driver so bear with me, but
the code sets policy->cpus just below here. Is there any particular
reason for not using that in PM_EM ?

>  	cpumask_copy(policy->cpus, &info->cpus);
>  	policy->freq_table = freq_table;
>  	policy->driver_data = info;
> -- 
> 2.20.1.611.gfbb209baf1-goog
> 

Thanks,
Quentin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
