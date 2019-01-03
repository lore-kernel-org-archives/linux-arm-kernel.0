Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7CBC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 04:47:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19E812070C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 04:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S7EkDREJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y4PnJPBf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19E812070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dLyqM4G8UUUnn0rabDNktJN1/OkPYRpUGABLw+Qa+zQ=; b=S7EkDREJSNWUrF
	2Y03qMJdqm+GrHge1m4In8QJie5maO6qdFX62kb/5vfjCUAtqOOhx4ihTF1347UMf/hvkWAIaNAah
	sSSaoX3SkitSLdS0gd0EmtCp4qkmkmpOhGrXrtMKUJDnLI4uJHbzFi290skydELRRPgV/vhnCaxKd
	+wNQaeTRs/IoZhxLZuunAPXJMGGaFJZj0KgZgJ12HULuhQizdX1p4E0nUJfIVb7ZJGsxLfZWZZ1FC
	NPcSKijPxfS6x0wEgA9Rtw1lvNjv+loKOQ6cWQERiWsCCWHzKY3jr0ymFSuHRHwGHOPT7sMxIOyd1
	6TprHEbSq+xDBPiqGXIg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1geuut-0003WJ-NP; Thu, 03 Jan 2019 04:47:35 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1geuup-0003VG-JY
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 04:47:33 +0000
Received: by mail-pg1-x543.google.com with SMTP id v28so15467032pgk.10
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 02 Jan 2019 20:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=On+I7NHOZIkneoPiu+k/yqQU7U/xet9QbNr1Xr5/6QM=;
 b=Y4PnJPBfkoSHIAuGksonZBhRFF+wiHmnKCF2+2xpk3mr+N/X7y1+ZkulAI1K9liMtK
 6pMjqkYa+YmaXtHtf4wSqw4CV0CFq8Gt39xokOtxWXYhAz59ryiYFewhwut23LnXrRwK
 3hzIpv2rOWRjVhhUyYVY3Um4McrXKFaj7NfH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=On+I7NHOZIkneoPiu+k/yqQU7U/xet9QbNr1Xr5/6QM=;
 b=qkqWEy4+iuXWwmKo2Do/A/fBazQQs0Ww1dQCB4NmyS/dQ1lLvCqUB4Voj3XNX9nlvd
 wTI7sfHrD7QtH0KcsB+1Jp2+i4jI7ZfpJKcgLdnzzcLs8TlaunwdmBnCFBRenbkgba+R
 be9gYSqrsMSkggFQNL/GveGl1W18v35O9i4PizIKwEZYZ/He6oJEMjNNpbFKy08HU5AD
 oGrrrQSW8MeSXypV2lnReqjA3+3x9EMsYKdNSiHj3LY0WrJjXAP5ZFIp1PEuEjO/IQr7
 2nc/oXSZTuj7HVcUo0I9r9KebwC9WWXDC/RKK4f4HFIuN2ciMRjhKyS8+gTrURgrg9up
 /ZJg==
X-Gm-Message-State: AA+aEWaBo/eK3u3M7KOdqh5DJX9trFoPqu1AAu8lAfL4FrHsRbTeOwe3
 9IdwudfGg5TTgAI2oqUaIhJTnQ==
X-Google-Smtp-Source: AFSGD/Uty+vxgE7wfGOFbBiGiiMCcWlnT0Sg5G3GqM2YA739QsspPIjVzuWHkOIcGyB9P1FQF/KLyg==
X-Received: by 2002:a62:de06:: with SMTP id h6mr48253415pfg.158.1546490850250; 
 Wed, 02 Jan 2019 20:47:30 -0800 (PST)
Received: from localhost ([122.166.131.155])
 by smtp.gmail.com with ESMTPSA id s21sm86243157pfk.133.2019.01.02.20.47.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 02 Jan 2019 20:47:29 -0800 (PST)
Date: Thu, 3 Jan 2019 10:17:27 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Henry Chen <henryc.chen@mediatek.com>
Subject: Re: [RFC RESEND PATCH 4/7] arm64: dts: mt8183: add performance state
 support of scpsys
Message-ID: <20190103044727.i34ak7vw6qfircvq@vireshk-i7>
References: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com>
 <1546438198-1677-5-git-send-email-henryc.chen@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1546438198-1677-5-git-send-email-henryc.chen@mediatek.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190102_204731_657876_42411D89 
X-CRM114-Status: GOOD (  16.03  )
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
 devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 02-01-19, 22:09, Henry Chen wrote:
> Add support for performance state of scpsys on mt8183 platform.
> 
> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index 47926a7..e396410 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -9,6 +9,7 @@
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/power/mt8183-power.h>
> +#include <dt-bindings/soc/mtk,dvfsrc.h>
>  
>  / {
>  	compatible = "mediatek,mt8183";
> @@ -243,6 +244,26 @@
>  			      "vpu-3", "vpu-4", "vpu-5";
>  		infracfg = <&infracfg>;
>  		smi_comm = <&smi_common>;
> +		operating-points-v2 = <&dvfsrc_opp_table>;
> +		dvfsrc_opp_table: opp-table {
> +			compatible = "operating-points-v2-mtk-level";
> +
> +			dvfsrc_vol_min: opp1 {
> +				mtk,level = <MT8183_DVFSRC_LEVEL_1>;
> +			};
> +
> +			dvfsrc_freq_medium: opp2 {
> +				mtk,level = <MT8183_DVFSRC_LEVEL_2>;
> +			};
> +
> +			dvfsrc_freq_max: opp3 {
> +				mtk,level = <MT8183_DVFSRC_LEVEL_3>;
> +			};
> +
> +			dvfsrc_vol_max: opp4 {
> +				mtk,level = <MT8183_DVFSRC_LEVEL_4>;
> +			};
> +		};
>  	};

I don't see a patch which makes use of this OPP table using the required-opps
thing. Where is that ?

-- 
viresh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
