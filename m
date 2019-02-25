Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CB7C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:03:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE47620842
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ma7wuwHv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE47620842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=081534Hj3DP/j6TyPN5PJvsxEbH8WT+YqwrhRWAM7d4=; b=ma7wuwHvj7OAec
	NrvPfDUpC6lsd2SsmP83JAMZlMnyGKUqHS7lgvePGctyhILr5vcReX/NoTFECK73wvsl/g0XxHiug
	ZQk7OH89Ayf/berEddoI/V1AMS20zONySUs7RCrzoMuSHzOhiETQ7oGENFHUd2lKxAl+8B+4oKDkX
	2MCKgVsmFIVJwtW6HxNZZOWD7xDV+Sml418VWeVCIQ+Tvy26zNw3lUQjcrUpXrbjx3cgqMoknY1uK
	bITndh7QcHFVDjt+i3AjcT3/o6hTjtN3poppOm7mUIjlsX3FdN0Zs7N8szXQOwV3EclbIO36O8Tr0
	SnrShzXqP/PoXbjLx5iw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyIit-0007rn-0J; Mon, 25 Feb 2019 16:03:19 +0000
Received: from mail-oi1-f196.google.com ([209.85.167.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyIip-0007rB-Pz; Mon, 25 Feb 2019 16:03:17 +0000
Received: by mail-oi1-f196.google.com with SMTP id q81so7660142oic.5;
 Mon, 25 Feb 2019 08:03:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=IujadDX2hF7f9HNLL7DzRWQPwH7CfDha+opQqkLdPAc=;
 b=lMXlWpsHBYIfmh1wfbnXXyl+hD3m8Vu8WmjN3/t6Qm9d73ZxxB/pPYmgXjfooAKqSk
 Yjz3g/g1notRIcuZC00Bryb0S6ObLMKN9JULKzYLp2Hz+AqYjyK4uheEIxmAZNGi/7TW
 /Jrj+vUrSXp7Nxu7P8l9vThB8dhOtpG+UYYXT/lyz3u+tZTtEEKWWTt/vFXMU7sLwB4L
 YTNqS0YhESx8AH9Ewo0DTFQXsbm+jL0PK+pBjj5Mq1uMimXlVtxAoOxjL1GTCe10p+/H
 FYGpn0/rhM9jdc9q32uLtvt1+frZ6DFgdF9TEVo8CDXEaSR5Wb9kzfIxHB2kGpt4T6Ql
 rrFA==
X-Gm-Message-State: AHQUAuZ4kw00IEFOhFBdlzNKujVyRkNX13jK7S4LurTxllrN62uGLB8l
 PlI/N50hXfcWlpXn6JG46Q==
X-Google-Smtp-Source: AHgI3IYPiSgnm1Ub3cRYaKNgR2GGGuHos+fCTz3fcyuyNE+daJ4Hc7p5pHsSFMmZxHOB/Hu3xuaLqA==
X-Received: by 2002:aca:6043:: with SMTP id u64mr10983757oib.32.1551110594611; 
 Mon, 25 Feb 2019 08:03:14 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id z6sm4121916otq.68.2019.02.25.08.03.13
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 25 Feb 2019 08:03:14 -0800 (PST)
Date: Mon, 25 Feb 2019 10:03:13 -0600
From: Rob Herring <robh@kernel.org>
To: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Subject: Re: [PATCH 3/6] regulator: Add document for MT6358 regulator
Message-ID: <20190225160313.GA29745@bogus>
References: <1548839891-20932-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1548839891-20932-4-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1548839891-20932-4-git-send-email-hsin-hsiung.wang@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_080315_838718_B9352B46 
X-CRM114-Status: GOOD (  10.19  )
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
 srv_heupstream@mediatek.com, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Lee Jones <lee.jones@linaro.org>,
 Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 30 Jan 2019 17:18:08 +0800, Hsin-Hsiung Wang wrote:
> add dt-binding document for MediaTek MT6358 PMIC
> 
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> ---
>  .../bindings/regulator/mt6358-regulator.txt        | 318 +++++++++++++++++++++
>  1 file changed, 318 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mt6358-regulator.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
