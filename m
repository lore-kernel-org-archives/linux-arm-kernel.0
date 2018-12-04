Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0A7C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:47:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B956C2081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BNiboaA4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B956C2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ay9UqwXytVFp6UMpT2FozRVOVmqwG61GET3IFonc+DA=; b=BNiboaA4LR0ep2
	9wKyrtRrZBZzCu3rj9GAi6TOwmhl5C9jhgoyE9J0LW7rPDndD7R+dLLevnUrXPECWJZ3CGP9t7/Zx
	V7R0jgQ795ypuXtOaN/q9RDh9DE5R5tQLFj7nld/Ow2+lQDr+/hgXEwDq0DPMLq7jYbqvZD25HNl8
	ksYWIYqSYd3dO0gEDm447NB5/lss1dt5g1dMGG0G5ttXMIw2dPHDI4T8HwwWtuNIp11a0BFbKbIvP
	+UD18dwanoQH7ZxrMa/emW1J8i4h+Ea8amf7XaXvCb/BhUv2H/OrvqxDcnNc4KIGYg4t5z9srsJ5f
	KRIvG729+Ufr02EbN5YQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUHbh-0003Fz-3M; Tue, 04 Dec 2018 20:47:49 +0000
Received: from mail-ot1-f67.google.com ([209.85.210.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUHbe-00033O-4r
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 20:47:48 +0000
Received: by mail-ot1-f67.google.com with SMTP id 32so16489973ota.12
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 12:47:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=fSCTz2xKuBHtxh7ywbeEpAbuSj2luDE0z7e4Lo4D3oo=;
 b=U0sUg7WOz0f9Jq2DdrMvUqQehdeW3Ou132R7xjeejEKeGb6EAxl8PoMRDNga5GcxHP
 H+8Tt1oHKIfXMWIiitLNn7J5CyRRv6DV++lrFiLQA6kuJB0W7AQYVpJJzvbrj6kI0U7w
 66/14hH30pXOXp8o7JotWdEQG2nCfp0X3gUYrshwUX1nP08S/Q6eOdBct+DPa5j5RN6m
 cacUF7rNYguq47tUKE8WxE+YTMtT+xsSN8gbRD3TDdsI7/C2OhvMy7du3D/sg0ozOIoz
 oxQgPhS6J00Fcs6Y1V52M6JOgQtNTnRqU7qOw6f+bf9+DWFnjsv1bfFLW8y7meLo1HBZ
 DdYg==
X-Gm-Message-State: AA+aEWZg/Qgqcf6kEkS3/gdoR/1MQ1dI0GwUye9gkFC5yEMCXI7DbYRi
 Slah6c2bCk5eHSq/vpqJ3Q==
X-Google-Smtp-Source: AFSGD/ULXByF7L8ViLYHXoCjDMyJiyl9bTEEBiVBiEtTVkmlYjUnQRw5l+SU5bILz2rpxfKNkuIefg==
X-Received: by 2002:a9d:784a:: with SMTP id c10mr14300244otm.175.1543956455141; 
 Tue, 04 Dec 2018 12:47:35 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id 52sm32258734oti.30.2018.12.04.12.47.34
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 04 Dec 2018 12:47:34 -0800 (PST)
Date: Tue, 4 Dec 2018 14:47:33 -0600
From: Rob Herring <robh@kernel.org>
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Subject: Re: [PATCH 1/3] dt-bindings: interrupt-controller: stm32: Document
 hwlock properties
Message-ID: <20181204204733.GA14508@bogus>
References: <20181113144805.1054-1-benjamin.gaignard@st.com>
 <20181113144805.1054-2-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181113144805.1054-2-benjamin.gaignard@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_124746_237537_330AC114 
X-CRM114-Status: GOOD (  14.92  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, jason@lakedaemon.net,
 marc.zyngier@arm.com, linux-kernel@vger.kernel.org,
 Benjamin Gaignard <benjamin.gaignard@st.com>, tglx@linutronix.de,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org,
 alexandre.torgue@st.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Nov 13, 2018 at 03:48:03PM +0100, Benjamin Gaignard wrote:
> Add hwlocks as optional property
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>

Should be linaro.org S-o-b?

> ---
>  .../devicetree/bindings/interrupt-controller/st,stm32-exti.txt        | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt b/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt
> index 6a36bf66d932..cd01b2292ec6 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt
> +++ b/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt
> @@ -14,6 +14,10 @@ Required properties:
>    (only needed for exti controller with multiple exti under
>    same parent interrupt: st,stm32-exti and st,stm32h7-exti)
>  
> +Optional properties:
> +
> +- hwlocks: reference to a phandle of a hardware spinlock provider node.
> +
>  Example:
>  
>  exti: interrupt-controller@40013c00 {
> -- 
> 2.15.0
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
