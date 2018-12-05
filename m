Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA13C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:26:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3DBE205C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Eqy0qzxJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCr12/vu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3DBE205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IS5eYR73l3la7Lm8cqCn8Y6U/fDKuXQ4MIYWbokxkhA=; b=Eqy0qzxJFSOpNo
	YHKlcyalSm4rvktjhbSnpX7iTl3J45qWU/32l/w3hI1RwiQL4JbfefV0EriEjUrHTWyrIFLmpdWMF
	gftUnUVhlluOae/2bjqPQYDjkkycycZ/Dd0rguEKpYpCJXCzFWBOQq41PR7XTjbnHfLbZZUQI8Oek
	dsCv2O8Pgnu0BMhpIzz2GwREOuA8m5sFo7iPdTuZDpZdPip4cl6ARRx+heQGAKnMvXCq/q7p7NvPT
	3FJeJxWUaYut2g7frSueaTltVL9yBssOeVdmSLqpngmn6KrgB8jpuvNbHWhGQcDjaZnnrTZ0FZO+p
	rlOJwr8pYYP3QS87Ly0Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUaw5-0005k5-51; Wed, 05 Dec 2018 17:26:09 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUavJ-0004yt-8K
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 17:25:24 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A3FE520989;
 Wed,  5 Dec 2018 17:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544030718;
 bh=a5S8271YuAAXHW3TVhL4YiMFaZAFFUty9bLcYII0KAM=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=lCr12/vutigdQ+5Og42lkakuqiMHAdK6v7F58k/xWmR4RMgx0AMYjkZQOMQ8oRqFL
 hWMVGxuMwMdujxSUMURGp7thXKU0Lq+Hero8AP2+MnY5P6PrgE9aVwrbWS+wUJ8lfa
 DO8daaw3M6p0GQrprOYQwHkEAPUtafhLLeZVXWiU=
MIME-Version: 1.0
To: matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1c73fcc1dcb63aa0e5c65492692658a9e74f3c2d.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
 <1c73fcc1dcb63aa0e5c65492692658a9e74f3c2d.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
Message-ID: <154403071814.88331.10541605548687550422@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v6 09/10] clk: apcs-msm8916: simplify probe cleanup by
 using devm
Date: Wed, 05 Dec 2018 09:25:18 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_092521_591586_FD09276A 
X-CRM114-Status: UNSURE (   5.12  )
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
Cc: david.brown@linaro.org, linux-clk@vger.kernel.org, b.zolnierkie@samsung.com,
 andrew.smirnov@gmail.com, linux-kernel@vger.kernel.org,
 mturquette@baylibre.com, rafael.j.wysocki@intel.com, linux-doc@vger.kernel.org,
 linux@armlinux.org.uk, krzk@kernel.org, akshu.agrawal@amd.com,
 cw00.choi@samsung.com, djkurtz@chromium.org, pavel@ucw.cz,
 pombredanne@nexb.com, andy.gross@linaro.org, sjhuang@iluvatar.ai,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Matti Vaittinen (2018-12-04 03:39:06)
> use devm variant for of_provider registration.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---

Applied to clk-next


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
