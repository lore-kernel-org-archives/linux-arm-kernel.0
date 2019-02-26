Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE1AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:18:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFF30217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nHkJZo63";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4UKrbE7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFF30217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:In-Reply-To:From:Subject:
	Message-ID:References:To:MIME-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OHVjEdocA+Oc5sxAKjY3gOu82sOKHODAZ7GR2O4fIHA=; b=nHkJZo63vgFun2
	EJ+RYkz2fe32+3LvC6NQmAKJsm/vKSEA0hidh9RccuP3XSRRW2sTtnloBNQ+cKx/ltNrmI+pdzQ55
	ox0P7LiyMzt0U8zr2vrEVY1O2ESnjQj1pR7+HsjNRR0wk8D+nfSBQ7wHJe8tnQBbzvATQo0OlIXe/
	AAv5PU6kcK6c1bXVJYCUVWoQa014Nomm0haXt62/lSsgs4Izybz2J5gWF6US9QAFaXKQU8d+Em9Hm
	On4wDv4QNCgZRruY2Oo94aF27lVtUNJ8jr2/80NJdE2rUVZjosaQLTHVv5swwSWUEC5VAxhH4VPVa
	DwmIjKt+Lbrav5bHqK4A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyhJ7-0007kP-3J; Tue, 26 Feb 2019 18:18:21 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyhJ3-0007iq-DP; Tue, 26 Feb 2019 18:18:18 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 018EB217F5;
 Tue, 26 Feb 2019 18:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1551205097;
 bh=bFLXljzs2qAylOC1A8tQ7CTZcoU6o67PgXbdazTu9uI=;
 h=To:References:Cc:Subject:From:In-Reply-To:Date:From;
 b=s4UKrbE7YvarmlFrjpcAMX83XIBwsz7PvW3mliL0XOlnJcULTTfeUdpx3ZNS+ZqQu
 d9DJAqjNCd5hBZqpop0MzQmsRr2ig+7cYrVcxavLIYCH63f7rrmDT/NPOMzWrrlHk6
 GeJh4QD/F+0Xka8gJPlxUbgH9Vi0CPFGo8WqbLv4=
MIME-Version: 1.0
To: Mark Rutland <mark.rutland@arm.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>,
 Seiya Wang <seiya.wang@mediatek.com>
References: <20190225065112.3400-1-seiya.wang@mediatek.com>
 <20190225065112.3400-2-seiya.wang@mediatek.com>
Message-ID: <155120509627.260864.5936412356126577519@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Subject: Re: [PATCH v2 2/2] clk: mediatek: correct cpu clock name for MT8173
 SoC
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190225065112.3400-2-seiya.wang@mediatek.com>
Date: Tue, 26 Feb 2019 10:18:16 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_101817_474397_51568E0B 
X-CRM114-Status: UNSURE (   8.27  )
X-CRM114-Notice: Please train this message.
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
Cc: devicetree@vger.kernel.org, Seiya Wang <seiya.wang@mediatek.com>,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Seiya Wang (2019-02-24 22:51:12)
> diff --git a/include/dt-bindings/clock/mt8173-clk.h b/include/dt-bindings/clock/mt8173-clk.h
> index 8aea623dd518..76e4e5b65353 100644
> --- a/include/dt-bindings/clock/mt8173-clk.h
> +++ b/include/dt-bindings/clock/mt8173-clk.h
> @@ -194,7 +194,8 @@
>  #define CLK_INFRA_PMICWRAP             11
>  #define CLK_INFRA_CLK_13M              12
>  #define CLK_INFRA_CA53SEL               13
> -#define CLK_INFRA_CA57SEL               14
> +#define CLK_INFRA_CA57SEL               14 /* Deprecated. Don't use it. */
> +#define CLK_INFRA_CA72SEL               14

Also, please send a followup patch to remove the deprecated define later
when the dts file is fixed up.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
