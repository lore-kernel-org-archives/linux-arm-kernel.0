Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0664C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:08:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99AE7218DE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p1irBTtN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="k8/6/kQq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99AE7218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mRO6fIXdNMbTsIMmwZTMddMcyrFNJX6bjXrGvQxF9P0=; b=p1irBTtNCN1sVb
	TtnOTuRLbDuf9i4ynYDRNHIUsbqCNDiIMGAT9JIvCF5lMBKHE/Ch7NJyEYZp4phjEO8Pib4GNyC0U
	jEBFZC9qb6cE+qCon+19biI2tcNLIfoaY4cxFPrd07/jO/4+jvRdSrnw6/42F8TCuu/Yfh/OM1Zdp
	f3pQdMjPWGSdgz2XzPjj7KvniLk2AU42tH/3KcTs2QplTYwTP7kHX5uN2gz5cIoDBES5oB8XyP+sD
	lIGbC4jv7n7jQBd5S5R3vplmiznxART4Z64CQXxiPKoCMwnJp2ro4qe3S4uxVYDQCU78PjpWfa+9Q
	h3DdKp1hmM3GBfcG229g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn1Dq-0003Wo-Nc; Fri, 25 Jan 2019 13:08:38 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn1Dn-00030T-CL
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 13:08:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3l9KA5WA47X3fuBSEU6EOmrGqfvF82jiXonXzym/elk=; b=k8/6/kQqbWxwHV0+gTzd5zLgg
 xQ+O/kY/yw/T/SD4qfcieWsxwb+5mKcpIh/cRlMkjo+bnWhfMalqrCZf6qTib1P/LzgipAc3zl1Bm
 M8Sqo8hVqizJEKWaTCa6/ujRJoM4m8b9MIHp8KDy0HG/Fno8gzMqgacm5aPff+PpzqOU4=;
Received: from e5254000004ec.dyn.armlinux.org.uk
 ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:50938 helo=shell.armlinux.org.uk)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gn1BV-00026v-Qn; Fri, 25 Jan 2019 13:06:13 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1gn1BV-0001hZ-4O; Fri, 25 Jan 2019 13:06:13 +0000
Date: Fri, 25 Jan 2019 13:06:13 +0000
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: Carlo Caione <ccaione@baylibre.com>
Subject: Re: [PATCH 0/3] at803x: Add quirk to disable SmartEEE
Message-ID: <20190125130612.npknjuzjmny4yohg@e5254000004ec.dyn.armlinux.org.uk>
References: <20190125125513.23656-1-ccaione@baylibre.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190125125513.23656-1-ccaione@baylibre.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_050835_568864_EC6CBE47 
X-CRM114-Status: GOOD (  14.05  )
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
Cc: mark.rutland@arm.com, andrew@lunn.ch, f.fainelli@gmail.com,
 devicetree@vger.kernel.org, s.hauer@pengutronix.de, abailon@baylibre.com,
 robh+dt@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de,
 fabio.estevam@nxp.com, shawnguo@kernel.org, aisheng.dong@nxp.com,
 linux-arm-kernel@lists.infradead.org, hkallweit1@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 25, 2019 at 12:55:10PM +0000, Carlo Caione wrote:
> SmartEEE, compatible with IEEE802.3az standard, is designed to include
> legacy MAC without EEE capability into the power saving system. SmartEEE 
> is enabled by default configuration on AR8031 after power-on or hardware 
> reset.
> 
> Unfortunately this is proved causing issues for certain hw 
> configurations.  We add a quirk to optionally disable SmartEEE.

It may be a good idea to detail what "certain hw configurations" are
and/or what the "issues" are, so it's easier to find this if/when
others encounter the same issue.

> 
> PATCH 3/3 depends on https://patchwork.kernel.org/patch/10781297/
> 
> 
> Carlo Caione (3):
>   net: phy: at803x: Introduce quirk to disable SmartEEE
>   dt-bindings: net: at803x: Document at803x,smarteee-disabled property
>   arm64: dts: imx8mq-evk: Disable SmartEEE
> 
>  .../devicetree/bindings/net/at803x.txt        | 18 +++++++++++++++
>  arch/arm64/boot/dts/freescale/imx8mq-evk.dts  |  1 +
>  drivers/net/phy/at803x.c                      | 22 +++++++++++++++++++
>  3 files changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/at803x.txt
> 
> -- 
> 2.19.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
