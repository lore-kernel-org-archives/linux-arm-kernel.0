Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F55BC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:40:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB124208A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l9qIhaUP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1VavgUKd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB124208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NDej8obluN5ogRy0CAxceJqnEU5VpyRzEQv4DhWKfVI=; b=l9qIhaUPmdVa7G
	dVC6VvqZ/3oaykW2Esjge1kEZwsqSai9xaCjfP+bXN+1wV0Awj5qTn50zhh0usRY8n2kTbk/GNSoY
	3HrE1r8Lpq0wDC9440zDhUJWLGX9kLAFGNr5sYoh3XoYykNusKrlEYhc8O/is1BpUC6Ohads9s8aH
	HqcIrxzJj9wRY9l5Eb3XVdLSaRVSMm+ypJ/ibZaJ/Q/fxRwbXTCy7XsuUzaKkwQDiS1suphKUu6Hd
	s/HkeJVFT2XoLAdpEVzOqkdOEn7g7Kpe/9E9QcxA4hrOZrFAspB6wgO9ZEvWAQCmKO8rX12sf2VQJ
	MTVZkwDGoNbBXpTW3rzA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTu4x-0007IZ-5f; Mon, 03 Dec 2018 19:40:27 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTtxZ-0000y5-OQ
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 19:33:35 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DA417208A3;
 Mon,  3 Dec 2018 19:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543865559;
 bh=4bP7New99I5IjCoQ+tB0VrAfQHewIzJFR3Qi+YsKEt8=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=1VavgUKdYWRYlHHR3Y23oMB+HnM54kz8Jq1di0yR18QZX+FWSFXEY7nJkB6ZihZS7
 ykqg/6TKlTWyeW7KYLGSVI9dgzHbaSp0N4IgDUg/1+oljXSUw8XIx7GW+/Yl05OnzH
 +j6n8tTXD7IURGTW1rfXI6JBHZWz0/PEL+TsUzik=
MIME-Version: 1.0
To: "A.s. Dong" <aisheng.dong@nxp.com>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1542200198-3017-10-git-send-email-aisheng.dong@nxp.com>
References: <1542200198-3017-1-git-send-email-aisheng.dong@nxp.com>
 <1542200198-3017-10-git-send-email-aisheng.dong@nxp.com>
Message-ID: <154386555833.88331.17771094561482296098@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH V6 9/9] clk: imx: add imx7ulp clk driver
Date: Mon, 03 Dec 2018 11:32:38 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_113250_643924_5DA79FE5 
X-CRM114-Status: UNSURE (   9.15  )
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

Quoting A.s. Dong (2018-11-14 05:02:08)
> i.MX7ULP Clock functions are under joint control of the System
> Clock Generation (SCG) modules, Peripheral Clock Control (PCC)
> modules, and Core Mode Controller (CMC)1 blocks
> 
> The clocking scheme provides clear separation between M4 domain
> and A7 domain. Except for a few clock sources shared between two
> domains, such as the System Oscillator clock, the Slow IRC (SIRC),
> and and the Fast IRC clock (FIRCLK), clock sources and clock
> management are separated and contained within each domain.
> 
> M4 clock management consists of SCG0, PCC0, PCC1, and CMC0 modules.
> A7 clock management consists of SCG1, PCC2, PCC3, and CMC1 modules.
> 
> This driver only adds clock support in A7 domain.
> 
> Note that most clocks required to be operated when gated, e.g. pll,
> pfd, pcc. And more special cases that scs/ddr/nic mux selecting
> different clock source requires that clock to be enabled first,
> then we need set CLK_OPS_PARENT_ENABLE flag for them properly.
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
