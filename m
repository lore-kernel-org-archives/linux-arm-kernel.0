Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBC9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:58:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D45D02084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YJFuadsk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D45D02084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iz4VW/c4t844BhQcxDCQchWjbZi2wcYJnypmoJzJI7Y=; b=YJFuadskZaDPuw
	ipy3Z0PgzYFEGmW1FXoXUmpHk7FJyO8ekxzVqRadnbAdZSFwSdEUwNDuieHa7j0A7vePGsgPVSQfn
	ZiKTKkHVovJ4w1DPW1bgXEsO2F3HC+qqYew1h8FbukHZQkT4a8kIZFk5Ui4XKNewJ/8ErqupHRBGz
	6YTLTxsGrzFnkORDcb/ukFW+dM08+rvdg8+xyn+Z12ponczPL7JRfbP9HsG0qMIYhPdJQmhbfCAzy
	dErMhBYo0yNjJuGv3RCazuF0dVKoqeFtk0no4jDAjuvMhUOohUAg+XYnxRSAQEGqEtSv1yR6q772z
	rY7JnTXALaHFj9YQarWg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw9ev-0005hT-A8; Tue, 19 Feb 2019 17:58:21 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw9er-0005h4-SB
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 17:58:19 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id A56EB80B6;
 Tue, 19 Feb 2019 17:58:27 +0000 (UTC)
Date: Tue, 19 Feb 2019 09:58:14 -0800
From: Tony Lindgren <tony@atomide.com>
To: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH] arm/mach-omap2/display: fix possible object reference leak
Message-ID: <20190219175814.GO15711@atomide.com>
References: <1550071969-86286-1-git-send-email-peng.hao2@zte.com.cn>
 <20190219170516.GL15711@atomide.com>
 <alpine.DEB.2.20.1902191830490.27989@hadrien>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1902191830490.27989@hadrien>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_095817_951602_241C3A63 
X-CRM114-Status: GOOD (  12.48  )
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
Cc: Rob Herring <robh@kernel.org>, Peng Hao <peng.hao2@zte.com.cn>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org,
 wen.yang99@zte.com.cn, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

* Julia Lawall <julia.lawall@lip6.fr> [190219 17:33]:
> On Tue, 19 Feb 2019, Tony Lindgren wrote:
> > In general, if the device tree node is never used afterwards,
> > should this be just:
> >
> > 	r = of_platform_populate(node, NULL, NULL, &pdev->dev);
> > 	of_node_put(dev_node);
> > 	if (r) {
> > 		...
> > 	}
> >
> > If so, Julia might have a Coccinelle recpipe for it?
> 
> Unfortunately this is not really an ideal case for Coccinelle, because
> node is the result of calling a local function and Coccinelle doesn't by
> default do any interprocedural analysis.  It is possible to write a rule
> that explicitly looks for one function that returns a device node and then
> the pattern of its usage in the caller, though.

OK thanks for the information.

Regards,

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
