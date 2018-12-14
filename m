Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B368BC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 00:44:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8242F2075B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 00:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SA+yWaYE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zkym+oO6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8242F2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BdCpDEHe1gtXfdWN34+mlKBbxh/DqF2SP9EEuexBYQ4=; b=SA+yWaYEaXuVDe
	WXrpVLTiUP8V7FanrjBztGdJ1PYMyMf0GmT7U7OS1qBiG+M1/lk+zR4o4HKvkASQbQeYl3F/m+pDp
	Z2Wcn+c0jb7JWQFLm5uuRdujy0VZwBe/vuSR9P9v+65ykPctvP3IvFvuGEXamZZkvwporE5lSpMHz
	qPd/6TRm2JTLrJ3qoeyIqMFXuqO9MBRJNTmyMfLseupjw11jA5WS/iCzNkM4UQvqn7ysqLglBXRh/
	L0w61wN1IwjBPttHbSaSPcE94QCSiMDu63koHnB6Hb0/eqPhfxiAElaBMMBg84mPxnfB30XuJTB9O
	qXKU8FLMXoGgHldyMi3w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXbaR-0005tC-9G; Fri, 14 Dec 2018 00:44:15 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXbaM-0005sI-3f; Fri, 14 Dec 2018 00:44:11 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 842B32075B;
 Fri, 14 Dec 2018 00:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544748238;
 bh=qiwmRejJtBcgQBbtzhZHQ2STHBHennZb7QnBQ4FdPAY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=zkym+oO6nQ5yVdejfiFlmhMiKwn/GYjaPLLLbbODWZ2NI2xCWtGyiRBPKKpjKBCDm
 A/Pl967Ghhjq5FStCcsbEarTeY44ynkKw04rhARwPBhuzECM5nwqykrj0WLK0GUvjA
 v6rRBHQrk7v8+cmT3f+05xU8eZcWZiA4NMSykMww=
Date: Fri, 14 Dec 2018 08:42:57 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Schrempf Frieder <frieder.schrempf@kontron.de>
Subject: Re: [PATCH 0/5] Prepare devicetrees for the new FSL QSPI driver
Message-ID: <20181214004251.GA15775@dragon>
References: <1544459182-23655-1-git-send-email-frieder.schrempf@kontron.de>
 <ce1442f3-357b-d647-958e-cc4a89282b79@kontron.de>
 <1ad93cdf-7ba1-ff49-f330-6bbd0f6c6972@kontron.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1ad93cdf-7ba1-ff49-f330-6bbd0f6c6972@kontron.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_164410_185611_216B9D72 
X-CRM114-Status: GOOD (  24.41  )
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
 Sascha Hauer <s.hauer@pengutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 13, 2018 at 09:45:04AM +0000, Schrempf Frieder wrote:
> + Shawn, Sascha
> 
> On 10.12.18 17:31, Schrempf Frieder wrote:
> > Hi FSL/ARM maintainers,
> > 
> > On 10.12.18 17:26, Schrempf Frieder wrote:
> >> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> >>
> >> We have prepared a new driver for the FSL QSPI controller that works under
> >> the SPI framework. The current devicetrees are broken because they use an
> >> inconsistent scheme for assigning the reg properties.
> >>
> >> As, in contrast to the current driver, the new driver will use the reg
> >> properties to select the correct chip, we need to fix them.
> >>
> >> We also add spi-[tx/rx]-bus-width to make sure the full buswidth will be used
> >> and while at it clean up and remove some unused properties.
> > 
> > could you please consider these devicetree patches for v4.21?
> 
> Any chance to get this merged? Otherwise we would need to postpone the 
> new driver even further.

As it came up a little bit late (the same day I sent pull request for
4.21), I was considering it as 4.22 material.  But as you mentioned that
the series is non-intrusive, I can try to send it to arm-soc folk for
4.21 merge window, and then that will be their call.  But before I do
it, I need you to double confirm that the series will not break anything
that is already working.

Shawn

> 
> All the changes to the devicetrees in this series are non-intrusive and 
> uncritical, anyway.
> 
> Thanks,
> Frieder
> 
> > 
> > We have the new FSL QSPI driver under the SPI framework ([1]) ready, but
> > we need some small fixes to the devicetrees that are currently broken.
> > 
> > As the new driver depends on these changes (mainly the change to the reg
> > properties) and it is not possible to add compatibility for the old
> > bindings, it would be really nice to have them in v4.21, so we can queue
> > the driver for v4.22 or whatever the next release will be called.
> > 
> > Please also see [2] for some more explanation.
> > 
> > Thanks,
> > Frieder
> > 
> > [1] https://patchwork.ozlabs.org/cover/1007641/
> > [2] https://patchwork.ozlabs.org/patch/922817/#1925445
> > 
> >>
> >> Frieder Schrempf (5):
> >>     arm64: dts: Remove unused properties from FSL QSPI driver nodes
> >>     ARM: dts: Remove unused properties from FSL QSPI driver nodes
> >>     ARM: dts: imx6sx-sdb: Fix the reg properties for the FSL QSPI nodes
> >>     arm64: dts: Add spi-[tx/rx]-bus-width for the FSL QSPI controller
> >>     ARM: dts: Add spi-[tx/rx]-bus-width for the FSL QSPI controller
> >>
> >>    arch/arm/boot/dts/imx6sx-sdb-reva.dts              | 8 ++++++--
> >>    arch/arm/boot/dts/imx6sx-sdb.dts                   | 8 ++++++--
> >>    arch/arm/boot/dts/imx6ul-14x14-evk.dtsi            | 2 ++
> >>    arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts        | 5 ++---
> >>    arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts  | 3 ++-
> >>    arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts  | 4 ++--
> >>    arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts  | 6 ++++--
> >>    arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi | 4 ++++
> >>    8 files changed, 28 insertions(+), 12 deletions(-)
> >>
> > ______________________________________________________
> > Linux MTD discussion mailing list
> > http://lists.infradead.org/mailman/listinfo/linux-mtd/
> > 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
