Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA0EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:27:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F1E120842
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eEV3IBo+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F1E120842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5qXZsPXmSz3Gmo8eud3cE+JzXwzkMHvpLa0Kh2Olhxw=; b=eEV3IBo+gAUYRZ
	aCUerLAjZc0IkZJiQy4xMvsBZGHUWljrRTpJTND6LRLUCnkV+6yjrONtty3UV2NOdAdPeAsvF4CUR
	edYfEyIBOZbvenwApH6H6OOj+vPut+Lq2wSSbETGbbXLIA6YR/HEzON+SuP+7x8fsfVdZMGEE+KdJ
	l79g+f2xdMp81WVqrZB717PK9Zr/ZJCtX8MY6yjcwGz4kM8E9WjWtlISb3zxiekaui3kiIKj46bz6
	52TNB882CEuhOPdP3KRZ5nKQ6LuUYvgZy4h2khcZy8aUu6sh+Wxt4ApO7bMiRLcXAJJ9T/Ar+38N6
	CPOQytmlqDXk5HKNH6Cw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyHE4-0002Sk-C3; Mon, 25 Feb 2019 14:27:24 +0000
Received: from mail-oi1-f193.google.com ([209.85.167.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyHE0-0002SQ-Hv
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 14:27:21 +0000
Received: by mail-oi1-f193.google.com with SMTP id w66so7376910oia.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 06:27:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ihiU+3n7h/gaAsQlqiSrq+3amM5GIY0eWEX29/lDcjQ=;
 b=U5Gju6o08XAXyJvl3rsYp5n8V3Mm9KCi2X3l4PqHIF9U4dGsiCPiznrZfbjt+iMUt9
 lfkjJnL1KlmGsDYIbfDSsddWZ59Hl68t7Xl3HIzZk8OECZjtFx/Mt6H8pELug/ht4Tcw
 mREUImQM7H2YZbmqlHoG0TKpivzRZmMUmrq/D/+StczJwRiKOvYfuf/Vu6sSDb01q2qs
 xJiZjUtw7MB8g97NTf0RB6gCmIz+qzJjzsmdavH52OqLPud8YKnfgb1qKl6qMJJO3LpN
 AR7jNOHRNLvDNjStwWSBYN3zQbL1tfadYmsbgaDKreVL5i9cBMAu0P87Pam21sXGyeuQ
 j5Xg==
X-Gm-Message-State: AHQUAuYOYaEFhr2Ybtgzp8OceBcPzmsB4pZLj9xzOVpLjqaJIJPAsIHj
 8Fs5Ce18iS3qUmgBIo82XA==
X-Google-Smtp-Source: AHgI3IZ6apreZ78o4sLjGiIC8bpimsbT4Nk/ecvVgZFMtigSXkVkYd4tNgh+HzDxUvGtx6aZEV80Ng==
X-Received: by 2002:aca:a90f:: with SMTP id s15mr11456206oie.42.1551104839108; 
 Mon, 25 Feb 2019 06:27:19 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id 3sm1335113ots.75.2019.02.25.06.27.18
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 25 Feb 2019 06:27:18 -0800 (PST)
Date: Mon, 25 Feb 2019 08:27:17 -0600
From: Rob Herring <robh@kernel.org>
To: Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH 1/6] dt-bindings: media: cedrus: Add H6 compatible
Message-ID: <20190225142717.GA27983@bogus>
References: <20190128205504.11225-1-jernej.skrabec@siol.net>
 <20190128205504.11225-2-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190128205504.11225-2-jernej.skrabec@siol.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_062720_593258_93EB07D5 
X-CRM114-Status: GOOD (  13.43  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, maxime.ripard@bootlin.com,
 linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org, wens@csie.org,
 robh+dt@kernel.org, mchehab@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 28 Jan 2019 21:54:59 +0100, Jernej Skrabec wrote:
> This adds a compatible for H6. H6 VPU supports 10-bit HEVC decoding and
> additional AFBC output format for HEVC.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  Documentation/devicetree/bindings/media/cedrus.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
