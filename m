Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B621C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:26:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2674E20837
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Cyg+EvEl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2674E20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2iCxRQR5n4uGbFJGuJ87Jy2XPt9TismqQ5ZnBtKiGhM=; b=Cyg+EvElOVxfUJ
	ZOD6RLMKAZkEE2CFcnqLSvXAof0sA7CIJLr4Ym0ZxYCEj+o+Af0FDdO4YFqoP2GSoBb154endgvDg
	LiECSid+rOeO0OxDg77gg5qqdlxcNZZjZQ6VSjhjYjQGu0sbnJOpfKDu9r7j0ek4Wk7nmtnntt73W
	LObcAAX0hey2T1l121gUJEQ3mm7zF6jRoM9917UTnCVQ36KUBglzifbPchcQzJxbyI0iOpzYDwwlK
	s1lnkNLGiZJ/WlnbQ+Qs/2Lsd6wGnUtr4jQxg9Yhime9doB2PswknpWAQvepXUrgyjWpp6RGKIawC
	6V4ssL8pAor9Dd6zZ2ow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVPVW-0007ir-PJ; Fri, 07 Dec 2018 23:26:06 +0000
Received: from mail-ot1-f68.google.com ([209.85.210.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVPVU-0007fI-69
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 23:26:05 +0000
Received: by mail-ot1-f68.google.com with SMTP id 81so5399448otj.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 15:25:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=aV/YMN4ro35LqdSd+Zm0fkgn/Mb9vd6cXeuYeRLZvqU=;
 b=bF8s9MwUMXvRUAxZYSnoeyvwlaU0JbzOwJiua2ZS0Qm+K3AxlScI+SRlOQcuFvpJn3
 QcnLaG3jV0n0CJLTjx0vmdhiLeBg5/Jk0CblfgONG8xYRx/F+DkihaGr3k4MVZtrdsq7
 sAHJM4qeU7FYXF58DOUh4ww2j/D21cGhW2Dkbiq/RXVerNthhf0o1qLoipGv8DURQJF5
 JM0zXGa8olv5bEFRFMJXDQIHJI5aCTSm12HMnRtoMAJLDT7XLCkXNpZhnO7Rn8EgJota
 OSPC/yRhdnHal5qsYXSOB7OkBCIkjXp9OEV0XVVgCYpvLE12maPwJXbe6QxQL2EzbO19
 PiSw==
X-Gm-Message-State: AA+aEWY4dzYjLqN9sSDyLOt+ndVEXT2HjeJNSpfjXQUk0PvMt98R3/6I
 +RCrCDnmpHR2ebxwR2TEsQ==
X-Google-Smtp-Source: AFSGD/XT6hhIoyP9TGcIEVqmplPk2A22vA+VKiDr9Yhp4xMkatDfC2WvmDv0eCmwWIgfaQi4KFK3Yg==
X-Received: by 2002:a9d:ac8:: with SMTP id 66mr2961139otq.315.1544225153204;
 Fri, 07 Dec 2018 15:25:53 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id d5sm2087961oth.78.2018.12.07.15.25.52
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 07 Dec 2018 15:25:52 -0800 (PST)
Date: Fri, 7 Dec 2018 17:25:52 -0600
From: Rob Herring <robh@kernel.org>
To: Hao Zhang <hao5781286@gmail.com>
Subject: Re: [PATCH v3 5/6] DEV: CLK: sunxi ccu: export clk_apb1 for
 sun8i-r40  soc pwm.
Message-ID: <20181207232552.GA27927@bogus>
References: <20181125162203.GA5392@arx-s1>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181125162203.GA5392@arx-s1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_152604_222825_455CE2B0 
X-CRM114-Status: GOOD (  11.40  )
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
 linux-gpio@vger.kernel.org, maxime.ripard@bootlin.com, mturquette@baylibre.com,
 linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org, hao5781286@gmail.com, sboyd@kernel.org,
 wens@csie.org, robh+dt@kernel.org, thierry.reding@gmail.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 26 Nov 2018 00:22:03 +0800, Hao Zhang wrote:
> The clock source for sun8i R40 is from apb1, so export it for
> dt parses.
> 
> Signed-off-by: Hao Zhang <hao5781286@gmail.com>
> ---
>  drivers/clk/sunxi-ng/ccu-sun8i-r40.h      | 4 +++-
>  include/dt-bindings/clock/sun8i-r40-ccu.h | 2 ++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
