Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC90BC6786C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 05:31:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8635A2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 05:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="B/VMOlGq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZ9iZ2D1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8635A2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EnundmnTQ5v2K6l+7VK81tyRU+xhPIgRipPicHN5wwA=; b=B/VMOlGqHYaO4N
	yGVeIfv/U5zT4GoWglxK/xbCooyetKdG9ne9OCZ5xc1Ar2I7O+Xobkgqsx0eM/iQQAeXz7AVXe90b
	RZkHJNilzriB1yeVlm9EWKNTmIE2NWswUvuOPOm+NuCVSQzWU41lX6ZwFAc+EHkJlV7EhcijnewHF
	ToTKh4NbsYTOOOw5XXpttfhP85qYq3UbBtwku8qLGBygojkwAe/rDRG+tf5gZNXWeGZAYB9YBObfy
	tUKU/3f4RHJpA33A0Zg3gsw9PQtB+DsI249wAf2FdhPzbWg4qS0YW8Y1apDh8mMRjhghMjDKp/w9m
	Bwp3K5aum3wcvfhuqs3Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXg4j-0001xn-KQ; Fri, 14 Dec 2018 05:31:49 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXg4g-0001xO-Ls
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 05:31:48 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D341E2086D;
 Fri, 14 Dec 2018 05:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544765495;
 bh=rIOJJ+2D70qQq778arfE7ZJ0dYcq8ltO9JSnsC2/vas=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lZ9iZ2D19tHr6spXfqhp207IxOuhLy71pLBn2SBUP+vzHFAScNPBo1DtmJbX/xPKL
 J1cgTh8rGzob1P15g62r5ZDPbPA0eGGsGihCiMGAJRsHubXRE8Znyk+IDZ1k2sFSJu
 wioInLaD007yvWqfmRjKMMAbA3LEZOMdeOCP54DU=
Date: Fri, 14 Dec 2018 13:30:35 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Aisheng Dong <aisheng.dong@nxp.com>
Subject: Re: [PATCH V12 0/5] clk: imx: add imx8qxp clock support
Message-ID: <20181214053033.GF13243@dragon>
References: <1544715442-8902-1-git-send-email-aisheng.dong@nxp.com>
 <20181214020533.GC13243@dragon>
 <AM0PR04MB42114ACB1A55BB42D2C5523280A10@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20181214031931.GD13243@dragon>
 <AM0PR04MB4211D692CBED348EF8C109A180A10@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20181214035606.GE13243@dragon>
 <AM0PR04MB4211CEFB586B7878BBB58FEB80A10@AM0PR04MB4211.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AM0PR04MB4211CEFB586B7878BBB58FEB80A10@AM0PR04MB4211.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_213146_752559_ABE69E2D 
X-CRM114-Status: GOOD (  20.81  )
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
Cc: "sboyd@kernel.org" <sboyd@kernel.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 14, 2018 at 04:57:46AM +0000, Aisheng Dong wrote:
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

You can not always expect all the pieces get in with one merge window.
It's very usual in upstreaming process that the dependant parts lands in
mainline with multiple release cycles.

> Stephen,
> What's your option?
> 
> Can we try the same way as Shawn did for arch and dts part?

In case Stephen is fine by pulling dependency from my tree, it's all on
branch below, which has been pulled/queued by arm-soc folks for 4.21
merge window.

 git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git imx/drivers

Shawn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
