Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AA8C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:58:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D576920851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cmBglZx+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JtL+TFWc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D576920851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0bXeczY94I+8hDZPJlC2LHSATvc9CNgDOAk+Rrw/vxU=; b=cmBglZx+15/h1+
	2oMMtaHVXFtT7KL1wbgVUU9e5xktPRFyS36L4ZheyFKBJgJ2SkMJ9MPSEtuRq3ZBt5ITANDeAczoB
	jjcJAzDhn2HVepq2kmh57OPj0x//iJzL/XO9C4WTIwBQSRpXyAWdRAgTnRzjFYt89aGzRGkvR0T92
	gJlA0Ueq93QdAUIsawAeOHUr5b+cX2sBkBhyBzpmSM4HH+VgRTtBcfbAIbVH5tMTchL5BO6/ICQdI
	K5lBUQ0g9yglHbXKygVTLiQBuUcg55Xqc//RLPlyea0jGADEKb4xUdoUrned0XL9hfOiJ/68NH5k2
	7tnwEfI4xgYjxhIsZqIw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWlMH-0003VD-NR; Tue, 11 Dec 2018 16:58:09 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWlME-0003U5-Na; Tue, 11 Dec 2018 16:58:08 +0000
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4683020851;
 Tue, 11 Dec 2018 16:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544547476;
 bh=YoqaabEEBbDsZSGjISA5gSQOB8ReY73onH5dT5MTtrU=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=JtL+TFWcfFY4Y6HPsuBf9N6IzkOKvCxyiXqUiTYJXkNgO80K6bS50g/J2u6iiC7u0
 63lfygeLbdh0TkPSU9782ctsPyH4xAOob+8QrFoc35ipia22C2jK0YDcKit0MPkKRl
 MrF7sNtzn5zaeKhN6Ub29vGvIIxqu0RAOgOr6C0E=
Received: by mail-qk1-f178.google.com with SMTP id 189so8987335qkj.8;
 Tue, 11 Dec 2018 08:57:56 -0800 (PST)
X-Gm-Message-State: AA+aEWb6ZW3wUbUHPLvMC1llmRWeyoJnby53RRt9Tz2sCVAERk5OXbPA
 wW7SciL/LhN6Z8/isetrbeukiDRvxCPUrzF4RA==
X-Google-Smtp-Source: AFSGD/UkuQno7KJltRfPGkvnOlzPoeT5M+tmaVy4ZpISj+pLF840iY5KiG9DWXReZqOZTD1krbEOy2KykpAkDUpX6jc=
X-Received: by 2002:ae9:edd8:: with SMTP id
 c207mr14759953qkg.184.1544547475471; 
 Tue, 11 Dec 2018 08:57:55 -0800 (PST)
MIME-Version: 1.0
References: <7hpnu9w22b.fsf@baylibre.com>
In-Reply-To: <7hpnu9w22b.fsf@baylibre.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 11 Dec 2018 10:57:44 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+SdoMCsk2uf=W_bs7ObCL6KvLA7gaojteFJmRhm4QjwQ@mail.gmail.com>
Message-ID: <CAL_Jsq+SdoMCsk2uf=W_bs7ObCL6KvLA7gaojteFJmRhm4QjwQ@mail.gmail.com>
Subject: Re: [GIT PULL] arm64: dts: Amlogic updates for v4.21, round 2
To: Kevin Hilman <khilman@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_085806_786027_F95FC2BF 
X-CRM114-Status: GOOD (  12.32  )
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
Cc: linux-amlogic@lists.infradead.org, ARM-SoC Maintainers <arm@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 10, 2018 at 2:37 PM Kevin Hilman <khilman@baylibre.com> wrote:
>
> The following changes since commit 5e339a1d7e438b2cc9f46ec9f2682efb58ee2dd3:
>
>   arm64: dts: meson-gx: Add Internal Clock Measurer node (2018-11-29 12:30:09 -0800)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt64-2
>
> for you to fetch changes up to b29e9eccaaa721c2a303db6540535ee77a515f61:
>
>   arm64: dts: meson-gxm: Add Mali-T820 node (2018-12-10 12:11:32 -0800)
>
> ----------------------------------------------------------------
> arm64: dts: Amlogic updates for v4.21, round2
>
> Highlights:
> - GXM: add Mali T820
> - fix IRQ trigger type
> - AXG: enable GPIO IRQs, PHY IRQ, watchdog
>
> ----------------------------------------------------------------
> Carlo Caione (4):
>       arm64: dts: meson-axg: Enable watchdog on Meson AXG SoCs
>       arm64: dts: meson-axg: s400: Enable PHY interrupt
>       arm64: dts: meson-axg: Enable GPIO interrupt controller
>       arm64: dts: meson: Fix IRQ trigger type for macirq
>
> Christian Hewitt (1):
>       arm64: dts: meson-gxm: Add Mali-T820 node
>
> Jerome Brunet (4):
>       arm64: dts: meson-axg: remove alternate xtal
>       dt-bindings: clk: meson: add ao controller clock inputs
>       dt-bindings: clk: meson: add main controller clock input
>       arm64: dts: meson: add clock controller clock inputs
>
> Neil Armstrong (1):
>       dt-bindings: gpu: mali-midgard: Add resets property

Submitted, applied and a pull request all in one day. I have review
comments on this.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
