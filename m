Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12A7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:30:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD41C218C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oZ1/Cagc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD41C218C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ATZjUYf/Xm5d4PSjAIokVm9lH3mNy/i9SFk2QbnP5pY=; b=oZ1/CagcEyjTds
	/2PChoBdxtEOo+yaHl7TslKXDlQdUzkmjLrLmVtWPIG82WDPl16pNUc2DYTGJ8vYclYGRGQqarsdd
	tu2BFQz+gJVoNfnLQ7J9yyFmIb6RdXMOjIAqty35Ieyl+GvyWGAQhb7gJ5YvMAxjEaUZRWFSQcQWB
	4nl6OZIu+wgYVbZfpdVMhndACpUVuJo9FiD7tsVGjA1+174WmZpn0vQOxXQSsge9QV3QEzzxA9dpN
	halCViVP2Jz0USx70ljkL78ZvHQLiKnvQ/b3ud4opq4lVqqyuNJwHg/5IKMnUVma+7lTgyxcfBTK3
	vxheDSjzN4qFBDXpnPpQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi2VQ-0006wl-9c; Fri, 11 Jan 2019 19:30:12 +0000
Received: from mail-oi1-f193.google.com ([209.85.167.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi2VJ-0005uM-2g; Fri, 11 Jan 2019 19:30:10 +0000
Received: by mail-oi1-f193.google.com with SMTP id r62so13152413oie.1;
 Fri, 11 Jan 2019 11:30:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=8c0Cd9SOEjMucxUgr1cK7o0spBsIvwNckk4Oy28C5lI=;
 b=Ccf0t418sVDTKpWjizpDaCuehJcpzu92oCl/xPvlZUiFSayXQ7NE/elOrdj0OQU0cA
 nLzM91UrIJ5JV38sZDWA9tZLPaa+xHpQDBNaXnve12p9McG8YYKi6M6hvruIEZSG/VkN
 vkMcCY9xUu50OQ/2HdMcagGfX3zascn79FemBkxtvqtGzKUYyAe59Twdl/s6uYlciM6U
 T9UzoO3XWYyzu3eiH1mxbIarWixq0JYDrWNypUAS9EYE1Vo0RMRtLSIHMgXCY2DQHLr3
 3MFTe+TNcuyPeYd76j0IbQ7xWZXO3AVS7bnZOkHA9iddzyG/rq6IHXc9zE1Gc46xihZY
 TRHQ==
X-Gm-Message-State: AJcUuke5ydyLXNo7cOcCSUi/KK23hm9SaXfQ5NbIqUl3sq7NnN8MQ9um
 26ITOFphAb4G+2noVuWjGQ==
X-Google-Smtp-Source: ALg8bN4aD2psTbop+nJFCIp6EGeA7Nih3kgQ7KPHL/VjW6kqRp1Sfq9RC0C0xCae3bHA5zHvpYMDVg==
X-Received: by 2002:aca:f44c:: with SMTP id s73mr10507571oih.102.1547235003963; 
 Fri, 11 Jan 2019 11:30:03 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id u65sm31698804oib.5.2019.01.11.11.30.03
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 11 Jan 2019 11:30:03 -0800 (PST)
Date: Fri, 11 Jan 2019 13:30:02 -0600
From: Rob Herring <robh@kernel.org>
To: Yunfei Dong <yunfei.dong@mediatek.com>
Subject: Re: [PATCH v2,1/3] media: dt-bindings: media: add 'assigned-clocks'
 to vcodec examples
Message-ID: <20190111193002.GA19308@bogus>
References: <1546571161-11470-1-git-send-email-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1546571161-11470-1-git-send-email-yunfei.dong@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_113005_162039_2D8904B6 
X-CRM114-Status: UNSURE (   9.87  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
 Tiffany Lin <tiffany.lin@mediatek.com>, devicetree@vger.kernel.org,
 Yunfei Dong <yunfei.dong@mediatek.com>, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, Qianqian Yan <qianqian.yan@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 4 Jan 2019 11:05:59 +0800, Yunfei Dong wrote:
> Fix MTK binding document for MT8173 dtsi changed in order
> to use standard CCF interface.
> MT8173 SoC from Mediatek.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> Signed-off-by: Qianqian Yan <qianqian.yan@mediatek.com>
> ---
> change note:
> v2: modify subject
> ---
>  .../devicetree/bindings/media/mediatek-vcodec.txt   | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
