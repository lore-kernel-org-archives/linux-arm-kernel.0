Return-Path: <SRS0=tR0U=PB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37ADC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:18:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1304218AF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="phVqF0oN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1304218AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fAuST0aW4jWr1VVcRxndjHKf7brnJv4bb5FsCrq1+1U=; b=phVqF0oNAPyK6i
	umnU1yXQjfgOU83cAmeXgslvHpStA49G9JmlCHRiZJC+4HcBBwsse8mBEaLj1zBG9A4aoRV+iRyid
	mYb6Tj+WIswCmn00aQ4akr//pWA25GhLF7XZRTroTJ5miyAbmm1TTnneGmGPM7M3ZwdDXAAvZv4CK
	vm0iAcKIdEjj49B8uNvAwRbkKxd39FTB+3nSJQpevy4RYca6jd29Llkq08FKkwZlir/ijyU4WMPat
	xms4s9C7o6CR+xFsJPS+T4qXgYkR7EZYwKEZiBBfxYw/b/PYawloHjd2le/luehIRzZRelG5kl0bk
	g+9HCqfY7Ts5CY98rzSw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbMNj-0001AL-NM; Mon, 24 Dec 2018 09:18:39 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbMNg-00018Q-2x; Mon, 24 Dec 2018 09:18:37 +0000
Received: from [46.183.103.8] (helo=phil.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1gbMNT-0003RC-Ne; Mon, 24 Dec 2018 10:18:23 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Subject: Re: [PATCH] clk: rockchip: fix frac settings of GPLL clock for rk3328
Date: Mon, 24 Dec 2018 10:18:22 +0100
Message-ID: <1898630.x4fnsSTjcx@phil>
In-Reply-To: <20181222164249.25620-1-katsuhiro@katsuster.net>
References: <20181222164249.25620-1-katsuhiro@katsuster.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181224_011836_278096_DC4A32A9 
X-CRM114-Status: GOOD (  12.48  )
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
Cc: linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am Samstag, 22. Dezember 2018, 17:42:49 CET schrieb Katsuhiro Suzuki:
> This patch fixes settings of GPLL frequency in fractional mode for
> rk3328. In this mode, FOUTVCO is calcurated by following formula:
>   FOUTVCO = FREF * FBDIV / REFDIV + ((FREF * FRAC / REFDIV) >> 24)
> 
> The problem is in FREF * FRAC >> 24 term. This result always lacks
> one from target value is specified by rate member. For example first
> itme of rk3328_pll_frac_rate originally has
>   - rate  : 1016064000
>   - refdiv: 3
>   - fbdiv : 127
>   - frac  : 134217
>   - FREF * FBDIV / REFDIV        = 1016000000
>   - (FREF * FRAC / REFDIV) >> 24 = 63999
> Thus calculated rate is 1016063999. It seems wrong.
> 
> If frac has 134218 (it is increased 1 from original value), second
> term is 64000. All other items have same situation. So this patch
> adds 1 to frac member in all items of rk3328_pll_frac_rate.
> 
> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>

applied for 4.22 with Elaine's Acked-by

Thanks
Heiko



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
