Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668DDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:09:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2086C20652
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n02fWLr7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2086C20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8DH2Gaqfu6m0RXsIeHyBdazimcXtKewtILzy339jnCo=; b=n02fWLr79MevLD
	oQY5rPje6EcDR3g9ZO69EwGuMXNV3YWRwzN8Y8N1XyIC4UnqOrWsjrr7IUQYoVpa4D73Fm+i3A/tX
	k5QJ+WWEz1KpPkN9nW4uMWewVVwLjJgGxx94cPSTFv3rFnofYKRwN/8YdBZl0K6qH81MhkBcU7jiD
	hfp1ZlZpmuf9bLXc0MmOmRs/6QiwIDbdS0q+c1V9nRuCIdOnpL3fit4dxJpSh+AWyQri4+GMZlUm/
	2N2XS/LkQIsjNBgZ9ajobBTlRH2RNx/z6VdHxANW2tISrT22FKXpZ2ZE2fO+B72I2yDXHUhN5cBIm
	w7XN6rAOsShEOiPT+FaA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjsRD-0005rY-Qb; Wed, 16 Jan 2019 21:09:27 +0000
Received: from mail-ot1-f67.google.com ([209.85.210.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjsRB-0005rC-2d
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 21:09:26 +0000
Received: by mail-ot1-f67.google.com with SMTP id f18so9073788otl.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 13:09:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=gDr/MNAhN9HZwjVOmfxhxRD6SUqMvqJOtw/ZofLvTLk=;
 b=rluX8+l897YPPDwCEQjOX3jowL8pgwzBgRLaoU5zEvjv8ry2yUeLUcIMLjpiFJkOMh
 lC6kWPvz+KbV5zGfph784Win7ezq3PnaLXVUDMxpi4oult3/2aXqZjlxORJgU2d1PMC6
 Ul1xKXKaea1IdfHTI1jcXUb9RCH8PHAyNSxxkgCPiWkslJM8/wDilCCPZYv8X3e/V4qZ
 uzdo1l2M2d9bTYg+64jrj7T6kJWkNuQFHNja2TdhbZQdRnnquy/4fjt2veM/tjnJ6PBU
 vAgah6n4L4fMiOjLTzqBB8dwp+QSV50yF5R8dQmy/kr+wMKwvHbdKV6E1OY4942/4jtz
 wLyg==
X-Gm-Message-State: AJcUukf02iwNViasBdcnAqBpGStyoZKYGUnWfw2WsrSWc5qvfEkeZjlA
 LgBRFYL9pqpQ0KiR8vOuNQ==
X-Google-Smtp-Source: ALg8bN5KojRUvLn9E60Hy1A7AZoYE4wjdzgeoipx97zK9vXP937w4r+Q6hrOHFRcnPZSEApUaDyVfQ==
X-Received: by 2002:a9d:1eea:: with SMTP id n97mr6443439otn.248.1547672964049; 
 Wed, 16 Jan 2019 13:09:24 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id h16sm2991561otl.29.2019.01.16.13.09.23
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 16 Jan 2019 13:09:23 -0800 (PST)
Date: Wed, 16 Jan 2019 15:09:22 -0600
From: Rob Herring <robh@kernel.org>
To: Eugen.Hristev@microchip.com
Subject: Re: [PATCH v2 2/3] dt-bindings: drm/panel: simple: add support for
 PDA  91-00156-A0
Message-ID: <20190116210922.GA24880@bogus>
References: <1547458584-29548-1-git-send-email-eugen.hristev@microchip.com>
 <1547458584-29548-3-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547458584-29548-3-git-send-email-eugen.hristev@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_130925_121879_F3C86590 
X-CRM114-Status: GOOD (  12.05  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, airlied@linux.ie,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 robh+dt@kernel.org, thierry.reding@gmail.com, Cristian.Birsan@microchip.com,
 Eugen.Hristev@microchip.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 14 Jan 2019 09:43:28 +0000, <Eugen.Hristev@microchip.com> wrote:
> From: Cristian Birsan <cristian.birsan@microchip.com>
> 
> PDA 91-00156-A0 5.0 is a 5.0" WVGA TFT LCD panel.
> This panel with backlight is found in PDA 5" LCD screen (TM5000 series or
> AC320005-5).
> Adding Device Tree bindings for this panel.
> 
> Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
> [eugen.hristev@microchip.com]: specified backlight and supply bindings
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
> Changes in v2:
> - added binding explanations for required properties from simple-panel:
> backlight and power supply which are mandatory
> 
>  .../devicetree/bindings/display/panel/pda,91-00156-a0.txt  | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/pda,91-00156-a0.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
