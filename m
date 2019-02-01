Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF96AC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:55:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9148220815
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gxfOMJON"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9148220815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sigxcpu.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8lWd9NJSarv3BmDPpNBp35Qz8BCFmGMB5Scxm8wSq6g=; b=gxfOMJONVuZcpT
	0uJt/X20KOA4lFPr69hrT942No4QxiwunjHFhm+wVNbqXS3inR6/L6KYKgZZRWd6H0EVb4pqOU+QB
	3V+YW4xHEy/CoIjTcXnAVp01cPGB2KBH5DXupZ/Q1gtz1Ut3LQRAGG+RgIp7ZA8okf8TcyUK6ZMUp
	xInMIiTric6sN1v1Gk9h93DQlEPcsGGMpY9N6stwjOz7tJooFGGz2QqeUwF0rj/BXgHCRx/rY2ZfV
	ygtG4FaIJWgsgpAN/1OTa7sJ5bpGv8Eg1ysqH2Nk58lTgcLvCargqCniXrhZ2KUyDkhqQI6SKn2GC
	HYWj+wjyWCzfOLv+tArQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpUbH-0004ed-PF; Fri, 01 Feb 2019 08:55:03 +0000
Received: from honk.sigxcpu.org ([24.134.29.49])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpUbD-0004dQ-7Z
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 08:55:00 +0000
Received: from localhost (localhost [127.0.0.1])
 by honk.sigxcpu.org (Postfix) with ESMTP id 6516BFB07;
 Fri,  1 Feb 2019 09:54:57 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
 by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rwGqnG5D4YpC; Fri,  1 Feb 2019 09:54:56 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
 id E4BE4461BC; Fri,  1 Feb 2019 09:54:55 +0100 (CET)
Date: Fri, 1 Feb 2019 09:54:55 +0100
From: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 2/2] phy: Add driver for mixel dphy
Message-ID: <20190201085455.GA32742@bogon.m.sigxcpu.org>
References: <cover.1548410989.git.agx@sigxcpu.org>
 <bbefc77a437bd21bfe1c27b15f65b57e7714b18a.1548410989.git.agx@sigxcpu.org>
 <20190125165355.GA3522@ravnborg.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190125165355.GA3522@ravnborg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_005459_423758_64738624 
X-CRM114-Status: GOOD (  15.51  )
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
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
 Robert Chiras <robert.chiras@nxp.com>, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Sam,
On Fri, Jan 25, 2019 at 05:53:55PM +0100, Sam Ravnborg wrote:
[..snip..]
> > +struct mixel_dphy_cfg {
> > +	u32 cm;
> > +	u32 cn;
> > +	u32 co;
> > +	unsigned long hs_clk_rate;
> > +	u8 mc_prg_hs_prepare;
> > +	u8 m_prg_hs_prepare;
> > +	u8 mc_prg_hs_zero;
> > +	u8 m_prg_hs_zero;
> > +	u8 mc_prg_hs_trail;
> > +	u8 m_prg_hs_trail;
> > +};
> 
> For the naive reader it would be helpful to spell out the names in a comment.
> As I assume the names comes from the data sheet the short names are OK - but
> let others know the purpose.

These are actual register names so I added comment just saying that.

[..snip..]
> > +static int mixel_dphy_config_from_opts(struct phy *phy,
> > +	       struct phy_configure_opts_mipi_dphy *dphy_opts,
> > +	       struct mixel_dphy_cfg *cfg)
> > +{
> Align extra paratmers below the first parameter using tabs and add necessary
> spaces.

Due to the long phy_configure_opts_mipi_dpy this whole hit the 80 char
limit so I left it like that to make checkpatch happy.

> 
> > +	struct mixel_dphy_priv *priv = dev_get_drvdata(phy->dev.parent);
> > +	unsigned long ref_clk = clk_get_rate(priv->phy_ref_clk);
> > +	int i;
> > +	unsigned long numerator, denominator, frequency;
> > +	unsigned step;
> > +
> > +static int mixel_dphy_ref_power_on(struct phy *phy)
> > +{
> > +	struct mixel_dphy_priv *priv = phy_get_drvdata(phy);
> > +	u32 lock, timeout;
> > +	int ret = 0;
> > +
> > +	mutex_lock(&priv->lock);
> > +	clk_prepare_enable(priv->phy_ref_clk);
> > +
> > +	phy_write(phy, PWR_ON, DPHY_PD_DPHY);
> > +	phy_write(phy, PWR_ON, DPHY_PD_PLL);
> > +
> > +	timeout = 100;
> > +	while (!(lock = phy_read(phy, DPHY_LOCK))) {
> > +		udelay(10);
> > +		if (--timeout == 0) {
> > +			dev_err(&phy->dev, "Could not get DPHY lock!\n");
> > +			mutex_unlock(&priv->lock);
> > +			return -EINVAL;
> > +		}
> USe goto to have a single exit path where you do mutex_unlock()

Using regmap I could drop the lock entirely.

[..snip..]
> > +static const struct mixel_dphy_ops mixel_dphy_ref_ops = {
> > +	.power_on = mixel_dphy_ref_power_on,
> > +	.power_off = mixel_dphy_ref_power_off,
> > +};
> > +
> > +static const struct phy_ops mixel_dphy_ops = {
> > +	.power_on = mixel_dphy_power_on,
> > +	.power_off = mixel_dphy_power_off,
> > +	.configure = mixel_dphy_configure,
> > +	.validate = mixel_dphy_validate,
> > +	.owner = THIS_MODULE,
> > +};
> This is confusing.
> We have struct mixel_dphy_ops => mixel_dphy_ref_ops
> And then struct phy_ops => mixel_dphy_ops
> 
> So reading this there are to uses of mixel_dphy_ops,
> one is a struct, and another is an instance of another type.
> Try to find a niming scheme that is less confusing.

Yeah, that's true. I found in another driver other imx8 variants have
different register offsets so I went for register offsets in devdata
rather than function pointer table which make this ambiguity go away too.
I hope I have tackled all your other comments.

Thanks!
 -- Guido

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
