Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6872AC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:18:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DDFC20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PEVdrdwD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFp1kJES"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DDFC20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Qn6nCNQVBz8KzfjUb3wU8GPDN1ZD9cSLRW97WtJFsWU=; b=PEVdrdwDVzhycU
	4J+dIRn1NbFhHPf7G9/YGJKIsZRXgOGpD/1rS+fAlCZdkRt/8loTl5Cxy+ihHnd+BNmr6016RStUE
	Ig3nVY6oms5vA7rhldPCSJkQy2ZaLFBTWBpaXuMAejTShOgljtex1huf0PQmLXPO/r1DSnNv4YCSb
	dFjojOu3XdviIfjVAYjLkqCoJ0Ruxe4h/OPtup4FZXADo0j8L8VG9vOgZY+M9hVS2GPzDO6m3xg9y
	skTlq5fzJM+gZu3rwGH+CiQQErsusl+UvsUVutpL6vHwgTUKKbVNXlOJ2/DLfAsTiV1Get9hqVLF2
	gm4K/A17Tq20GsyEGgRA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTsnA-0001hH-3m; Mon, 03 Dec 2018 18:18:00 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTsma-0001Be-8E
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 18:17:27 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 386C7208A3;
 Mon,  3 Dec 2018 18:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543861037;
 bh=5RQLaRV1qHuWhzIXnnTlJ+6vTCGgCCmraY9Qk+7bDq8=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=dFp1kJESh176MoKtg5mVkeQuSzW7Jvig/eYzA6YBblD1uohx+HKkk2UiSqcXmbjIg
 cmKumGUKkYdfuVj8AWh/C0kjBkJK1avtke44xh+qRPnA5YhZ97aIMb2On51LVtxdEK
 ARZUkwA1uXNQjyohq/GLQc9SgOz2s3jMyCLC0X7k=
MIME-Version: 1.0
To: Abel Vesa <abel.vesa@nxp.com>, Aisheng DONG <aisheng.dong@nxp.com>,
 Lucas Stach <l.stach@pengutronix.de>, Sascha Hauer <kernel@pengutronix.de>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1543661502-18573-3-git-send-email-abel.vesa@nxp.com>
References: <1543661502-18573-1-git-send-email-abel.vesa@nxp.com>
 <1543661502-18573-3-git-send-email-abel.vesa@nxp.com>
Message-ID: <154386103670.88331.8658319817515727072@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v15 2/5] clk: imx: Add fractional PLL output clock
Date: Mon, 03 Dec 2018 10:17:16 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_101724_355323_E2113ECA 
X-CRM114-Status: UNSURE (   9.58  )
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
 Abel Vesa <abel.vesa@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Abel Vesa <abelvesa@linux.com>, dl-linux-imx <linux-imx@nxp.com>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Abel Vesa (2018-12-01 02:52:11)
> From: Lucas Stach <l.stach@pengutronix.de>
> 
> This is a new fractional clock type introduced on i.MX8.
> 
> The description of this fractional clock can be found here:
> 
> https://www.nxp.com/docs/en/reference-manual/IMX8MDQLQRM.pdf#page=834
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---

Applied to clk-next


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
