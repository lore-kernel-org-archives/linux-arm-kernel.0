Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91046C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 02:19:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 631AE2084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 02:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="riTUS+E+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wA4hBMNG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 631AE2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vJNj7qPjEf+R9H0q1aieXmgeVo0AznwpF7MVMrI/eeA=; b=riTUS+E+SAtc0v
	Sf7fghrHhOlmUhqPJZvLyeWsPhsKtQyUKZns1b7e1GJZhWbidrYCBgsv05w35VIg67dke5AdWZnbb
	cv/CMKRlmvDP02FscMoTPtY6AE02zieiHPkXqrGf5i4j2ht5mGIkYT24N7IhvlwvNx6lhMq5xfKI7
	J6EewyIJLSwgpjyDOXtWsDXbp0eIvWqC9mjUcWVDes52KW1UJM4uVXENNkft3LTkO/eRvTrvgRBSH
	KvbCP498sjFd1Pl7hpY/66kiGCe0+1pJ1PZWUacyEi6cVTewbNHeGxSfI3DcuPZRrg4VIuT6ryyHi
	yTmnBeeCXLGfqsfyGFgw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt1C6-0006vZ-Db; Mon, 11 Feb 2019 02:19:38 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt1C3-0006vE-F8
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 02:19:36 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2BE472084D;
 Mon, 11 Feb 2019 02:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549851575;
 bh=WBip9+yQal7fzQiqL8/PA7bzT8kCaPqfkOfQz3RPd1s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=wA4hBMNG0KU/HJfGcK4MwX7WtKoBn1HOfnh9HIwOQpKlrnf2vdEU1dyoWnOMfzfzF
 GF4amOxyMsMkBw+wVYx5DoOgCURtZF/Fvl9mU3dnUW1u9hWYOMeP6G2H2hUGVNYP8p
 55kXWl1220qVbNtRNH5iCHxCDLX9irQoYoAJklgg=
Date: Mon, 11 Feb 2019 10:19:23 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Abel Vesa <abel.vesa@nxp.com>
Subject: Re: [PATCH] arm64: dts: imx8mq: Add RTC support
Message-ID: <20190211021921.GE22487@dragon>
References: <1548946870-29037-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1548946870-29037-1-git-send-email-abel.vesa@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190210_181935_559817_74C2DD33 
X-CRM114-Status: UNSURE (   9.22  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
 Baruch Siach <baruch@tkos.co.il>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Abel Vesa <abelvesa@linux.com>, dl-linux-imx <linux-imx@nxp.com>,
 Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 31, 2019 at 03:01:22PM +0000, Abel Vesa wrote:
> Add RTC support for i.MX8MQ.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

Applied, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
