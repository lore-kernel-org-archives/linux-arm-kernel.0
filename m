Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B70C31680
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:10:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A9B720879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KwqsvnIj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A9B720879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hmvd9+iL0BWvRgot1r2odudQP93810kgct0s0x2A52M=; b=KwqsvnIjOesIxR
	LhFGcGmIuk53QPdUlX6IBe6Zgn9thKGKsgwtyyEyNeVduep2kktgPippsMxBkALnwu+Y5/J4p02xv
	/lK94eRNNxLKE1JT+aBEy3f9R7QPFCqQZUXlT+knum7dpk8P0DGQg5Lp0rHA4rl0UIH8CvY2ipLGP
	E9v/jBMzFRQJlgwyXLdQ91YrvPyCCGsvg97e7R4sdaBZkOCJoRM4bvGEbbkDfLSskIfxyO+Q/3Ubd
	8qG8OpiibZWGXJO4v77v6VKZxdISY0tWfZX2ukelbUzUh6b2wZwTLDq2sXsXINV/CCFE5di3cJRip
	h5OHQiQ0IhnqYtSU/dPg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gld5i-0007w1-Fe; Mon, 21 Jan 2019 17:10:30 +0000
Received: from mail-oi1-f194.google.com ([209.85.167.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gld5Z-0007tE-Bt; Mon, 21 Jan 2019 17:10:27 +0000
Received: by mail-oi1-f194.google.com with SMTP id v6so15119546oif.2;
 Mon, 21 Jan 2019 09:10:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=LQZ0RN34D2hW12PR3UPXkOMhkhpjo0tL1Zas8kCCPco=;
 b=AkVGvGaaf3gho2sgDag0Aex+T1cykQtRDgIIM6Ie5v17J9xYnIxCGbyTKCLw1zNEMC
 Kaj0Eyjy9vQxdqKm+1r1mzI3/KB/+Lw6FJid2UqacgnDiaaOtVp4vNhi9URWEQ44NYKj
 4s+6bQZyM/Rqmm68pQUqhMVP8OVDBBbAT+FllkLBolTuAtCn9noioEFQJl6cSy1C+AuW
 yN3iwi9SBHTpQ8WKOpI8m0xoul7Mofh/R69hSlA98NxLf4UqRNFgZlJO5I1bMfn7bwc3
 cB+hX2Uk2huN82CG0A+2+f+sctPeF/JyVIK4QyE5AxnUZZUxvBM7KUTFuB1M8VMIN6CH
 XGlw==
X-Gm-Message-State: AJcUukfOJZbWeSJLjfBthNIW2v0u/T8PwEvK1dbW9D3J4Rua8bqRV4PD
 sxfkSgbSWJLah3uO0q1ziw==
X-Google-Smtp-Source: ALg8bN6vlKKmgSljeMVxbOa2VFpltgrb28B5/EXX8WtrovBjZqgkEA0Pz3WFpXGzoUyVaZ71ts4u2Q==
X-Received: by 2002:aca:5241:: with SMTP id g62mr3103336oib.354.1548090620362; 
 Mon, 21 Jan 2019 09:10:20 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id v1sm5775452otq.80.2019.01.21.09.10.19
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 21 Jan 2019 09:10:19 -0800 (PST)
Date: Mon, 21 Jan 2019 11:10:19 -0600
From: Rob Herring <robh@kernel.org>
To: Loys Ollivier <lollivier@baylibre.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: gnss: add mediatek binding
Message-ID: <20190121171019.GA2903@bogus>
References: <1547744074-28308-1-git-send-email-lollivier@baylibre.com>
 <1547744074-28308-3-git-send-email-lollivier@baylibre.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547744074-28308-3-git-send-email-lollivier@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_091025_772138_BAAE79C3 
X-CRM114-Status: GOOD (  10.81  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Kevin Hilman <khilman@baylibre.com>, Loys Ollivier <lollivier@baylibre.com>,
 Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 17 Jan 2019 17:54:32 +0100, Loys Ollivier wrote:
> Add binding for Mediatek-based GNSS receivers.
> 
> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
> ---
> 
> v2:
> Renamed bindings from Globaltop/gtop to Mediatek/mtk.
> Moved current-speed as an optional propertie.
> Removed the status line in the example.
> Added "mediatek,mt3339" compatible.
> 
>  .../devicetree/bindings/gnss/mediatek.txt          | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gnss/mediatek.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
