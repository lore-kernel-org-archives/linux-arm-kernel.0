Return-Path: <SRS0=mu0f=QD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0F3C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 21:08:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 275F12087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 21:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OydXgb7I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 275F12087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KqdpSZ3/G4BFz0o7xOTI43nT4Dk970Cm3/94dps0pkA=; b=OydXgb7IkI5KvW
	1j81wg/qZiOeSubper6Rt3RpFPJMEzC3823T7i3MWTn6YgCawFhXGIxSGhXvqVQlDAc+Trjdhyazf
	CzGc18rjeQTJrzQXhZrfXLkcofuEyocr5Ld9vX+Odh+3YqHDMVf8vl5yq8w/haox8879ZaYloi9fJ
	geBsJLXQgJWqYB3IraLyma+eAL7psWwhfptqqqvsWJPWCPirk/dJtzeOVx7CHSe8SspKyLxhRml8H
	2duT98PttCUxNbR4L6fOkoMUzg7UR7c3984SufCPvxvIUI8aqiEFM/RmOrK8g/GPoMReVHu4H/Sfa
	wDTHad8SP6YcadHvp64A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnrez-0007n6-Di; Sun, 27 Jan 2019 21:08:09 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnrev-0007m1-86; Sun, 27 Jan 2019 21:08:06 +0000
Received: from p5b12725f.dip0.t-ipconnect.de ([91.18.114.95]
 helo=phil.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1gnreq-0000aK-GA; Sun, 27 Jan 2019 22:08:00 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH 1/3] arm64: dts: rockchip: fix rk3300-gru-bob graph_port
 warning
Date: Sun, 27 Jan 2019 22:08:00 +0100
Message-ID: <4055651.A8C7SXy0L7@phil>
In-Reply-To: <20190126103730.3883-1-enric.balletbo@collabora.com>
References: <20190126103730.3883-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190127_130805_441311_A42A57FD 
X-CRM114-Status: GOOD (  10.59  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Vicente Bergas <vicencb@gmail.com>,
 linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
 kernel@collabora.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am Samstag, 26. Januar 2019, 11:37:28 CET schrieb Enric Balletbo i Serra:
> Ports are described by child 'port' nodes contained in the device node.
> 'ports' is optional and is used to group all 'port' nodes which is not
> the case here.
> 
> This patch fixes the following warning:
> 
> arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dts:25.9-29.5: Warning (graph_port): /edp-panel/ports: graph port node name should be 'port'
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

I've squashed all 3 into one and applied the result as fix for 5.0

Thanks
Heiko



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
