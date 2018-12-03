Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD16C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:34:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA9CE2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q8QRJU2V";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xxtHWDop"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA9CE2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sFZe66PKSpIK8wPIQHGZaWM3qg9eXjMpTWa2g6iQ1Mc=; b=Q8QRJU2V4/yUXN
	aHSzKbdvrnNBbUp/hFAOJTWo6vX0uGA/OgkWFZwfpBVLgxjpHLzv6Dwy6BgqNk8+4M5HzqmAXcceF
	hZat+6JodHwstz0zREJwU/auBzQHSd/zH0T77kiA+6R7KOoNOr4fSZAJ+kydvfhmpaKMCokR0Juja
	vWU2RZjIQCVHDRe3VRk32XEcNbQbMKErzBAmwCOvALkcod5hgoevw9kbI+K6EyZBQL9iEKthNgj9f
	551CCULSK1XMkkJg7ezLLK+jFdRAl2pNqwnOVr2gx3heSygbgpSWN5ZAmD16PdUpZ1KqjU+3BCPx7
	OSyXBaM4HSgvvagOH1dg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTtys-0002Tv-EA; Mon, 03 Dec 2018 19:34:10 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTtxJ-0000ee-1B
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 19:33:27 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5D73E2081C;
 Mon,  3 Dec 2018 19:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543865542;
 bh=YavQxUs2aYtJS3H9JApIzgtskWnmMskf54E//MhiYxA=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=xxtHWDopi9r4p13gWunA1yjpQsji9gIN0FswBoWsTa7V82w5PmlsqozH9jNfPnYdo
 pT8RxVr8xBaRorub6wW0UEbBhyA9j94GScqPQjiNzXLevwZ/Lr1N3qsn8BYXpbvfHm
 g0Zsv2ZteabsyOOxRUZHGmN1rbsMuPnXpmbSxd8g=
MIME-Version: 1.0
To: "A.s. Dong" <aisheng.dong@nxp.com>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1542200198-3017-8-git-send-email-aisheng.dong@nxp.com>
References: <1542200198-3017-1-git-send-email-aisheng.dong@nxp.com>
 <1542200198-3017-8-git-send-email-aisheng.dong@nxp.com>
Message-ID: <154386554175.88331.9328534190030483928@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH V6 7/9] clk: imx: make mux parent strings const
Date: Mon, 03 Dec 2018 11:32:21 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_113234_732016_BD51438E 
X-CRM114-Status: UNSURE (   7.55  )
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

Quoting A.s. Dong (2018-11-14 05:02:00)
> As the commit 2893c379461a ("clk: make strings in parent name arrays
> const"), let's make the parent strings const, otherwise we may meet
> the following warning when compiling:
> 
> drivers/clk/imx/clk-imx7ulp.c: In function 'imx7ulp_clocks_init':
> drivers/clk/imx/clk-imx7ulp.c:73:35: warning: passing argument 5 of
>         'imx_clk_mux_flags' discards 'const' qualifier from pointer target type
> 
>   clks[IMX7ULP_CLK_APLL_PRE_SEL] = imx_clk_mux_flags("apll_pre_sel", base + 0x508, 0,
>         1, pll_pre_sels, ARRAY_SIZE(pll_pre_sels), CLK_SET_PARENT_GATE);
>                                    ^
> In file included from drivers/clk/imx/clk-imx7ulp.c:23:0:
> drivers/clk/imx/clk.h:200:27: note: expected 'const char **' but argument is
>  of type 'const char * const*'
> ...
> 
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> 
> ---

Applied to clk-next


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
