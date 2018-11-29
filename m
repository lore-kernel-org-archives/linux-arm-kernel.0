Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC4AC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:52:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FD3B21019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uM4RX04O";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ybPTvHHz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FD3B21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gQf5qqtUMYFJAbCgjIfsXpN4i9fWCM1HAlyisQJHu04=; b=uM4RX04Ot7FlQN
	btOIEp7U7G5OkOKElvFtmyEg8WYyePXmhEtuN6JnJybW2E5xNgA/5TpaHfzXLbHNPb8k3cwSf9Wdx
	oKzLPIW0Wlq/MGO1UzR8itZ3kLF2PPnMd166hP9K9/HWF2hNouSMxHH1XxXGXJoR7LPM/89ILY3sK
	57ulkRlizpOvFDOfgb4/TRX/uRkSz+cdZQRS2gwzwDThgM3Cu58jqp278ts16FH1TJjLVbh9AEdnB
	ymiyNylLdR+XrAuMpM81F45reI8Ha4uSEgkNFw0Xi9xFgBUPzqOLSumnkBnjnzLc/wYCULx8Ulx8o
	JJ3VF6k7cQApf0dhNTtQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSUEN-0004VV-0c; Thu, 29 Nov 2018 21:52:19 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSUDL-0003hM-TO
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 21:51:19 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2827521019;
 Thu, 29 Nov 2018 21:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543528265;
 bh=qsEDmw2EjV+cE5P+2S+AvdpnpQQ6ZLjFtSihyjsKzH0=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=ybPTvHHzhYjdgC87Gsd1XNAfhsit/SQMs/+yR+mS/l0FEjLBb0zJAxZ+5wNqzUf//
 PhpDwaKd8tl3c/SbK+EMqEn7sSHsRidjnitBSdj+f3ezt9rUkLGuyLqgpdFI/qXpsF
 JFw4SKEPR02Q3NgtooD9csR6YxZP0eKUvrkHhqlM=
MIME-Version: 1.0
To: Abel Vesa <abel.vesa@nxp.com>, Aisheng DONG <aisheng.dong@nxp.com>,
 Lucas Stach <l.stach@pengutronix.de>, Sascha Hauer <kernel@pengutronix.de>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <AM0PR04MB42117F72B9C4D41C14B96CBD80D20@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1542125975-8448-1-git-send-email-abel.vesa@nxp.com>
 <154345210894.88331.8277410833858111600@swboyd.mtv.corp.google.com>
 <AM0PR04MB42117F72B9C4D41C14B96CBD80D20@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <154352826457.88331.16669625591730377740@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: RE: [PATCH v13 0/5] Add i.MX8MQ clock driver
Date: Thu, 29 Nov 2018 13:51:04 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_135116_049383_48591B15 
X-CRM114-Status: GOOD (  12.20  )
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
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Abel Vesa <abelvesa@linux.com>, dl-linux-imx <linux-imx@nxp.com>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Aisheng DONG (2018-11-28 23:46:41)
> > -----Original Message-----
> > From: Stephen Boyd [mailto:sboyd@kernel.org]
> [...]
> > >
> > > Changes since v12:
> > >  * replaced the division in clk_pll_recalc_rate in clk-frac
> > >    with do_div as suggested by Stephen
> > >
> > > Abel Vesa (2):
> > >   clk: imx: Add imx composite clock
> > >   clk: imx: Add clock driver for i.MX8MQ CCM
> > >
> > > Lucas Stach (3):
> > >   dt-bindings: add binding for i.MX8MQ CCM
> > >   clk: imx: add fractional PLL output clock
> > >   clk: imx: Add SCCG PLL type
> > >
> > 
> > I had to apply this set of fixes to silence sparse and smatch warnings about
> > things that are not right. Please take a look over things and see if it's sane.
> > 
> 
> The change looks good to me and tested ok.
> I did not see this patch series in your tree.
> Do you want us to apply your changes and re-send for easy pick up?
> 

I applied this version and my fixes. I'll just mark v14 as superseded.
Thanks for testing!


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
