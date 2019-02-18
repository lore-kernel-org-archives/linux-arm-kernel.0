Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DA7C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:12:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8D3B218FC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lqROjVQe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8D3B218FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=P4YKiHmSmzel5qHV7CbOY5LcTpiWLRcP9fpPlSYDfoI=; b=lqROjVQeMnVxmn
	AHvTfJhlXPRhi9Enll34pgQPL588DdVYW90dm4qelBIK/aZdtw5svovdnkObwk1xPQR7v/0AMsUaz
	zXq9NYbW/lrQD2R5xgKMqPoGUDRYVQR0yZeq9bM4q71iILIS7WU1SjogCFLu/+WRkr+U/JAWDds96
	CpFw9wynysgYpOjIspLhx0XYLPXErRPPxK4PIW+J/Emg7xFvQnqETBTNME+SS4Bmi6Xy8CAKcKcMD
	+EvFReyXP5uN6b114+hS+GUxXHgcE9CEnQ/HMFanpEwJ5JIGpVoPHz/HTe/bri1L/hdCz5P106f4a
	TluNrjFe+7DCz7inJfYw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvqDQ-0001te-JU; Mon, 18 Feb 2019 21:12:40 +0000
Received: from mail-ot1-f67.google.com ([209.85.210.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvqDN-0001tI-Im
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 21:12:38 +0000
Received: by mail-ot1-f67.google.com with SMTP id c18so9064127otl.13
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 13:12:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=belrf9S1ZRx9yo0wr3HYzIUiLBsZIziEnB/8D0iwtAc=;
 b=bsjTbsnv+nqGDHaPQdzIbPYpV6pFG7aJwZOiYMns2KE305Xk8U5IeKrMnuH0j3lXev
 VOq1Q3qUROphs0ChDdg82D6lFRyAxRa16PciQO9cYJ/U5rc1gdwvq0DQ6Gr/vygCrfey
 EFufub8lbXHuLjW1vj0fwghPfzXeRe5QMri0r/oE3f2zp+O22nNhU16toGO9ztwa6Jd7
 RuGK5805rLk4SvxCc+/4JihmPJN4105WcXPNKNBsvQHmNTy+Szjncw20lMOE/fwh2zEn
 kNLahc+mtHtCQKUKlgcHCRRuZ8W9xtgU8Oz++BKVflX/pmdFq5+a+SJ8dkpcY3jCWzEr
 Lm4A==
X-Gm-Message-State: AHQUAubrx7PJ+1AILfGb+6jiUh4ysL1Lq3flHDmalPYlXnm9N1+NPqaM
 60WOGPy+UmHyyxCGCkTF7Q==
X-Google-Smtp-Source: AHgI3IZhb5LhrgIgI9QpoFlcozLFQh2H8yTUBg57KQdiTyuyJbXVDwvI1+O2AWQFoa8xzhgXAyHVvw==
X-Received: by 2002:aca:4d53:: with SMTP id a80mr534949oib.154.1550524356636; 
 Mon, 18 Feb 2019 13:12:36 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id i5sm6513068oia.46.2019.02.18.13.12.35
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 18 Feb 2019 13:12:35 -0800 (PST)
Date: Mon, 18 Feb 2019 15:12:35 -0600
From: Rob Herring <robh@kernel.org>
To: Claudiu.Beznea@microchip.com
Subject: Re: [PATCH 4/4] pwm: atmel: add PWM binding for SAM9X60
Message-ID: <20190218211235.GA17147@bogus>
References: <1548073783-22640-1-git-send-email-claudiu.beznea@microchip.com>
 <1548073783-22640-5-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1548073783-22640-5-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_131237_673302_CF2C5876 
X-CRM114-Status: GOOD (  11.29  )
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
Cc: mark.rutland@arm.com, linux-pwm@vger.kernel.org,
 alexandre.belloni@bootlin.com, devicetree@vger.kernel.org, robh+dt@kernel.org,
 linux-kernel@vger.kernel.org, Ludovic.Desroches@microchip.com,
 thierry.reding@gmail.com, Claudiu.Beznea@microchip.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 21 Jan 2019 12:31:01 +0000, <Claudiu.Beznea@microchip.com> wrote:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> Add PWM binding for SAM9X60 SoC.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/pwm/atmel-pwm.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
