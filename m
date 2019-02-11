Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F91C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:16:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1214520873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R328ORpD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZWvoY2MU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1214520873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=n49Jpk9oxdZKrkI5jihgU8FRFXtdPksQIzI8h/hP9Y4=; b=R328ORpDF/Galg
	r+TYk8f4X7CcYMzykro83Q1Hsw4jUUHsAko5QO2RIQZK3eRIVlKB8gIuAiv1vf2MBvfhTP+f1+GcU
	F1luwhVHLDFmM7U+P88HEFZt6PnmnWpbN1q2rarZouQZI10zU5dtclpDyEyTDEH/6QT4/fTMaKEiw
	0udfYXrtMcr12+RzeKEXPumDXjlNJhntZUEiiG9mtZ8ui5xWKybPXe5ZFCu7/KWv5zHgIoLA7ssBc
	a5qSWR797ejQ6482OltaD35DS162qq7dtAre0WLHbB8ywdm9++DCDun+/Unufava6A4DRMy9jJdx5
	OUBN4PRbKoY3k6e7GUuw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt6lN-0000II-LG; Mon, 11 Feb 2019 08:16:25 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt6lI-0000GC-PO
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 08:16:22 +0000
Received: by mail-lf1-x141.google.com with SMTP id b20so6989834lfa.12
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 00:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3rOeLj/zzZBpsUzwQ4Gl0C5dRDYfMa0NPqlhcNE/Mh8=;
 b=ZWvoY2MUdc978cQven92P/Vf4iHZKtRyBolu+Ld+IbzdNWHmmDRgLzQh0WFZZsdVr+
 a0vTkvYJ1bMZjAtnuYWJa3EIcu1n8+EqbkO0sGox34JjJ+2r0h0lwXWxinjlozPpxbJ6
 yfjEN0jpGT/uHCflstsHEY1/s0Tov39OW3gp/AvlYTFMwmB6DJaZGBl2nQKbMGXNfl38
 ygynFodafAOmsgs3eyYad9QF2gzi0PrR3rXqyQXB5HWYmr3O8ilRFJSw7ciVWF6Rg4sE
 saqCJinu1mxqjHCE8TKPun2E+LhK9U0dov2G1BIQwmMCYxwY1XW+Zr8L0M/j69KsuFjk
 NfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3rOeLj/zzZBpsUzwQ4Gl0C5dRDYfMa0NPqlhcNE/Mh8=;
 b=C13U5UKTS1Flclex0WqJBFjWm2bS1sIkkn5huZsTz6YxRPpgDYRthjWm7X8lCB0oGA
 JHE9lV7D5yLwEW2Qiqbn/ZV9nPda7ni7i+SF1yrlyLI2VoFiPp3gDibuAi4KaPFQ6eVK
 kAXAGjF8WgRd4AN9mD9Pt1ttbxgauYL+iUNM10zAMJI2TOu0kwAxHZpIhInYd3JGiHiZ
 E2PR1kydPBZwE1f8JXw7rdtM8u9Vid0+glv/6dI+4f/y6mR601qilPpvFNDsjsxsSdmc
 Bo07HKoezkBfF0+gj2XJHOBZTl+zERYaoEGYuWVIk8uisfyN0Tj8Kiqe2noI1HcVW3Vm
 OsCw==
X-Gm-Message-State: AHQUAuaCWYp3O1RLhZVoPd0IgcHFGSNrC+m2sV2W/aVgxkjDNFo5MEuH
 Q37uZYZnp+2xfFYlkoydp0dMYc/9IzqLCfIjQk8MPg==
X-Google-Smtp-Source: AHgI3IYRwiauksWbzzhVv/buhcfZlPVVNva9j5Ck1EjuNTHYFYEXIgDLOIWrcLp1Aob/2SQDsMtqEuzShuyFaVmsLm4=
X-Received: by 2002:a19:7dc2:: with SMTP id y185mr21953938lfc.27.1549872976524; 
 Mon, 11 Feb 2019 00:16:16 -0800 (PST)
MIME-Version: 1.0
References: <20190209010101.12210-1-martin.blumenstingl@googlemail.com>
In-Reply-To: <20190209010101.12210-1-martin.blumenstingl@googlemail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 11 Feb 2019 09:16:05 +0100
Message-ID: <CACRpkdY3ygTU3UvA=Gu36S+Gte_WpR3stX5H-8Od42fJyDdSug@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: meson: meson8b: fix the sdxc_a data 1..3 pins
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_001620_856226_6F2D1D7F 
X-CRM114-Status: GOOD (  10.35  )
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
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Feb 9, 2019 at 2:01 AM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:

> Fix the mismatch between the "sdxc_d13_1_a" pin group definition from
> meson8b_cbus_groups and the entry in sdxc_a_groups ("sdxc_d0_13_1_a").
> This makes it possible to use "sdxc_d13_1_a" in device-tree files to
> route the MMC data 1..3 pins to GPIOX_1..3.
>
> Fixes: 0fefcb6 ("pinctrl: Add support for Meson8b")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Patch applied for fixes.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
