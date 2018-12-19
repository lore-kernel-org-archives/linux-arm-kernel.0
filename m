Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06059C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:18:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB2D821850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Fqt1wOwU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB2D821850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7P2YstfB1ECGfDKLjNR5LhWqq1fekzvfb6tVx9wM4E8=; b=Fqt1wOwU2JtbP1
	/7fIT3KcfYsxcVweN0NBm7Nhfpg26zcaqaK49hT+eTRxRXTWIYky9wqeyVa0Kj+YFMdxmqVw9dLFW
	yx7BifQP/PP2dcA5Jrx+GujbXJGtDnRX3hD78Q4yhlM4Kt2qP5L65Qp2AqooVKdkTZ9w5yV6qrN4p
	0BCtswfCZrbLDqUjn1wu/CcEHNFAXFUZ9daTtQlG2+aaNqLQW1J50d3FzSKThD8JmGjtZJSKEWylh
	gKd0CaOjMACkHWhwWEpwIQuYRJ7VJSOdS9p1N5HQCyxrPYl/HT340dIi8goMVSxo5PZY1TnWYPRH3
	tkkDZxBCsqBJuYhN4IXQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZYvg-0005It-Kg; Wed, 19 Dec 2018 10:18:16 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZYvc-0005I1-Qc
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 10:18:14 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id CB999207D9; Wed, 19 Dec 2018 11:17:59 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
 by mail.bootlin.com (Postfix) with ESMTPSA id 9841720510;
 Wed, 19 Dec 2018 11:17:49 +0100 (CET)
Date: Wed, 19 Dec 2018 11:17:49 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Aisheng Dong <aisheng.dong@nxp.com>
Subject: Re: [PATCH V4 2/4] rtc: add i.MX system controller RTC support
Message-ID: <20181219101749.GK19816@piout.net>
References: <1543455856-18021-1-git-send-email-Anson.Huang@nxp.com>
 <1543455856-18021-3-git-send-email-Anson.Huang@nxp.com>
 <20181219085429.GJ19816@piout.net>
 <DB3PR0402MB39167296BD1302130B537FD7F5BE0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <AM0PR04MB42119CF2FB98AEDE02DC0FB980BE0@AM0PR04MB4211.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AM0PR04MB42119CF2FB98AEDE02DC0FB980BE0@AM0PR04MB4211.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_021812_993412_DF12E96F 
X-CRM114-Status: GOOD (  13.85  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "heiko@sntech.de" <heiko@sntech.de>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
 "LW@KARO-electronics.de" <LW@KARO-electronics.de>,
 "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
 Anson Huang <anson.huang@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
 Andy Gross <andy.gross@linaro.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
 "ezequiel@collabora.com" <ezequiel@collabora.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "a.zummo@towertech.it" <a.zummo@towertech.it>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
 "olof@lixom.net" <olof@lixom.net>, "shawnguo@kernel.org" <shawnguo@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 19/12/2018 09:48:25+0000, Aisheng Dong wrote:
> [...]
> > >
> > > I applied it on my test branch and this makes sparc64-allyesconfig
> > > fail
> > > with:
> > >
> > >    drivers/rtc/rtc-imx-sc.o: In function `imx_sc_rtc_read_time':
> > >    rtc-imx-sc.c:(.text+0x34): undefined reference to `imx_scu_call_rpc'
> > >    drivers/rtc/rtc-imx-sc.o: In function `imx_sc_rtc_probe':
> > >    rtc-imx-sc.c:(.text+0x90): undefined reference to `imx_scu_get_handle'
> > 
> > Maybe there are some changes on basic support of imx scu driver, I will resend
> > a patch set later, thanks.
> > 
> 
> This driver should depend on IMX_SCU which seems not got compiled.
> 

Yes, this seems to be the straightforward solution.

> Regards
> Dong Aisheng
> 
> > Anson.
> > 
> > >
> > >
> > >
> > > --
> > > Alexandre Belloni, Bootlin
> > > Embedded Linux and Kernel engineering
> > > https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fboo
> > > tl
> > in.com&amp;data=02%7C01%7Canson.huang%40nxp.com%7C72b147643a3f
> > >
> > 44c258c208d6658f9cce%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0
> > > %7C636808064818797711&amp;sdata=%2Bl5jGXX6wBYbOg5Zalg4CyxyZKj
> > Ue
> > > uzRSQEKO9TJnRI%3D&amp;reserved=0

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
