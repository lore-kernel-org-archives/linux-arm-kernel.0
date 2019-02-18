Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD64C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:05:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A60D217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SCIaekKd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A60D217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JZEksPWX2IVNKrZzZXcJXWWhtB77qtHaiAb4rZzLbyM=; b=SCIaekKdX3jmIo
	nTvGSC13gFaumTh8pZ2OAfTZV6l8/vsZi6+iDbGoDbg+ECWcY2fFSMNWu1EvoPgfn3EoVD96qZHko
	dFZ+Aggz7arxhQTuKGvTjmpwDxBXDlcMqq86XnH96Qa2oIWXFxs8lcXX82tuT5TEpSBqaIb2fMdbY
	ZWn9K7+t248OqmWMDHq5zIXu0wP4YfYfyK14YAMEnRDAPelyYv6kohims4ilxeHWpOb6Ustcg68R6
	lnLl7nMYc1XypenN/EvvExX1LnY6YiSIfQsyCVrSQnPc//Aos0ykZZn8Ni9dKKg3CpXYbwvyL+/oi
	n9L5yAjxEZG6MQ/GeBAw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvp9r-0007Ha-KW; Mon, 18 Feb 2019 20:04:55 +0000
Received: from mail-ot1-f67.google.com ([209.85.210.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvp9o-0007HB-BC
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 20:04:53 +0000
Received: by mail-ot1-f67.google.com with SMTP id n71so30307039ota.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 12:04:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=B+x2incSj0C+DkTX95+6ke3OKgtXf3toGQqasEk4wj0=;
 b=KhGQ+FQv0R4g7s05lAqkWjRh95pC1Nict/YHd+lDstq1az2FXiwe0EokS/Jz33PHJ2
 DoLHXkC08p/hl0gXv33vpjCCVMwHedExqW9y9pRe8DxCGe01D0embl2/D2IRONfBwASp
 2fyJc2iYJsg2syKOGGo9GAY7CNNknqrn2BmFoAxZDzTNm9hoc9wRjS1OW8itUNSe/mn6
 07f0iPf58kMVD9/Hw5O2JZCb5D0kW/+4TeXdDYs7e/yve6nmMjurNkJ4jm0/nMHF5Xvl
 1KyDWNEo5syF4om6wFcqYx8yumHl+eQs0IpAJys6b6BYXsY0p8PkSJ06rd6uNcEjFxL9
 f1Kw==
X-Gm-Message-State: AHQUAuYu6ZiCNguj2i5DNSrYimvBBktUyJYDUV7lF8tpsXdrNQnGbBpW
 vdoxE+R3tfB6S1MXxPJjTQ==
X-Google-Smtp-Source: AHgI3IaeCnhJ+xDVtm0C4DG88T1M6FFfqfTSOqkVbUM6H7bpEzeTS8bkg0x3DQnpzVVrVUgjqvYdSw==
X-Received: by 2002:aca:3506:: with SMTP id c6mr343700oia.65.1550520291652;
 Mon, 18 Feb 2019 12:04:51 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id 88sm2909281otx.57.2019.02.18.12.04.50
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 18 Feb 2019 12:04:51 -0800 (PST)
Date: Mon, 18 Feb 2019 14:04:50 -0600
From: Rob Herring <robh@kernel.org>
To: Claudiu.Beznea@microchip.com
Subject: Re: [PATCH v2 3/3] dt-bindings: clk: at91: add bindings for
 SAM9X60's  slow clock controller
Message-ID: <20190218200450.GA3545@bogus>
References: <1550146447-1441-1-git-send-email-claudiu.beznea@microchip.com>
 <1550146447-1441-4-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550146447-1441-4-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_120452_378145_431EF46C 
X-CRM114-Status: GOOD (  11.48  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alexandre.belloni@bootlin.com, sboyd@kernel.org, mturquette@baylibre.com,
 linux-kernel@vger.kernel.org, Ludovic.Desroches@microchip.com,
 robh+dt@kernel.org, Claudiu.Beznea@microchip.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 14 Feb 2019 12:14:36 +0000, <Claudiu.Beznea@microchip.com> wrote:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> Add bindings for SAM9X60's slow clock controller.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/clock/at91-clock.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
