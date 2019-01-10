Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAFEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:46:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB21020879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lyZaYcpV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB21020879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4qMy9gLFbSbeA4i28IveaibD/Tr/PLaF5rghrku+YTM=; b=lyZaYcpVBF2SQD
	ePRcYsUyaM+1i34xUKcGkBfX2C3YSpuQ0NBdAeAYI3fv64lis6T11t3uK1i6NEkk5Iqkk6va2qo/z
	Wz/aIeD+N55Slmnb6lCfi/bSxNHkGqTKV+KzPOYSGaHSA27/5PXhSyJ1qTtfayImMvlcu1b2ghZ7S
	H/uZRhGDdU5/Q4RkY+axrBmaj8hHc8DqJ9cPFnrnO4eC4f54Zi7qkojhreY4xPLbqwu/c6+YV6pOP
	4PNl+9jaMjuHgQRUgGpYwwro1CeFjl604GFG1Xz0JdTJz6gJYVVD/EJElHtsESujctnvhSj6vhm10
	jeGgqIJUnWxo9mIh7JMA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghafa-0002t4-3C; Thu, 10 Jan 2019 13:46:50 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghafW-0002sK-EK; Thu, 10 Jan 2019 13:46:47 +0000
Received: from wf0848.dip.tu-dresden.de ([141.76.183.80] helo=phil.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1ghafU-0003TG-MU; Thu, 10 Jan 2019 14:46:44 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 3/5] arm64: dts: rockchip: Refine nanopi4 differences
Date: Thu, 10 Jan 2019 14:46:44 +0100
Message-ID: <1962946.sYgHsuXWla@phil>
In-Reply-To: <2123f6ef0bc4429fc48709af822289c82a63d46f.1546981251.git.robin.murphy@arm.com>
References: <cover.1546981251.git.robin.murphy@arm.com>
 <2123f6ef0bc4429fc48709af822289c82a63d46f.1546981251.git.robin.murphy@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_054646_629048_0D9AAD3B 
X-CRM114-Status: GOOD (  11.19  )
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
Cc: linux-rockchip@lists.infradead.org, tomeu.vizoso@collabora.com,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am Dienstag, 8. Januar 2019, 22:57:25 CET schrieb Robin Murphy:
> The nanopi4 boards differ primarily in their power trees, with the main
> 5V and 3.3V rails having very different topologies on the smaller USB-C
> powered boards vs. the 12V-powered T4, as well as minor variation in
> other regulators related to various external connectors.
> 
> Additionally, the recovery key is only present on the T4 - ADC_IN1 is
> simply pulled high and not exposed on the other boards - and the lowest
> common denominator for MMC speed is actually HS200 according to the
> vendor DTs.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

this looks good to me, so only need patch2 to adapt and get reviewed.

Heiko



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
