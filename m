Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1368C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:45:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B01032147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fnC9qogy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B01032147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lZFY86tdfKwSItmBhD/LQxUhPzYEELNF08kuDd45G3M=; b=fnC9qogyomNQuk
	B1dOHob5rGYLJktBM8eDnhjwl8c/yuCN6FtMYaB9++na+6ZtxWT8lbD42hDx62J1XTgbmBNUtTNR7
	QaBj/ItaQLu/L9RT2BkV/VStC68DH5JXyoPDZJm2wtCU+nJxmvvvTUOtr5PawcyIf6+L0dNulwUZ1
	2C4d+TFATAXLhHRy1At0pCDX/EFKJBMNCi0UxJLlMdjtgToRTP0PLr8OzNNXdW5Cr5nqakDS0ExUM
	T9giqv+ePKiUZZsaIX6esYPvgWE8IH4FXDRSS1BSG1BBbjJJGDSQQH7aESsZFFGBfxwOhm+k7P9pC
	sJX89nm8yhwE5cKcPLdQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw3q3-0008Us-2l; Tue, 19 Feb 2019 11:45:27 +0000
Received: from smtp3-g21.free.fr ([212.27.42.3])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw3pz-0008UG-JK
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 11:45:25 +0000
Received: from [192.168.108.68] (unknown [213.36.7.13])
 (Authenticated sender: marc.w.gonzalez)
 by smtp3-g21.free.fr (Postfix) with ESMTPSA id 4592F13F8C4;
 Tue, 19 Feb 2019 12:44:56 +0100 (CET)
Subject: Re: [PATCH net-next v3 1/2] net: phy: at803x: don't inline helpers
To: Vinod Koul <vkoul@kernel.org>, David Miller <davem@davemloft.net>,
 netdev <netdev@vger.kernel.org>
References: <20190219061800.31025-1-vkoul@kernel.org>
 <20190219061800.31025-2-vkoul@kernel.org>
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <3cc1b4c8-489e-b5a9-d1ae-c0905befc229@free.fr>
Date: Tue, 19 Feb 2019 12:44:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190219061800.31025-2-vkoul@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_034523_782708_3879ADB9 
X-CRM114-Status: GOOD (  14.49  )
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
 Nori Sekhar <nsekhar@ti.com>, Bjorn Andersson <bjorn.andersson@linaro.org>,
 Peter Ujfalusi <peter.ujfalusi@ti.com>,
 Niklas Cassel <niklas.cassel@linaro.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 19/02/2019 07:17, Vinod Koul wrote:

> Some helpers were inlined, but makes more sense to allow compiler
> to do the right optimizations instead, so remove inline for
> at803x_disable_rx_delay() and at803x_disable_tx_delay()

I would word it slightly differently:

Some helpers were declared with the "inline" function specifier.
It is preferable to let the compiler pick the right optimizations,
so drop the specifier.

[ This is just a random suggestion, feel free to ignore ]


> Reviewed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  drivers/net/phy/at803x.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
> index 8ff12938ab47..c6e7d800fd7a 100644
> --- a/drivers/net/phy/at803x.c
> +++ b/drivers/net/phy/at803x.c
> @@ -110,13 +110,13 @@ static int at803x_debug_reg_mask(struct phy_device *phydev, u16 reg,
>  	return phy_write(phydev, AT803X_DEBUG_DATA, val);
>  }
>  
> -static inline int at803x_disable_rx_delay(struct phy_device *phydev)
> +static int at803x_disable_rx_delay(struct phy_device *phydev)
>  {
>  	return at803x_debug_reg_mask(phydev, AT803X_DEBUG_REG_0,
>  				     AT803X_DEBUG_RX_CLK_DLY_EN, 0);
>  }
>  
> -static inline int at803x_disable_tx_delay(struct phy_device *phydev)
> +static int at803x_disable_tx_delay(struct phy_device *phydev)
>  {
>  	return at803x_debug_reg_mask(phydev, AT803X_DEBUG_REG_5,
>  				     AT803X_DEBUG_TX_CLK_DLY_EN, 0);

Reviewed-by: Marc Gonzalez <marc.w.gonzalez@free.fr>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
