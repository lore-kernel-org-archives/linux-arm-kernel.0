Return-Path: <SRS0=kGow=PH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C2BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 14:04:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C551A2075D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 14:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P5dSYBRM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C551A2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Qzi4CmGXYOhCrjZC2fNoWqmZdi6yo/C7l5pYpZbnT+I=; b=P5dSYBRML94REJ
	9lmBxJS64+vOTZQz6Bd9qZ6E+5xbvznWXIX0ccriElEhpb3FzLQmdI9cixtQZOwJeDBzQDywsoAGc
	XQm4YMCEdxryfJpMEcmsQLvIgVl5zoPSxZfbSZzF3KOELnC1i8VQ48b6pgC9epubT+Jb5XMZzLsO4
	UIrHmDcv/SvOAojlcF1rNbBELdgKEqTODU7VmlkOLPUffLSitLmc8gjjeT/NMd4Wj7CsjkHc9sMZ3
	oVqiqxhhaEcBf9NRxSf1VrDN5FGRa8oUdcU2JcoQ1/f7Xd8AygjJwDphJHcxSJl03JF4E04bPauMP
	49CuN8r8LMhpyPA0BtFA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gdbhO-0000sV-2E; Sun, 30 Dec 2018 14:04:14 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gdbhK-0000r8-Et; Sun, 30 Dec 2018 14:04:12 +0000
Received: from [46.183.103.8] (helo=phil.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1gdbgv-00038W-C4; Sun, 30 Dec 2018 15:03:45 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Johan Jonker <jbx6244@gmail.com>
Subject: Re: [PATCH v2 1/7] ARM: dts: rockchip: rk3066: add HCLK_HDMI to pmu
 node
Date: Sun, 30 Dec 2018 15:03:43 +0100
Message-ID: <1546188525.f5QxLQzqUk@phil>
In-Reply-To: <20181229133318.18128-2-jbx6244@gmail.com>
References: <20181229133318.18128-1-jbx6244@gmail.com>
 <20181229133318.18128-2-jbx6244@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181230_060410_647664_4A60528A 
X-CRM114-Status: GOOD (  11.41  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, airlied@linux.ie, mturquette@baylibre.com,
 hjc@rock-chips.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, sboyd@kernel.org, robh+dt@kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am Samstag, 29. Dezember 2018, 14:33:12 CET schrieb Johan Jonker:
> A MK808 TV stick with rk3066 processor
> boots normal with logo and console,
> but after booting the monitor remains black.
> This patch fixes a vblank wait time out
> by adding HCLK_HDMI to the pmu node.
> The HCLK_HDMI clock is now part of the logic
> that enables the RK3066_PD_VIO power domain.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

applied for 4.22

Thanks
Heiko



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
