Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92094C282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:05:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65B0B218A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c4XKh1uw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EtuQZhH5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65B0B218A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:Message-ID:In-Reply-To:From:
	References:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NPqXIjJiuS9k3vuaM+5T4ASm3ZpK87DZT8Lj/wjPzpQ=; b=c4XKh1uwbkIAcz
	Rkd5foznuOZjh4ShZIHW5CvfaZ2fQZ6Kajr412nkr0IY8Sk8Tthb4NqXUfkfMKnFV1zWe3YENwMF2
	+AyCpfMY+R2GA7rc3+e9trGioi1x8lpF3WYsyzH7HdUB4DaapEV3vGo+e/NE8RcOrFymlskpinAZk
	vh8F5SoLmdAEBZR6hMLiuaRxq35ziRfZMmRgaD72cD65EYeh7xMfyUEZhU36XTFN9kxfeJC97kfFu
	ETKeSBbPo4tpENGXfRTIFYKYodWhwKNtob82YPTpy3gi6RC9AFOzHH1XytcS672/byExinrou1IVz
	hVZ8S40IW8EsQXqE5Ziw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goXkw-0001hI-NE; Tue, 29 Jan 2019 18:05:06 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goXkr-0001XL-Ex; Tue, 29 Jan 2019 18:05:02 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A9F6621848;
 Tue, 29 Jan 2019 18:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548785100;
 bh=/0MckasgqQJ/KD2MVKBvKpBYnZf749g0hqFHF7Q6ugE=;
 h=Subject:References:Cc:From:In-Reply-To:To:Date:From;
 b=EtuQZhH5S7Jt5X39Vn6nIl1wQjXoLV/fGCwx7xD0XHJYSMdwkFvI6tQAP2NpV3pK1
 kOK4BiUJlUVCPm0tGNQaBjgx98RLyIj6gCpz4nqObNLewNEoB+w3NWwRThLA/Qud1S
 wplb8AI53+IMvC7vEFcf1P+Ko92BM/X5xXAP+mHE=
MIME-Version: 1.0
Subject: Re: [PATCH 04/14] clk: meson: move MESON_GATE to clk-regmap.h
References: <20190128180430.28689-1-jbrunet@baylibre.com>
 <20190128180430.28689-5-jbrunet@baylibre.com>
User-Agent: alot/0.8
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190128180430.28689-5-jbrunet@baylibre.com>
Message-ID: <154878509992.136743.15892625146758066106@swboyd.mtv.corp.google.com>
To: Jerome Brunet <jbrunet@baylibre.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Neil Armstrong <narmstrong@baylibre.com>
Date: Tue, 29 Jan 2019 10:04:59 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_100501_521906_6C2E326E 
X-CRM114-Status: UNSURE (   4.19  )
X-CRM114-Notice: Please train this message.
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
Cc: Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Jerome Brunet (2019-01-28 10:04:20)
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---

And also make clk-regmap.c a module? Having any commit text would be
good.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
