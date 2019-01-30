Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF8FC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:46:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2DDA2086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oFbmUq0j";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="T23VvXbA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2DDA2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MmX3wsKQ755+g8f/uf7zN9xC9qwBALEXFdd0u9hYYNw=; b=oFbmUq0jrKre6H
	n4bwjJB/OUnofK+mG3WQTFskIGL3cFsy82je65VS7cTY7W3d8mqM4ctJCrVGQ/jn72xGZXumka5yQ
	IfEul3JeZNl+RS0jmLx5IsgQ4XEQmYnp95FDFvIt0Klu1XHsfAMc5RkEMLrULPkMEEX7fyhCcun2D
	hI49ls6sZYW45wdKZtfVLt1KQYkMsFT40eTFrOwUECuXYvcijSjOL0z/asEa6ZqtWqnbthBarL1YJ
	VsqX6CvSBOfQYN3lXCjtfoei3n2E11+MZfob6GIwB3t9Sor7l+SE+WqIq3/b59RyAp/0b3r7mdwkI
	uHBSOgC44+lAITMJHHlw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1got0L-0001Fi-TE; Wed, 30 Jan 2019 16:46:25 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goszv-00010Z-1q
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 16:46:02 +0000
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F1AA721473
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 16:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548866758;
 bh=Qhz+Cmj3XDWVYkJBbEvc6p6QJjAfUK9C+dxUODNU86A=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=T23VvXbAKybvHdF5MkEVDXLqqZ/s1s86/RB8XHMAK39bV0uJ/9ASVZyOI3cpvoaVt
 qRtYtmLzqDn2RBYmiqmEP+8Xgs7f07NUwnhSQcsdQslGVCG4i/TcnM50AEmkaoR3kq
 K6xr1A7HFIt3G6R0yibpSCO1ynnF4gk6L1eSm82c=
Received: by mail-qk1-f169.google.com with SMTP id c21so114540qkl.6
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 08:45:57 -0800 (PST)
X-Gm-Message-State: AJcUukejVJq8uJyqs5b2Ja9IXvpiTNWQgcS8H86m+EVgVxyhxyOoUxn7
 NOQd5gz1w64PK20RzXtzKf21kuNTve0BVNF5HA==
X-Google-Smtp-Source: ALg8bN5aQKy+V94ZoHB/unZJZGaCCM7zhepzAF91LXVuuxQiPNrkPzFgIKzb1OsbsqyFf/SSIQOvnL0SQ1VG4XcaTcM=
X-Received: by 2002:a37:5686:: with SMTP id k128mr26623744qkb.29.1548866757172; 
 Wed, 30 Jan 2019 08:45:57 -0800 (PST)
MIME-Version: 1.0
References: <1547207400-28307-1-git-send-email-aisheng.dong@nxp.com>
 <1547207400-28307-5-git-send-email-aisheng.dong@nxp.com>
 <20190122001011.GA15952@bogus>
 <AM0PR04MB4211003C959DCC89B169D39B80980@AM0PR04MB4211.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB4211003C959DCC89B169D39B80980@AM0PR04MB4211.eurprd04.prod.outlook.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 30 Jan 2019 10:45:46 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKwJEJmb2iAom1nckj6-eFrpfMXoGC4id5rqWiQZZn2yw@mail.gmail.com>
Message-ID: <CAL_JsqKwJEJmb2iAom1nckj6-eFrpfMXoGC4id5rqWiQZZn2yw@mail.gmail.com>
Subject: Re: [PATCH RESEND v1 4/4] dt-bindings: imx8-clock: add a53 and a72
 clock id
To: Aisheng Dong <aisheng.dong@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_084559_684784_C0B349DE 
X-CRM114-Status: GOOD (  18.72  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "sboyd@kernel.org" <sboyd@kernel.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 22, 2019 at 6:59 AM Aisheng Dong <aisheng.dong@nxp.com> wrote:
>
> > From: Rob Herring [mailto:robh@kernel.org]
> > Sent: Tuesday, January 22, 2019 8:10 AM
> >
> > On Fri, Jan 11, 2019 at 11:56:09AM +0000, Aisheng Dong wrote:
> > > Add a53 and a72 clock id, as there's still no users, we update
> > > IMX_LSIO_MEM_CLK base to start from 6 to allow a53 and a72 clock id to
> > > be continued with a35 clk.
> > >
> > > Cc: Stephen Boyd <sboyd@kernel.org>
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Cc: devicetree@vger.kernel.org
> > > Cc: Shawn Guo <shawnguo@kernel.org>
> > > Cc: Sascha Hauer <kernel@pengutronix.de>
> > > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > > Cc: Michael Turquette <mturquette@baylibre.com>
> > > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > > ---
> > >  include/dt-bindings/clock/imx8-clock.h | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/include/dt-bindings/clock/imx8-clock.h
> > > b/include/dt-bindings/clock/imx8-clock.h
> > > index 4236818..2f1aa2f 100644
> > > --- a/include/dt-bindings/clock/imx8-clock.h
> > > +++ b/include/dt-bindings/clock/imx8-clock.h
> > > @@ -13,10 +13,12 @@
> > >
> > >  /* CPU */
> > >  #define IMX_A35_CLK                                        1
> > > +#define IMX_A53_CLK                                        2
> > > +#define IMX_A72_CLK                                        3
> >
> > All 3 cores in one chip? If not maybe these should be split or define them as
> > cpu cluster x clocks.
> >
>
> Not in one chip.
> Here are common clock IDs used for both MX8QXP and MX8QM.
> You mean change to something like below?
>
> #define IMX_CPU_CLUSTER_A53_CLK                 2
> #define IMX_CPU_CLUSTER_A72_CLK                 3

What happened to A35? What I'm saying is if the same clock controller
registers are used across chips even if the cores are different, use
the same clock ID. Ideally, clock IDs have some relationship to the
h/w such as their control register address and offset.

To put it another way, don't create a common number space of clock IDs
across SoCs unless they are strictly subsets and supersets of each
other.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
