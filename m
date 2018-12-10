Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AAD9C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:35:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F4362084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="su6p48tE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rUgCZyGR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F4362084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:References:From:Subject:To:
	Message-ID:In-Reply-To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8Bc9ISfb+Q35clb7JNMBMWZtX5xSj1JPEgAvwlu/Uak=; b=su6p48tEicvcXM
	65SFPChgkD+0owytl3d7Iax92Wy7ltEm+2JUfncQaYTSJnGXPQNWKHxn7KeiSOWIxczvzEPge+scu
	1qDESNIdUChvMSv2I+qukdma4bzj39g+HaLKlJnzl73d8OU2DrfLrYMGpo/XVyEXvpNJ770xTYOdZ
	IBx7fLK9/yf7iitaLQxSSa77GHtCKiicLkCGkmBkAOhkhiwHrPCCATSncO5bLOzc7kwea3/eomRw9
	iHlRx/emgE331eJJguU2c0Qcg9CzNly0atj+ohOCGX/gYS3nJHFm+vtFy0mQM1cj+CkcGAxO387HM
	exUbcKnBRQXRn48So5Ow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWRKT-0001ov-9B; Mon, 10 Dec 2018 19:34:57 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWRKQ-0001c6-Hq
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 19:34:55 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 27EA320821;
 Mon, 10 Dec 2018 19:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544470484;
 bh=OtV4UjICH5aESXX0GcFxrGH53CZ4eFb/tZI9JTtfVik=;
 h=In-Reply-To:To:Subject:From:References:Cc:Date:From;
 b=rUgCZyGRqUvby1Tc3ovvUsEv7aA4CriZsK70IXbaIpypSZIXUFKdsqBoAAbnYWFKF
 h3/pTsD+86EPGPIWnWGfICHyM32SrACHP3hWYlLXsPXzb8O9ltE0UCzr1dyrasKC61
 ZVwdJb7VssVbD1fFf5+jqXeDOvA9a6xHywRplIM4=
MIME-Version: 1.0
In-Reply-To: <1543562288-28638-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <154447048344.17204.1093424854159784373@swboyd.mtv.corp.google.com>
To: "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>, Anson Huang <anson.huang@nxp.com>,
 Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [PATCH] clk: imx6sl: ensure MMDC CH0 handshake is bypassed
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.7
References: <1543562288-28638-1-git-send-email-Anson.Huang@nxp.com>
Date: Mon, 10 Dec 2018 11:34:43 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_113454_602741_E97C9F2E 
X-CRM114-Status: UNSURE (   6.48  )
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
Cc: dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Anson Huang (2018-11-29 23:23:47)
> Same as other i.MX6 SoCs, ensure unused MMDC channel's
> handshake is bypassed, this is to make sure no request
> signal will be generated when periphe_clk_sel is changed
> or SRC warm reset is triggered.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Applied to clk-next


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
