Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFF1C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:17:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7001521736
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kYAUdPHZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7001521736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aAnP+633+AMCY0rgLXLW8HO3i8a7Bg1fUFQQYato7c8=; b=kYAUdPHZiPsim+
	IpRikGy68cbxizDXzPlr5UM1sBa94u/Dnm2qIB+lsPl/4NAHgeiDsh6SsVrEXuTE9yMl5yEXNCEBt
	RIP8gNkMCC6kw+rJcgAMKsdJNBHm8ikICz+COasBhpPbUp0MY0VbgEMBsjbzuzsyHbiDms6XIPOBL
	SQfQN9GWPPz4Es4xRieXurzGpDcvAQQV3uRa2VNPVqRmP4Mlg9C9KPof8NUhiYl6A/WrKLbbbt1LE
	EL+cPmghhurLkE1UbRtjG/0eeK1TAhaPF1/NX5FoFhgeuf6v8R2/uMiMHdEKj2LjOQ1ciRDkfs9Qz
	Z6SVCdjRJXPzy+bF4cWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go3yt-0002Z1-9A; Mon, 28 Jan 2019 10:17:31 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go3yp-0002YY-W6; Mon, 28 Jan 2019 10:17:29 +0000
Received: from wf0848.dip.tu-dresden.de ([141.76.183.80] helo=phil.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1go3yg-0002qk-9K; Mon, 28 Jan 2019 11:17:18 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Damian Kos <dkos@cadence.com>
Subject: Re: [PATCH] drm/rockchip: fix for mailbox read validation.
Date: Mon, 28 Jan 2019 11:17:17 +0100
Message-ID: <4752187.AQatX9g1G3@phil>
In-Reply-To: <1542640463-18332-1-git-send-email-dkos@cadence.com>
References: <1542640463-18332-1-git-send-email-dkos@cadence.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_021728_195294_F3744A96 
X-CRM114-Status: GOOD (  10.49  )
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
Cc: David Airlie <airlied@linux.ie>, Sandy Huang <hjc@rock-chips.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, Chris Zhong <zyw@rock-chips.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am Montag, 19. November 2018, 16:14:14 CET schrieb Damian Kos:
> This is basically the same fix as in
> commit fa68d4f8476b ("drm/rockchip: fix for mailbox read size")
> but for cdn_dp_mailbox_validate_receive function.
> 
> See patchwork.kernel.org/patch/10671981/ for details.
> 
> Signed-off-by: Damian Kos <dkos@cadence.com>

forgot that patch in my inbox somehow ... applied to drm-misc-next now

Thanks
Heiko



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
