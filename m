Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E70C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 03:20:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 782D620870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 03:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nh/FMFGQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/hUj4q5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 782D620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1IYLl0NHylPf0j5W0zjX/VbQ1Sm4G/fCTauhNlvBjUg=; b=nh/FMFGQpB5SLU
	tPCPsGkAB4klCLh4YYg9Rp19rvaMI1Z0DQvodUqjNTSIcf+r4E79fqPCUfTYcljaaWuyXsimKk3j6
	YuegQ1DCAjsOoKJ4Ux1gBw3agnCyo1xayBzI7jNnJdkIGbboeY7iePE77oe9UovDCKvinx/PJQw5G
	88m40r/yfcrZ1Nv/k0Jbp9mD2nCg6qewdI6O4xz6qQPkC7mvFnU2Udkx4p7djImdg6vRAn4xs8N6F
	Am0bjHz0S5Wp76h5lVFQby5L1WsUNVTIqzqNCzheUlX55zu+8asAP8J5lU+8xPaftF5bAKb3yvnip
	N1ojkPSFuB3ch5WHqVdQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXe1v-00024D-LM; Fri, 14 Dec 2018 03:20:47 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXe1q-00023b-E8
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 03:20:46 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 784CA2054F;
 Fri, 14 Dec 2018 03:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544757631;
 bh=aCCCAYs8y/8FQyTryYtQNgvYdyv1NUjaVmpTVbHW8+k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=R/hUj4q5LaFs7+3SGh/RrABccuOwBWmZu9m57y1HAybA1uy/1qQ0c+o0Hyj5V6Bqf
 XksJezj3VP9JEw0ZW0+gaOjq3lX6CWsDnE0MbvwbBmSt4FtqhvO14kPa58yWl3a1Ge
 RYHtN4TrKj8uX+UxaLfmOomvGU4JIcjdiFp5VfMM=
Date: Fri, 14 Dec 2018 11:19:32 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Aisheng Dong <aisheng.dong@nxp.com>
Subject: Re: [PATCH V12 0/5] clk: imx: add imx8qxp clock support
Message-ID: <20181214031931.GD13243@dragon>
References: <1544715442-8902-1-git-send-email-aisheng.dong@nxp.com>
 <20181214020533.GC13243@dragon>
 <AM0PR04MB42114ACB1A55BB42D2C5523280A10@AM0PR04MB4211.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AM0PR04MB42114ACB1A55BB42D2C5523280A10@AM0PR04MB4211.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_192044_653362_CC616941 
X-CRM114-Status: GOOD (  13.57  )
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

On Fri, Dec 14, 2018 at 02:17:04AM +0000, Aisheng Dong wrote:
> [...]
> > > Note: It depends on SCU driver which has already been merged by Shawn.
> > > So this patch series could go through Shawn's tree as well.
> > 
> > To be clear, I'm not going to take this via my tree, and it definitely needs to go
> > through clk tree.  If there is a dependency on my tree, you will likely need to
> > wait for the dependency to land on mainline and then retry.
> > 
> 
> Sorry, I should have corrected that comment.
> It's not depend on SCU driver which is already in the Stephen's tree.
> It actually depends on the resource ID definitions[1] and the centralized PM
> related service definitions headifle in in power domain series which is already
> in your tree.
> 
> 1. https://patchwork.kernel.org/patch/10664125/
> 2. https://patchwork.kernel.org/patch/10664137/
> 
> [2] can be fixed by defining them in clock driver.
> But [1] seems can't be fixed as resource ID is shared by power domain
> and possible many other SCU client drivers.
> 
> Any suggestion?

After [1] and [2] land on v4.21-rc1, you rebase the series on that.  The
dependency will be gone, right?  This is what I suggested above.

Shawn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
