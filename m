Return-Path: <SRS0=kGow=PH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B89C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 17:15:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B58920828
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 17:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FLgyvsKR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B58920828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cTErQmlWJhNxgjMUqx/K1UyD/6fPw7NzznP+soZMNYg=; b=FLgyvsKRjO2y0R
	kV0RTgW2j5V2mDZnqy5rFXFaHQ8/+ENiDF0HtfXKMuQQPt4FAIx+pTHnTZ2y0iOAdv67uPcZXRtU3
	oVjc4Tixu6P1oKNiEe1XYjYJgLCpYlHkBwowYm5whuB11Wmz+/V+D+5JUMAdalz7VBIaI0hvv6Sh4
	pmyJhIGzJwzuw7Ms4a3zv/6X9xYISeMkCATVp7FvuGpCK0Zsx+alOmBPtyoarLimLsltVnVdfwnPD
	IZPnMzcEvz31qb9VZ8OS7waxRc/6QXA37gQ9hNFQ3kng9bguZ+y389COn3cotD476Hg+P7CGFN4m0
	pVw9EHy/TGmZoqyRbv+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gdeg0-0002pG-LX; Sun, 30 Dec 2018 17:15:00 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gdefw-0002oW-Ty; Sun, 30 Dec 2018 17:14:58 +0000
Received: from [46.183.103.17] (helo=phil.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1gdefY-0003f0-RG; Sun, 30 Dec 2018 18:14:32 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Johan Jonker <jbx6244@gmail.com>
Subject: Re: [PATCH v2 2/7] clk: rockchip: rk3188: add CLK_SET_RATE_PARENT for
 lcdc dclk
Date: Sun, 30 Dec 2018 18:05:00 +0100
Message-ID: <4934072.iLo9ia0RBU@phil>
In-Reply-To: <20181229133318.18128-3-jbx6244@gmail.com>
References: <20181229133318.18128-1-jbx6244@gmail.com>
 <20181229133318.18128-3-jbx6244@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181230_091457_135981_58E658C2 
X-CRM114-Status: UNSURE (   8.91  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, airlied@linux.ie, mturquette@baylibre.com,
 hjc@rock-chips.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, sboyd@kernel.org, robh+dt@kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am Samstag, 29. Dezember 2018, 14:33:13 CET schrieb Johan Jonker:
> From: Finley Xiao <finley.xiao@rock-chips.com>
> 
> Add CLK_SET_RATE_PARENT for lcdc dclk.
> 
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

applied for 4.22

Thanks
Heiko



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
