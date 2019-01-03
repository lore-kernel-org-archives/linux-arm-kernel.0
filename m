Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D547BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:23:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E0F3208E3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rGXRZ9GF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E0F3208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nTTWPjjJKLkhz0dZlccxOc8LFcz1VhBColWCOLSSN0A=; b=rGXRZ9GFi+NYZH
	vd6i9yga5HA/XxWGddBTdC3o9eO/8SLzLgJz1WCJjKjUd+blJoou1xXr68rEjylv4UCTKo6WXceXM
	5r388aVNUkiOEdAOUaxGm7BfZLRYV3wXKE6lBY1i6Mn61RuR7Nd+DzLElVrgK14zJOzkQ7t8ek059
	OAIHk2Faoa4sTPApvkV8NYRdt6+HjXtvAQIplvqFB8awTvFT2H2ykJNZQcIp7xk2w7hd05MWucByw
	AsP58+R5Lgai65s2StYtSR0eIS8cXadrMQ85NHR2oCotQ3/4KBmxFS3XBgrkfO0mkIs/mVOPaiQ1j
	t0sGQCSAEeX7MhKc5t0Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf8aJ-0006K2-Iv; Thu, 03 Jan 2019 19:23:15 +0000
Received: from mail-io1-f66.google.com ([209.85.166.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf8aF-0006Jf-U1; Thu, 03 Jan 2019 19:23:13 +0000
Received: by mail-io1-f66.google.com with SMTP id r200so27810452iod.11;
 Thu, 03 Jan 2019 11:23:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=hKMN0hpq+/jcMTDWf2h/27DjjkDxdUwdk8lzBZytIUw=;
 b=Nsdx3RCAiHVlj2a6B6WqKJQcsNeEdeVWgGOiKSj+BEbtLiNG0eUUbkUD1TU183I+PH
 bUgH4CTSICu+05uBL1AFThuEFgTRSRFnL4LB0J68p4MYRwDkVyQKzowikTWkRAV83wxv
 yOPBER5PbWLl0K7Le+TmL+74pdwCkoxtAC30uqaFYVpyG7l5isXtuoQkaar5y2RGgo4X
 +c2cRUjTx6sUokVx4FP4uQ6FEBfpa7KQVTtFjBvBxpwEN7ITMnlIkKejZ7eT2FJmK0dq
 u3t4y6sR0Y3i0eSfGWyG1mBlbDBjlGEq7jgEK8eBU+Dv+20HHR9cjdAGHQLhV5BaYQiq
 xkGg==
X-Gm-Message-State: AJcUukd8Pn4W7c7ZaM8sT2cCozKNaV+V89L7z4n52DHH8DHDs9o32v30
 E57/qAVQGkaoJCVQpi3QEQ==
X-Google-Smtp-Source: ALg8bN6BttsupZdvN37T3bb/h0KSkrF5elEJYocxKlK0oVXXXNr3JhXqksYU4Z6Pzs0W8HnugDLC5g==
X-Received: by 2002:a5e:860a:: with SMTP id z10mr31702177ioj.35.1546543390492; 
 Thu, 03 Jan 2019 11:23:10 -0800 (PST)
Received: from localhost ([24.51.61.172])
 by smtp.gmail.com with ESMTPSA id 196sm22186871itu.33.2019.01.03.11.23.09
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Jan 2019 11:23:09 -0800 (PST)
Date: Thu, 3 Jan 2019 13:23:09 -0600
From: Rob Herring <robh@kernel.org>
To: qii wang <qii.wang@mediatek.com>
Subject: Re: [PATCH 5/6] dt-bindings: i2c: Add Mediatek MT8183 i2c binding
Message-ID: <20190103192309.GA18564@bogus>
References: <1545397111-24183-1-git-send-email-qii.wang@mediatek.com>
 <1545397111-24183-6-git-send-email-qii.wang@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1545397111-24183-6-git-send-email-qii.wang@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_112311_961648_2F948330 
X-CRM114-Status: UNSURE (   9.95  )
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
Cc: devicetree@vger.kernel.org, ryder.lee@mediatek.com, qii.wang@mediatek.com,
 srv_heupstream@mediatek.com, wsa@the-dreams.de, leilk.liu@mediatek.com,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 21 Dec 2018 20:58:30 +0800, qii wang wrote:
> Add MT8183 i2c binding to binding file. Compare to 2712 i2c
> controller, MT8183 has different registers, offsets, clock,
> and multi-user function.
> 
> Signed-off-by: qii wang <qii.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-mtk.txt |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
