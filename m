Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49732C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:05:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B0242075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CzioMsnb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1GgZuPbj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B0242075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:From:References:Message-ID:Subject
	:In-Reply-To:To:MIME-Version:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yWlI7WkLDGUzlTwQfYzGmbaZlgYssYuMk1oc5xHct4Q=; b=CzioMsnb+TPaFz
	0ly9CW2N4ep8jqDGaefhKAglQefWjWoXMDHrFXyQxcfNweffUmc8jNSFqf8eEMbUg6PQ2Z/DV1lkU
	F8bwOju5DOzkgzqD8mx40rZ8FU0EQR55itbiJfsj3GYfxLExtZGKXQWpEYP2xeIqdpnSWRZCiEbe/
	IZij0MPZnpf6BA3Iky9WLUN+8DPMgxVeOg5fzLVFLovIiOljYn7hr4hm0oyem2HIiuNDlCl0CIzFe
	kQ/yuWDJJd9EEzBz8bWMQN+1C/fBFipEzsGx8rqb5gc6UEvzCz8LXyb2t6o4obaOZGlhZg+6h/U9W
	TdAf7Bh4Am7AZINdi3jg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grSVy-0006g6-Bl; Wed, 06 Feb 2019 19:05:42 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grSVU-0006FY-HV
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 19:05:14 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E630220B1F;
 Wed,  6 Feb 2019 19:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549479912;
 bh=ML2vFOb4cvoSl2x2j8/yMf0bXCQpACrQKo5uQ76N2S0=;
 h=To:In-Reply-To:Subject:References:From:Date:From;
 b=1GgZuPbjWKXsOnRC9GjD57iZbwA4AhzlL1ZQl9nmQl8/SraEF0uZteFydseXau8xV
 ZQX+Fthp4Xp6FBqsbWy/PTdZC5iRehXLAJc29LI6db12aJ2yajVAQYIys3GaWhpdRs
 2Ai+w1Dp+mDoU7GC6+4+VkHfvtaSZ1qlJfnroRHE=
MIME-Version: 1.0
To: akshu.agrawal@amd.com, andrew.smirnov@gmail.com, b.zolnierkie@samsung.com,
 corbet@lwn.net, cw00.choi@samsung.com, djkurtz@chromium.org, krzk@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
 linux@roeck-us.net, matti.vaittinen@fi.rohmeurope.com,
 mazziesaccount@gmail.com, mturquette@baylibre.com, pavel@ucw.cz,
 pombredanne@nexb.com, rafael.j.wysocki@intel.com, sjhuang@iluvatar.ai,
 sre@kernel.org, vkoul@kernel.org
In-Reply-To: <f40c69fc858cc7ec3cc722c6664d933ea6558fb9.1544177090.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: alot/0.8
Subject: Re: [PATCH v7 3/3] clk: clk-st: avoid clkdev lookup leak at remove
Message-ID: <154947991126.115909.9165588104956568526@swboyd.mtv.corp.google.com>
References: <cover.1544177090.git.matti.vaittinen@fi.rohmeurope.com>
 <f40c69fc858cc7ec3cc722c6664d933ea6558fb9.1544177090.git.matti.vaittinen@fi.rohmeurope.com>
From: Stephen Boyd <sboyd@kernel.org>
Date: Wed, 06 Feb 2019 11:05:11 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_110512_876700_DA7060F1 
X-CRM114-Status: UNSURE (   4.96  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Matti Vaittinen (2018-12-07 03:10:51)
> Use devm based clkdev lookup registration to avoid leaking lookup
> structures.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---

Applied to clk-next


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
