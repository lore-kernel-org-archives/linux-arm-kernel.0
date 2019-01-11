Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D7AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:21:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18BFD2084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fDrjjCXm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18BFD2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CpCRiAIjkHGh3BzdxzDVhKIoKD1LBVH1kikNTt2GU0w=; b=fDrjjCXm84CYIo
	9r+Ng6EDx+e+0xQqzbxkKJA/MVC4SqJciAQmCkRdDAiDIdgaR4XkFs7aHkyJMiTb/sTHdybQ9g3LE
	vnMonhuGt6UYEEsDWYrTmKJOsUx1NwDmTUCi5k/YL4WMsDFppeXvIvvVYK1vnTXkygxAmp4jZciA2
	MGpJHzXTtu7hW7W4GZf5qy4T+SwrHwkLesaWkGQi7/1icMGuQITJluKm0iWBnhmYDalW2AikOZ4is
	XlHtgefZnxmBvCMnw/dQdmDUuBEWYH40vZOu1Jn/cndr+iSuHuQrPTO06L9LYVTgDDIG40BUTCcFg
	kHELeHobxXeEbGaBUjDQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi5B1-0007EL-DF; Fri, 11 Jan 2019 22:21:19 +0000
Received: from mail-ot1-f66.google.com ([209.85.210.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi5Ax-0007DS-Dw
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 22:21:17 +0000
Received: by mail-ot1-f66.google.com with SMTP id u16so14510241otk.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 14:21:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=/Nel2vVzq6eWDK0fFrMqnPPVRkuH4RMd3RrAGtv5Xdo=;
 b=B6ijBxR12cVPunQrJ9blLnxo76AMLM1Fx5cH7c+XVWdK0rqN7YJ7XStYOhJ0BHvTF7
 zbXpwLtVvKIoa33o5oNh9PtpITWd0o+VWEyNqI1wUsWwfkTpm5ExKMw4y0qwUq8JWAi5
 xOUYxo2mKWkrTRNfyLpKMuy7xUU9cMFbU3MmG2ud+0605rA4wZmRKdGN/JsZkirsvGwo
 l1P9uAOv1dECqt4iBgZD46UF3UKxLpBJAuAhBRfBcm8Gv4qZjFSVP3K3dIDBaXSbIBwD
 0JTJetQa08nsWijFAkQ04oSgB1N/F7rWPvomrUvut2WOD8G527rSBVttN64AFRRwqTak
 dAJg==
X-Gm-Message-State: AJcUukcBDIl8jCydg5RI3Mxft1tWoMFBV9QqtWpnwSLeBPSndmu9UIT9
 JxOvYru67kp5TybG+5hzqw==
X-Google-Smtp-Source: ALg8bN70geTue42OwdBrFAUryFk0n6KBaHh9O+hanM0kR1SSpFzF98W9yIRUDG6tNKgZ3bhfMhp5Lg==
X-Received: by 2002:a9d:ac8:: with SMTP id 66mr11625947otq.315.1547245273906; 
 Fri, 11 Jan 2019 14:21:13 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id d5sm35176349oth.78.2019.01.11.14.21.12
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 11 Jan 2019 14:21:12 -0800 (PST)
Date: Fri, 11 Jan 2019 16:21:12 -0600
From: Rob Herring <robh@kernel.org>
To: Joseph Lo <josephl@nvidia.com>
Subject: Re: [PATCH 1/6] dt-bindings: timer: add Tegra210 timer
Message-ID: <20190111222112.GA14252@bogus>
References: <20190107032810.13522-1-josephl@nvidia.com>
 <20190107032810.13522-2-josephl@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190107032810.13522-2-josephl@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_142115_468630_431910D9 
X-CRM114-Status: GOOD (  12.03  )
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
Cc: devicetree@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
 linux-kernel@vger.kernel.org, Jonathan Hunter <jonathanh@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>, Joseph Lo <josephl@nvidia.com>,
 linux-tegra@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 7 Jan 2019 11:28:05 +0800, Joseph Lo wrote:
> The Tegra210 timer provides fourteen 29-bit timer counters and one 32-bit
> timestamp counter. The TMRs run at either a fixed 1 MHz clock rate derived
> from the oscillator clock (TMR0-TMR9) or directly at the oscillator clock
> (TMR10-TMR13). Each TMR can be programmed to generate one-shot periodic,
> or watchdog interrupts.
> 
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-kernel@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
>  .../bindings/timer/nvidia,tegra210-timer.txt  | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
