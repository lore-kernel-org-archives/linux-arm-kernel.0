Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFD4C282E1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:52:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF6852086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ChR2N1Ul";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="pUXtqEko"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF6852086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NHIuuFARhZTMgOqJvQp/eggThO0NDR5uvzjdITR1IwU=; b=ChR2N1UlW2UWRR
	tax6WwLsJOfa1mEsI4S8A3EViAQNGYSk+ikV6fgXM7da17h36OIRD4wgVqPUhsQej+i3FWFABBFy5
	0SEe+z95sFhyGy1MPBRDSjECF23ZoqY5MawYHphoYzUrYyh05p7IWQLcL+EZCia4G4F+q26rkN2b1
	l1C+6Oc5G0rsPj1tTW9VPuJbC0ooanyOCnHh9wc/zbntWCMoXsNn4JrODq3j8P+kSOHzhr6LWaMv+
	821bxIAVVnPklQRw+UcOMNi016li0i7oMmSAQhVXByakIKi7uwX3Ryt3A4WWedpZJtX5J8fpEqx/1
	qF8i3hgTwg3zLUUE5YuQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs5e7-00080p-GE; Fri, 08 Feb 2019 12:52:43 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs5e3-00080T-Sm
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 12:52:41 +0000
Received: by mail-lf1-x144.google.com with SMTP id e27so2434519lfj.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 04:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:organization:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Sstv+FariMaDhiPskpASC+lRTN6ZSuuUp6yHfV2vVeo=;
 b=pUXtqEkoPQZauIcsHjpB761HPyBOV3Iq5ePVbpOkaV8s6katFMt0diQdY5IVrOvjHx
 x0daotQvK6kMcXax4UNQrLOOe3ZRSRic6X4DrmdJRJbf7NBOXkEleXJRLAs8IEilrVqb
 B31puiKCR6nJCYaMHlu9Kg8GxOZpxwRB1gsJ2k+DjN5jbRr6VFPWlBCkTWrtISsySFmu
 ri+KyZ8VuxLtoRbLrAvg55AJ575XLTJeTa1HYhZgyZZwyM98NC12xc2mY45LpatU0uuA
 aRbQw+6q0aW8WIwEAzAFCzsygj6jH2uKjq5P7Rw9bdrkrTVAtLtEscDWEe//I03hNZ/l
 7ajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Sstv+FariMaDhiPskpASC+lRTN6ZSuuUp6yHfV2vVeo=;
 b=n2yxsWzlKqB1+LQh75IDYxi/gtT0w1tQbyH0Q33WVJxykgsuobdjHDuef84RR6NN6/
 1ns5ha+qSW9o/03XlpCYs1E2LMWzMSBe1C936d28UsLLJ4vIdAwxVIjAqe/jOOcd2bus
 787Jz+CVb6dwH6z4DcE36wtmiwCP1rZRSmRKjJYoAlpRQbWyGxRgQleNfcwockq0+SIX
 h3zf1/Ez6j256LeBettoUIq6X2aPTWLXlTpB0NfA4sXhry5kNrILF6SXCc6iFfjl5pUS
 HIm+etKPRl1LAFVYoVRzhknxDdcvloSXxs/KcmnglYweASn/BI3uppFY4pzVDke7cETK
 vjmg==
X-Gm-Message-State: AHQUAuYjjftC7IW8lM00rs7Xv5l/0fcXUTswDcyuBCO8rbOuK0KJ3eyx
 y/ckjxr39fcEP9oPg1Xe5uccZw==
X-Google-Smtp-Source: AHgI3IYIX8QubbdZUqL0dfyxcVIoZ9Oo1GAT+HJwmp5FzO6CzomrM/ENEturuFWDVc+CALZ5MhfA/A==
X-Received: by 2002:ac2:5224:: with SMTP id i4mr6988894lfl.145.1549630356984; 
 Fri, 08 Feb 2019 04:52:36 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.84.132])
 by smtp.gmail.com with ESMTPSA id p77-v6sm405827lja.0.2019.02.08.04.52.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 08 Feb 2019 04:52:35 -0800 (PST)
Subject: Re: [PATCH 08/12] arm64: dts: renesas: r8a774c0: Add OPPs table for
 cpu devices
To: Simon Horman <horms+renesas@verge.net.au>,
 linux-renesas-soc@vger.kernel.org
References: <cover.1549623801.git.horms+renesas@verge.net.au>
 <231d8908a66fa98f09553d31ad8cd5f382b29959.1549623801.git.horms+renesas@verge.net.au>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <7d60ebf5-c245-f48d-47db-ce63f4f3690b@cogentembedded.com>
Date: Fri, 8 Feb 2019 15:52:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <231d8908a66fa98f09553d31ad8cd5f382b29959.1549623801.git.horms+renesas@verge.net.au>
Content-Language: en-MW
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_045240_345176_B5D78E38 
X-CRM114-Status: GOOD (  16.24  )
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
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
 Magnus Damm <magnus.damm@gmail.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello!

On 02/08/2019 02:13 PM, Simon Horman wrote:

> From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> 
> This patch defines OOP tables for all CPUs, similarly to
> what done by Takeshi Kihara and Yoshihiro Kaneko for the
> R8A77990.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
[...]
> @@ -55,6 +76,8 @@
>  			power-domains = <&sysc R8A774C0_PD_CA53_CPU0>;
>  			next-level-cache = <&L2_CA53>;
>  			enable-method = "psci";
> +			clocks =<&cpg CPG_CORE R8A774C0_CLK_Z2>;

   Need space after =...

> +			operating-points-v2 = <&cluster1_opp>;
>  		};
>  
>  		a53_1: cpu@1 {
> @@ -64,6 +87,8 @@
>  			power-domains = <&sysc R8A774C0_PD_CA53_CPU1>;
>  			next-level-cache = <&L2_CA53>;
>  			enable-method = "psci";
> +			clocks =<&cpg CPG_CORE R8A774C0_CLK_Z2>;


   Here as well...

> +			operating-points-v2 = <&cluster1_opp>;
>  		};
>  
>  		L2_CA53: cache-controller-0 {

MBR, Sergei

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
