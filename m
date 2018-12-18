Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBDCC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:45:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D352321852
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GE4U8TBA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D352321852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HAjeybq1spMHrUqGF/87aB1L/lu9DtilecJH33vl0Pg=; b=GE4U8TBAvsW5j+
	DSn60SBmH0I5yu+qmpBnpYvl5LFmPtFjKP0AD0ny43veXOBsc9GSjzdyfbxLzfpLc2Hb/jUP2Y42z
	Z/6KEWJIgNIjw0clLCraoB6tJcRcFS33KWCmbg5Htnfv4RQqAs6p4UDH/1VRsEngczsZkvlFyz7ZX
	nmizZ6GmBoIeeTf9c5jOqJll7S0khY9bKDfkXg8TKlyn6YzKcZJtCJmma/S+0r2Ok++/FiMciY+qP
	FIg9SOiB3WMm9eWERH5ETxeweEbe+DpzxYyoXJ1k3hYeEiMzJcCXzHIlKWE+5wohAmBD9CAgjK70m
	q8juxIjCFUfkXH1qAX+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZHYR-0005r0-77; Tue, 18 Dec 2018 15:45:07 +0000
Received: from mail-oi1-f194.google.com ([209.85.167.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZHYO-0005Be-5W
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 15:45:05 +0000
Received: by mail-oi1-f194.google.com with SMTP id h25so2320325oig.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 07:44:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=NcWVkWKG6oRU/4m7cHZ3YmJci15Y/kvJSx5k2vvnUtM=;
 b=F0gqelzUi0FKSAddLHkfhDUrXDGXZMoMR3RYpjHIVHjjnU7Ro3xgQHdgHU+h9RBVM4
 DSoUb4GZbvWaqW+ahPiJex4C/vt0ficC74EVQfnoYbPMCGSpIz/4KAXVxHlmEeS4rnDt
 dUFdBwRR7vDYHgb75OJuqPtm72N0z583sYLUILYdG7m8p+dNasy78t+Y8qSopckfK23b
 +njHG2o6OMHLk6z+SVJWz3jdKvOTYeVvyAY9hkkYxrZ4UVfkdb1oW64c2+ekzrA1CItC
 rqVRr7AKqmaNhdEcGzET2L5OkitsxCnk+44lMOAQrMYcTm5Dc06RYdFmKYmAUiEQ0ydK
 BkIA==
X-Gm-Message-State: AA+aEWbtgiDpHrTEPnI/p/1bFzJcu+7E69w/X2Uuxedk8eK5ixC1ROJJ
 +JAiG8ZROLKGv6EDFHmfXA==
X-Google-Smtp-Source: AFSGD/VTpA+q4J/0L1oahdvDemcj8GbLv8Vy+fn0wDCVLrnL3U0A3haKdTlmYNQEmQfa1nbKNalVfg==
X-Received: by 2002:aca:b184:: with SMTP id a126mr1661186oif.187.1545147892881; 
 Tue, 18 Dec 2018 07:44:52 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id w5sm7097461oif.48.2018.12.18.07.44.51
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 18 Dec 2018 07:44:52 -0800 (PST)
Date: Tue, 18 Dec 2018 09:44:51 -0600
From: Rob Herring <robh@kernel.org>
To: Joseph Lo <josephl@nvidia.com>
Subject: Re: [PATCH V3 02/20] dt-bindings: clock: tegra124-dfll: add Tegra210
 support
Message-ID: <20181218154451.GA23737@bogus>
References: <20181218091232.23532-1-josephl@nvidia.com>
 <20181218091232.23532-3-josephl@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181218091232.23532-3-josephl@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_074504_210578_1F997729 
X-CRM114-Status: GOOD (  12.85  )
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
Cc: devicetree@vger.kernel.org, Peter De Schrijver <pdeschrijver@nvidia.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>, Joseph Lo <josephl@nvidia.com>,
 linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 18 Dec 2018 17:12:14 +0800, Joseph Lo wrote:
> Add Tegra210 support for DFLL clock.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> Acked-by: Jon Hunter <jonathanh@nvidia.com>
> ---
> *V3:
>  - no change
> *V2:
>  - add ack tag
> ---
>  .../devicetree/bindings/clock/nvidia,tegra124-dfll.txt        | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
