Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B94C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:56:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F4432145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fuPXiLg/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F4432145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=g1cpo+GBnc/JioEMTGdB6zQgWY7SjSvJEeV1fbi+8hg=; b=fuPXiLg/wogkxN
	7zzgYz50WDsLB7irxi4n+KlGhTz+WlXZuJUAxzaI7pwcdXU+Ryfbh8mZxFQrIWKHbY+qYe2OK1I+D
	RsZjbBTy5JkjF/t5hJyuIthvY5PXFRVM3DA91DE2HFf8h4+3DqklyWBVUkQjkfgxmnw29BTRpE3al
	5YIe28b+xAF+oB855gxrBOtJQv2yBYXlW5UtsAaPAa59h3TvNV0UQYlTtZpwjTynvykVq5lmMj+Hs
	5NyL2C4lq6/39M33v1wy2q2CTYhXHBFM8jfA8e2DM9CaeAoV2EjrmYKvnU35DVeEgQrrXDsjzDjbh
	CZ9rZAimlhLAr6r1OqaQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSZuY-0001U6-4h; Fri, 30 Nov 2018 03:56:14 +0000
Received: from mail-ed1-f65.google.com ([209.85.208.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSZuV-0001TO-7j
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 03:56:12 +0000
Received: by mail-ed1-f65.google.com with SMTP id r27so3738023eda.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 19:56:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rtVlvmxu/HbPwX1djWwZgBZo6Exl0kkMIvLIu0XvI7s=;
 b=trAa+YCRoBCUznoMsc6cAP3kXnrUDZ5mCF7P1afFgRTLGrQ0QSYz1CQBxvqBV95KQF
 Nz8VZek7cdCDNiHlSK/c+T3QmywAgnP7tN4FttpsR34NKbpx328PsSHTE4m8TgnwRcuD
 wrOygSo6dCh3nnKS4jzG7lZU62yvOtEO1J68Zq2A7jxH2S21elTypIGH8z5esrY5J/7w
 BskvX6INIQmY05RrCeH32YT74yzSoTrbS70hn/ab9DcaeyTV5GSO/G0+K91yEgwfg7bz
 3g1PoLnh6gf7112JOb7LCoO/IGp0y27RJJl6+uXuOhQIA9aiSYHn8U5RapysBpC41aSY
 xZTw==
X-Gm-Message-State: AA+aEWYZAXVdGoTMi+PSx1Bs6s5M05PEUP3fn69hFuIz15ZjFrhsCZLk
 zSKw0HfsiqIh8B5rvRLFrt3lmHu1aS8=
X-Google-Smtp-Source: AFSGD/W9p8knaR3j/97Qcg8+X7mdwLDik1HfDUSsoPsBpnaw+q57UvCKcPjFg9e+TmDJITv7NSOutQ==
X-Received: by 2002:a17:906:1604:: with SMTP id
 m4-v6mr3405284ejd.167.1543550159333; 
 Thu, 29 Nov 2018 19:55:59 -0800 (PST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com.
 [209.85.128.50])
 by smtp.gmail.com with ESMTPSA id dc5-v6sm618687ejb.53.2018.11.29.19.55.58
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Nov 2018 19:55:58 -0800 (PST)
Received: by mail-wm1-f50.google.com with SMTP id q26so4265961wmf.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 19:55:58 -0800 (PST)
X-Received: by 2002:a1c:2382:: with SMTP id j124mr3896642wmj.14.1543550158329; 
 Thu, 29 Nov 2018 19:55:58 -0800 (PST)
MIME-Version: 1.0
References: <20181128093013.24442-1-wens@csie.org>
 <20181128093013.24442-11-wens@csie.org>
 <154344054442.88331.8887745218976145062@swboyd.mtv.corp.google.com>
In-Reply-To: <154344054442.88331.8887745218976145062@swboyd.mtv.corp.google.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Fri, 30 Nov 2018 11:55:44 +0800
X-Gmail-Original-Message-ID: <CAGb2v64cER=qU2e_jnZemVfYbtQFNk+ev1MFBQDQu86f98X2dw@mail.gmail.com>
Message-ID: <CAGb2v64cER=qU2e_jnZemVfYbtQFNk+ev1MFBQDQu86f98X2dw@mail.gmail.com>
Subject: Re: [PATCH 09/15] clk: sunxi-ng: r40: Force LOSC parent to RTC LOSC
 output
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_195611_282691_35FA0CE5 
X-CRM114-Status: GOOD (  16.31  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Alessandro Zummo <a.zummo@towertech.it>, alexandre.belloni@bootlin.com,
 devicetree <devicetree@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Mike Turquette <mturquette@baylibre.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, linux-sunxi@googlegroups.com,
 Rob Herring <robh+dt@kernel.org>, linux-clk <linux-clk@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 29, 2018 at 5:29 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Chen-Yu Tsai (2018-11-28 01:30:07)
> > On the R40, in addition to a mux between the RTC's own RC oscillator and
> > an external 32768 Hz crystal, which are muxed inside the RTC module, the
> > CCU also has its own RC oscillator, which runs at around 2 MHz, and can
> > be muxed with the LOSC output from the RTC. This muxed output is called
> > "SYS 32K" in the module clock diagram, but otherwise referred to as the
> > LOSC throughout the CCU documentation.
> >
> > The RC oscillator is not very accurate, even though it has an undocumented
> > calibration function. We really want a precise clock at 32768 Hz,
> > instead of something at around 32 KHz. This patch forces the SYS 32K
> > clock to use the RTC output as its parent, and doesn't bother
> > registering the internal oscillator nor a clock mux.
> >
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > ---
>
> Acked-by: Stephen Boyd <sboyd@kernel.org>

Merged with acks from Maxime and Stephen.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
