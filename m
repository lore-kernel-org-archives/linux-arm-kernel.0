Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54355C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:50:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24BD8214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZuZ/2rwk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24BD8214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Uqdk5r0a5Bn4b81BpdtJ512QPOPazL3KOM18MH3XBSs=; b=ZuZ/2rwkMAvaz7
	jlqlfqPca7K6rRXqKX+nu+OnuevWnrO2QwoAIo46xscNQ/8ud6oJXziL2nYuaJusyOBb96cSQPFlU
	IyaQ4O77ENS6jObOTUCb9ngWRM1r3DZA2R8KJ6XNuAUx1rlNBRkxLaGnm2lKPA2vJWk8gKDRqeUCa
	KbK35qjfhgdxuovbFgXwcRkNAr7dTCi85uImEr4dnoPqpgvT1JUhK92kyN1U18VbuFAwd+1joeF35
	+ibsVHGg1LlvLZgTVT759NqBBv00fAXEXN240TEljXzN0rzYsKAunOY20kTVlhifTFPxtxxz2Tb3y
	W3rTdZQSQEHkfeu1Bkyg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtVdX-0008BY-49; Tue, 12 Feb 2019 10:49:59 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtVdU-0008B4-Mk; Tue, 12 Feb 2019 10:49:58 +0000
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32]
 helo=diego.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1gtVdP-00014V-Tf; Tue, 12 Feb 2019 11:49:51 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Yizhuo <yzhai003@ucr.edu>
Subject: Re: [PATCH] phy: rockchip-typec: Variable "val" of function
 rockchip_usb3_phy_power_on() could be uninitialized
Date: Tue, 12 Feb 2019 11:49:51 +0100
Message-ID: <3410531.oxWKaip9ZE@diego>
In-Reply-To: <20190206021810.21596-1-yzhai003@ucr.edu>
References: <20190206021810.21596-1-yzhai003@ucr.edu>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_024956_889207_7F4BD6ED 
X-CRM114-Status: GOOD (  15.40  )
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
Cc: csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, linux-kernel@vger.kernel.org,
 Kishon Vijay Abraham I <kishon@ti.com>, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am Mittwoch, 6. Februar 2019, 03:18:10 CET schrieb Yizhuo:
> In function rockchip_usb3_phy_power_on(), local variable
> "val" could be uninitialized if function regmap_read()
> returns -EINVAL. However, this value is directly used in
> later context. This is potentially unsafe.

While highly unlikely case (GRF-registers are mmio-based),
it's still nicer to go the clean way, so

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> Signed-off-by: Yizhuo <yzhai003@ucr.edu>
> ---
>  drivers/phy/rockchip/phy-rockchip-typec.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-typec.c
> b/drivers/phy/rockchip/phy-rockchip-typec.c index
> a958c9bced01..b1e24418cb2d 100644
> --- a/drivers/phy/rockchip/phy-rockchip-typec.c
> +++ b/drivers/phy/rockchip/phy-rockchip-typec.c
> @@ -716,7 +716,10 @@ static int rockchip_usb3_phy_power_on(struct phy *phy)
> 
>  	/* wait TCPHY for pipe ready */
>  	for (timeout = 0; timeout < 100; timeout++) {
> -		regmap_read(tcphy->grf_regs, reg->offset, &val);
> +		ret = regmap_read(tcphy->grf_regs, reg->offset, &val);
> +		if (ret)
> +			goto unlock_ret;
> +
>  		if (!(val & BIT(reg->enable_bit))) {
>  			tcphy->mode |= new_mode & (MODE_DFP_USB | MODE_UFP_USB);
>  			goto unlock_ret;





_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
