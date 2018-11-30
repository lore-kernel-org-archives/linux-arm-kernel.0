Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E81C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:25:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99FA32146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Rd92ckZB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tgMlZJ1I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99FA32146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=M1x4taKwWto1w4TJXrsnfTlla5WGQOVK7IfQLF4Kz9k=; b=Rd92ckZBWKOxs6
	20lcs7PnGF6TCD9g/KRBObQoUO8ON5pG8abtsuaolUJLFItFBnXbT6YvhgpGxs4qLbUjcJk/hdJa3
	UActIKZg2t8WeaXwGXnhjkAVDGM190fQEwkL0w6jbqdYn7E9NUZZHRQSNLwBOew0om9KqeJwO0eS3
	yAeg5+To4GsKO3wc5eW9BBpHV8Yar70nG5O0cxnfbiy4atXZeE9mUCrFpKmRftmTuODJTibJLOYHf
	CUoLxo6SOLORlrABDAasyL7MGNX0d1Gqn69peE9nZu3ABJhOY1Qbee+arYISlzjkLBlbCcIuerIod
	mRfMAhszup9qo/oRY4VA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSdAw-0004i1-6T; Fri, 30 Nov 2018 07:25:22 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSdAt-0004hL-Ax
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 07:25:20 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CAB2A20863;
 Fri, 30 Nov 2018 07:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543562708;
 bh=fq1oEIovxHpkJ1uMug5WWBHXM47wP0Jfq5qx+KHDIaE=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=tgMlZJ1ITqkEwtUGEn5hZ32PcgonirgUmeij8uXcWm24H5uxYO1eyX5QmARSolMby
 c81/3QMQDS1ZTqgjHuQ7tUOvm4RV/sePlmsdlh5RldsMcNYCdxLOnNXvud2lTOU4px
 mDhgpskDfywmoE3wAMSHCoe65OZ2SEa3mnDspac4=
MIME-Version: 1.0
To: "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 Anson Huang <anson.huang@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1543562288-28638-1-git-send-email-Anson.Huang@nxp.com>
References: <1543562288-28638-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <154356270811.88331.17520386069332746427@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: imx6sl: ensure MMDC CH0 handshake is bypassed
Date: Thu, 29 Nov 2018 23:25:08 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_232519_437423_00F622D9 
X-CRM114-Status: UNSURE (   6.44  )
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

Does this need a fixes tag?


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
