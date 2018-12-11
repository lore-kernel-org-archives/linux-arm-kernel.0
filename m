Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83C4C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:03:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86BF62081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LFrKajUz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jucL7OdG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86BF62081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=K5cXEbV7KEuVkcl0ALO1TexCj2/Rf3WgW+LzOkOlDSk=; b=LFrKajUzc1wnWR
	gYAtlr7JhQC9lGCHrC21NECit17ayeKsF0D4IJwMt47bTNgpKsj9zLs8nfSRa5RvVeS+wo8HWByIs
	CiFrqkGrJS7qR7wG1VX6VH1s2djXL7aKwF9/MB+sywwWb9BhDyGOGbigtkXwrmICEKc2LMsVIafwU
	AMfLzRIBkDOlw/PyxglU4mP9NsjwUu7sIrnxgQ7/9pZxOXZic3HuIYTyGA/fVInN0SZcpSwe+rX8V
	WNQMJ166Lq2rtG9s/rGX468GrE8D7cPSZa/JMXfpUB5eeziJ2kZsOdu2A8Aq8vcaJ334I/0wNKkWY
	m/QNteNH/km6hWduMQgw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWd0n-0001kg-Bj; Tue, 11 Dec 2018 08:03:25 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWd0c-0001hE-JH
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 08:03:23 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 931602081B;
 Tue, 11 Dec 2018 08:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544515384;
 bh=27qKANtVyfxGEReXEC/rQ61r+efcmhaDdmDRwkL0jS8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jucL7OdGvNUFtwk2AR6s4lOan8LP23jXKWbLuBLIKooszl8d9UY1DVRno1F9T5Dm2
 KNeYhKXqSsAISUi7b+DoUV3z81X81v1j8L1c9a8Bzc2V+j/iV838v2eRnCa36RIO3r
 dybtzjt8cIDwhJhf/wiBnj8skIZEo7mmWzk3eRYg=
Date: Tue, 11 Dec 2018 16:02:09 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v13 0/5] Add i.MX8MQ clock driver
Message-ID: <20181211080208.GY3987@dragon>
References: <1542125975-8448-1-git-send-email-abel.vesa@nxp.com>
 <154345210894.88331.8277410833858111600@swboyd.mtv.corp.google.com>
 <AM0PR04MB42117F72B9C4D41C14B96CBD80D20@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <154352826457.88331.16669625591730377740@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <154352826457.88331.16669625591730377740@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_000314_650330_3A203BC0 
X-CRM114-Status: GOOD (  14.27  )
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
Cc: Aisheng DONG <aisheng.dong@nxp.com>, Rob Herring <robh@kernel.org>,
 Abel Vesa <abel.vesa@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Abel Vesa <abelvesa@linux.com>, dl-linux-imx <linux-imx@nxp.com>,
 Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>,
 Mark Rutland <mark.rutland@arm.com>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 29, 2018 at 01:51:04PM -0800, Stephen Boyd wrote:
> Quoting Aisheng DONG (2018-11-28 23:46:41)
> > > -----Original Message-----
> > > From: Stephen Boyd [mailto:sboyd@kernel.org]
> > [...]
> > > >
> > > > Changes since v12:
> > > >  * replaced the division in clk_pll_recalc_rate in clk-frac
> > > >    with do_div as suggested by Stephen
> > > >
> > > > Abel Vesa (2):
> > > >   clk: imx: Add imx composite clock
> > > >   clk: imx: Add clock driver for i.MX8MQ CCM
> > > >
> > > > Lucas Stach (3):
> > > >   dt-bindings: add binding for i.MX8MQ CCM
> > > >   clk: imx: add fractional PLL output clock
> > > >   clk: imx: Add SCCG PLL type
> > > >
> > > 
> > > I had to apply this set of fixes to silence sparse and smatch warnings about
> > > things that are not right. Please take a look over things and see if it's sane.
> > > 
> > 
> > The change looks good to me and tested ok.
> > I did not see this patch series in your tree.
> > Do you want us to apply your changes and re-send for easy pick up?
> > 
> 
> I applied this version and my fixes. I'll just mark v14 as superseded.
> Thanks for testing!

Hi Stephen,

For the same reason as clk-imx7ulp, please keep branch clk-imx8mq
stable.  Thanks.

Shawn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
