Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20943C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 03:57:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E608B2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 03:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kURUWdrQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="t/3SxZ73"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E608B2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NbmUlcEYhMvccMLVwwKmkDhTK1yIrCPx6sbWrHzrI5g=; b=kURUWdrQ9z+HnV
	Hf4DPc+2//n7YsLebb41R+Wo9arTBd7IR7oyzz363jeA62oe/NZiOKmdKV3yBK/FRABbfvP3xJCWi
	6zujsAAeb5YmyziKp5NzoumF7zzL1IQlY/M9qpC2axBbKGLBOg6lD8E+bRCn4iwutTQ2VXE04hOjU
	8m/wdPL+mk6zUdyIbfI7q/kQq26flqRfp+4DLx3tUectEXF9C010RRiI8z8OUgKakArcrqxz8ARb1
	oTgyjaQXaycInY4MEWNdJBfwb23nAfiZ2DebYFoygv8SvKN1DbxrBDjC1l0KY5k+x7D8znITKztWs
	Wtwh54sHv6ZJwaCnuTJA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXebJ-0004PY-0A; Fri, 14 Dec 2018 03:57:21 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXebF-0004OZ-Pq
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 03:57:19 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8D74C2086D;
 Fri, 14 Dec 2018 03:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544759827;
 bh=Dq9naHHMhruE6QJzGF+MrbrZJN05iqujzsiSxbMqiUU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=t/3SxZ73LvmPvFkW48vLF50U82pzIDfU50r/hG9LSsdoGSfZU1ffwvLNH4T5z1G+G
 JQsDRMJViJ1dihykSvwryjJy8b58Ux72iok5DBQ2lbiQeeOdjmCqyG8GdXAWdCsItA
 d5Iq9dTPOvNFlmGYFgXR6oIucZd99Qw9nKkgUeOA=
Date: Fri, 14 Dec 2018 11:56:07 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Aisheng Dong <aisheng.dong@nxp.com>
Subject: Re: [PATCH V12 0/5] clk: imx: add imx8qxp clock support
Message-ID: <20181214035606.GE13243@dragon>
References: <1544715442-8902-1-git-send-email-aisheng.dong@nxp.com>
 <20181214020533.GC13243@dragon>
 <AM0PR04MB42114ACB1A55BB42D2C5523280A10@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20181214031931.GD13243@dragon>
 <AM0PR04MB4211D692CBED348EF8C109A180A10@AM0PR04MB4211.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AM0PR04MB4211D692CBED348EF8C109A180A10@AM0PR04MB4211.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_195717_861596_327BCA1A 
X-CRM114-Status: GOOD (  17.22  )
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

On Fri, Dec 14, 2018 at 03:37:47AM +0000, Aisheng Dong wrote:
> > -----Original Message-----
> > From: Shawn Guo [mailto:shawnguo@kernel.org]
> > On Fri, Dec 14, 2018 at 02:17:04AM +0000, Aisheng Dong wrote:
> > > [...]
> > > > > Note: It depends on SCU driver which has already been merged by
> > Shawn.
> > > > > So this patch series could go through Shawn's tree as well.
> > > >
> > > > To be clear, I'm not going to take this via my tree, and it
> > > > definitely needs to go through clk tree.  If there is a dependency
> > > > on my tree, you will likely need to wait for the dependency to land on
> > mainline and then retry.
> > > >
> > >
> > > Sorry, I should have corrected that comment.
> > > It's not depend on SCU driver which is already in the Stephen's tree.
> > > It actually depends on the resource ID definitions[1] and the
> > > centralized PM related service definitions headifle in in power domain
> > > series which is already in your tree.
> > >
> > > [2] can be fixed by defining them in clock driver.
> > > But [1] seems can't be fixed as resource ID is shared by power domain
> > > and possible many other SCU client drivers.
> > >
> > > Any suggestion?
> > 
> > After [1] and [2] land on v4.21-rc1, you rebase the series on that.  The
> > dependency will be gone, right?  This is what I suggested above.
> > 
> 
> Okay, that may need a few more weeks.
> BTW, after v4.21-rc1 is out, can the mx8qxp CLK and DTS hit the final v4.21 release?
> As I understand, usually we don't receive new feature patch after the first RC,
> right?

Yes, they will have to land on 4.22 then.

Shawn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
