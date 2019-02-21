Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72025C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:45:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DA7A206C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SFsdglP4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hP1yHl0q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DA7A206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:In-Reply-To:From:References:
	Message-ID:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ae/T8tp83YD+jLbwETKOwdg2TdcbnL6L6N3zkHnhc8A=; b=SFsdglP4fbIF0Z
	wKrOs215sVfTvJg6VsKliX2M3lnTy+7WMbYUg8DS1+NROxl0ipioL7/Oon9WOztcDMVbHb7wjnL3/
	p00JXKOmS5TazkB+JGRWQ52Z/xI04PSjZ0qHuXgOIUjSvIDCrp2Xbe4L6aNSn8tuKLMByXf/35QU8
	0aQag2zvnKTMgY0foPSb/9BVwG4yV/bPX+UAPXZqecTQqtOmazJx0x8RMpVJ7QexEWJCUAfNA0tD4
	EZxlQB7hiGPxr0owxuUOAWElE69smN+NVWz/ptQ+cx1lieFCnyOIhvoqM3OW8cfLNYqIHplnV1t3s
	17j6IsmCy9O/1aZRsYdA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwvDH-0002kK-9Q; Thu, 21 Feb 2019 20:44:59 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwvCd-00029s-29
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 20:44:21 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A6688206C0;
 Thu, 21 Feb 2019 20:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550781858;
 bh=5yQhSBabw2eOAgliUMzLrkIhxkqZBQdNeRy3D3awaLQ=;
 h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
 b=hP1yHl0q4c95LO9ofSitKsQSpo/Vf+zkXgmRDkKPemY4uM8UqNb8j73hn7XiBdll+
 WYpZugKspUncC24hkHOahmKFd5Sw7zlfliBafSFwWpI/uNcOL6xVWiPZkF5kLLbnN8
 i2IKnlyTzNvLaRkY+fy5THVkRU1aVl93WucvDHW4=
MIME-Version: 1.0
Subject: Re: [PATCH] clk: imx5: add imx5_SCC2_IPG_GATE
Message-ID: <155078185794.77512.9942043032261092251@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <20190108162115.1998-1-l.stach@pengutronix.de>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190108162115.1998-1-l.stach@pengutronix.de>
To: Lucas Stach <l.stach@pengutronix.de>
Date: Thu, 21 Feb 2019 12:44:17 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_124419_348204_19F14B15 
X-CRM114-Status: UNSURE (   5.90  )
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
Cc: Michael Turquette <mturquette@baylibre.com>, patchwork-lst@pengutronix.de,
 NXP Linux Team <linux-imx@nxp.com>, kernel@pengutronix.de,
 Shawn Guo <shawnguo@kernel.org>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Lucas Stach (2019-01-08 08:21:15)
> From: Michael Grzeschik <m.grzeschik@pengutronix.de>
> 
> This adds the missing clock for the SCC2 peripheral unit.
> 
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---

Applied to clk-next


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
