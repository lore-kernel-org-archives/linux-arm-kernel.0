Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32280C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:32:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4A072146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uOEa1fnE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGpOFkpv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4A072146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ru1nGdaHVQYo9Br8h0mXHf+Sd5pXbbgF5QfL37TVw0g=; b=uOEa1fnEwCcfor
	CNR5VabcljVWfWApiasPdo5quQBtsTwTo/t2wxcDVsIDZRmlnWgVk7AlVeRVH0ezkPua1oYH+e+yU
	tCQ63QtGCdnidQi4uAbu6tRReP2bu7QZhIexvuxbXKcoWSbvrrJpcRUf82C2EZSYCe4wRq5M2BstP
	d/g9bvKuPg/ulXqS4k2n8LGD0erwXeVZctn9ac2v4HWlgxX3uZYWBZbe/Bc+sWx7n8tVvGDUjgRDR
	j7zS1uJE2pfbwdQL6DtPlxHceJXDDlhxC2Oxitxn6vgkGXVAnHhlc8a4Vso11mT88OGxb1Fm/W+J+
	LdMvhQjedIyoQxpljN9w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTtxJ-0000qP-8T; Mon, 03 Dec 2018 19:32:33 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTtwg-00006A-5J
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 19:31:57 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A6BC32081C;
 Mon,  3 Dec 2018 19:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543865503;
 bh=EpU8ahTAcUeE0VWeJAlpdwbWBlwtxLz63+h9P4QqtRw=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=BGpOFkpvaybDGugOuPseg/zA7VCP9gSuVHrGZQaEtbKd2UUOG98BgLiiv74c/qd+U
 WpRtiiAIioC6K74jKqQeLWNUuTegtEfu4Lnq2DU6IGpwv2nH/5Qw8dNozRqOu/TwqZ
 ejX3DvMhBhbOW7BDgKQsLyE8XOGAmHYGsCW4QOUI=
MIME-Version: 1.0
To: "A.s. Dong" <aisheng.dong@nxp.com>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1542200198-3017-1-git-send-email-aisheng.dong@nxp.com>
References: <1542200198-3017-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <154386550302.88331.785218354920872757@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH V6 0/9] clk: add imx7ulp clk support
Date: Mon, 03 Dec 2018 11:31:43 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_113154_412329_60DE28A9 
X-CRM114-Status: UNSURE (   8.48  )
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
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting A.s. Dong (2018-11-14 05:01:31)
> This patch series intends to add imx7ulp clk support.
> 
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
> Note: this series only adds A7 clock domain support as M4 clock
> domain will be handled by M4 seperately.
> 

I got:

drivers/clk/imx/clk-pllv4.c:152:15: warning: symbol 'imx_clk_pllv4' was not declared. Should it be static?
drivers/clk/imx/clk-pfdv2.c:166:15: warning: symbol 'imx_clk_pfdv2' was not declared. Should it be static?
drivers/clk/imx/clk-divider-gate.c:174:15: warning: symbol 'imx_clk_divider_gate' was not declared. Should it be static?
drivers/clk/imx/clk-composite-7ulp.c:22:15: warning: symbol 'imx7ulp_clk_composite' was not declared. Should it be static?

which I can fix easily by throwing in clk.h into each file.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
