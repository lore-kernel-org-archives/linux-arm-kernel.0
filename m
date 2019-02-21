Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCF8C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:44:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C69020823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ktb4kIwF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C69020823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=H345W1zbeWwauZHBFe06cwK888bLMJfT1EzwSjt2wLA=; b=Ktb4kIwFW3l8YD
	WAjuu7og0q1T2pZoxyvKKJ4dqxrp8xXflEJfdQsgU2IRgeETUPT8CJjKrYtcUnCjgr5z9e/PNbC7u
	XjUp7M/a8OsuwVLdp7eMyhatr4QWUy5oGatXpo722N8aWHNo2t96hhuy08IRbFfP2rADHsNbOBOeM
	zNlHj3Go7fQALnrlY006IW2D5zYcQ7MTOs5QqZGjpsL35xvz9feN3Xlaw9FuHTgaJsXyW33sLeq24
	mtjhYDKooVX1V4cEYuJmQMqSebMVvDOri0ft6mkdkVjXQaatO6bQypGK6iAdGObUiqTC5irSSdNPZ
	8qGaFOQ1mmUAdw+bSpug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwqWB-0002rR-72; Thu, 21 Feb 2019 15:44:11 +0000
Received: from mail-ua1-f65.google.com ([209.85.222.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwqW7-0002qp-PF
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 15:44:09 +0000
Received: by mail-ua1-f65.google.com with SMTP id v9so9627492uar.11
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 07:44:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/Ujnw5Uiwkv5qTiAYI4IO+ayFYK6PgidtMZeh00Ee/Y=;
 b=fvifBO4mEQqqsZCORsXCsayX/N++comIp1RP0IzrX1yt4MprUEsoKHBv+WOyZoQ4ck
 SLRDNmR/es5HsPnjzNuXyq6YOYaJedRbwwuLwO/+dYh5vFBfgbHm4q2OCBEyAoyTtLOn
 vOfI5J7UziU+eejiXIPzyoWtD7ktD5FYH2pC7Gl9lRPReAx4jX81/ODhllCBy5eAyNcH
 xdThj3g02cbkaqRrMBdj4mqbc8KjkWNSU5jezfeUu7QvFZPM5e1Id1wGwPitTb2Ejd2n
 Kd2PsG2xBhx554x4j61EL+jFbr6TJ5e99n20P0BY3RLCtvStIcwUYVpb/oW1NgNIMGVL
 hrrg==
X-Gm-Message-State: AHQUAuZxKFRXC9ekxUGYbE/2i0WkBYnYHe+p1rWuF0mJiJjO8ld5jWrc
 fMI84E0OWqNoIn+0x1Js3LrnoWw5ERxG+4VtSho=
X-Google-Smtp-Source: AHgI3IZkIsmyOUVreh1QOkHEAPFxqcxd77snLAmAV+9Sy/chSvR4jotEu/irvqDdLX1f9A4IiENyMkkEowuXViAeJaU=
X-Received: by 2002:a67:fc9a:: with SMTP id x26mr3949088vsp.166.1550763846010; 
 Thu, 21 Feb 2019 07:44:06 -0800 (PST)
MIME-Version: 1.0
References: <1550749552-8133-1-git-send-email-krzk@kernel.org>
 <1550749552-8133-2-git-send-email-krzk@kernel.org>
In-Reply-To: <1550749552-8133-2-git-send-email-krzk@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 21 Feb 2019 16:43:53 +0100
Message-ID: <CAMuHMdUcn4LtMnE75XzF+p2G8ivTxKPMp_gT6ozx0iwtQFS+Hw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] clk: samsung: exynos5: Fix possible NULL pointer
 exception on platform_device_alloc() failure
To: Krzysztof Kozlowski <krzk@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_074407_820547_D15B0CFB 
X-CRM114-Status: GOOD (  11.34  )
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
Cc: linux-samsung-soc@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Tomasz Figa <tomasz.figa@gmail.com>, stable <stable@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Chanwoo Choi <cw00.choi@samsung.com>, Kukjin Kim <kgene@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 linux-clk <linux-clk@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 21, 2019 at 12:47 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> During initialization of subdevices if platform_device_alloc() failed,
> returned NULL pointer will be later dereferenced.  Add proper error
> paths to exynos5_clk_register_subcmu().  The return value of this
> function is still ignored because at this stage of init there is nothing
> we can do.
>
> Fixes: b06a532bf1fa ("clk: samsung: Add Exynos5 sub-CMU clock driver")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
