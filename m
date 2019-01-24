Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A4AC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:52:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45CF7218AF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cYH5NQif";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ss6Ztrhz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45CF7218AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qwnCtOdiUL4HoE118+vUMCYorDz8ppJeBvlfdHp5Uco=; b=cYH5NQif5YsmmS
	5KVmDrvNCPVIUQR+w4A5SAh+Z1RBvO7om3e0EWtiGW32XdOroPFvL4uCXJyK3jkOL9mp98QdX2d7P
	bxu5XteYkd1uvx5n27eMIKwiOFjAtaKPl6BgSsxWyJL7zzGp5Mjo5mAB3ToC7SeJS28vjQJk7Y5Nv
	uACBykSCMFf1qmTyp4NPc83adP9HGRPguP4tiPRl8ZcjNBZM3lkNxOQBHIwUqLaf37PA2ME//60GX
	ymRJuQBvS3KKAwu0Bw+0S2UDBVGEAKVBPFaYCgUiwyLcLZObwZtjuBbGUD1H/PlqIhehZvzGuGpcC
	2oGkQ53D7K17Nmnz3mKg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmiEQ-0006mg-LW; Thu, 24 Jan 2019 16:51:58 +0000
Received: from vps0.lunn.ch ([185.16.172.187])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmiEM-0006lZ-EC
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 16:51:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=LpuInYSroaxsGpBGg9udgqUneFMOSkBCIERNmtCdHdY=; b=Ss6ZtrhzsRTPRyvZCtGSVs2Eil
 w1+ZWZjktRc9IfbTR9lJeLrizPORe/pDEGojViyB+4FzUgoxXH6wE4cU1qypQnK0WFdC7mr2JeVtT
 GjSSg7DBAk15PzlhHsIzbhoNfvzViPt4uiVrx5+6nwusxiagrBtaBo6/19Yg5+Nf78nk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
 (envelope-from <andrew@lunn.ch>)
 id 1gmiEB-0002Fl-Jx; Thu, 24 Jan 2019 17:51:43 +0100
Date: Thu, 24 Jan 2019 17:51:43 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Vid <vladimir.vid@sartura.hr>
Subject: Re: [PATCH v5] arm64: dts: marvell: Add device tree for uDPU board
Message-ID: <20190124165143.GK482@lunn.ch>
References: <20190124163225.10863-1-vladimir.vid@sartura.hr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190124163225.10863-1-vladimir.vid@sartura.hr>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_085154_630514_067717EF 
X-CRM114-Status: UNSURE (   7.62  )
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
Cc: devicetree@vger.kernel.org, Luis Torres <luis.torres@methode.com>,
 Jason Cooper <jason@lakedaemon.net>, Paul Arola <paul.arola@telus.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Scott Roberts <scott.roberts@telus.com>, Luka Perkov <luka.perkov@sartura.hr>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> +	leds {
> +		pinctrl-names = "default";
> +		compatible = "gpio-leds";
> +
> +		power1 {
> +			label = "power:green:led1";
> +			gpios = <&gpionb 11 GPIO_ACTIVE_LOW>;
> +		};

Documentation/leds/leds-class.txt

LED Device Naming
=================

Is currently of the form:

"devicename:colour:function"

Your device is not named 'power'.

     Andrew

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
