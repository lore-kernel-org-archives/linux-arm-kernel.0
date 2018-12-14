Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E8FC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 06:15:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBFA720866
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 06:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c9+GUT0O";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="loAKaW3b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBFA720866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:From:Message-ID:References:To:
	Subject:In-Reply-To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gpcdce0fhH6gdMHbCrJjuiVx96/CDcNTZbrQu83OxJk=; b=c9+GUT0OGQQEMY
	+lKxqsNrkwduIIZVUmswEXDw+wEe3X/9vNZ9a0OLqBqp/1roCVz6DBATjX2FvjdXbbXV/efuNFiV/
	xGj2Lo5ObAFw6UY0ct2pMC5SE5R7PqjYyiMoExZ7Hjp/uW/1VdZ7W+r6xTu2kTDDhXIElqXl1xo21
	OlNt3o0JA+1HHslfpoY4AqIzs+ewj/Z3BEKiNM64aKstPq7DwAwxGRctQY3JhEQETIOSkMwUsYNA6
	A5Nni6jDx2AtNdtMsQocnw0QqgXjekFFZb64GKXlXNjRkeEdqM7/JZ5hOUantkwhYG8FJgehHgSif
	Jk/nu/VdETMGbpxumBkw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXgl7-0000NL-IS; Fri, 14 Dec 2018 06:15:37 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXgl4-0000MB-8u
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 06:15:35 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D6C7720811;
 Fri, 14 Dec 2018 06:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544768124;
 bh=BCQ0LbNWC79KT9SlAAcLyRjVLVQkhRzjZKVng6YMYBw=;
 h=In-Reply-To:Subject:To:References:From:Cc:Date:From;
 b=loAKaW3bDQuCllvjtWwhbpwWsX35TLcBYsLtwc4ky13DKTafpypZJ7trxZHUoc2+n
 nDwiNImYWl9y7gygK+NuYZKXjLSiwbvdgqps9AbLJp4pk9h5cfxa1ghVmIfWjgPXT7
 BuE1HLb3jhN+Tdx3d9RxjNPBXJg/OobNNMzMYjrU=
MIME-Version: 1.0
In-Reply-To: <154476762849.19322.6761040252503231833@swboyd.mtv.corp.google.com>
Subject: Re: [PATCH V12 0/5] clk: imx: add imx8qxp clock support
To: Aisheng Dong <aisheng.dong@nxp.com>, Shawn Guo <shawnguo@kernel.org>
References: <1544715442-8902-1-git-send-email-aisheng.dong@nxp.com>
 <20181214020533.GC13243@dragon>
 <AM0PR04MB42114ACB1A55BB42D2C5523280A10@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20181214031931.GD13243@dragon>
 <AM0PR04MB4211D692CBED348EF8C109A180A10@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20181214035606.GE13243@dragon>
 <AM0PR04MB4211CEFB586B7878BBB58FEB80A10@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20181214053033.GF13243@dragon>
 <154476762849.19322.6761040252503231833@swboyd.mtv.corp.google.com>
Message-ID: <154476812306.19322.4832664425826114886@swboyd.mtv.corp.google.com>
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
Date: Thu, 13 Dec 2018 22:15:23 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_221534_330843_C4501674 
X-CRM114-Status: UNSURE (   7.75  )
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

Quoting Stephen Boyd (2018-12-13 22:07:08)
> Quoting Shawn Guo (2018-12-13 21:30:35)
> > 
> > In case Stephen is fine by pulling dependency from my tree, it's all on
> > branch below, which has been pulled/queued by arm-soc folks for 4.21
> > merge window.
> > 
> >  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git imx/drivers
> > 
> 
> I can pull just the first patch from this branch and then everything
> will compile? That should be OK.
> 

Hm.. turns out I need to pull up to

0a914a4948d4 firmware: imx: add pm svc headfile

but then it all compiles fine. Ok I can do that.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
