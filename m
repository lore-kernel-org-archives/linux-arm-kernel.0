Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BECC6786C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 05:44:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFD6220811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 05:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tmvaasIc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EX6AFq1D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFD6220811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:From:Message-ID:References:To:
	Subject:In-Reply-To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1Ib+Z9Es8qHG1SzZhpj64hgeunYA5BqBk0bCgDgpVkw=; b=tmvaasIcebsiav
	Lgm5rvzMIJhlUwfk+jQmysifecTw/nqNh/YZTFYxhYktTPtJXMeNWPELc/8fu7dSdcymShc660iOd
	QQ5zlUvGeD9CV7uG8OP7ZUtTjiUMBmAeQqIPGoXR3m5+dTH0NSovN33dB0J0i9nZFxT9PrvLADubC
	rXd4z/428jhQ+7XAnJnSUxKVa4p4S8RYmpO0CSeb3NmyciZn/NgnfsRfdrRy/3jN43XCIP43pkX3o
	wFkWKHkmxzxPp2dyQETnTQc8mfct9Qd50OSwTbRyoiNPsd+MJ9mAeup2Z490j0pu0RWeS4h6mMcWm
	TVWSdiyBZtJak7FNtVvg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXgH3-0005fa-Jo; Fri, 14 Dec 2018 05:44:33 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXgGz-0005ef-Jd
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 05:44:31 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1C69B20811;
 Fri, 14 Dec 2018 05:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544766259;
 bh=zEtND072MverXHNjnDrs63pMQCgNgJnQz1m9DMrCxJQ=;
 h=In-Reply-To:Subject:To:References:From:Cc:Date:From;
 b=EX6AFq1DJgwPgmX6YbBdjbXvTakkUZ3APNNb6Vo61V3L0nx9/N2x+DWhbxCCsg7oT
 PvpI1TaEfanGBthHXPz2J8N5cog7PVWmujj+8h42O+uzH8wpPzso/mgN99m5NYTC8b
 nXR7A8Y7TXFCxyM2sJKdVyo0Eqy+ZsTRExBngGnw=
MIME-Version: 1.0
In-Reply-To: <AM0PR04MB4211CEFB586B7878BBB58FEB80A10@AM0PR04MB4211.eurprd04.prod.outlook.com>
Subject: RE: [PATCH V12 0/5] clk: imx: add imx8qxp clock support
To: Aisheng Dong <aisheng.dong@nxp.com>, Shawn Guo <shawnguo@kernel.org>
References: <1544715442-8902-1-git-send-email-aisheng.dong@nxp.com>
 <20181214020533.GC13243@dragon>
 <AM0PR04MB42114ACB1A55BB42D2C5523280A10@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20181214031931.GD13243@dragon>
 <AM0PR04MB4211D692CBED348EF8C109A180A10@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20181214035606.GE13243@dragon>
 <AM0PR04MB4211CEFB586B7878BBB58FEB80A10@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <154476625826.19322.10114583343237309899@swboyd.mtv.corp.google.com>
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
Date: Thu, 13 Dec 2018 21:44:18 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_214429_681900_25F98206 
X-CRM114-Status: GOOD (  23.45  )
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
Cc: "mturquette@baylibre.com" <mturquette@baylibre.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Aisheng Dong (2018-12-13 20:57:46)
> > -----Original Message-----
> > From: Shawn Guo [mailto:shawnguo@kernel.org]
> > On Fri, Dec 14, 2018 at 03:37:47AM +0000, Aisheng Dong wrote:
> > > > -----Original Message-----
> > > > From: Shawn Guo [mailto:shawnguo@kernel.org] On Fri, Dec 14, 2018 at
> > > > 02:17:04AM +0000, Aisheng Dong wrote:
> > > > > [...]
> > > > > > > Note: It depends on SCU driver which has already been merged
> > > > > > > by
> > > > Shawn.
> > > > > > > So this patch series could go through Shawn's tree as well.
> > > > > >
> > > > > > To be clear, I'm not going to take this via my tree, and it
> > > > > > definitely needs to go through clk tree.  If there is a
> > > > > > dependency on my tree, you will likely need to wait for the
> > > > > > dependency to land on
> > > > mainline and then retry.
> > > > > >
> > > > >
> > > > > Sorry, I should have corrected that comment.
> > > > > It's not depend on SCU driver which is already in the Stephen's tree.
> > > > > It actually depends on the resource ID definitions[1] and the
> > > > > centralized PM related service definitions headifle in in power
> > > > > domain series which is already in your tree.
> > > > >
> > > > > [2] can be fixed by defining them in clock driver.
> > > > > But [1] seems can't be fixed as resource ID is shared by power
> > > > > domain and possible many other SCU client drivers.
> > > > >
> > > > > Any suggestion?
> > > >
> > > > After [1] and [2] land on v4.21-rc1, you rebase the series on that.
> > > > The dependency will be gone, right?  This is what I suggested above.
> > > >
> > >
> > > Okay, that may need a few more weeks.
> > > BTW, after v4.21-rc1 is out, can the mx8qxp CLK and DTS hit the final v4.21
> > release?
> > > As I understand, usually we don't receive new feature patch after the
> > > first RC, right?
> > 
> > Yes, they will have to land on 4.22 then.
> 
> That's unfortunately and may need wait 3 more months.
> I really wish we can hit v4.21-rc1, then other modules driver can start
> their work based on it.
> 
> Stephen,
> What's your option?
> 
> Can we try the same way as Shawn did for arch and dts part?
> 

I see some options:

	1. Shawn can provide the required header files in some signed
	tag that I can pull into clk tree and then apply these patches
	on top and merge it all up into clk-next.

	2. I can pick any patches required for the header files the clk
	driver needs into clk tree and duplicate the commits in Shawn's
	tree. I don't see a big downside here, git manages just fine
	when it sees duplicate content on both sides of a merge so it's
	just more noise than anything else.

	3. I apply the clk driver bits but nobody tries to enable the
	config option around it just yet. Instead, we wait for
	everything to meet up in linux-next via different trees and then
	enable compilation later. This is bad for compile testing
	drivers and makes it harder to bisect problems later. Probably
	not a big deal here for bringing in new hardware support but it
	might work out.

	4. We all wait three months (happy new year!) but otherwise are
	sad that we can't figure this out.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
