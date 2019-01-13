Return-Path: <SRS0=Fp1N=PV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F8EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 03:31:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1ACC21721
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 03:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n/UyXsg4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jnn7/10A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1ACC21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IuCaYVG1B2JosR3UWNwfv3kIukBL2b6gYNJu6JHElXU=; b=n/UyXsg4vEYODf
	oahCfnr46kUSx2fgitis6Ry/xGGtGoS9Jojc3E8nDei7TkuM/OBATg6cCdrDoQVCVOPy6npzWXYCC
	ftFMO65uBDyjwxXMztt8jvxEG1WnbOchLZJTZuBoP86UGdn03fQ52DtE5eXsGo66Z+3W5/rWkJFwg
	AONLRfMlIHL1e+yiwTv/3CZle7pdrIwa5/OdqwEUIXXovFkBredCbaPLd9dzLJq1cQDGFRMgNVmhq
	WxT+TOxdbfBSrPMmMKi8z2KJ0MVvLPpr1l+LYCVq6NwhdH/YZ/4WOBlGgU/NlH5vPTvuvg6B6PXdc
	RuswKycOmu+mlhArECpA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giWUz-0006ty-9p; Sun, 13 Jan 2019 03:31:45 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giWUv-0006ta-So; Sun, 13 Jan 2019 03:31:43 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7C3AB20842;
 Sun, 13 Jan 2019 03:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547350300;
 bh=i3YZhurD+wS38n1W/dKsJd/8/j3dp3xIr4+kune7Zxo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Jnn7/10AFQ25Tyk+pVSEDuAUebK+YxALTfB5yfgsKg+Qq+8mHIoBNq4dvdgdaEM1x
 oyJBlGd4by+lcSrCO6wazvs0u5daDtVAQaOi51+WyLdlkwg/sN6GUqYGvOzVvm23+t
 cbmjUeLAGdVVFvtdl6nkeUzDfL7tvW2arz3E3OwY=
Date: Sun, 13 Jan 2019 11:31:19 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Schrempf Frieder <frieder.schrempf@kontron.de>
Subject: Re: [PATCH v8 5/7] ARM: dts: ls1021a: Remove
 fsl,qspi-has-second-chip as it is not used
Message-ID: <20190113033117.GG11426@dragon>
References: <20190107092823.11188-1-frieder.schrempf@kontron.de>
 <20190107092823.11188-6-frieder.schrempf@kontron.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190107092823.11188-6-frieder.schrempf@kontron.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_193141_950612_62BC2E54 
X-CRM114-Status: UNSURE (   9.07  )
X-CRM114-Notice: Please train this message.
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
 "richard@nod.at" <richard@nod.at>,
 "prabhakar.kushwaha@nxp.com" <prabhakar.kushwaha@nxp.com>,
 "han.xu@nxp.com" <han.xu@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Li Yang <leoyang.li@nxp.com>,
 "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
 "yogeshnarayan.gaur@nxp.com" <yogeshnarayan.gaur@nxp.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
 "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
 "david.wolfe@nxp.com" <david.wolfe@nxp.com>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 07, 2019 at 09:29:54AM +0000, Schrempf Frieder wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> After switching to the new FSL QSPI driver the property
> 'fsl,qspi-has-second-chip' is not needed anymore.
> 
> The driver now uses the 'reg' property to determine the bus and
> the chipselect.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Applied, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
