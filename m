Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5724DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:09:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DF0D2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K8+kALLB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAAOyUTS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DF0D2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:From:Message-ID:References:To:
	Subject:In-Reply-To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rkJJuyaRtEC3nH/R/kVMU0WdVvwsHUYu1efJEfNjc3w=; b=K8+kALLBqE2M1I
	tjbfv6YIKXWGiWWu0vK62p8/LCO/PKOBHCzGW9kgQ1th3f+WC3wv6WFzNORi48+4EZFz1RPDpw/Gw
	4PYpYuweK9hMALq8iquQVK414/H88a7lLMta9wFf+/6GX7ebYaUxNN9iBCvhHeYeW38qBNUeuZ51z
	VQ9bxOzoqwRSL5iBpWl+/BS+jtD1MeXhoDyAi/1Tkl62D6J7qK6ca3MUWkoGxEYWQ0Cv3x8MkkQut
	YFOiKIwPjRHNer0YgkC3RcKSp4Xq0VW1o2O6N1KySZICvpUcVgoBJpUaPBJbWNvXCSyEOzXeRDGUV
	d4NNJnuVd4CMS7ZlEBCg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXuiW-00043p-OE; Fri, 14 Dec 2018 21:09:52 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXuhn-0003Et-UO
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 21:09:09 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 860A8208C1;
 Fri, 14 Dec 2018 21:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544821740;
 bh=qtv9fCbo5zble2Uy57MuGKLgicbzVs3JmMyN85OaTuw=;
 h=In-Reply-To:Subject:To:References:From:Cc:Date:From;
 b=jAAOyUTSi9Qvrjc0UmI25nb06qnK8Io2Nrp6Z7iPyiqBxRuATcu6yOCTHd23Fz7P/
 F3sTV7LCdsESM0vv2TFNMUCVk3z2Kn27oc6maD0/bPvYxvclhyv6Oy/ocWyuBeiNVW
 6OzrVIEkQbpMytaLP5n0kRfUGjDWD0I5GJ/eKzj0=
MIME-Version: 1.0
In-Reply-To: <1544715442-8902-3-git-send-email-aisheng.dong@nxp.com>
Subject: Re: [PATCH V12 2/5] clk: imx: add scu clock common part
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 Aisheng Dong <aisheng.dong@nxp.com>
References: <1544715442-8902-1-git-send-email-aisheng.dong@nxp.com>
 <1544715442-8902-3-git-send-email-aisheng.dong@nxp.com>
Message-ID: <154482173946.19322.455504829466810893@swboyd.mtv.corp.google.com>
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
Date: Fri, 14 Dec 2018 13:08:59 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_130908_024267_15D7100D 
X-CRM114-Status: UNSURE (   6.84  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Aisheng Dong (2018-12-13 07:42:54)
> Add SCU clock common part which will be used by client clock drivers.
> SCU clocks are totally different from the legacy clocks (No much
> legacy things can be reused), it's using a firmware interface now based
> on SCU protocol. So a new configuration option CONFIG_MXC_CLK_SCU is added.
> 
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---

Applied to clk-next


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
