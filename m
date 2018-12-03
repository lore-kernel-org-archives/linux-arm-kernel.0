Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF5DC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:32:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7B242146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qfMiG12S";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AuiLwFv7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7B242146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=svaaysBrAPKv2I9aSErIxPSUTtp47rbdXvwC4V28ymE=; b=qfMiG12SWyN+lr
	PteJIMy9MbHK/JBUbLrwdF14dMCtGnV/mQY7k6MjG7h6ruDGKmg0q4LG82t6JxBR5ler37CBbijjW
	8cmXudWO+6aqE0FAk6yizpQRDYYqI0OJbs2srXmIlhurmQ9W9fx3nFLSEPUX3l5jk8/C2pKRjycTA
	pILaCOwFoSlPaJQfe7V6a0emLNrdcifC9LMmUNZRUHEtvna8T9po4TSKJPILqY4p1iWPV6KBFXPyM
	w1hkW8pDM70vTz9UmGqwxfsejBjxDgf3AdohahT6GwHzYXHVxqb35SoIzsLW6EvImV0uMEFZPGR06
	vg5W6Ja/f0dK0aAtfOtQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTtx6-0000Yh-VF; Mon, 03 Dec 2018 19:32:20 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTtwg-00006Y-5K
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 19:31:57 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 64F4B214D9;
 Mon,  3 Dec 2018 19:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543865512;
 bh=A7/igc0CZhhDZenx7tAoa1nrc70SuLXpbM8leEwrcBM=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=AuiLwFv776oiyZDCNtaALYb+RydKpP6SGfdelqBQ7dzOsroyI/LpWWO5LPRdM4uT6
 2k+3D//RkYCtuVhm70Cb9GBTmoCma6t/zESugqsGxdXK/gqy6o0R5am2GW6r7tCXni
 sXOv2DYWGcGfuBZQtYIDkqyPQ+Z7yyQDDc7n9NRY=
MIME-Version: 1.0
To: "A.s. Dong" <aisheng.dong@nxp.com>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1542200198-3017-4-git-send-email-aisheng.dong@nxp.com>
References: <1542200198-3017-1-git-send-email-aisheng.dong@nxp.com>
 <1542200198-3017-4-git-send-email-aisheng.dong@nxp.com>
Message-ID: <154386551184.88331.6087190803273481557@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH V6 3/9] clk: imx: add pllv4 support
Date: Mon, 03 Dec 2018 11:31:51 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_113154_406387_E5B57EAE 
X-CRM114-Status: UNSURE (   7.22  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
 Anson Huang <anson.huang@nxp.com>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@codeaurora.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting A.s. Dong (2018-11-14 05:01:43)
> pllv4 is designed for System Clock Generation (SCG) module observed
> in IMX ULP SoC series. e.g. i.MX7ULP.
> 
> The SCG modules generates clock used to derive processor, system,
> peripheral bus and external memory interface clocks while this patch
> intends to support the PLL part.
> 
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Anson Huang <Anson.Huang@nxp.com>
> Cc: Bai Ping <ping.bai@nxp.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> 
> ---

Applied to clk-next


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
