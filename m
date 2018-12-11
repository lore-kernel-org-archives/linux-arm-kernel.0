Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491E3C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:37:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19C3F2084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I6tMkL6A";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DT1V4ovv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19C3F2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AUWnLVi96sVy50Upzpe6ZyIb76ZWAngspDoziRWmJ0I=; b=I6tMkL6Ai5tBpY
	9+Vaeyd5aErfC6B4MPTAnZn0QHrOA0zP467phROoAIA/arXGCNvlW7ld5Cpyz1RsSIgMs0m8EQd7b
	DK9junmCl4yh+Lqofvvo8sfNN0bJonFAl/9vc7gKo2p/veIMyeAbpm/2pAkSa9d5wJoXMvdTp3rzD
	6a09XelKoFGVBu+I4BfktJnYUlEBdsuTwvB+3lrzxZ58cw4IMfgHH8G8+Amo2ZG40aKiUzpuIRhV0
	OqUkJGfTrEtVKvfJEUUgVMs/j9Tvn3k0jFku81mOZnYxi8sugA0qqhRgs2vz4UJM2c5Gj+DxnzGQE
	GZebykQScoPPOmRECnIQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWhHW-0005fd-5F; Tue, 11 Dec 2018 12:36:58 +0000
Received: from vps0.lunn.ch ([185.16.172.187])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWhHS-0005PY-JE
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 12:36:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; 
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
 bh=cO8bqPObluxtwqtj8Yy9cAeq1a0www2jVDD2cOH/QRk=; 
 b=DT1V4ovvDhT0t/LTh66Wy+z2sFoLJfmE2O9wcKkg3bm4C4HAwc/JNhVHM/+bzHshR/cmCBH70LlJHqMIbjUkk4SCPkhyxvzp3ebGyP8EcHoPzQrwabdcUp6SNxRgRigdGlnmVVFD3YiX42OkhKUzt8imbVsCcGxilTqBev0/vOM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
 (envelope-from <andrew@lunn.ch>)
 id 1gWhHE-0001mm-1C; Tue, 11 Dec 2018 13:36:40 +0100
Date: Tue, 11 Dec 2018 13:36:40 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>
Subject: Re: [PATCH] ARM: dts: imx: Add Y Soft IOTA Draco, Hydra and Ursa
 boards
Message-ID: <20181211123640.GC4632@lunn.ch>
References: <1541086962-52626-1-git-send-email-michal.vokac@ysoft.com>
 <5bea0e99.1c69fb81.18be0.5162@mx.google.com>
 <42ffee3e-7c2a-aab9-547f-2064a77339a8@ysoft.com>
 <a61683a2-30aa-e387-2170-3d79e0043739@ysoft.com>
 <18065d41-4ae0-ada2-35f1-00d8a8489397@ysoft.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <18065d41-4ae0-ada2-35f1-00d8a8489397@ysoft.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_043654_824304_826E2F8A 
X-CRM114-Status: GOOD (  15.51  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> > Hi Rob, gentle ping on this.
> > 
> > I would like to be sure how to proceed with this. Do you really want me
> > to move *all* nodes that are disabled in this common dtsi into the per
> > board dts?
> > 
> > All the boards use identical PCB. Anything that is disabled here is not
> > present on at least one of the boards. It means it is routed on the
> > board and the SoC has the capability but the parts are not populated.
> > 
> > So it is not only about the LED controller. What about the LCD, OLED,
> > backlight, USB..?
> 
> Can anybody advice how to split these dts/dtsi files, please?
> I am not sure what should reside in the common dtsi and what should
> be moved into the per board dts in case my current solution is not
> appropriate.

The kirkwood-synology.dtsi might be of interest? There are a lot of
Synology NAS boxes which share a lot in common. So all the common
parts are in that .dtsi. The .dbs file for each individual model then
enables the parts its needs.

Although you have one PCB, or the different population options
considered different products, each with there own name?

	   Andrew

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
