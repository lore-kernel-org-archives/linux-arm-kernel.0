Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AABAC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:41:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF59420989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z+KqZz58";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGo1uSUs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF59420989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XJFApYBIfcIZOyTcHdEykDCtTbJRRtYrYA+txm+wZfg=; b=Z+KqZz58l2v2/y
	XHhN7YeS0do9Yzr8VwQvaxKZCQStanxUYMfRRYRbkLsKAZ9DuDpv3IwSPe1oxWRDUtYQWiDe8PEPy
	BiwhumaP3JpE57XxiiImDdPUo0vuMo9uRCYzIP0nWwC6a3kaXd2y59X4GKXdWPX7zZdKf2X5+kiRd
	BXux1m3SgYZT1/45VEcPG4oRYCu3xV/8Hdta+aF9+2Et0PVWWmJ0iA/T/U0gs/R/up+uX5e1BzQGX
	keHKVvSeRJIGu0jMX512PVqU7D7wsEq4p4OxNBm2pxlHEYyIaoaKzrtowd5Eu40heACoK4pgv9srE
	sHk4fFsyOBiQbJUa0b2g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUd2q-0004rw-4r; Wed, 05 Dec 2018 19:41:16 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUd2n-0004r4-44
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 19:41:14 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B219220892;
 Wed,  5 Dec 2018 19:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544038862;
 bh=c06hqMnM00NOPeTCT27KnLTKJd29CYg7xBJXvl/L2lE=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=OGo1uSUsl+FQCjMfP6uueQvHzEFP2KH3k0mwdEURqihz+w3PKZXjW21X5wWIcmKDY
 yfjzL+KOupCXFQKVxBfR3YGZsTCFp/O1XoGG6mQv2bIKyCctIuwdc8fhJ7UfQN/kLT
 Tl9Q1nDuA20eeTCi6i+dLSc3TdOow8Fm0Mx5L4XA=
MIME-Version: 1.0
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 Aisheng DONG <aisheng.dong@nxp.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <AM0PR04MB42111FFF525D6EC5D785692380AF0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1542200198-3017-1-git-send-email-aisheng.dong@nxp.com>
 <154386550302.88331.785218354920872757@swboyd.mtv.corp.google.com>
 <AM0PR04MB42111FFF525D6EC5D785692380AF0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <154403886196.88331.15597466595875847820@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: RE: [PATCH V6 0/9] clk: add imx7ulp clk support
Date: Wed, 05 Dec 2018 11:41:01 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_114113_177255_F8547B68 
X-CRM114-Status: GOOD (  13.53  )
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
Cc: Jacky Bai <ping.bai@nxp.com>, Anson Huang <anson.huang@nxp.com>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Aisheng DONG (2018-12-03 17:29:29)
> > -----Original Message-----
> > From: Stephen Boyd [mailto:sboyd@kernel.org]
> > Sent: Tuesday, December 4, 2018 3:32 AM
> > To: Aisheng DONG <aisheng.dong@nxp.com>; linux-clk@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > mturquette@baylibre.com; shawnguo@kernel.org; Anson Huang
> > <anson.huang@nxp.com>; Jacky Bai <ping.bai@nxp.com>; dl-linux-imx
> > <linux-imx@nxp.com>; Aisheng DONG <aisheng.dong@nxp.com>
> > Subject: Re: [PATCH V6 0/9] clk: add imx7ulp clk support
> > 
> > Quoting A.s. Dong (2018-11-14 05:01:31)
> > > This patch series intends to add imx7ulp clk support.
> > >
> > > i.MX7ULP Clock functions are under joint control of the System Clock
> > > Generation (SCG) modules, Peripheral Clock Control (PCC) modules, and
> > > Core Mode Controller (CMC)1 blocks
> > >
> > > The clocking scheme provides clear separation between M4 domain and A7
> > > domain. Except for a few clock sources shared between two domains,
> > > such as the System Oscillator clock, the Slow IRC (SIRC), and and the
> > > Fast IRC clock (FIRCLK), clock sources and clock management are
> > > separated and contained within each domain.
> > >
> > > M4 clock management consists of SCG0, PCC0, PCC1, and CMC0 modules.
> > > A7 clock management consists of SCG1, PCC2, PCC3, and CMC1 modules.
> > >
> > > Note: this series only adds A7 clock domain support as M4 clock domain
> > > will be handled by M4 seperately.
> > >
> > 
> > I got:
> > 
> > drivers/clk/imx/clk-pllv4.c:152:15: warning: symbol 'imx_clk_pllv4' was not
> > declared. Should it be static?
> > drivers/clk/imx/clk-pfdv2.c:166:15: warning: symbol 'imx_clk_pfdv2' was not
> > declared. Should it be static?
> > drivers/clk/imx/clk-divider-gate.c:174:15: warning: symbol
> > 'imx_clk_divider_gate' was not declared. Should it be static?
> > drivers/clk/imx/clk-composite-7ulp.c:22:15: warning: symbol
> > 'imx7ulp_clk_composite' was not declared. Should it be static?
> > 
> > which I can fix easily by throwing in clk.h into each file.
> 
> Thanks, I will double check it when I back to office.
> 

No worries, I fixed it up and merged to clk-next.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
