Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8AC4C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 20:43:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 888A620811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 20:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dICmM+Fu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 888A620811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fZGz9NqpzmJtwJWmlzvsAo1ARkdgDsbTgXUJIsTy5s0=; b=dICmM+FuQb87Ah
	ebehXwWZrgMiaCMHL5OqcSKlc3VJbrOCaQe3L0YWzIDW2P0xcgq/Py7m+7laxf/9PEHKYW3CkaBqg
	1nnIMdbmcScIg34CmiFl0uUrt8H6cO5sgrcgSUqAsezH9qfX2UpM2Nh0lW3PyYqi8bB2lyLtO+ZcQ
	ME8DNpAan/13jOEe/I5vRdcYdm+yv/h88ipvja306UkgagVWL2E/gb6mFBAcI6ptrxqIetWdNut0D
	5RPB4VMAuCC04lShWQqAE9qiKQ3jm6TJFch43jTv5p0AiEfmqpZP20+bR0nzOawmrmGYa0QcublJD
	xbUjj2goSa2I9cKhI0Ig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXXpQ-0001uf-Mn; Thu, 13 Dec 2018 20:43:28 +0000
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]
 helo=hillosipuli.retiisi.org.uk)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXXpM-0001u3-KS
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 20:43:26 +0000
Received: from valkosipuli.localdomain (valkosipuli.retiisi.org.uk
 [IPv6:2001:1bc8:1a6:d3d5::80:2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by hillosipuli.retiisi.org.uk (Postfix) with ESMTPS id 866D7634C7D;
 Thu, 13 Dec 2018 22:42:34 +0200 (EET)
Received: from sailus by valkosipuli.localdomain with local (Exim 4.89)
 (envelope-from <sakari.ailus@retiisi.org.uk>)
 id 1gXXoY-0000kG-IC; Thu, 13 Dec 2018 22:42:34 +0200
Date: Thu, 13 Dec 2018 22:42:34 +0200
From: sakari.ailus@iki.fi
To: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v3 02/10] phy: Add configuration interface
Message-ID: <20181213204234.63hr74etgxvhnmhy@valkosipuli.retiisi.org.uk>
References: <cover.ad7c4feb3905658f10b022df4756a5ade280011f.1544190837.git-series.maxime.ripard@bootlin.com>
 <8a8d7bf8a3d2bad492dd63e39fe3d490bdae5c80.1544190837.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8a8d7bf8a3d2bad492dd63e39fe3d490bdae5c80.1544190837.git-series.maxime.ripard@bootlin.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_124325_027743_0BD8A95F 
X-CRM114-Status: GOOD (  32.83  )
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
Cc: Archit Taneja <architt@codeaurora.org>,
 Krzysztof Witos <kwitos@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>,
 Andrzej Hajda <a.hajda@samsung.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Kishon Vijay Abraham I <kishon@ti.com>,
 Boris Brezillon <boris.brezillon@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Maxime,

On Fri, Dec 07, 2018 at 02:55:29PM +0100, Maxime Ripard wrote:
> The phy framework is only allowing to configure the power state of the PHY
> using the init and power_on hooks, and their power_off and exit
> counterparts.
> 
> While it works for most, simple, PHYs supported so far, some more advanced
> PHYs need some configuration depending on runtime parameters. These PHYs
> have been supported by a number of means already, often by using ad-hoc
> drivers in their consumer drivers.
> 
> That doesn't work too well however, when a consumer device needs to deal
> with multiple PHYs, or when multiple consumers need to deal with the same
> PHY (a DSI driver and a CSI driver for example).
> 
> So we'll add a new interface, through two funtions, phy_validate and
> phy_configure. The first one will allow to check that a current
> configuration, for a given mode, is applicable. It will also allow the PHY
> driver to tune the settings given as parameters as it sees fit.
> 
> phy_configure will actually apply that configuration in the phy itself.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  drivers/phy/phy-core.c  | 64 ++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/phy/phy.h | 58 ++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 122 insertions(+)
> 
> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
> index df3d4ba516ab..19b05e824ee4 100644
> --- a/drivers/phy/phy-core.c
> +++ b/drivers/phy/phy-core.c
> @@ -408,6 +408,70 @@ int phy_calibrate(struct phy *phy)
>  EXPORT_SYMBOL_GPL(phy_calibrate);
>  
>  /**
> + * phy_configure() - Changes the phy parameters
> + * @phy: the phy returned by phy_get()
> + * @opts: New configuration to apply
> + *
> + * Used to change the PHY parameters. phy_init() must have been called
> + * on the phy. The configuration will be applied on the current phy
> + * mode, that can be changed using phy_set_mode().
> + *
> + * Returns: 0 if successful, an negative error code otherwise
> + */
> +int phy_configure(struct phy *phy, union phy_configure_opts *opts)
> +{
> +	int ret;
> +
> +	if (!phy)
> +		return -EINVAL;
> +
> +	if (!phy->ops->configure)
> +		return -EOPNOTSUPP;
> +
> +	mutex_lock(&phy->mutex);
> +	ret = phy->ops->configure(phy, opts);
> +	mutex_unlock(&phy->mutex);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(phy_configure);
> +
> +/**
> + * phy_validate() - Checks the phy parameters
> + * @phy: the phy returned by phy_get()
> + * @mode: phy_mode the configuration is applicable to.
> + * @submode: PHY submode the configuration is applicable to.
> + * @opts: Configuration to check
> + *
> + * Used to check that the current set of parameters can be handled by
> + * the phy. Implementations are free to tune the parameters passed as
> + * arguments if needed by some implementation detail or
> + * constraints. It will not change any actual configuration of the
> + * PHY, so calling it as many times as deemed fit will have no side
> + * effect.
> + *
> + * Returns: 0 if successful, an negative error code otherwise
> + */
> +int phy_validate(struct phy *phy, enum phy_mode mode, int submode,
> +		 union phy_configure_opts *opts)
> +{
> +	int ret;
> +
> +	if (!phy)
> +		return -EINVAL;
> +
> +	if (!phy->ops->validate)
> +		return -EOPNOTSUPP;
> +
> +	mutex_lock(&phy->mutex);
> +	ret = phy->ops->validate(phy, mode, submode, opts);
> +	mutex_unlock(&phy->mutex);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(phy_validate);
> +
> +/**
>   * _of_phy_get() - lookup and obtain a reference to a phy by phandle
>   * @np: device_node for which to get the phy
>   * @index: the index of the phy
> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> index 453f21834685..04476c026b5a 100644
> --- a/include/linux/phy/phy.h
> +++ b/include/linux/phy/phy.h
> @@ -43,6 +43,12 @@ enum phy_mode {
>  };
>  
>  /**
> + * union phy_configure_opts - Opaque generic phy configuration
> + */
> +union phy_configure_opts {
> +};
> +
> +/**
>   * struct phy_ops - set of function pointers for performing phy operations
>   * @init: operation to be performed for initializing phy
>   * @exit: operation to be performed while exiting
> @@ -59,6 +65,37 @@ struct phy_ops {
>  	int	(*power_on)(struct phy *phy);
>  	int	(*power_off)(struct phy *phy);
>  	int	(*set_mode)(struct phy *phy, enum phy_mode mode, int submode);
> +
> +	/**
> +	 * @configure:
> +	 *
> +	 * Optional.
> +	 *
> +	 * Used to change the PHY parameters. phy_init() must have
> +	 * been called on the phy.
> +	 *
> +	 * Returns: 0 if successful, an negative error code otherwise
> +	 */
> +	int	(*configure)(struct phy *phy, union phy_configure_opts *opts);
> +
> +	/**
> +	 * @validate:
> +	 *
> +	 * Optional.
> +	 *
> +	 * Used to check that the current set of parameters can be
> +	 * handled by the phy. Implementations are free to tune the
> +	 * parameters passed as arguments if needed by some
> +	 * implementation detail or constraints. It must not change
> +	 * any actual configuration of the PHY, so calling it as many
> +	 * times as deemed fit by the consumer must have no side
> +	 * effect.
> +	 *
> +	 * Returns: 0 if the configuration can be applied, an negative
> +	 * error code otherwise

I think it'd be good to document which error codes can be returned and what
do they mean. I'm no expert in the PHY framework, but it seems the caller
would need to be able to cope with -EOPNOTSUPP for instance, which may not
necessarily signal an error at all.

Would it be enough to document the PHY framework interface functions rather
than the ops at this level? There seems to be a non-zero chances of the two
descriptions of diverging. Just an idea.

> +	 */
> +	int	(*validate)(struct phy *phy, enum phy_mode mode, int submode,
> +			    union phy_configure_opts *opts);
>  	int	(*reset)(struct phy *phy);
>  	int	(*calibrate)(struct phy *phy);
>  	struct module *owner;
> @@ -165,6 +202,9 @@ int phy_power_off(struct phy *phy);
>  int phy_set_mode_ext(struct phy *phy, enum phy_mode mode, int submode);
>  #define phy_set_mode(phy, mode) \
>  	phy_set_mode_ext(phy, mode, 0)
> +int phy_configure(struct phy *phy, union phy_configure_opts *opts);
> +int phy_validate(struct phy *phy, enum phy_mode mode, int submode,
> +		 union phy_configure_opts *opts);
>  
>  static inline enum phy_mode phy_get_mode(struct phy *phy)
>  {
> @@ -309,6 +349,24 @@ static inline int phy_calibrate(struct phy *phy)
>  	return -ENOSYS;
>  }
>  
> +static inline int phy_configure(struct phy *phy,
> +				union phy_configure_opts *opts)
> +{
> +	if (!phy)
> +		return 0;
> +
> +	return -ENOSYS;
> +}
> +
> +static inline int phy_validate(struct phy *phy, enum phy_mode mode, int submode,
> +			       union phy_configure_opts *opts)
> +{
> +	if (!phy)
> +		return 0;
> +
> +	return -ENOSYS;
> +}
> +
>  static inline int phy_get_bus_width(struct phy *phy)
>  {
>  	return -ENOSYS;

-- 
Kind regar,

Sakari Ailus

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
