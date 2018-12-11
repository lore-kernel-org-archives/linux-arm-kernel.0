Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFD1C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:20:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA66C20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XLLLSX7b";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HA+56jvv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA66C20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6p6MdaXhQPLwXWPDLL5QumD9f7PESkNrXp+E5zVyKPQ=; b=XLLLSX7blSz4rN
	p77/kzAJpjaVPudopJK+lH/O1Pcw5qpeNsygIDsMIk9j/isXwiZx1TzjkrF7tqxrurEU6iLmY3POL
	C7QDWZZtjrVN6l6YLU2Eyq0ENwUOVpXAC1fUwrOAEjLfQfUiA+eJJ2cJi2sMpeiqR/ka63XxbTvMt
	QuGa9lQcLF5FaZYzaAiv88hBb/OFEioqBLBQbRY1dBFlzJLC20fRQ/TvS7GeGbZYttulgGZv83xPv
	QBbTvsRejIOavHABtReD6lMbyl3gkqYs0YQCxB1y/xOYoYOUNFKIGHKQ0gzYpyRX4jucVPuFTW/6i
	F/IMI27v+SH4ZcDqo4KQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWmdU-0005SE-FW; Tue, 11 Dec 2018 18:20:00 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWmdR-00056E-NA
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 18:19:59 +0000
Received: by mail-lj1-x244.google.com with SMTP id l15-v6so13860003lja.9
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 10:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=o+glzSU/yixlOEeoAqrZddDdfJRCsBql6/bcWiN/Yrc=;
 b=HA+56jvvX4vt6DhMvcs8B6TnJho4PRSfHPOSulJIQ11XVtzcAUVIydpPDTV4PoRQw4
 VwBIK0XAXg7rb1u4zCFzE82yScwupgMQ5L4kKbmF1/h/gCCzURUUVyc6v5hlFbgmX5nO
 C99XlhJHdh3sQfLkeIzPYTknmOp7TZzQtxD1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=o+glzSU/yixlOEeoAqrZddDdfJRCsBql6/bcWiN/Yrc=;
 b=MiR61jh5IvvuxN0S5tg0hMwrrSf/t+B3o0S4msg50faLq7u23LGnAygd0j8T+wo4XN
 SXgyltRTL5umW2atPAagDCyMJenPeAri7yWeaAvzz3Xi2ALjn/C+zxoUXOdgHREQNQiK
 9r74gCRGCTf7XGNUpmNUZdi8e540Bkg5K+Az8QZjQWUeEbiaVRlx9U/Ena7rQI7AvSvk
 VliLfqB6LFjQPlAIwXaVLVzfElFW7tzVk28OJ41VVYHcuU+SN93CG8nrZdBPO9tRW0pa
 ZRV4iTZ88V6/PGIbN5R9/JnlWs1L48iaaO3XEtfYzwnRsYTv6zPIAnmZAn8LzECgpZ/P
 cLWg==
X-Gm-Message-State: AA+aEWZVCGCjmCpCxJLg/HzbStJnCmLquvHZJqFMMzKBLDd11Yxr3148
 CI7tQqT+OHK9KB/g6jx8tZ9J2qRPaLVgDu4Qv6VtmQ==
X-Google-Smtp-Source: AFSGD/VWBll2yBQcaKZcEVLbrLcOGYC1t1M9CNf628LltAAsxAX8cx+02XEUbjt8CtSHu3nZ7XUHyFrpHnzOiuDUGl0=
X-Received: by 2002:a2e:710a:: with SMTP id
 m10-v6mr10458024ljc.66.1544552384670; 
 Tue, 11 Dec 2018 10:19:44 -0800 (PST)
MIME-Version: 1.0
References: <20181207102749.15205-1-bigeasy@linutronix.de>
 <20181207102749.15205-2-bigeasy@linutronix.de>
 <20181207130012.GX6920@n2100.armlinux.org.uk>
 <CACRpkdbvyimBfCCBOEr84P+_y6+sBkqz0+nmFyYeOJ4cXjsA6A@mail.gmail.com>
 <20181209004138.GC9507@n2100.armlinux.org.uk>
 <20181210143718.plwd36vdxxd7q2el@linutronix.de>
In-Reply-To: <20181210143718.plwd36vdxxd7q2el@linutronix.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 11 Dec 2018 19:19:32 +0100
Message-ID: <CACRpkdby=Xreh0VPpHBPLhvupgQyEqDiae+e0u=-n3o2SWVMTw@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm: Convert arm boot_lock to raw
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_101957_769069_FAC8DF6A 
X-CRM114-Status: GOOD (  14.53  )
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
Cc: ext Tony Lindgren <tony@atomide.com>,
 viresh kumar <viresh.kumar@linaro.org>, David Brown <david.brown@linaro.org>,
 Xu Wei <xuwei5@hisilicon.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
 Viresh Kumar <vireshk@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Kukjin Kim <kgene@kernel.org>, Andy Gross <andy.gross@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Linux-OMAP <linux-omap@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Barry Song <baohua@kernel.org>, Frank Rowand <frank.rowand@am.sony.com>,
 Patrice CHOTARD <patrice.chotard@st.com>,
 shiraz hashim <shiraz.linux.kernel@gmail.com>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 10, 2018 at 3:37 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:

> Okay. So the whole patch won't get applied, right? If so, may I please
> get the
>         arch/arm/plat-versatile/platsmp.c
>
> hunk applied?

Can you please send one patch per mach-* plat-*?

I can apply the plat-versatile patch and send upstream.

> The remaining platforms would have then either justify why
> they have the same problems like the ARM devel board or rework their
> code.

I sent a patch for Actions semiconductor today:
https://marc.info/?l=linux-arm-kernel&m=154451577304234&w=2

I guess I will keep on patching when I have time.
It would be even nicer if platform maintainers saw the
problem and did it themselves, but that doesn't always
work so I usually poke them with a patch when I want
something to improve.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
