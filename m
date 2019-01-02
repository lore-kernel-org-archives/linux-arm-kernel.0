Return-Path: <SRS0=RmN+=PK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217B1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 13:41:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE6AB218E2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 13:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PyBvdvAg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QcSVU526"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE6AB218E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wXRddJBKsabzboruSoAciepBAYr9CrPSp+8AzpO/dzY=; b=PyBvdvAgenYK64
	EIkh68gg5XaRQ4aU5GPvLxua3RCDYV1DDonnuhpapSPgmpdpdJbqV3LeJNuRN+HON6kwysWLSesgt
	1cXZKdHDsPR0RjVHTnfX8L/l22r3D+6Ji2VZFzp3o0XyaqbbFqYwBCPfazQxL/3mMh9vTjBQ04epf
	eB6BAVObjqnvJ2iL98+7C/+UN+GdSS97VKP+jhl8ihMX8T+1HNiaxawjqHTz7V3JLLBLTcwcMey2G
	OJgWPtc2zsy4TOaY2yR2s0hp3Hd1iwr1xIGujp7Ywrp1KR3Wa45XSW/aRlNTD5Y+lRXcuFNtbw4+P
	kuOd52Yf9nQo/iuxe1lw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gegld-0001Tf-FU; Wed, 02 Jan 2019 13:41:05 +0000
Received: from vps0.lunn.ch ([185.16.172.187])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gegla-0001TG-RH
 for linux-arm-kernel@lists.infradead.org; Wed, 02 Jan 2019 13:41:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; 
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
 bh=m0iTPW671tTXajJFRjb1LLuTxgaUteVusXQJqnhlxEI=; 
 b=QcSVU526/DSV+yJY+jXxXSbEgUPDvntx47oQx2P1qBnAQHh7MmFM2YYMWKPrau94f11Y5KxUxrLrOWXtyKwVuHF2zbUpPxMcMFrud4De0BIsGObnFOSvOMHihXQlZwYqMZK7msMILOGST+4iIODIBn1huEDdogKiTtvp1nKOVTA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
 (envelope-from <andrew@lunn.ch>)
 id 1geglS-0008EN-Br; Wed, 02 Jan 2019 14:40:54 +0100
Date: Wed, 2 Jan 2019 14:40:54 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 6/7] net: phy: at803x: Add support to disable tx/rx delays
Message-ID: <20190102134054.GF22737@lunn.ch>
References: <20190102091729.18582-1-vkoul@kernel.org>
 <20190102091729.18582-7-vkoul@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190102091729.18582-7-vkoul@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190102_054103_034761_CCF07010 
X-CRM114-Status: GOOD (  18.82  )
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
Cc: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Niklas Cassel <niklas.cassel@linaro.org>,
 "David S . Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 02, 2019 at 02:47:28PM +0530, Vinod Koul wrote:
> Some controllers require the tx and rx delays to be disabled. So check
> the property and if present do not enable the delay and disable the
> delay explicitly.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  drivers/net/phy/at803x.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
> index 63e3d3d774d1..9bfc0d381159 100644
> --- a/drivers/net/phy/at803x.c
> +++ b/drivers/net/phy/at803x.c
> @@ -122,6 +122,17 @@ static inline int at803x_enable_tx_delay(struct phy_device *phydev)
>  					AT803X_DEBUG_TX_CLK_DLY_EN);
>  }
>  
> +static inline int at803x_disable_rx_delay(struct phy_device *phydev)
> +{
> +	return at803x_debug_reg_mask(phydev, AT803X_DEBUG_REG_0,
> +					AT803X_DEBUG_RX_CLK_DLY_EN, 0);
> +}
> +
> +static inline int at803x_disable_tx_delay(struct phy_device *phydev)
> +{
> +	return at803x_debug_reg_mask(phydev, AT803X_DEBUG_REG_5,
> +					AT803X_DEBUG_TX_CLK_DLY_EN, 0);
> +}
>  /* save relevant PHY registers to private copy */
>  static void at803x_context_save(struct phy_device *phydev,
>  				struct at803x_context *context)
> @@ -250,12 +261,18 @@ static int at803x_probe(struct phy_device *phydev)
>  static int at803x_config_init(struct phy_device *phydev)
>  {
>  	bool rx_delay = false, tx_delay = false;
> +	bool rx_disable_prop, tx_disable_prop;
>  	int ret;
>  
>  	ret = genphy_config_init(phydev);
>  	if (ret < 0)
>  		return ret;
>  
> +	rx_disable_prop = device_property_read_bool(&phydev->mdio.dev,
> +						    "rx-delay-disable");
> +	tx_disable_prop = device_property_read_bool(&phydev->mdio.dev,
> +						    "rx-delay-disable");
> +

Hi Vinod

I understand why you are doing this, to not break backwards
compatibility, but it is ugly. Lets see if we can avoid it. Thinking
allowed here. Here are the use cases i can think of:

1) The DT does not specify any phy-mode. The board works because delays
are enable by the bootloader

2) The DT correctly specifies RXID/ID/TXID and the driver does the
right thing.

3) The DT incorrectly specifies no delay, the bootloader however sets
delays, and the driver does not disable the delay.

4) The DT correctly specifies no delay, but the driver does not
disable delays, and it does not work.

You are interested in 4) if i understand this patch correct.

1) should not be a problem. If phy-mode is not one of the RGMII
values, don't touch the delays.

2) works

3) is the tricky one. But i would also say that is a bug in the DT.
The question is, do we want to keep bug compatible?

I say don't add these new properties. If we have a phy-mode which
explicitly specifies no delay, clear the delay. And we then fixup
anything which breaks because of DT bugs.

	 Andrew

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
