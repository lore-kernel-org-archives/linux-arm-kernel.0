Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DCAC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 23:48:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 656FA2173B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 23:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qqUsRjJ+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Wa403v3v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 656FA2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BzAvfOMMYcXPfd1n2JumlyhkXIz453lAJiQccahSaf8=; b=qqUsRjJ+awBeKk
	iw0eYOqDIZHRhf9mhY79cJXB+QZsDaFG11aohwo++s7fv7PBbyS8hmu3uzGYdhNsNEERYpkgf7Oui
	y9L0PanEKtDCwqcBwB5EjR2Vrq6zsZjsNnq0YESbAMUZtIjlxtqQg2ikAPf1mKHJFMoFBTfwsE4IZ
	0s8O+JVStqJId6pLyNURPJsylFBTFv4tD4H+ddl8687nC8buPfpDmo0QGT913cz0LoYpqMcMK7+Cz
	Mt1FuPg38h/hDzJ3Q2VukPHIOIxQzrk7UcWpyWEXfAayxte6iBrdPW3zx9IbCrJzgjdmsSnrNTiS7
	nIfzEKLfH9Br6LI0sxaA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grtPO-00009r-2F; Thu, 07 Feb 2019 23:48:42 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grtPJ-00008K-K2
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 23:48:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gjPeUEpl3IC8+f3m0OUBhJxI8Sy93l2m2nEMVlydeXk=; b=Wa403v3v2SN2evhNn6D3hojc4
 UXfBsGSVFcvxNAGIjTscdV7OPeelgKhq/CZjiTMeHT0zHAJ45LawgdQHUQyROjym3WXRP90JCnKfA
 4xFnzyHsvrk2hSiAte3zW5o/ljoM/ptffZ9V1mwI12bUs2+k2nCVKujnR0w3gcHUOLfHI=;
Received: from shell.armlinux.org.uk
 ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:36618)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1grtPA-0004hN-CD; Thu, 07 Feb 2019 23:48:28 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1grtP6-0006Zb-RH; Thu, 07 Feb 2019 23:48:24 +0000
Date: Thu, 7 Feb 2019 23:48:24 +0000
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v2 07/10] net: phy: marvell10g: Add support for
 2.5GBASET
Message-ID: <20190207234824.dhynfaglfxllxhei@shell.armlinux.org.uk>
References: <20190207094939.27369-1-maxime.chevallier@bootlin.com>
 <20190207094939.27369-8-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190207094939.27369-8-maxime.chevallier@bootlin.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_154837_767020_9B60699A 
X-CRM114-Status: GOOD (  25.67  )
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
 gregory.clement@bootlin.com, linux-kernel@vger.kernel.org, nadavh@marvell.com,
 thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com, stefanc@marvell.com,
 mw@semihalf.com, davem@davemloft.net, linux-arm-kernel@lists.infradead.org,
 Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 07, 2019 at 10:49:36AM +0100, Maxime Chevallier wrote:
> The Marvell Alaska family of PHYs supports 2.5GBaseT and 5GBaseT modes,
> as defined in the 802.3bz specification.
> 
> When the link partner requests a 2.5GBASET link, the PHY will
> reconfigure it's MII interface to 2500BASEX.
> 
> At 5G, the PHY will reconfigure it's interface to 5GBASE-R, but this
> mode isn't supported by any MAC for now.
> 
> This was tested with :
>  - The 88X3310, which is on the MacchiatoBin

Hi Maxime,

Looking deeper at this, I think we actually need an additional patch at
the beginning of your series.

The default AN advertisement in 7.32 is 0x1181 - which includes the
2.5G and 5G modes.  We need to clear these bits, so that when the 10G
mode disabled via ethtool, we do not switch to 2.5G or 5G speed (both
of which are not currently reported as supported.)  Such a patch needs
backporting to stable kernels.

>  - The 88E2010, an Alaska PHY that has no fiber interfaces, and is
>    limited to 5G maximum speed.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
> V1 -> V2: Use a #define for the 88X3310 PHY ID, since it's reused in
> 	  various places in the code. Rebased on Heiner Kallweit's patch
> 	  introducing the phy_modify_mmd accessor.
> 
>  drivers/net/phy/marvell10g.c | 30 ++++++++++++++++++++++--------
>  include/linux/marvell_phy.h  |  1 +
>  2 files changed, 23 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
> index 07df87b81369..581b4b6e31e9 100644
> --- a/drivers/net/phy/marvell10g.c
> +++ b/drivers/net/phy/marvell10g.c
> @@ -238,6 +238,7 @@ static int mv3310_config_init(struct phy_device *phydev)
>  
>  	/* Check that the PHY interface type is compatible */
>  	if (phydev->interface != PHY_INTERFACE_MODE_SGMII &&
> +	    phydev->interface != PHY_INTERFACE_MODE_2500BASEX &&
>  	    phydev->interface != PHY_INTERFACE_MODE_XAUI &&
>  	    phydev->interface != PHY_INTERFACE_MODE_RXAUI &&
>  	    phydev->interface != PHY_INTERFACE_MODE_10GKR)
> @@ -307,8 +308,18 @@ static int mv3310_config_aneg(struct phy_device *phydev)
>  	else
>  		reg = 0;
>  
> +	if (linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
> +			      phydev->advertising))
> +		reg |= MDIO_AN_10GBT_CTRL_ADV2_5G;
> +	if (linkmode_test_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
> +			      phydev->advertising))
> +		reg |= MDIO_AN_10GBT_CTRL_ADV5G;
> +
>  	ret = phy_modify_mmd(phydev, MDIO_MMD_AN, MDIO_AN_10GBT_CTRL,
> -			     MDIO_AN_10GBT_CTRL_ADV10G, reg);
> +			     MDIO_AN_10GBT_CTRL_ADV10G |
> +			     MDIO_AN_10GBT_CTRL_ADV5G |
> +			     MDIO_AN_10GBT_CTRL_ADV2_5G, reg);
> +
>  	if (ret < 0)
>  		return ret;
>  	if (ret > 0)
> @@ -337,17 +348,20 @@ static int mv3310_aneg_done(struct phy_device *phydev)
>  static void mv3310_update_interface(struct phy_device *phydev)
>  {
>  	if ((phydev->interface == PHY_INTERFACE_MODE_SGMII ||
> +	     phydev->interface == PHY_INTERFACE_MODE_2500BASEX ||
>  	     phydev->interface == PHY_INTERFACE_MODE_10GKR) && phydev->link) {
>  		/* The PHY automatically switches its serdes interface (and
> -		 * active PHYXS instance) between Cisco SGMII and 10GBase-KR
> -		 * modes according to the speed.  Florian suggests setting
> -		 * phydev->interface to communicate this to the MAC. Only do
> -		 * this if we are already in either SGMII or 10GBase-KR mode.
> +		 * active PHYXS instance) between Cisco SGMII, 10GBase-KR and
> +		 * 2500BaseX modes according to the speed.  Florian suggests
> +		 * setting phydev->interface to communicate this to the MAC.
> +		 * Only do this if we are already in one of the above modes.
>  		 */
>  		if (phydev->speed == SPEED_10000)
>  			phydev->interface = PHY_INTERFACE_MODE_10GKR;
> +		else if (phydev->speed == SPEED_2500)
> +			phydev->interface = PHY_INTERFACE_MODE_2500BASEX;
>  		else if (phydev->speed >= SPEED_10 &&
> -			 phydev->speed < SPEED_10000)
> +			 phydev->speed < SPEED_2500)
>  			phydev->interface = PHY_INTERFACE_MODE_SGMII;
>  	}
>  }
> @@ -450,7 +464,7 @@ static int mv3310_read_status(struct phy_device *phydev)
>  
>  static struct phy_driver mv3310_drivers[] = {
>  	{
> -		.phy_id		= 0x002b09aa,
> +		.phy_id		= MARVELL_PHY_ID_88X3310,
>  		.phy_id_mask	= MARVELL_PHY_ID_MASK,
>  		.name		= "mv88x3310",
>  		.features	= PHY_10GBIT_FEATURES,
> @@ -468,7 +482,7 @@ static struct phy_driver mv3310_drivers[] = {
>  module_phy_driver(mv3310_drivers);
>  
>  static struct mdio_device_id __maybe_unused mv3310_tbl[] = {
> -	{ 0x002b09aa, MARVELL_PHY_ID_MASK },
> +	{ MARVELL_PHY_ID_88X3310, MARVELL_PHY_ID_MASK },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(mdio, mv3310_tbl);
> diff --git a/include/linux/marvell_phy.h b/include/linux/marvell_phy.h
> index 1eb6f244588d..5851d68d828a 100644
> --- a/include/linux/marvell_phy.h
> +++ b/include/linux/marvell_phy.h
> @@ -20,6 +20,7 @@
>  #define MARVELL_PHY_ID_88E1540		0x01410eb0
>  #define MARVELL_PHY_ID_88E1545		0x01410ea0
>  #define MARVELL_PHY_ID_88E3016		0x01410e60
> +#define MARVELL_PHY_ID_88X3310		0x002b09aa
>  
>  /* The MV88e6390 Ethernet switch contains embedded PHYs. These PHYs do
>   * not have a model ID. So the switch driver traps reads to the ID2
> -- 
> 2.19.2
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
