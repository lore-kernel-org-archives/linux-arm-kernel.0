Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598D7C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:45:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26357206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ACrfdht7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26357206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1tfsZ4sG4wVC7HlhUCuxSwbsv/P1/IXl6U+We0I81nc=; b=ACrfdht7CjHU6qLBS2IkXZKz0
	VSbQT8yH4+kKTnijTlajX46Th++RJ4mx0sYg50lQyeCgQLnZoZnfYCLxYE6HW2y0GxIRUeZgJz6Pt
	CeJExp0rcVGnDoKdGO4G6UqrcK5s6+ww2UFdutmATaffo6LRfIUcfJdbKuqzuTGlzBapsbvzV/Yyy
	jcxFGoh1OtvN+jSN1TLBvHF5QyxNyJCSlCcMq/2ywlkz8cV2Nso9ZcfRGma3pmj8kq2aYtixDlAdA
	rSD6GAMe20hpIPfY+QMmLnch6qTKDQJ0HTomm4D92s9rbH243vEXbJNPU4wOLDWeNrYu3UDoSZ25g
	G+UD7m2zg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj5ME-000098-VI; Mon, 14 Jan 2019 16:45:02 +0000
Received: from gateway33.websitewelcome.com ([192.185.146.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj5MA-00007A-GG
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 16:45:00 +0000
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
 by gateway33.websitewelcome.com (Postfix) with ESMTP id 98CA618179
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 10:44:45 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22]) by cmsmtp with SMTP
 id j5LxgVDtndnCej5Lxga4JU; Mon, 14 Jan 2019 10:44:45 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=46058 helo=[192.168.43.131])
 by gator4166.hostgator.com with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.91)
 (envelope-from <gustavo@embeddedor.com>)
 id 1gj5Lw-002oK3-CM; Mon, 14 Jan 2019 10:44:45 -0600
Subject: Re: [PATCH] clk: imx: imx7ulp: use struct_size() in kzalloc()
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, NXP Linux Team <linux-imx@nxp.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
References: <20181224064025.GA9588@embeddedor.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <18969a9a-f9e1-e301-9f17-d1e3ab301dbd@embeddedor.com>
Date: Mon, 14 Jan 2019 10:44:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181224064025.GA9588@embeddedor.com>
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.infradead.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1gj5Lw-002oK3-CM
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.43.131]) [189.250.130.205]:46058
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_084458_629838_39F7D317 
X-CRM114-Status: GOOD (  17.62  )
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
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

Friendly ping:

Who can take this?

Thanks
--
Gustavo

On 12/24/18 12:40 AM, Gustavo A. R. Silva wrote:
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
> 
> struct foo {
>      int stuff;
>      void *entry[];
> };
> 
> instance = kzalloc(sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);
> 
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
> 
> instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);
> 
> This issue was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>   drivers/clk/imx/clk-imx7ulp.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-imx7ulp.c b/drivers/clk/imx/clk-imx7ulp.c
> index 4e18f629f823..ce306631e844 100644
> --- a/drivers/clk/imx/clk-imx7ulp.c
> +++ b/drivers/clk/imx/clk-imx7ulp.c
> @@ -48,8 +48,8 @@ static void __init imx7ulp_clk_scg1_init(struct device_node *np)
>   	struct clk_hw **clks;
>   	void __iomem *base;
>   
> -	clk_data = kzalloc(sizeof(*clk_data) + sizeof(*clk_data->hws) *
> -			   IMX7ULP_CLK_SCG1_END, GFP_KERNEL);
> +	clk_data = kzalloc(struct_size(clk_data, hws, IMX7ULP_CLK_SCG1_END),
> +			   GFP_KERNEL);
>   	if (!clk_data)
>   		return;
>   
> @@ -136,8 +136,8 @@ static void __init imx7ulp_clk_pcc2_init(struct device_node *np)
>   	struct clk_hw **clks;
>   	void __iomem *base;
>   
> -	clk_data = kzalloc(sizeof(*clk_data) + sizeof(*clk_data->hws) *
> -			   IMX7ULP_CLK_PCC2_END, GFP_KERNEL);
> +	clk_data = kzalloc(struct_size(clk_data, hws, IMX7ULP_CLK_PCC2_END),
> +			   GFP_KERNEL);
>   	if (!clk_data)
>   		return;
>   
> @@ -183,8 +183,8 @@ static void __init imx7ulp_clk_pcc3_init(struct device_node *np)
>   	struct clk_hw **clks;
>   	void __iomem *base;
>   
> -	clk_data = kzalloc(sizeof(*clk_data) + sizeof(*clk_data->hws) *
> -			   IMX7ULP_CLK_PCC3_END, GFP_KERNEL);
> +	clk_data = kzalloc(struct_size(clk_data, hws, IMX7ULP_CLK_PCC3_END),
> +			   GFP_KERNEL);
>   	if (!clk_data)
>   		return;
>   
> @@ -228,8 +228,8 @@ static void __init imx7ulp_clk_smc1_init(struct device_node *np)
>   	struct clk_hw **clks;
>   	void __iomem *base;
>   
> -	clk_data = kzalloc(sizeof(*clk_data) + sizeof(*clk_data->hws) *
> -			   IMX7ULP_CLK_SMC1_END, GFP_KERNEL);
> +	clk_data = kzalloc(struct_size(clk_data, hws, IMX7ULP_CLK_SMC1_END),
> +			   GFP_KERNEL);
>   	if (!clk_data)
>   		return;
>   
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
