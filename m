Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CA1C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:47:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B51220823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QVCRszfL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="owks95T2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B51220823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WCMnLIsgI6Rwr6H6prpxYmsEDrTauJCrWUkwlVPnVFE=; b=QVCRszfLbvFK+w
	KWxbwQfxORshxNNCMxbBc6N6XUoqeaTna2LUUWbkfyUU7LRfL3+RABiSA3lY7VgzRoigvgqhBJHxF
	VRG1ScYs0oN0tyqca0jG9KoHHh4LAkl8NwPMq2RKROUSqLLR0lFwGgExLJyLj/636N0bOUHwA5a65
	aJ2WxBGYi5NxIBD4SNV4YydXY7SZLoaoZWnQDBvuspbK8j6GgHXMwfDXk0f4MTyI/fmOnd3Q8G0xY
	eU+y5tVKqxP2D+2Wa5ACCAL8P5HOqA839wCxGpvHysodHT/gdccGe8EHTZWoAa4mUYzbDz3jbOiYR
	qYR0B3nL0QLlGygvtbNw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt7Ff-00037T-Gm; Mon, 11 Feb 2019 08:47:43 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt7Fc-000374-Ca
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 08:47:41 +0000
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com
 [209.85.167.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BF0FC217D9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 08:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549874860;
 bh=zivmjRJeqY7jYqs9u4inzJ0Gz6WHby5gz1++O+RQWrc=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=owks95T2YWjgSufmMAOQbpJ9QKYe0RV0d+FUmOSBNz+KrwCo4LRWDUd2m87D7oMVs
 EjQLL3NKYe/308PGAu/NnQK7ZKjwyX1sbNPgC389AYYNCz0hJC1eqc0XCxB5Zu+xOM
 Nwt4SEeuPCbT3GxWUw4V/u7u6ZAJ3wJTa76rmfJE=
Received: by mail-lf1-f49.google.com with SMTP id t14so7068620lfk.7
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 00:47:39 -0800 (PST)
X-Gm-Message-State: AHQUAuZh1cjGzda1yWIRZK/gq1t5CvCYPy0rTBt6SVxiwRrtaZQj/ryF
 N9/rncX5rOn+wrWqIMbkFS7LpLcJwLzj+m3qeyM=
X-Google-Smtp-Source: AHgI3IbTz8HP3Eg7bv12FIUNhMJ0rqouVwIoGeFgtCcEBNN5rnfW7lFYNkeSvMATpHhxBiE1qsp2MsnwKI5ePzpSkps=
X-Received: by 2002:a19:f013:: with SMTP id p19mr2761837lfc.154.1549874857895; 
 Mon, 11 Feb 2019 00:47:37 -0800 (PST)
MIME-Version: 1.0
References: <20190210225114.20110-1-stuart.menefy@mathembedded.com>
 <20190210225114.20110-2-stuart.menefy@mathembedded.com>
In-Reply-To: <20190210225114.20110-2-stuart.menefy@mathembedded.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 11 Feb 2019 09:47:26 +0100
X-Gmail-Original-Message-ID: <CAJKOXPdNLd5MeFXa9bht4hzN8u+dMq=0GiWhhOShpUArS6RLtA@mail.gmail.com>
Message-ID: <CAJKOXPdNLd5MeFXa9bht4hzN8u+dMq=0GiWhhOShpUArS6RLtA@mail.gmail.com>
Subject: Re: [PATCH 1/2] clocksource: exynos_mct: Move one-shot check from
 tick clear to ISR
To: Stuart Menefy <stuart.menefy@mathembedded.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_004740_445665_E2CA981B 
X-CRM114-Status: GOOD (  14.18  )
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
Cc: "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org,
 Kukjin Kim <kgene@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, 10 Feb 2019 at 23:51, Stuart Menefy
<stuart.menefy@mathembedded.com> wrote:
>
> When a timer tick occurs and the clock is in one-shot mode, the timer
> needs to be stopped to prevent it triggering subsequent interrupts.
> Currently this code is in exynos4_mct_tick_clear(), but as it is
> only needed when an ISR occurs move it into exynos4_mct_tick_isr(),
> leaving exynos4_mct_tick_clear() just doing what its name suggests it
> should.
>
> Signed-off-by: Stuart Menefy <stuart.menefy@mathembedded.com>
> ---
>  drivers/clocksource/exynos_mct.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
