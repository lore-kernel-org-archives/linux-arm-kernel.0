Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC813C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:42:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E924205C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i4WW49XY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPZWTvmk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E924205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uXK1z6gwYk5yb0PjnVkIXcwVpwjoSwyGWq4+QkiEVIM=; b=i4WW49XYUg5/Yw
	7o532QLyu4qDzMm6YgLCgXUNlivPpQjxYw0PyHweJRCQU+mPwSIEWwxiu45vABuGzXXGDve2qIVFx
	76scB8AJX7D/ovw3IBX0itZySQp1Q/rABNL4xY6uKmy1vK5BiFerbPgUD+fEIFquIgI8lV6JI0Cml
	v0BaPbMU7ykSLoM4OUX2YC5IHnUacCtqpHPrRqOhysFAaUfGy67ps8y1YMpk1twGStt5c5SrsdEVX
	orBDfMqgBaPn9MmcP6M60x/ZtksGKbqIQnWEPSbUyaiwpLL0K9fD5p+dOmQbPoW0ABbByJVg2lBj3
	y/18vFqeH3wyNnY4soTg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxFmU-0000Gy-6H; Fri, 22 Feb 2019 18:42:42 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxFmR-0000Gf-3T
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 18:42:40 +0000
Received: by mail-wr1-x441.google.com with SMTP id r5so3415608wrg.9
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 10:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=TGjiaNf+TchAJ9Gtpr3tqaggBXdzik2vcZtd+3yyA38=;
 b=IPZWTvmkrMYwaPO/jRG33qshvJWYRMqruTRJb+clDaZnpI1ghbvZl64rmb5HxoRNOp
 a5kZTm8JqKmiSEAeOXqKsyEWhulm7q9Ms2hpTSk949IG9Ol0his9RW6x/yNc7i4vRz7t
 MUzNEyA/hgoBVGC2R5ZD+N2JIbxydJ2I9jagvflxQyZEwzfmvYY/nIiD5jVyuTiG8+x1
 4im4orCPAke8lJpk98ZZEJq7yFWp16SZIm2ckWtGsAHP92CL4fKOQk13e9YB/rCThKgF
 fwVH1VFaUp5PfrraFfpbVNwWTImzMP9ZWZrjyizCgYDyOWWhwkDdGiVat9Rl5M6mOcRi
 G2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TGjiaNf+TchAJ9Gtpr3tqaggBXdzik2vcZtd+3yyA38=;
 b=VNSW78JmxENx9JH3keYCJBSKQJTp9TdE2LDr+TnZ6T1z4l9JM6R0m/CAPNaOPuIW/h
 NRnSAq9jo8JzNIXXBoyelJ9mBHt0W8AXQvgav0UlPStOLp2RcOU6p+VCNTBXO9UGAOMy
 NDGD+wJYioDIMzmIp5sHU7y/ayih7XTEVFRsZ3enjhx7wQgTJSsERwpa/0zC+jCeYVnV
 cMGwcRv5h4R1FqCBuc5AnOk3c+j0dghLJsKBnj0zbAkqNO4tt6V+yXlt1qCH7a5lqZ9D
 wDQwaM4C8HNOpTLVsYLNoCGI99+kUlPQ1bZ1TxKOyRWiotyLb6NIclcj334NgHmdDN6j
 FSxA==
X-Gm-Message-State: AHQUAuasZ2maxz9RPteqjOf9EcPxhqn0wbjqt3kH9bWXbYLqOCJH/7FL
 iBUk4oq5vuzvSB75yCQ+yls=
X-Google-Smtp-Source: AHgI3IZdPsGfCh6i9nnFkKpECl3oQ3s6Gqev41iTPMDF0ifz+gaFIftr3h+jrl0+XBpICN2zVS13/w==
X-Received: by 2002:adf:ff81:: with SMTP id j1mr4038281wrr.261.1550860956942; 
 Fri, 22 Feb 2019 10:42:36 -0800 (PST)
Received: from ?IPv6:2003:ea:8bf1:e200:881a:e62a:a902:5b57?
 (p200300EA8BF1E200881AE62AA9025B57.dip0.t-ipconnect.de.
 [2003:ea:8bf1:e200:881a:e62a:a902:5b57])
 by smtp.googlemail.com with ESMTPSA id m26sm1148509wmg.13.2019.02.22.10.42.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Feb 2019 10:42:35 -0800 (PST)
Subject: Re: [PATCH net-next 1/7] net: phy: marvell10g: Use get_features to
 get the PHY abilities
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net
References: <20190221095128.28188-1-maxime.chevallier@bootlin.com>
 <20190221095128.28188-2-maxime.chevallier@bootlin.com>
From: Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <a69da540-fe5c-e9a7-d848-2f2c61011f21@gmail.com>
Date: Fri, 22 Feb 2019 19:42:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190221095128.28188-2-maxime.chevallier@bootlin.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_104239_167887_78B72E7B 
X-CRM114-Status: GOOD (  24.53  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Antoine Tenart <antoine.tenart@bootlin.com>, netdev@vger.kernel.org,
 gregory.clement@bootlin.com, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org, nadavh@marvell.com, thomas.petazzoni@bootlin.com,
 miquel.raynal@bootlin.com, stefanc@marvell.com, mw@semihalf.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 21.02.2019 10:51, Maxime Chevallier wrote:
> The Alaska family of 10G PHYs has more abilities than the ones listed in
> PHY_10GBIT_FULL_FEATURES, the exact list depending on the model.
> 
> Make use of the newly introduced .get_features call to build this list,
> using genphy_c45_pma_read_abilities to build the list of supported
> linkmodes, and adding autoneg ability based on what's reported by the AN
> MMD.
> 
> .config_init is still used to validate the interface_mode.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
>  drivers/net/phy/marvell10g.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
> index 9ea27acf05ad..65ef469adf58 100644
> --- a/drivers/net/phy/marvell10g.c
> +++ b/drivers/net/phy/marvell10g.c
> @@ -233,8 +233,6 @@ static int mv3310_resume(struct phy_device *phydev)
>  
>  static int mv3310_config_init(struct phy_device *phydev)
>  {
> -	int ret, val;
> -
>  	/* Check that the PHY interface type is compatible */
>  	if (phydev->interface != PHY_INTERFACE_MODE_SGMII &&
>  	    phydev->interface != PHY_INTERFACE_MODE_XAUI &&
> @@ -242,6 +240,12 @@ static int mv3310_config_init(struct phy_device *phydev)
>  	    phydev->interface != PHY_INTERFACE_MODE_10GKR)
>  		return -ENODEV;
>  
> +	return 0;
> +}
> +
> +static int mv3310_get_features(struct phy_device *phydev)
> +{

After my just submitted patch to include the aneg capability checking in
genphy_c45_pma_read_abilities() function mv3310_get_features() isn't
needed any longer and can be replaced with the generic one.
But we can make this change afterwards, then you don't have to
rework your series.

Also I'm not sure whether there will be a 5.0-rc8 or whether beginning
of next week we'll see 5.0. In the latter case we're a little bit in a
hurry because the merge window will start very soon.

> +	int ret, val;
>  	if (phydev->c45_ids.devices_in_package & MDIO_DEVS_AN) {
>  		val = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_STAT1);
>  		if (val < 0)
> @@ -429,7 +433,7 @@ static struct phy_driver mv3310_drivers[] = {
>  		.phy_id		= 0x002b09aa,
>  		.phy_id_mask	= MARVELL_PHY_ID_MASK,
>  		.name		= "mv88x3310",
> -		.features	= PHY_10GBIT_FEATURES,
> +		.get_features	= mv3310_get_features,
>  		.soft_reset	= gen10g_no_soft_reset,
>  		.config_init	= mv3310_config_init,
>  		.probe		= mv3310_probe,
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
