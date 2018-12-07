Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47426C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:37:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1946920837
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mG1HVw7d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1946920837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=205lLTLkFU/LA44oMvv1zo0Wwg6MUwDe6Tpj0/e9jLU=; b=mG1HVw7dG6T5w5
	C+RP08sHNNWx9OR+wyjF8/15h8BITpMi0ttqaCptJSXc2dQ5Q+sKCmb6TNfyotJuXYbrknEY7HbFX
	jicbvN+d5ydDKGyXjXx79JP9yofbiyfl5fOIcNWHBrtocqQ7sFCBbU62Cdv0YvYudYtBfa0o+RU/Z
	ZMMs9OASZIjUxTKsQMVMoDAkBmhGBB4e+UvtvcHVM2m2eQJ5y7bji8cOE/H2I7a5N2rxdN108qtqI
	I0xu5K4hL3qs/ra71BtJmwxWIFbQXJsYMmtX8W6JIOX8Ceo5JHwkDbbyVVVhIUgzRmsmqFxB2YWyo
	XbMq5iy1F/esYrB/XXmQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVJ7u-000255-S5; Fri, 07 Dec 2018 16:37:18 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVJ7k-0001oI-PC
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 16:37:14 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gVJ7V-0003Wn-8T; Fri, 07 Dec 2018 17:36:53 +0100
Message-ID: <1544200612.3709.111.camel@pengutronix.de>
Subject: Re: [PATCH v4 2/6] arm64: add basic DTS for i.MX8MQ
From: Lucas Stach <l.stach@pengutronix.de>
To: Abel Vesa <abel.vesa@nxp.com>, Rob Herring <robh@kernel.org>
Date: Fri, 07 Dec 2018 17:36:52 +0100
In-Reply-To: <20181207161723.2u5z3sdobbpop4kz@fsr-ub1664-175>
References: <20181114175242.12468-1-l.stach@pengutronix.de>
 <20181114175242.12468-2-l.stach@pengutronix.de>
 <20181116232524.GA2013@bogus>
 <20181207161723.2u5z3sdobbpop4kz@fsr-ub1664-175>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_083709_452604_F3250E3B 
X-CRM114-Status: GOOD (  11.98  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "patchwork-lst@pengutronix.de" <patchwork-lst@pengutronix.de>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Abel,

Am Freitag, den 07.12.2018, 16:17 +0000 schrieb Abel Vesa:
> On Fri, Nov 16, 2018 at 05:25:24PM -0600, Rob Herring wrote:
> 
> > > +
> > > +	clk_ext1: clock-ext1 {
> > > +		compatible = "fixed-clock";
> > > +		#clock-cells = <0>;
> > > +		clock-frequency = <133000000>;
> > > +		clock-output-names = "clk_ext1";
> > > +	};
> > > +
> > > +	clk_ext2: clock-ext2 {
> > > +		compatible = "fixed-clock";
> > > +		#clock-cells = <0>;
> > > +		clock-frequency = <133000000>;
> > > +		clock-output-names = "clk_ext2";
> > > +	};
> > > +
> > > +	clk_ext3: clock-ext3 {
> > > +		compatible = "fixed-clock";
> > > +		#clock-cells = <0>;
> > > +		clock-frequency = <133000000>;
> > > +		clock-output-names = "clk_ext3";
> > > +	};
> > > +
> > > +	clk_ext4: clock-ext4 {
> > > +		compatible = "fixed-clock";
> > > +		#clock-cells = <0>;
> > > +		clock-frequency= <133000000>;
> > > +		clock-output-names = "clk_ext4";
> > > +	};
> > 
> > This is really 4 independent clocks or is 1 clock connected to 4
> > sinks?
> 
> According to the RM, yes, there are 4 independent clocks. Here is a
> link to the rm:
> 
> https://www.nxp.com/webapp/Download?colCode=IMX8MEVKBHUG (page 829)
> 
> Unfortunately, the old link (which worked without login) does not
> work anymore.

It's really 4 clock inputs to the SoC, but they may actually be
connected to the same clock source on the board. So I really wonder if
we should even put this into the base SoC DT, but rather push this into
individual board DTs.

Regards,
Lucas

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
