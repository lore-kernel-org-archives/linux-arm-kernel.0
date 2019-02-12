Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AFCC282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:47:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FE5121773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fhaEFObf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FE5121773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NU0RhDoHKmzCIHxTy10dqrVjds9q2ph8Negj6gf/iXU=; b=fhaEFObfT0I6w1
	EQnL6s2sNjaMmvCFS3BINbzI08IE6OGZBZWB5bE8k52J2Z+ihthd8YpRaDrPJ1SyXhKACRCFwpxPB
	EBKNpV9BefkhME7iy6j1WLxaaW5wJWwVz6DMI513tTnZuH/2ZdWnduSSt3jYirt3G4HaxPLKHAXGx
	baJ3Fs7gF95xHXyPpGz6sNXXoa8bSc8g2Bt/geVg0K1VlqsknQmdzUvXSExaG02bpm1fzoR55LmdP
	7qO/cxfUomQ+DcEoHRZE5l299IyVVebN8P5BNr6yD+c+AnyW6bisQ6dvXGWADIoJN0j4FymAdmG58
	Q5rANNpw/neIpb5P3UZw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtVbR-0007fO-1B; Tue, 12 Feb 2019 10:47:49 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtVbM-0007el-9a; Tue, 12 Feb 2019 10:47:47 +0000
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32]
 helo=diego.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1gtVbA-00013l-F1; Tue, 12 Feb 2019 11:47:32 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Yizhuo <yzhai003@ucr.edu>
Subject: Re: [PATCH] phy: Variable "caldone" in function
 rockchip_emmc_phy_power() could be uninitialized
Date: Tue, 12 Feb 2019 11:47:31 +0100
Message-ID: <1884796.YtlDmFZGdE@diego>
In-Reply-To: <20190206014733.21094-1-yzhai003@ucr.edu>
References: <20190206014733.21094-1-yzhai003@ucr.edu>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_024744_632667_8C22229B 
X-CRM114-Status: GOOD (  17.38  )
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

Am Mittwoch, 6. Februar 2019, 02:47:33 CET schrieb Yizhuo:
> In function rockchip_emmc_phy_power(), local variable "caldone"
> could be uninitialized if function regmap_read() returns -EINVAL.
> However, it will be used directly in the later context, which
> is potentially unsafe.
> 
> Signed-off-by: Yizhuo <yzhai003@ucr.edu>
> ---
>  drivers/phy/rockchip/phy-rockchip-emmc.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-emmc.c
> b/drivers/phy/rockchip/phy-rockchip-emmc.c index f1b24f18e9b2..ca921ae08309
> 100644
> --- a/drivers/phy/rockchip/phy-rockchip-emmc.c
> +++ b/drivers/phy/rockchip/phy-rockchip-emmc.c
> @@ -85,11 +85,12 @@ struct rockchip_emmc_phy {
>  static int rockchip_emmc_phy_power(struct phy *phy, bool on_off)
>  {
>  	struct rockchip_emmc_phy *rk_phy = phy_get_drvdata(phy);
> -	unsigned int caldone;
> +	unsigned int caldone = 0;

hmm, this may hide actual uninitialized uses in the future?
With the added error handling below, there shouldn't be a case
where caldone might be used uninitialized still?


Heiko

>  	unsigned int dllrdy;
>  	unsigned int freqsel = PHYCTRL_FREQSEL_200M;
>  	unsigned long rate;
>  	unsigned long timeout;
> +	int err;
> 
>  	/*
>  	 * Keep phyctrl_pdb and phyctrl_endll low to allow
> @@ -164,9 +165,14 @@ static int rockchip_emmc_phy_power(struct phy *phy,
> bool on_off) * wait 5us for calpad busy trimming
>  	 */
>  	udelay(5);
> -	regmap_read(rk_phy->reg_base,
> +	err = regmap_read(rk_phy->reg_base,
>  		    rk_phy->reg_offset + GRF_EMMCPHY_STATUS,
>  		    &caldone);
> +	if (err) {
> +		pr_err("Failed to read status.\n");
> +		return err;
> +	}
> +
>  	caldone = (caldone >> PHYCTRL_CALDONE_SHIFT) & PHYCTRL_CALDONE_MASK;
>  	if (caldone != PHYCTRL_CALDONE_DONE) {
>  		pr_err("rockchip_emmc_phy_power: caldone timeout.\n");





_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
