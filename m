Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D81C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:33:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98CA92147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QTLEwKap"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98CA92147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:
	In-Reply-To:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=v8OQQ29CuLPDt6GhbpK0AnDKjLhQl1t//J6cpxabZE8=; b=QTLEwKapDLQt3P
	BzzGba0J71ZDF4BeTqtkY6ZmmCSCBIGxTKmHVuyrZr84SMMhuMK/0NS7H0tkVfLYFRvC2kw8+VBA5
	Y9PuQJb+enOtdRDhqAhCtgB2I9lxvF17X2WDIofmjDHJd2dstZDTSEScgpEnPoWiDJfJbwhrgx4Rm
	YnpFzNP4RxpbU0gpTVznFtfgsFCAI0xG48xmlBLyiuV311rqTaEC8sHw5LlHhdgWIBth11G9Dng3q
	QUGPnyE9ExKq0yYD1uepxnJt8zUz6nn15MF0FfKMg1cbHP6ZQP+oAhFAznjmbYu14z9rj3ASQuNpN
	mv3H5Y5LF5MdrdP8uDNg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw9Gt-0006N6-Ql; Tue, 19 Feb 2019 17:33:31 +0000
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw9Gp-0006MK-Vb
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 17:33:29 +0000
X-IronPort-AV: E=Sophos;i="5.58,388,1544482800"; d="scan'208";a="370069650"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 19 Feb 2019 18:33:24 +0100
Date: Tue, 19 Feb 2019 18:33:22 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm/mach-omap2/display: fix possible object reference leak
In-Reply-To: <20190219170516.GL15711@atomide.com>
Message-ID: <alpine.DEB.2.20.1902191830490.27989@hadrien>
References: <1550071969-86286-1-git-send-email-peng.hao2@zte.com.cn>
 <20190219170516.GL15711@atomide.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_093328_291680_D9762F22 
X-CRM114-Status: GOOD (  19.04  )
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



On Tue, 19 Feb 2019, Tony Lindgren wrote:

> Hi,
>
> Adding devicetree list, Julia, Rob and Tomi to Cc.
>
> * Peng Hao <peng.hao2@zte.com.cn> [190212 23:11]:
> > of_find_device_by_node() takes a reference to the struct device
> > when it finds a match via get_device.When returning error we should
> > call put_device.
> >
> > Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> > ---
> >  arch/arm/mach-omap2/display.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
> > index f86b72d..c6aa9ed 100644
> > --- a/arch/arm/mach-omap2/display.c
> > +++ b/arch/arm/mach-omap2/display.c
> > @@ -258,6 +258,7 @@ static int __init omapdss_init_of(void)
> >  	r = of_platform_populate(node, NULL, NULL, &pdev->dev);
> >  	if (r) {
> >  		pr_err("Unable to populate DSS submodule devices\n");
> > +		put_device(&pdev->dev);
> >  		return r;
> >  	}
>
> In general, if the device tree node is never used afterwards,
> should this be just:
>
> 	r = of_platform_populate(node, NULL, NULL, &pdev->dev);
> 	of_node_put(dev_node);
> 	if (r) {
> 		...
> 	}
>
> If so, Julia might have a Coccinelle recpipe for it?

Unfortunately this is not really an ideal case for Coccinelle, because
node is the result of calling a local function and Coccinelle doesn't by
default do any interprocedural analysis.  It is possible to write a rule
that explicitly looks for one function that returns a device node and then
the pattern of its usage in the caller, though.

julia

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
