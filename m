Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECBEC37120
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:53:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C58320861
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s9ITCM9I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C58320861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=I9zsw+BsaLca98o36viCXoKuTCKLWnTU6Uc+AjSy0D4=; b=s9ITCM9IUXViNY
	eBEV+OEHTug1Pjmoxqrebzy4ep4C4MJ+TxIQHRwhmoSHMc5nWx7aKhI88WhIOPyB5CASpxnRHX2rK
	Vo2SY6Nri2eZfgIofCw7gWb0L4NGJf2pf/j39swZnX17LPl2qnb5X+iTc96V9+e0MrQ4KrWIrQgC4
	DvxqmgIx6hMeaLQOQVrsSEn+lmhEhIuO7VTRcimQw0GDvKhTjD7Zu2iS2MuGh6DDOKCTHPnFiuP3o
	TMiuJL174bf9zwx9N7iPUpQmxsfiHZPC0m2LVl/nrrehMOyqbLERr/QU7nBN38Ve108S/80o7JX9P
	9zFxS/etRazX9es2feaQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glgZV-0000yT-Bu; Mon, 21 Jan 2019 20:53:29 +0000
Received: from mail-ot1-f66.google.com ([209.85.210.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glgZR-0000y9-Ju
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 20:53:27 +0000
Received: by mail-ot1-f66.google.com with SMTP id w25so21671731otm.13
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 12:53:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ov5pmAFbz5CryQbLFY689CpqmNQ0pk9SPQ12zumIw28=;
 b=r6Qo0rxdlJMHzj7fDX/bogi3xaOjCQEmZbVIUZLagbRCzFLg2u7u/7drpf6hUz+Asx
 q9umPf+2WX2AU6UtzjL/MGM1MYfRw1itHz8BmI6hGcWZ6kTtn66cdh9HwjjD+MQ0KQHt
 19PAPX+LNSuxbBZXR7BFAJOF2ZKwtOFrTsbKsI46LvFEF9g1boqHAqNmiVGOK1uPL4AJ
 N0bNzhHislDHEWxcOnO3mAaWuGeqXsCqjbDghTabf8IKeyRb+H0qQLffCKUkD5xPJKfS
 pBeYQO9fwCCHkaVmEIWJYG+ijxdnf4wrlQLWc7zeKFNhmwYIOiwOLTsipnwbglUQK39a
 haaw==
X-Gm-Message-State: AJcUukd1Z4jHUrbtxCwkNPyfRhHJnLTD5Cp+oIXd/paCSqMJ1JHrYbIw
 aKCAjfCQ5uHW1cnvpPMqVw==
X-Google-Smtp-Source: ALg8bN6J4RK8rZbvMI1FGxQG/MkZMWFSPv/tFYxLdKtK22uk7YqAEXs7lhZabwBTnkc69iV8np1DWw==
X-Received: by 2002:a9d:73d0:: with SMTP id m16mr20701898otk.117.1548104004401; 
 Mon, 21 Jan 2019 12:53:24 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id q131sm6731677oih.1.2019.01.21.12.53.23
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 21 Jan 2019 12:53:23 -0800 (PST)
Date: Mon, 21 Jan 2019 14:53:23 -0600
From: Rob Herring <robh@kernel.org>
To: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 2/3] clk: keystone: sci-clk: add support from parsing
 clock info from DT
Message-ID: <20190121205323.GA7851@bogus>
References: <1546954223-9738-1-git-send-email-t-kristo@ti.com>
 <1546954223-9738-3-git-send-email-t-kristo@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1546954223-9738-3-git-send-email-t-kristo@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_125325_650134_BB574624 
X-CRM114-Status: GOOD (  18.82  )
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
Cc: devicetree@vger.kernel.org, sboyd@kernel.org, mturquette@baylibre.com,
 ssantosh@kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 08, 2019 at 03:30:22PM +0200, Tero Kristo wrote:
> Currently the sci-clk driver queries clock data from the firmware, which
> can be pretty slow operation in certain cases. Add an option for the
> driver to probe the available clocks from DT also, in this case the
> number of clocks probed from firmware gets cut down drastically. To
> enable the feature, a new flag ti,scan-clocks-from-dt can be added
> under the clock provider node.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Tested-by: Andreas Dannenberg <dannenberg@ti.com>
> ---
>  drivers/clk/keystone/sci-clk.c | 188 ++++++++++++++++++++++++++++++++++-------
>  1 file changed, 159 insertions(+), 29 deletions(-)


> +static int ti_sci_scan_clocks_from_dt(struct sci_clk_provider *provider)
> +{
> +	struct device *dev = provider->dev;
> +	struct device_node *np = NULL;
> +	int ret;
> +	int index;
> +	struct of_phandle_args args;
> +	struct list_head clks;
> +	struct sci_clk *sci_clk, *prev;
> +	int num_clks = 0;
> +	int num_parents;
> +	int clk_id;
> +
> +	INIT_LIST_HEAD(&clks);
> +
> +	while (1) {
> +		np = of_find_node_with_property(np, "clocks");
> +		if (!np)
> +			break;

for_each_node_with_property

> +
> +		index = 0;
> +
> +		do {
> +			ret = of_parse_phandle_with_args(np, "clocks",
> +							 "#clock-cells", index,
> +							 &args);
> +			if (ret)
> +				break;

of_for_each_phandle can be used here. And then of_phandle_iterator_args 
will get the args.

> +
> +			if (args.args_count == 2 && args.np == dev->of_node) {

dtc will warn if the # of cells are wrong, so that's probably redundant.

Invert the if and save a level of indentation.

> +				sci_clk = devm_kzalloc(dev, sizeof(*sci_clk),
> +						       GFP_KERNEL);
> +				if (!sci_clk)
> +					return -ENOMEM;
> +
> +				sci_clk->dev_id = args.args[0];
> +				sci_clk->clk_id = args.args[1];
> +				sci_clk->provider = provider;
> +				provider->ops->
> +					get_num_parents(provider->sci,
> +							sci_clk->dev_id,
> +							sci_clk->clk_id,
> +							&sci_clk->num_parents);
> +				list_add_tail(&sci_clk->node, &clks);
> +
> +				num_clks++;
> +
> +				num_parents = sci_clk->num_parents;
> +				if (num_parents == 1)
> +					num_parents = 0;
> +
> +				clk_id = args.args[1] + 1;
> +
> +				while (num_parents--) {
> +					sci_clk = devm_kzalloc(dev,
> +							       sizeof(*sci_clk),
> +							       GFP_KERNEL);
> +					if (!sci_clk)
> +						return -ENOMEM;
> +					sci_clk->dev_id = args.args[0];
> +					sci_clk->clk_id = clk_id++;
> +					sci_clk->provider = provider;
> +					list_add_tail(&sci_clk->node, &clks);
> +
> +					num_clks++;
> +				}
> +			}
> +
> +			index++;
> +		} while (args.np);
> +	}
> +
> +	list_sort(NULL, &clks, _cmp_sci_clk_list);
> +
> +	provider->clocks = devm_kmalloc_array(dev, num_clks, sizeof(sci_clk),
> +					      GFP_KERNEL);
> +	if (!provider->clocks)
> +		return -ENOMEM;
> +
> +	num_clks = 0;
> +	prev = NULL;
> +
> +	list_for_each_entry(sci_clk, &clks, node) {
> +		if (prev && prev->dev_id == sci_clk->dev_id &&
> +		    prev->clk_id == sci_clk->clk_id)
> +			continue;
> +
> +		provider->clocks[num_clks++] = sci_clk;
> +		prev = sci_clk;
> +	}
> +
> +	provider->num_clocks = num_clks;
> +
> +	return 0;
> +}

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
