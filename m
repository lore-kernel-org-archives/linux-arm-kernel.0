Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0150FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:58:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6CE02173B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mpbD+jCL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6CE02173B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=u7DtNyeJq4TLmHVnIJW+otcJ//5oSAffuVadM/QGaH4=; b=mpbD+jCLG5/j1J
	g3W/ZfT6b278BTduXZ7luiPpurcM4CQj+t5wfu1W42HcB/mhVRuuq+iXanRv00inZomPTBkgPElRz
	I1xfquSNR6EgMD2DYEL/OPAYMxOX5gbuHM6hkIK0CIiTxyNkQ4Js2N6QKoYwURi4Sfyhwj8f1Xz+o
	Dor7sIrzqliOzl69UgBE0DaaD+QZwgfavLtIxBTL39VQVIAQrRTqNIP0fEePbzJvIrPy51irKrQuU
	jm7OJjlEA+Z295NaUEZn/w9/dpu1Imz57ZqPC5Cfa7AQo7Z85t7w7s/D0nMcuguFiCE2KaZjfrfsA
	KMeM2p3mU4lvShapL5Aw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghjHR-0006ik-Jj; Thu, 10 Jan 2019 22:58:29 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghjHO-0006iI-Ey; Thu, 10 Jan 2019 22:58:27 +0000
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32]
 helo=phil.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1ghjHJ-0005pc-Px; Thu, 10 Jan 2019 23:58:21 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Helen Koike <helen.koike@collabora.com>
Subject: Re: [PATCH v4] drm/rockchip: update cursors asynchronously through
 atomic.
Date: Thu, 10 Jan 2019 23:58:20 +0100
Message-ID: <2812027.QDNv8WpI9g@phil>
In-Reply-To: <20181205123310.7965-1-helen.koike@collabora.com>
References: <20181205123310.7965-1-helen.koike@collabora.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_145826_650735_1FA24450 
X-CRM114-Status: UNSURE (   9.20  )
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
Cc: kernel@collabora.com, Sean Paul <seanpaul@google.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 David Airlie <airlied@linux.ie>, Sandy Huang <hjc@rock-chips.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org,
 =?ISO-8859-1?Q?St=E9phane?= Marchesin <marcheu@google.com>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Tomasz Figa <tfiga@chromium.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am Mittwoch, 5. Dezember 2018, 13:33:10 CET schrieb Helen Koike:
> From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> 
> Add support to async updates of cursors by using the new atomic
> interface for that.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> [updated for upstream]
> Signed-off-by: Helen Koike <helen.koike@collabora.com>

applied to drm-misc-next after testing cursor operation on multiple
machines.

Thanks
Heiko



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
