Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0EFC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:40:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C2E420851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jOktDHgl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I8HHXaaw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C2E420851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JS54WefreXw4VprCXyqJY3/twMXt132yLVsZjRAsoyY=; b=jOktDHglaiNepC
	XSFYoKHG4IqVemhc45z8JLrUWX7iT1LkSuN4wWClsmx5vm/R2aAQg/CYphM8nv9dtsfTxUHLLy9iB
	m1x4nmZ4TMXC6kVATiYTj3cE3QBQpKSG4co0bbMcJosumoeC8EXwioimiH7QkSM2ze6nvp7bb39hm
	JHb0NoeUUY4LcE9vRXX0ps2+7gYGq2Hh/4+dePGvQBepG8B3ubnxSOmIkw5brP/0r8BaW11TLdMs6
	FpbvLDgYT7AQ0D7z3h0mE/HmGbjgzKZrMi2+tRqIbFPzsqkP48Jk61Z5nfFmVMjYoRIehhDQqj1iY
	Fxf3jJD5Dzdt+k4gYXeg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXVtr-0006Tu-DC; Thu, 13 Dec 2018 18:39:55 +0000
Received: from mail-ua1-x941.google.com ([2607:f8b0:4864:20::941])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXVtn-0006TS-2T
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 18:39:52 +0000
Received: by mail-ua1-x941.google.com with SMTP id d21so1068876uap.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 13 Dec 2018 10:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oSfMVDqZJ47lomyqLeIRmJ0S3d3Zt5v0Ew/Xgv+czUU=;
 b=I8HHXaawGriN/FkxqzO5eRrv58/pzZ5cEX9klMTd5HocKtIWy0ELiTqXJCQxPZvUwO
 YrXhPxkLe6rR9X4Yvrr5rLyZPSxiGQSvRJRJxXmfXrhFZbOaXhrs6wso0OFmau7F4OaI
 U2s7K4IbMy3+y74OyupjP7bs+icRogJhUMByI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oSfMVDqZJ47lomyqLeIRmJ0S3d3Zt5v0Ew/Xgv+czUU=;
 b=F+ClVYIPUA9djlUzJtYRMcOElc43DRHNYV+mpZvZuEtDV1sWK6ObckOa7UIvCdGgT+
 klGXYzDNWSdZJyY6gWAKXsf/uFrK3RYbygAj6RLJwTrKRL5VnGtglExcNYJ8pjc4zZbh
 irPkXT9P2xk1+Nv2CBUv5wLT88mU2BfFdRgCaQ9ATwQWUJLmLC1uPaZaMLDwzcc49cLT
 zOf6NyBM+t3iDxMVa8uh+SLBmn662nc4W2RNzlPw/d4gYN4TOoj/IWLpmOa7Myixbujg
 R/l6w/ae9obSLfambPY6W4PqAmWhXDCvnQG8MXQPo1zqQlLFN3lPIrPcEAZOCmNX6Tzf
 I3zg==
X-Gm-Message-State: AA+aEWa0HvUQNoGoOwHnxux9LTZv5iUzcCOBul/B7gOZMaKYJ6Iqccyh
 9jo594FppwbnK62jpU63esI7nijtGiI=
X-Google-Smtp-Source: AFSGD/UvWHrkb87LuGkfsskbdrC6ILenRwKPDfC5nc/OgwgE+E8CnW8X0vQM7Sm6DKnFzk9GmlGdKA==
X-Received: by 2002:ab0:30d8:: with SMTP id c24mr9362253uam.44.1544726379604; 
 Thu, 13 Dec 2018 10:39:39 -0800 (PST)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com.
 [209.85.217.49])
 by smtp.gmail.com with ESMTPSA id m79sm859964vka.22.2018.12.13.10.39.38
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Dec 2018 10:39:38 -0800 (PST)
Received: by mail-vs1-f49.google.com with SMTP id t17so1785212vsc.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 13 Dec 2018 10:39:38 -0800 (PST)
X-Received: by 2002:a67:da93:: with SMTP id w19mr772347vsj.144.1544726378379; 
 Thu, 13 Dec 2018 10:39:38 -0800 (PST)
MIME-Version: 1.0
References: <20181212211848.26768-1-jcrouse@codeaurora.org>
 <20181212211848.26768-2-jcrouse@codeaurora.org>
In-Reply-To: <20181212211848.26768-2-jcrouse@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 13 Dec 2018 10:39:27 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Vju=d4954gbXThhY7YemeBLKLcuDNwapd6tPgNPUHafw@mail.gmail.com>
Message-ID: <CAD=FV=Vju=d4954gbXThhY7YemeBLKLcuDNwapd6tPgNPUHafw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: drm/msm/a6xx: Document GMU and update
 GPU bindings
To: jcrouse@codeaurora.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_103951_113037_F1281DDF 
X-CRM114-Status: GOOD (  14.59  )
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
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
 Rajendra Nayak <rnayak@codeaurora.org>, linux-pm@vger.kernel.org,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, vireshk@kernel.org,
 freedreno <freedreno@lists.freedesktop.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Wed, Dec 12, 2018 at 1:18 PM Jordan Crouse <jcrouse@codeaurora.org> wrote:
> diff --git a/Documentation/devicetree/bindings/display/msm/gpu.txt b/Documentation/devicetree/bindings/display/msm/gpu.txt
> index 43fac0fe09bb..8d9415180c22 100644
> --- a/Documentation/devicetree/bindings/display/msm/gpu.txt
> +++ b/Documentation/devicetree/bindings/display/msm/gpu.txt
> @@ -8,14 +8,21 @@ Required properties:
>    with the chip-id.
>  - reg: Physical base address and length of the controller's registers.
>  - interrupts: The interrupt signal from the gpu.
> -- clocks: device clocks
> +- interrupt-names: List of names for the interrupt signals. The following can be
> +  provided:
> +  * "kgsl_3d0_irq"
> +- clocks: device clocks (if applicable)
>    See ../clocks/clock-bindings.txt for details.
> -- clock-names: the following clocks are required:
> +- clock-names: the following clocks can be provided:
>    * "core"
>    * "iface"
>    * "mem_iface"
> +- iommus: optional phandle to an adreno iommu instance
> +- operating-points-v2: optional phandle to the OPP operating points
> +- qcom,gmu: For a6xx and newer targets a phandle to the GMU device that will
> +  control the power for the GPU

Seems fine to me.  If you happen to spin it again for some other
reason it might be nice to be more explicit about exactly when clocks
are required and when they aren't.   IIUC they are always required on
systems without a GMU and they are never present on systems with a
GMU.  ...but I wouldn't spin it just for that.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
