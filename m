Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD47C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:26:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F84620665
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tSrdS2ID"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F84620665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cXjwxjIsKbssOMZA4A85CNgxBQgJFQ+p6Ec8gnqVgrs=; b=tSrdS2IDQE3hJW
	YImgkVWBnU5K3OGApq8311SSJEdUPyqvLHAEXzoKpaFrcO3bp4jDNN1yZ0Az0tiVlr88RerZOpiiL
	b1Qa7xMAsGrd48NVfVc7gjZgFOWeqZBoJKYVL545hJ5Q9haUENvBXV3SPXQD0Mu5VPAsJE40JjRVg
	Sm5wxagYMqu6Gzp/6/NokM1lzbd77NcfrmK0iq4bx0XiRlzBsWqHSHmj/RSWiQFqbNcjiA6LQZweT
	JjTZO/2mw6Fm5qFwssS5arIBkpSqFj67dluxX0IpS0EmfzrX2/SzJIe7LFXn92WHRKqDKS2r0iQyT
	2taR/sJhhRFp8Lq6T/4Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghZQ6-0004T6-Ab; Thu, 10 Jan 2019 12:26:46 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghZPR-0003ta-1l; Thu, 10 Jan 2019 12:26:26 +0000
Received: from wf0848.dip.tu-dresden.de ([141.76.183.80] helo=phil.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1ghZPK-000320-Au; Thu, 10 Jan 2019 13:25:58 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH v2] dt-bindings: phy-rockchip-inno-usb2: add documentation
 for extcon property
Date: Thu, 10 Jan 2019 13:25:57 +0100
Message-ID: <6183155.mchCxN3k72@phil>
In-Reply-To: <20190109171739.11494-1-enric.balletbo@collabora.com>
References: <20190109171739.11494-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_042605_804192_FEE8DE17 
X-CRM114-Status: UNSURE (   9.97  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 groeck@google.com, Kishon Vijay Abraham I <kishon@ti.com>,
 linux-kernel@vger.kernel.org, kieran.bingham@ideasonboard.com,
 linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
 kernel@collabora.com, bleung@chromium.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am Mittwoch, 9. Januar 2019, 18:17:39 CET schrieb Enric Balletbo i Serra:
> Commit 98898f3bc83c8 ("phy: rockchip-inno-usb2: support otg-port for
> rk3399") introduces the extcon property that is used to detect the
> cable-state. Document this property in the documentation binding.
> 
> Fixes: 98898f3bc83c8 ("phy: rockchip-inno-usb2: support otg-port for rk3399")
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>




_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
