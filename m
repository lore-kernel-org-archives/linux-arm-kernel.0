Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EB7C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:53:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 548BB2082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mM0yoCbv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="tAQsFzPy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 548BB2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=m99YxEhxqv0YA0zFY1FnJCFvRJYLJfTd+vABuKhevX4=; b=mM0yoCbv+h302v
	6XkhrAJWYzfQKEcikeagupXaTUyvEbghKQJniLhT05zFAvw/0TkiET3xmwWPWKyaog551EpNues8r
	WKNWca0UzOnj9soLpWa0m6lkRcmRuxvc5oVUaffxvLKU/Fps6YGTtYJB5qFRmj5os/m+VSOfI21v9
	Bt5VB1t604X0UXMl0WyL46PSQL3Y+uKYV7kd3pvumQeD+dg7r4z9zPSbsbt5EZ5vIU9FZK5Qe9Pr4
	ciGCBXSFyFy/DnsffF2B4Lp001cGhAk7C4SNYz8jTAcdSGnZN168o3DnOF+Xt/zbIf/VxewnrGNzf
	LgXtwD6Lkv+AgaCPGOlA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gULRG-0000bD-FQ; Wed, 05 Dec 2018 00:53:18 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gULRB-0000Yk-S5
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 00:53:15 +0000
Received: by mail-pl1-x644.google.com with SMTP id g9so9171955plo.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 16:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=ATCg9fvTUzVSYrKq8MWA0GV6b6vl2SbhBcgVyZ2mmJs=;
 b=tAQsFzPya0J+e2ukEg4itkrdH8qkWF0z9Gp/TYbIQt0/6MXiT016uFFucX6OrgqwOZ
 J9DImptrsXJ6CAU8ywDio9+/5utflAcvrPBgCCdOMZJUSPRqtmFRozv2cj3e8lMwf4xv
 Eb8jHkb5aaoOT7unz3jUEwFP+wNyJEotQ3OHWKrUgwJv35mMJoh5OlGY7JSZCCsWssMY
 Wpy0K/fvyi9PhG/Zm9SLKxrg44tNKtEAFmf35z0Upmd4yDrbztHpMb1DkMGQ4x4PVgER
 hJxRnhMHqDI3Vzeww6ZaCM3NYZDEfFhjmCpttc44D5KT4/+rAyAU0VAPJ5aHsXxrmiFU
 xzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=ATCg9fvTUzVSYrKq8MWA0GV6b6vl2SbhBcgVyZ2mmJs=;
 b=gh/pi7TjyEv4boKBXmSFr1iNQ7Sa2huo3cNQuEBBZM5Bx3xZx4vj1w+gEBVS7uWLRq
 O2Rk0zbyOwacbnaaB606AlZHSJ/0wpElMvtf3PKuWvzCETddOS5lSTJCTEWPEU/iobwq
 Ou3gFmSC4K84MULkizcq5NTeizcl8pdJAatwW8TYP2QaT994y1ScsCfbdN0OTTzTBN75
 Sj0ijEioGJuzuEFRjbOCv2PZkwT7lhSSzBPKBJFFCRVDa2rtLPSQMQEh4KU+A5MAs5X5
 BBOk7MJEZDMu/veDB99N3ttSpz+WOqhYmZ43HgQ66QxNpO75hbQI5Jj/jFBTfVnRWXLo
 7eCA==
X-Gm-Message-State: AA+aEWY8MOY9SZPFTMb4CQwKaZMuouaHg+xWSivHTkZteehicwxF4ZYO
 ANhBHWl73JB+gep8n06e9qGK1A==
X-Google-Smtp-Source: AFSGD/U+vln/sVxNumAskd/VD/c9RRfiNGiP38FroUtKg1M+ksNzRjyECAPyB+q7y7lBh+sGHxQP+A==
X-Received: by 2002:a17:902:2862:: with SMTP id
 e89mr22501733plb.158.1543971182845; 
 Tue, 04 Dec 2018 16:53:02 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net.
 [71.197.186.152])
 by smtp.googlemail.com with ESMTPSA id 6sm25011955pfv.30.2018.12.04.16.53.02
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 04 Dec 2018 16:53:02 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org, carlo@caione.org
Subject: Re: [PATCH 0/2] ARM: dts: enable CPU frequency scaling on
 Meson8/Meson8b
In-Reply-To: <20181129230044.21358-1-martin.blumenstingl@googlemail.com>
References: <20181129230044.21358-1-martin.blumenstingl@googlemail.com>
Date: Tue, 04 Dec 2018 16:53:01 -0800
Message-ID: <7htvjsbxqq.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_165313_958651_B5E75A26 
X-CRM114-Status: GOOD (  20.65  )
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
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> This series enables CPU frequency scaling on Meson8 and Meson8b. On
> these SoCs all CPU cores are using the same clock, so all cores will
> always run at the same frequency.
>
> On Meson8b this is pretty straight-forward by taking the frequency and
> voltage table from Amlogic's 3.10 vendor kernel and converting it to
> "operating-points-v2".
>
> Meson8 (which is inherited by Meson8m2) is not so straight forward:
> The 3.10 vendor kernel contains two frequency and voltage tables with
> different voltages for the same frequency. It turns out that this is
> due to the design of a specific reference board where the output
> voltage of the regulator is limited. This has nothing to do with the
> recommended voltages of the chip so this adds the "operating-points-v2"
> which are used by all boards in the vendor kernel except the special
> case.
> The two fastest (clock rates: 1.8GHz and 1.992GHz) operating points are
> causing my Meson8m2 "M8S" (not upstream yet) board to lock up hard with
> instruction errors. I'm not sure if this is due to the poor design of
> the PCB (the LED is getting darker when I switch to 1.8GHz and soon
> after that it will crash). Thus I decided to play safe and disabled
> these two frequencies for now.
>
> Special thanks to Jianxin from Amlogic who patiently replied to all of
> my questions about the CPU clocks (without his hints I would still be
> looking at why I'm seeing random lockups when running the CPU off
> cpu_in_div3 or why the udelay is not working properly)!
>
> This is successfully tested on:
> - Meson8b: Odroid-C1 and EC-100
> - Meson8m2: MXIII-Plus and my "M8S" board (the latter is not upstream
>   yet) with frequencies up to 1.608GHz
>
> Dependencies of this series:
> - these patches are based on my other series: [0] "32-bit Meson: add
>   the ARM TWD and Global Timers"
> - when not running linux-next this requires the the clock driver
>   patches which are queued for v4.21: [1] "[GIT PULL] clk: meson:
>   updates for v4.21"
> - when not running linux-next there is a runtime dependency on the
>   meson6_timer from [2] "clocksource/meson6_timer: implement ARM
>   delay timer" because changing the CPU clock requires a small udelay
>   which only works properly when using a timer as clocksource (instead
>   of running a jiffies based delay loop where the timing changes with
>   the CPU frequency)

Thanks for the detailed description of dependencies.

Applied to v4.21/dt,

Kevin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
