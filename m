Return-Path: <SRS0=RmN+=PK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15C6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 14:38:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66603218EA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 14:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fMz/b38A";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngfbFqhu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66603218EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pK9iFFAkj4Ivnu2Tch9lCdNsEhli9nXJsbLDJRt0bkU=; b=fMz/b38A1jSAOb
	zn92zim4ve5S8+eL70PeJYXKfP5BLTB82JvwdWid3xQtfuS+GoYnLF1F4NlrYxUFdCh46Ocnjy/DO
	grkOHkCBK9FW0a5qlJA/+dMtBHAtzT5ZyTMieNj5QWVqwX7A7GGcLaxfCjmzh9YaWWZt4Nb3XB50r
	8QmZ+HvqBuzXVR62QupnYzlo+kyThsrf0qQZqZdYI5aD32XUB2oHJ+KQg0EfI74gehy0rpKJvvtnp
	XYgnCzeI89M443ArPohTAeDBWChCmU8SHFZqnXrgXM0qNcMsHaGwdacIV0+SH7fr4vrFHiqYlepNG
	fTHAIF8qrWvzENAOIUIg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gehep-0000eN-A0; Wed, 02 Jan 2019 14:38:07 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gehel-0000e0-SK
 for linux-arm-kernel@lists.infradead.org; Wed, 02 Jan 2019 14:38:05 +0000
Received: from localhost (unknown [171.76.109.220])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 50973218DE;
 Wed,  2 Jan 2019 14:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546439883;
 bh=MwNTaKWyh3gDpwehgt8vHQgPe4EDAyyfc9whMZQYr8o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ngfbFqhuPS7VU75whF8dap6xgaiVGamHH5oTAUl0HglPYmsJQkg29QEgbvyvOsr9U
 7NzilIjD7otGTnW7d1pBfePmlkFMQOozgh0tB4qDua/hjfsUDGzJpMmQ2cvLrZfAYB
 yzLiSJ505ozgGHHn7oCdO4breUJ9kwn7aceJuM00=
Date: Wed, 2 Jan 2019 20:06:24 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 6/7] net: phy: at803x: Add support to disable tx/rx delays
Message-ID: <20190102143624.GM7581@vkoul-mobl>
References: <20190102091729.18582-1-vkoul@kernel.org>
 <20190102091729.18582-7-vkoul@kernel.org>
 <20190102134054.GF22737@lunn.ch>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190102134054.GF22737@lunn.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190102_063803_943831_376E0B6D 
X-CRM114-Status: GOOD (  23.50  )
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


Hi Andrew,

Thanks for the comments,

On 02-01-19, 14:40, Andrew Lunn wrote:
> On Wed, Jan 02, 2019 at 02:47:28PM +0530, Vinod Koul wrote:
> > Some controllers require the tx and rx delays to be disabled. So check
> > the property and if present do not enable the delay and disable the
> > delay explicitly.
> > 
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >  drivers/net/phy/at803x.c | 36 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> > 
> > diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
> > index 63e3d3d774d1..9bfc0d381159 100644
> > --- a/drivers/net/phy/at803x.c
> > +++ b/drivers/net/phy/at803x.c
> > @@ -122,6 +122,17 @@ static inline int at803x_enable_tx_delay(struct phy_device *phydev)
> >  					AT803X_DEBUG_TX_CLK_DLY_EN);
> >  }
> >  
> > +static inline int at803x_disable_rx_delay(struct phy_device *phydev)
> > +{
> > +	return at803x_debug_reg_mask(phydev, AT803X_DEBUG_REG_0,
> > +					AT803X_DEBUG_RX_CLK_DLY_EN, 0);
> > +}
> > +
> > +static inline int at803x_disable_tx_delay(struct phy_device *phydev)
> > +{
> > +	return at803x_debug_reg_mask(phydev, AT803X_DEBUG_REG_5,
> > +					AT803X_DEBUG_TX_CLK_DLY_EN, 0);
> > +}
> >  /* save relevant PHY registers to private copy */
> >  static void at803x_context_save(struct phy_device *phydev,
> >  				struct at803x_context *context)
> > @@ -250,12 +261,18 @@ static int at803x_probe(struct phy_device *phydev)
> >  static int at803x_config_init(struct phy_device *phydev)
> >  {
> >  	bool rx_delay = false, tx_delay = false;
> > +	bool rx_disable_prop, tx_disable_prop;
> >  	int ret;
> >  
> >  	ret = genphy_config_init(phydev);
> >  	if (ret < 0)
> >  		return ret;
> >  
> > +	rx_disable_prop = device_property_read_bool(&phydev->mdio.dev,
> > +						    "rx-delay-disable");
> > +	tx_disable_prop = device_property_read_bool(&phydev->mdio.dev,
> > +						    "rx-delay-disable");
> > +
> 
> Hi Vinod
> 
> I understand why you are doing this, to not break backwards
> compatibility, but it is ugly. Lets see if we can avoid it. Thinking

Agreed this is ugly and the reason to do this is not to break existing
users

> allowed here. Here are the use cases i can think of:
> 
> 1) The DT does not specify any phy-mode. The board works because delays
> are enable by the bootloader
> 
> 2) The DT correctly specifies RXID/ID/TXID and the driver does the
> right thing.
> 
> 3) The DT incorrectly specifies no delay, the bootloader however sets
> delays, and the driver does not disable the delay.
> 
> 4) The DT correctly specifies no delay, but the driver does not
> disable delays, and it does not work.
> 
> You are interested in 4) if i understand this patch correct.

that is correct reading of the patch :-)

> 1) should not be a problem. If phy-mode is not one of the RGMII
> values, don't touch the delays.
> 
> 2) works
> 
> 3) is the tricky one. But i would also say that is a bug in the DT.
> The question is, do we want to keep bug compatible?
> 
> I say don't add these new properties. If we have a phy-mode which
> explicitly specifies no delay, clear the delay. And we then fixup
> anything which breaks because of DT bugs.

I do not mind fixing this and doing disable delays for rgmii mode, if we
agree that it would break devices and those should be fixed and not
treated as a regression due to this fix. As long as Dave agree to this,
I can spin a v2 and post :)

~Vinod

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
