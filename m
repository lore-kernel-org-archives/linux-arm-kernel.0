Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F163C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:56:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21E302146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mh+tK4Dt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKBRAHo7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21E302146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:In-Reply-To:From:References:
	Message-ID:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+7yzuJUlQpVl/udjabiDUdl6lzpvh6nVsAVNWkQIpto=; b=mh+tK4DtsSnR7L
	GFwjp3TfvzoDIvqOgKjNYW5TYUsSh8q+cxK/aJmA2pUT1sGNyvo0TZYWofz2bizW9Z6ybGPfsOMyI
	JT2A/tuasXpxCGV5lmvJH3f0YU70VpG112g3x13mB96kP5THZlLTQEPz0oSgWBke/tPkXr84trH7q
	gCO3oP9IyQidBIichrfMYvGBj5fsP4fI4k/XbbMPzSn2ElxFUgSia7ep2lbrptWSnRnyVm8NNB460
	gwtTt49jYKGHaB8VphDHw4+/o7+/pDCmJDIGtOQjFTJefxN/mY2a19fOaT8IwQHkwnuJjBWO4DmL7
	AYFktclhWShskWwKzaDg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwYur-0002O4-NV; Wed, 20 Feb 2019 20:56:29 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwYuo-0002Na-34
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 20:56:27 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 65F1F2089F;
 Wed, 20 Feb 2019 20:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550696185;
 bh=i19Yd9t0tE1oyBSiiT8riqBloLBi5GvIMO+tNvl7dh0=;
 h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
 b=LKBRAHo7onXu9aIkZmqrDVtw/bnpLf+T7Dorop5sTL2CIUqROn40D5i08vN0PNUba
 AqVwXXENsLoS0IIoA9sep3P0NP4/SyFNFLb2ymfhmadeGqs4yvfQ2zdS5lVBD5E543
 8h0tOHLzMVNQr7/XP6tLs04ZkH2LXtoM7haxcglY=
MIME-Version: 1.0
Subject: RE: [PATCH V3 4/5] dt-bindings: imx8-clock: add a53 and a72 clock id
Message-ID: <155069618457.77512.12216138806698646030@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <1548335800-6438-1-git-send-email-aisheng.dong@nxp.com>
 <1548335800-6438-5-git-send-email-aisheng.dong@nxp.com>
 <20190213221818.GA13126@bogus>
 <AM6PR04MB4215A70B99715434A3770532807D0@AM6PR04MB4215.eurprd04.prod.outlook.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <AM6PR04MB4215A70B99715434A3770532807D0@AM6PR04MB4215.eurprd04.prod.outlook.com>
To: Aisheng Dong <aisheng.dong@nxp.com>, Rob Herring <robh@kernel.org>
Date: Wed, 20 Feb 2019 12:56:24 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_125626_171375_DA7B68C9 
X-CRM114-Status: GOOD (  21.79  )
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

Quoting Aisheng Dong (2019-02-19 23:07:46)
> > From: Rob Herring [mailto:robh@kernel.org]
> > Sent: Thursday, February 14, 2019 6:18 AM
> > On Thu, Jan 24, 2019 at 01:22:45PM +0000, Aisheng Dong wrote:
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
> > > v1->v2:
> > >  * change cpu clock to cpu cluster clock per Rob's suggestion
> > > ---
> > >  include/dt-bindings/clock/imx8-clock.h | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/include/dt-bindings/clock/imx8-clock.h
> > > b/include/dt-bindings/clock/imx8-clock.h
> > > index b149e63..dcce744 100644
> > > --- a/include/dt-bindings/clock/imx8-clock.h
> > > +++ b/include/dt-bindings/clock/imx8-clock.h
> > > @@ -14,10 +14,12 @@
> > >  /* CPU */
> > >  #define IMX_A35_CLK                                        1
> > >  #define IMX_CPU_CLUSTER_A35_CLK                            1
> > > +#define IMX_CPU_CLUSTER_A53_CLK                            2
> > > +#define IMX_CPU_CLUSTER_A72_CLK                            3
> > 
> > I still don't get this. How many clock outputs does the clock controller have for
> > CPUs? If 3, then this is correct. If it's the same clock controller bits across
> > different SoCs, then just name it something like IMX_CPU_CLUSTER_CLK and
> > reuse the same ID.
> > 
> 
> For SCU firmware based platforms like mx8qxp/qm, the clocks are provided
> by SCU firmware via SCU firmware call with unique IDs. So it's safe to use a common
> Clock IDs file.
> 
> But please ignore patch 3 and 4 first because we still met a few limitations with
> current approach due to the device availability may vary a bit across CPUs and
> Subsystems.
> 
> We formerly planned to add all new IDs for each SS and dynamically check availability
> in driver. That can be done but that may involve a lot effort and may result in more
> changes In driver. Also hard to upstream device tree code due to dependency on Clock IDs.
> 
> To relief this situation, we want to move the clock definition into device tree which
> can fully decouple the dependency of Clock ID definition from device tree.
> And no frequent changes required in clock driver.
> 
> I will send a patch set to do it later.
> 

Ok. I'll take this as a signal to drop these from the clk review queue.
Thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
