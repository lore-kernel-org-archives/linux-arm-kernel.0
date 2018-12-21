Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD66AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:01:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7F7C2190A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ppqNOupZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+mBcdCU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7F7C2190A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Message-ID:References:In-Reply-To:
	From:To:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pPRdgdVi8Cp0nJ2jqwwl11oKx0zyUds4ZfdD6NDlsvY=; b=ppqNOupZD03OYm
	PHJXbW6Oe8LAg94eJcwdrspIWq/zVjp2bU/QcHpsRODa1TQTf1SUxYMK1tCEihQfDkVipW/Ah/V3q
	2t/gTlNcluQdAtGHkEnkxCR0EJMAgpe4fDrFVRbgz0WelEfnLCEhiAVxlfUw3tb4EIEiZl9LbJsgN
	tLtOuq5qqF/VhsNPjFyr3RFgq2e63nIT298hM0aLGMZx4qONDnCaihV3NaTWZHaVtGLq7adkb0Vp6
	kr0+dpHGF93uN8daiMF5zhjEDSaLZVaZYWgUCRH+1e8BsCIeEisAmzSST7bN7Ql6XVjK1Y9dxRfJz
	2J9XcasOUBTrmmIGuuKg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaQ2n-0003qh-Do; Fri, 21 Dec 2018 19:01:09 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaQ2k-0003pz-5c
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 19:01:07 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 850B32190A;
 Fri, 21 Dec 2018 19:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545418855;
 bh=tKCy/obsv6cYooVTpl2l9vGZthElPottVY1/IlJ5K/g=;
 h=Subject:Cc:To:From:In-Reply-To:References:Date:From;
 b=a+mBcdCUQcVDpSgzwJmjvTpF8HuVX+W8gv7FKLePBo3HkWAHngvyfIM9+kRkz2lPk
 UVlad/N1p7E6CtM4nebr4kewmMjn9LE744MIzmh4Jk6OgUHQ8bxz3dn15MbvUQOi4x
 DPvrl04jDBvy/rqilWyEGgDmCgkKFkrQqMhK/UUM=
MIME-Version: 1.0
Subject: RE: [PATCH 4/5] clk: imx8qxp: make the name of clock ID generic
To: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, Aisheng Dong <aisheng.dong@nxp.com>,
 Fabio Estevam <festevam@gmail.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <AM0PR04MB4211F8786714DD6CCBB55F0A80B80@AM0PR04MB4211.eurprd04.prod.outlook.com>
User-Agent: alot/0.8
References: <1545232888-9302-1-git-send-email-aisheng.dong@nxp.com>
 <1545232888-9302-5-git-send-email-aisheng.dong@nxp.com>
 <CAOMZO5DzMpMp-Tf74iM3SuHoFpji8z-dxM-UsC13GeDx2bZYgA@mail.gmail.com>
 <VI1PR04MB4222ABD43B82BD3C0B73404780BF0@VI1PR04MB4222.eurprd04.prod.outlook.com>
 <154533484105.79149.16225192496445475758@swboyd.mtv.corp.google.com>
 <AM0PR04MB4211F8786714DD6CCBB55F0A80B80@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <154541885475.13075.16994932864140896829@swboyd.mtv.corp.google.com>
Date: Fri, 21 Dec 2018 11:00:54 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_110106_247479_35FCEF5E 
X-CRM114-Status: GOOD (  27.60  )
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
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Aisheng Dong (2018-12-20 17:44:28)
> > -----Original Message-----
> > From: Stephen Boyd [mailto:sboyd@kernel.org]
> > Quoting Aisheng Dong (2018-12-19 22:26:50)
> > > > -----Original Message-----
> > > > From: Fabio Estevam [mailto:festevam@gmail.com] Hi Aisheng,
> > > >
> > > > On Wed, Dec 19, 2018 at 1:29 PM Aisheng Dong
> > <aisheng.dong@nxp.com>
> > > > wrote:
> > > > >
> > > > > SCU clock can be used in a similar way by IMX8QXP and IMX8QM SoCs.
> > > > > Let's make the name of clock ID generic to allow other SoCs to
> > > > > reuse the common part.
> > > > >
> > > > > This patch only changes the clock id name and file name, so no
> > > > > functional change.
> > > > >
> > > > > Cc: Shawn Guo <shawnguo@kernel.org>
> > > > > Cc: Sascha Hauer <kernel@pengutronix.de>
> > > > > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > > > > Cc: Stephen Boyd <sboyd@kernel.org>
> > > > > Cc: Michael Turquette <mturquette@baylibre.com>
> > > > > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > > > > ---
> > > > >  drivers/clk/imx/clk-imx8qxp-lpcg.c        | 146 +++++++--------
> > > > >  drivers/clk/imx/clk-imx8qxp.c             | 152 ++++++++--------
> > > > >  include/dt-bindings/clock/imx8-clock.h    | 289
> > > > ++++++++++++++++++++++++++++++
> > > > >  include/dt-bindings/clock/imx8qxp-clock.h | 289
> > > > > ------------------------------
> > > > >  4 files changed, 438 insertions(+), 438 deletions(-)
> > > >
> > > > This seems like unneeded churn. Just keep the existing naming and
> > > > other SoCs can reuse it without problem.
> > >
> > > There's a reason.
> > > We still need add some clock IDs which exist on MX8QM only (probably
> > > more on future SoCs) Having them prefixed with 'IMX8QXP' may look
> > strange.
> > >
> > > Besides that, as those clock IDs will also be used in devicetree, make
> > > the name generic for different SoCs seems still better and less confusing.
> > >
> > 
> > This looks like an integration problem. Is anyone using the defines that are
> > merged through clk tree now? A grep of linux-next says no, but how can I be
> > sure?
> 
> I'm sure no one is using it now.
> The only user DTS (imx8qxp mek) is waiting for merge after 4.21-rc1 is out.
> So it's a chance to update it. 
> 
> > 
> > So can you leave around the header file with the deprecated define names and
> > introduce another one that's a copy of the header file but with the non-SoC
> > specific names?  Then you can wait for a release cycle and delete the old
> > header file that nobody should be using in DT anymore.
> > Unless you plan to make sure that nobody uses the deprecated defines
> > somehow?
> > 
> 
> Yes, the plan is to make sure nobody uses that.
> Otherwise, it may be hard to send DTS patches using new CLK ID name through
> different tree later.
> 

I've already tagged and prepared to send out clk tree for the next merge
window. It's getting difficult to change this before -rc1 too because
I'm traveling for the holidays in the US. I'm fine with changing the
world if it doesn't break anything, but I'm not interested in making the
pull request wait another few days for this particular topic, so I'd
rather send this as part of a follow-on fixes PR during the merge window
next week.

Can you resend with just the things that need to be changed for the next
release (v4.21 or v5.0)? And Cc the relevant people/lists and try to
collect acks and reviewed-by tags before next Wednesday? I can send a
fixes PR on Friday next week then.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
