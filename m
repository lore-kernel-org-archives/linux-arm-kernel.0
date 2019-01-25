Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF35EC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 21:21:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BA77218B0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 21:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Es9ygHo5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BA77218B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rGvIV45PtK4KcQ8lrxsxkrpzKDNDAMVqmDQyunvUhj8=; b=Es9ygHo5yqwwgC
	WO7ih2D+bnpkTJn10XaQc3zIkGNC7P/BgPY5FQMAMZCwlddpGrF0obZyi1aecBdzQ5/AVCwPlw2S+
	+9U/ENgxH2c7HMDOg4PwoFcGH04db3qiXgLk/ACWDkmKs99Js/NfzV0U1qQeahq/apAmpUNMILwcM
	nG0YrdaHfU4tt7AAsR9H7Sy5nbowBMx59XvPaEIirO3p8mbRXeoPzsYwPVrxgBi73CrW2vrmpe/rE
	KDO8m9uogGuACQDDuFbcAawsD713X17Q2fsd/tfV3FQVk0xQiSULmxka4AdEtghaeZ7r4ydFQOlhV
	jTNvd91lVLaoMxgY9Hsw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn8uw-0003NU-9Q; Fri, 25 Jan 2019 21:21:38 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn8us-0003Mq-M9
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 21:21:37 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 55484207B2; Fri, 25 Jan 2019 22:21:32 +0100 (CET)
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
 by mail.bootlin.com (Postfix) with ESMTPSA id 113C620397;
 Fri, 25 Jan 2019 22:21:32 +0100 (CET)
Date: Fri, 25 Jan 2019 22:21:32 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v5 07/17] drm/sun4i: sun6i_mipi_dsi: Refactor vertical
 video start delay
Message-ID: <20190125212132.ea2iq6tsgyawkemx@flea>
References: <CAMty3ZBb8byOwh=_W83Ta0Dse1qkoqccOeaBEY9oHPaxDxe9QA@mail.gmail.com>
 <20190108085829.clianbtjovu3oieq@flea>
 <CAMty3ZC9OQtwT-iH=S1LhHsBPc_jFKGAnCYYeR9nuKuDWSKLQw@mail.gmail.com>
 <20190112164319.whr7gwvl4oux5svz@flea>
 <CAMty3ZD8X9KmHjUtAo-+Y83a2j8NF3DjM9Yr3LPMxOvQ8kOV7g@mail.gmail.com>
 <20190116191756.ajzzaga43srk77dk@flea>
 <CAMty3ZCw8itG=nizA5E218HT5kg=-xDzLmShF51vRh4ENYKuBA@mail.gmail.com>
 <CAMty3ZDbTgo3EY12VC0X_XuaRobQXvHx=Y6-_sgSWxDm1ZXbHQ@mail.gmail.com>
 <20190122111118.db7bqppop4basxd7@flea>
 <CAMty3ZA0rhpQbumoVOGQRGDG0-iU84wcpUN2Q=ooT4iRD6y5hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMty3ZA0rhpQbumoVOGQRGDG0-iU84wcpUN2Q=ooT4iRD6y5hQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_132135_004385_CE264643 
X-CRM114-Status: GOOD (  21.82  )
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
Cc: Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 linux-sunxi <linux-sunxi@googlegroups.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, Chen-Yu Tsai <wens@csie.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com, linux-clk <linux-clk@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 22, 2019 at 05:21:08PM +0530, Jagan Teki wrote:
> On Tue, Jan 22, 2019 at 4:41 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > On Fri, Jan 18, 2019 at 09:14:19PM +0530, Jagan Teki wrote:
> > > On Thu, Jan 17, 2019 at 10:02 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
> > > >
> > > > On Thu, Jan 17, 2019 at 12:48 AM Maxime Ripard
> > > > <maxime.ripard@bootlin.com> wrote:
> > > > >
> > > > > On Sun, Jan 13, 2019 at 01:07:41AM +0530, Jagan Teki wrote:
> > > > > > > > > > > Again, I cannot help you without the datasheet for the panels you're
> > > > > > > > > > > trying to submit.
> > > > > > > > > >
> > > > > > > > > > The panel bound with Sitronix ST7701 IC
> > > > > > > > > > http://www.startek-lcd.com/res/starteklcd/pdres/201705/20170512144242904.pdf
> > > > > > > > >
> > > > > > > > > It's the controller, not the panel
> > > > > > > >
> > > > > > > > As I said before, the datasheet of that panel doesn't have any
> > > > > > > > information except electrical characteristics and used IC which is
> > > > > > > > ST7701.
> > > > > > > >
> > > > > > > > I have one more panel, which is from Bananapi, S070WV20-CT16 ICN621
> > > > > > > > please find the attachment for the same.
> > > > > > > >
> > > > > > > > Here is some more details of the same.
> > > > > > > >
> > > > > > > > https://github.com/yesnoandor/x300/blob/master/kernel/arch/arm/boot/dts/erobbing/x300/x300.dtsi#L81
> > > > > > > > https://github.com/wxzed/Raspberry_5MIPI_Display/blob/master/I2C_Slave/USER/main.c#L15
> > > > > > > >
> > > > > > > > https://github.com/eliot-shao/qcom/blob/master/icn6211_cxn0102/kernel/drivers/video/msm/mdss/mdss_i2c_interface.c#L152
> > > > > > > > matches timings for
> > > > > > > > https://github.com/eliot-shao/qcom/blob/master/icn6211_cxn0102/kernel/arch/arm/boot/dts/qcom/dsi-mipi-2-rgb_1280p_video.dtsi#L20
> > > > > > > >
> > > > > > > > https://github.com/zestroly/micromat/blob/master/test/raspberry/ICN6211.cpp#L169
> > > > > > >
> > > > > > > Where did you get the timings from then?
> > > > > >
> > > > > > You mean drm_mode timings, the same panel with RGB available in
> > > > > > panel-simple[1], and dsi driver in Mailing list[2] and actual DSI
> > > > > > sequence commands from BSP[3]
> > > > > >
> > > > > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/gpu/drm/panel/panel-simple.c?id=7ad8b41cd8f5c2842646d01cdd576663caee04a7
> > > > > > [2] https://patchwork.kernel.org/patch/10680331/
> > > > > > [3] https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/lcd/S070WV20_MIPI_RGB.c
> > > > >
> > > > > So you had no reliable source for the timings then? How do you know if
> > > > > all your patches that are timing related are right then?
> > > >
> > > > I don't understand your point, or may be I confused with many links
> > > > that I attached in previous mail.
> > > >
> > > > 1. Patch for same panel timings are already in Mainline that was
> > > > tested on one of the board. [1]
> > > > 2. Driver from AW, released bsp from BPI-M64-bsp [3]
> > > >
> > > > Do you think the above two points are not valid sources?
> > >
> > > fyi, the panel datasheet attached in above mail has timing information.
> >
> > Do you have a page number?
> 
> Page 4
> 5.2 Interface Timings

Which datasheet are we talking about here?

The only one I've seen is the Sitronix IC's and the page 4 is the summary.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
