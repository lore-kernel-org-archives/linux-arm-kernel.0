Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7A6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:34:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80ED12184C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CvdzWMCs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80ED12184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5yCb5qgO0OsHSlRtUV3AbZ2f4uq0mHY7buBMCGJdXOc=; b=CvdzWMCsYGBLpG
	bjRIoJcfHQAmlYDkB7m+/BBpPtRzkUBucx9J8lu5ZCK/C46E/t5NwGi/BTX5u+Vj0sT01TicBDmZB
	fmbBF/LuZt9tXUaaMxCncbCI80kz/Q8F4UmehQyc0D2+NFU9PMadC+er6y3Mp29wBt8bMcaH3LksY
	5ffxwCzZHDc87AvWtMHwe+6MYfD4hfxkWcZOx36mT+ivIhbtcrMweyrmm53XVKncSy7BbpQM15Y7Q
	0qv6K59R85aC1nRAXhCqasutb7FLeDsuVYXIwIYmsmPgqUaZ1mFNGSctTnPp+3uERKacIsQ551Az+
	7A7IG9OC9N+MpPC44vnw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZNwZ-0004Db-D6; Tue, 18 Dec 2018 22:34:27 +0000
Received: from mail-ot1-f68.google.com ([209.85.210.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZNwW-0004Be-Kg
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 22:34:25 +0000
Received: by mail-ot1-f68.google.com with SMTP id e12so17321233otl.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 14:34:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=dYd+lErnFsPlAbocOmOvetKu/YmEk1zn+9MT7xtM1p4=;
 b=XoXo+sw3fD53+xse/rX9AGKXQGOOeXTwDR/7HpittfZl2zCGRaldNIA5DRqz/kFa4g
 bTjAtF/Zu6NIJoYd6VCAYJg7u7JFNuIKLMTN/qVoBYn2Ar7LzhAe5f4R/BDgppF42u19
 GVFxlwvPaHqn1Jl1TQ+RFOTNfYaaC6VRuQ2M0ThXMR9jxX179pfwRDc5ObmIALORqeMa
 XVD31MfpvFimSURtoIWoYOOaCam/gN5AozXvg0pUA/X4WhbXk3aNmbYdBucJqR9BU6L5
 4WRjRzbPcqgRUpRTseGoOywbwy9DUA2Iqg9kGGI8iWBUB8k+itw4beSTl87fwiKnXBAw
 fPHA==
X-Gm-Message-State: AA+aEWZzyKDk7OnekGh7mVjoVcznM2Im5tKdlycPS1ZzgEzOZ3cRW3oJ
 kcstTki1E1w9TtxKAlxM0w==
X-Google-Smtp-Source: AFSGD/WaVyPChMJ02PG9CRr1qeyyEjLuXGtEZAFGxWA0lqR1Z2DyTQvG5xzMdwOQZQdW+rZm9+de3w==
X-Received: by 2002:a9d:7a8c:: with SMTP id l12mr11751408otn.335.1545172452956; 
 Tue, 18 Dec 2018 14:34:12 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id a201sm9558754oii.27.2018.12.18.14.34.12
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 18 Dec 2018 14:34:12 -0800 (PST)
Date: Tue, 18 Dec 2018 16:34:11 -0600
From: Rob Herring <robh@kernel.org>
To: Jordan Crouse <jcrouse@codeaurora.org>
Subject: Re: [PATCH v7 5/6] dt-bindings: drm/msm/a6xx: Document GMU and
 update GPU bindings
Message-ID: <20181218223411.GA12855@bogus>
References: <20181218183241.12830-1-jcrouse@codeaurora.org>
 <20181218183241.12830-6-jcrouse@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181218183241.12830-6-jcrouse@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_143424_671554_DE4F5815 
X-CRM114-Status: GOOD (  12.84  )
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
Cc: nm@ti.com, devicetree@vger.kernel.org, rnayak@codeaurora.org,
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, dianders@chromium.org,
 dri-devel@lists.freedesktop.org, vireshk@kernel.org,
 freedreno@lists.freedesktop.org, georgi.djakov@linaro.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 18 Dec 2018 11:32:40 -0700, Jordan Crouse wrote:
> Update the GPU bindings and document the new bindings for the GMU
> device found with Adreno a6xx targets.
> 
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
> 
> v7: Updated the GMU compatible string and clarified details about when clocks
> can be optional on the GPU
> 
>  .../devicetree/bindings/display/msm/gmu.txt   | 59 +++++++++++++++++++
>  .../devicetree/bindings/display/msm/gpu.txt   | 42 ++++++++++++-
>  2 files changed, 98 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/msm/gmu.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
