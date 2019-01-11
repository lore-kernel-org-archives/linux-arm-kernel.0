Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B474C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:09:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CD4B20657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jOm08Agb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CD4B20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eRv6019acxGs5/codafWwepke9r1UQZhiQsxJ7CMlxc=; b=jOm08AgbGcu5aq
	yAWvWQRvNbOGD6lZvZg5Z3WunnXjoeudXpBSiZoy0Sc3yU9O6npZCSEyJfqtLyYAJ92DlY+WZFj0O
	Jx2OQD6B9zmRyPdCehk58z184/94OPYGATnoMSYZgTkH1eEMTdSXAPWGWyWEvhrsJvhfXdzWakJsA
	IQCSZzuC2pzy2Lto9md+MA+myjS4tRSdUhgbvsgGvP8lGhmCulnDNcAiIEKmvBl4QDWk9HpWULgws
	Zcrq/xSddpLExQpZR/ugybFosfWAtnyfTCl+sDxJZatnKO5pdWxdUoIZxoK+rf9i7QMfSQDyxjkM1
	+ELMN1BhXBjSjCM8lyXQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghzN6-0006kE-DS; Fri, 11 Jan 2019 16:09:24 +0000
Received: from mail-oi1-f196.google.com ([209.85.167.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghzN2-0006jR-VC; Fri, 11 Jan 2019 16:09:22 +0000
Received: by mail-oi1-f196.google.com with SMTP id a77so12587822oii.5;
 Fri, 11 Jan 2019 08:09:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=C+4rePCn2D2muFtmby3dx4B8iAj2ZTfNNUldaFzxF8U=;
 b=nSf3KSaplS6rSilyV4tz9nfZDXEGZVdsafD1ntQMPgT3YF2KzDdIFr/hu9Qp2lNz10
 AoXU5ZAt7+DCafZRYGOqdzMiMD0/Kl3UcX4MkR8l3Dg1FlgcPWDKJ5TalG6PrKM5w+ko
 gghiNLXE0rdOF02YSr+qtnaDtYj4DWG5VATXdi7DV7pVQDnGY/5V5AjuVdZaJaEdu3gA
 XydzAl1v0j6jnRrfAFhEiOJSComxFlpRu7ueA7LHdskTdv7+SRsHHVwtt3JiJcxyLY+Q
 I6/7Khdm2RYgZowcg+ncAc1p9PlV+jBRwiT/PmknGmKiSrKY5O9jT/RqDEEqRhnOF593
 DgcQ==
X-Gm-Message-State: AJcUukc8l9SKxx6wfg/0YWO6HqfKc0cmSignXpfHuouRHq6OeDa3JHX0
 gk1Sk0KfNqmuWdWWvAePxA==
X-Google-Smtp-Source: ALg8bN48OhaEJVJKRoVwfabmjGSOvtviWRDaI1vMYq7S4o6y7YNztWl1lTEPkpdeaDYqsQkxYkQf3A==
X-Received: by 2002:aca:ea57:: with SMTP id i84mr9603880oih.346.1547222959652; 
 Fri, 11 Jan 2019 08:09:19 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id g19sm34112953otl.26.2019.01.11.08.09.18
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 11 Jan 2019 08:09:19 -0800 (PST)
Date: Fri, 11 Jan 2019 10:09:18 -0600
From: Rob Herring <robh@kernel.org>
To: Henry Chen <henryc.chen@mediatek.com>
Subject: Re: [RFC RESEND PATCH 1/7] dt-bindings: soc: Add DVFSRC driver
 bindings
Message-ID: <20190111160918.GA20480@bogus>
References: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com>
 <1546438198-1677-2-git-send-email-henryc.chen@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1546438198-1677-2-git-send-email-henryc.chen@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_080921_004042_736AB6B7 
X-CRM114-Status: GOOD (  22.10  )
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
 Stephen Boyd <sboyd@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
 linux-kernel@vger.kernel.org, Fan Chen <fan.chen@mediatek.com>,
 devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 02, 2019 at 10:09:52PM +0800, Henry Chen wrote:
> Document the binding for enabling DVFSRC on MediaTek SoC.
> 
> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> ---
>  .../devicetree/bindings/soc/mediatek/dvfsrc.txt    | 26 ++++++++++++++++++++++
>  include/dt-bindings/soc/mtk,dvfsrc.h               | 18 +++++++++++++++
>  2 files changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/dvfsrc.txt
>  create mode 100644 include/dt-bindings/soc/mtk,dvfsrc.h
> 
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/dvfsrc.txt b/Documentation/devicetree/bindings/soc/mediatek/dvfsrc.txt
> new file mode 100644
> index 0000000..402c885
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/mediatek/dvfsrc.txt
> @@ -0,0 +1,26 @@
> +MediaTek DVFSRC Driver

Bindings are for h/w blocks, not drivers.

> +The Dynamic Voltage and Frequency Scaling Resource Collector (DVFSRC) is a
> +HW module which is used to collect all the requests from both software and
> +hardware and turn into the decision of minimum operating voltage and minimum
> +DRAM frequency to fulfill those requests.

Seems like the OPP table should be a child of this instead of where you 
currently have it?

> +
> +Required Properties:
> +- compatible: Should be one of the following
> +	- "mediatek,mt8183-dvfsrc": For MT8183 SoC
> +- reg: Address range of the DVFSRC unit
> +- dram_type: Refer to <include/dt-bindings/soc/mtk,dvfsrc.h> for the
> +	different dram type support.

This information should come from the DDR controller or memory nodes 
probably. And we already have some properties related to DDR type.

> +- clock-names: Must include the following entries:
> +	"dvfsrc": DVFSRC module clock
> +- clocks: Must contain an entry for each entry in clock-names.
> +
> +Example:
> +
> +	dvfsrc_top@10012000 {

Drop the '_top'. (Don't use '_' in node and property names).

> +		compatible = "mediatek,mt8183-dvfsrc";
> +		reg = <0 0x10012000 0 0x1000>;
> +		clocks = <&infracfg CLK_INFRA_DVFSRC>;
> +		clock-names = "dvfsrc";
> +		dram_type = <MT8183_DVFSRC_OPP_LP4>;
> +	};
> diff --git a/include/dt-bindings/soc/mtk,dvfsrc.h b/include/dt-bindings/soc/mtk,dvfsrc.h
> new file mode 100644
> index 0000000..60b3497
> --- /dev/null
> +++ b/include/dt-bindings/soc/mtk,dvfsrc.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * Copyright (c) 2018 MediaTek Inc.
> + */
> +
> +#ifndef _DT_BINDINGS_POWER_MTK_DVFSRC_H
> +#define _DT_BINDINGS_POWER_MTK_DVFSRC_H
> +
> +#define MT8183_DVFSRC_OPP_LP4	0
> +#define MT8183_DVFSRC_OPP_LP4X	1
> +#define MT8183_DVFSRC_OPP_LP3	2
> +
> +#define MT8183_DVFSRC_LEVEL_1	1
> +#define MT8183_DVFSRC_LEVEL_2	2
> +#define MT8183_DVFSRC_LEVEL_3	3
> +#define MT8183_DVFSRC_LEVEL_4	4
> +
> +#endif /* _DT_BINDINGS_POWER_MTK_DVFSRC_H */
> -- 
> 1.9.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
