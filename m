Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1650C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:49:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA6902087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ewlVHr3e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA6902087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4Rrm/FOzyUzxuSAuSTd+daReP6TazTQtONXFOqomdWA=; b=ewlVHr3evgwF0t
	E035dNNZiU/+RZR4Qk13E7R6P5iTqYXoP8Y4yBxMIaxAS8jFPYBA+C7d3KHkNJ/ATybzh8u5ubijp
	t5pgJfgk1PfINFz96L8d+f6mlGnOdF1PrmKrSkbqwqbcb/LIBPyv2YRw/3IS/XmE6lVxlkh7wCPtg
	KN3Gdj48HfY6wRX1BlQ7AbV7qRadV52X1m6+M/bzEffBsq0p04vubgaXZGVvd9rLUlKq0qJYCU8VJ
	0fF6Uvm8l9JCZSEc++DDv7cwgA4zIzDTdbE4ghZH/qCbihzgq+N8HHVpaMxJneqv3HDYqFBPkPamx
	rip5VIsaAHlc51hK/mCA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUTnh-00048M-Ba; Wed, 05 Dec 2018 09:49:01 +0000
Received: from mail-ed1-f67.google.com ([209.85.208.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUTne-00046W-9D
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 09:48:59 +0000
Received: by mail-ed1-f67.google.com with SMTP id p6so8183195eds.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 01:48:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Gurne33gwhpLkCvGi9a1PbXR8R7tVqXsE2HVurD45GM=;
 b=W27wcduEqLCJdHWIgiJdCOLiWhzB5Ev3g5nEIVg6g+U0DSeKRQb/7egZec72HEONZ2
 xKnCS/8giREVVCpNffUAmpYmfQyTUkmLt+vCapod/yY88l0liJkq67xdxmtPsfdlg9ot
 skH02qcZ4vhVwpWW+6p/FHDWRiq30xcTjJD462MpCaQhxrfAXJ/oQRCHni0FPdeRl5AE
 31WDOnB8QnQnw3vY0eox+d0rcbqXMmrI+He0vmWpdxSClReMkAlR+g05PtnEZVb9KKdc
 ZQJzYkNacwPJOUCVVWKvK3XWyBSLyiOlJPLXcHqh5xKvX5I9oslzdyuaJsKH+HtCUz2Z
 t+RQ==
X-Gm-Message-State: AA+aEWbvTb2KWcJYUcmTPChJ5WR40GhkiEckGoj6Wi/D+IrOeLko35+a
 WevxEDp0mYVEs1MUG2pF0cuF5Yqw/0w=
X-Google-Smtp-Source: AFSGD/XpvWdkZXucSW5eLOniM+BpoxhEbKazmIwhqBtpmbm26itZygd82keROzkcq+zjSXi7XamSfw==
X-Received: by 2002:a50:8bb5:: with SMTP id m50mr20369398edm.211.1544003326282; 
 Wed, 05 Dec 2018 01:48:46 -0800 (PST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com.
 [209.85.128.50])
 by smtp.gmail.com with ESMTPSA id d2sm5365285eda.92.2018.12.05.01.48.45
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Dec 2018 01:48:46 -0800 (PST)
Received: by mail-wm1-f50.google.com with SMTP id z18so12538826wmc.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 01:48:45 -0800 (PST)
X-Received: by 2002:a1c:f605:: with SMTP id w5mr15965019wmc.116.1544003325382; 
 Wed, 05 Dec 2018 01:48:45 -0800 (PST)
MIME-Version: 1.0
References: <20181205092444.29497-1-paul.kocialkowski@bootlin.com>
In-Reply-To: <20181205092444.29497-1-paul.kocialkowski@bootlin.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 5 Dec 2018 17:48:34 +0800
X-Gmail-Original-Message-ID: <CAGb2v64fjKbxET61S7NzTaPGJc7-XUG=Zb87_BOah9xWr5zpvg@mail.gmail.com>
Message-ID: <CAGb2v64fjKbxET61S7NzTaPGJc7-XUG=Zb87_BOah9xWr5zpvg@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] Cedrus H5 and A64 support with A33 and H3 updates
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_014858_316294_B1604932 
X-CRM114-Status: GOOD (  19.21  )
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
Cc: devel@driverdev.osuosl.org, devicetree <devicetree@vger.kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Hans Verkuil <hverkuil@xs4all.nl>,
 linux-sunxi <linux-sunxi@googlegroups.com>, Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 5, 2018 at 5:25 PM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
>
> This series adds support for the Allwinner H5 and A64 platforms to the
> cedrus stateless video codec driver, with minor updates to the A33 and
> H3 platforms.
>
> It requires changes to the SRAM driver bindings and driver, to properly
> support the H5 and the A64 C1 SRAM section. Because a H5-specific
> system-control node is introduced, the dummy syscon node that was shared
> between the H3 and H5 is removed in favor of each platform-specific node.
> A few fixes are included to ensure that the EMAC clock configuration
> register is still accessible through the sunxi SRAM driver (instead of the
> dummy syscon node, that was there for this purpose) on the H3 and H5.
>
> The reserved memory nodes for the A33 and H3 are also removed in this
> series, since they are not actually necessary.
>
> Changes since v1:
> * Removed the reserved-memory nodes for the A64 and H5;
> * Removed the reserved-memory nodes for the A33 and H3;
> * Corrected the SRAM bases and sizes to the best of our knowledge;
> * Dropped cosmetic dt changes already included in the sunxi tree.
>
> Paul Kocialkowski (15):
>   ARM: dts: sun8i: h3: Fix the system-control register range
>   ARM: dts: sun8i: a33: Remove unnecessary reserved memory node
>   ARM: dts: sun8i: h3: Remove unnecessary reserved memory node
>   soc: sunxi: sram: Enable EMAC clock access for H3 variant
>   dt-bindings: sram: sunxi: Add bindings for the H5 with SRAM C1
>   soc: sunxi: sram: Add support for the H5 SoC system control
>   arm64: dts: allwinner: h5: Add system-control node with SRAM C1
>   ARM/arm64: sunxi: Move H3/H5 syscon label over to soc-specific nodes
>   dt-bindings: sram: sunxi: Add compatible for the A64 SRAM C1
>   arm64: dts: allwinner: a64: Add support for the SRAM C1 section
>   dt-bindings: media: cedrus: Add compatibles for the A64 and H5
>   media: cedrus: Add device-tree compatible and variant for H5 support
>   media: cedrus: Add device-tree compatible and variant for A64 support
>   arm64: dts: allwinner: h5: Add Video Engine node
>   arm64: dts: allwinner: a64: Add Video Engine node

Other than the error in patch 7,

Acked-by: Chen-Yu Tsai <wens@csie.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
