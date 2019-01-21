Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B49DC2F441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:31:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D50021019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XXznK4Lj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gd/udcq5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D50021019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WIUZiUOo2968T1wVFoqAdafJM6pPuHxIATOW1X7A4bM=; b=XXznK4LjSqsBtx
	MCkQoY6XbW3EJ6mLrtT4j91sMTGJ8D6JDfwB9PUkfenPOPd0ZY6wZPyykflfutaQnPL6+QB2e5Bb2
	Agg94Qi8hYrcjwm6aAgzvJ1NqsUJT+CY47ttM1ti7IcPFRIYzBoLL0DWSY/+Ew4b/JO6kRdP9Gnx6
	R7A+ocx70BI3bRa0+87jwgXgQ4QvjkLg6LeBiNR/H76oqo44GtVmxmVB6gFWlH6mSs/s1xpUj+a+r
	TmTDt4kLC9EzcV5/AKR3PtxAMzWE7bSCeuiAQUWPCkJNrSUf/zSUz3Z0Hzok+VQy5RzPBIfXxhCod
	r2DqqevlT/Ddhvu0QBEA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glcTl-0004kz-Ji; Mon, 21 Jan 2019 16:31:17 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glcTh-0004kW-PS
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 16:31:15 +0000
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com
 [209.85.160.170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A7CEE21726
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 16:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548088272;
 bh=aK6aS/yuKJOP8fwrRCwYGKWxZODXaq8bkOM+L+up4j4=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=gd/udcq5Ocuk9lntIBEhbioKic7wSv1xKlRoJEUfmUrOYLtsRGKkHtGvlJHba8fIQ
 9igHdwMvqPWRIZsDC5f3zX3PRFfeld1BqAY0CB+f6KfGwqPDKDObu/CwGOzL6xSozL
 7C2wPhtzK6c9XaY45j7gGptEb48T86zt4LzhUPzc=
Received: by mail-qt1-f170.google.com with SMTP id d19so24145230qtq.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 08:31:12 -0800 (PST)
X-Gm-Message-State: AJcUukc7D6mFOh+xcRMrC9x1M+ReTiuvX7RGTT2jz9tS+98qNFor3TdS
 BEUHdrcXPiK1fcA041QHBvY6wFVyCrD4RiquZw==
X-Google-Smtp-Source: ALg8bN4Cwq5+/MBDulqYkPznPi/YYm5isaewNmkHAPofd3uExUb7M1t5dEyMZ6JBz37Ty+O+8sdK1w7PMxXNHbj8qBs=
X-Received: by 2002:ac8:1712:: with SMTP id w18mr27165898qtj.76.1548088271901; 
 Mon, 21 Jan 2019 08:31:11 -0800 (PST)
MIME-Version: 1.0
References: <1545148524-658-1-git-send-email-aisheng.dong@nxp.com>
 <1545148524-658-2-git-send-email-aisheng.dong@nxp.com>
 <20190111090009.GG32649@dragon> <20190111090653.GH32649@dragon>
 <AM0PR04MB42119B411244F0B1BB829D9F80850@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20190111130311.GA3599@dragon>
In-Reply-To: <20190111130311.GA3599@dragon>
From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 21 Jan 2019 10:31:00 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+v+TpgwMhhboo7UKA7bbPNT66QqO10of43gqR--pY4aQ@mail.gmail.com>
Message-ID: <CAL_Jsq+v+TpgwMhhboo7UKA7bbPNT66QqO10of43gqR--pY4aQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: fsl: scu: add fallback compatible string
 for power domain
To: Shawn Guo <shawnguo@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_083113_855216_84D85F4B 
X-CRM114-Status: GOOD (  21.86  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>, Mark Rutland <mark.rutland@arm.com>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "dongas86@gmail.com" <dongas86@gmail.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "khilman@kernel.org" <khilman@kernel.org>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 11, 2019 at 7:03 AM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Fri, Jan 11, 2019 at 10:48:21AM +0000, Aisheng Dong wrote:
> > Hi Shawn,
> >
> > > -----Original Message-----
> > > From: Shawn Guo [mailto:shawnguo@kernel.org]
> > > Sent: Friday, January 11, 2019 5:07 PM
> > >
> > > On Fri, Jan 11, 2019 at 05:00:11PM +0800, Shawn Guo wrote:
> > > > On Tue, Dec 18, 2018 at 04:01:20PM +0000, Aisheng Dong wrote:
> > > > > SCU power domain can be used in the same way by IMX8QXP and
> > > IMX8QM SoCs.
> > > > > Let's add a "fsl,scu-pd" fallback compatible string to allow other
> > > > > SoCs to reuse the common part.
> > > >
> > > > This is not the practice we used to match devices with
> > > > compatibilities, i.e. coding the compatible string with the SoC name
> > > > that firstly introduces the device, and use the compatible as fallback for new
> > > SoCs.
> > >
> >
> > This is suggested by Rob that if the future SoCs are likely to be compatible.
> > Then we can use a general fallback compatible string like "fsl,scu-pd".
> > https://patchwork.kernel.org/patch/10644815/
> >
> > From SCU HW protocol point of view, they're indeed compatible.
> > Just varies a bit on the domains numbers.
> > That's why we introduce "fsl,scu-pd".
> > But still keep SoC specific compatible string in case any special tricks
> > to ensure the ABI stability.
> >
> > How do you think?
>
> Unless Rob is against the practice we have been used for long time on
> i.MX, I would keep using it for i.MX8, i.e. instead of introducing a
> generic compatible for fallback, simply falling on the compatible SoC
> specified IP block.

That is certainly my preference and the traditional way to do
compatible in DT, but some reason folks don't like having old SoC
names in their shiny new SoC DT. So either way is fine. But I'd follow
what you do for the rest of i.MX which I guess is what Shawn suggests.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
