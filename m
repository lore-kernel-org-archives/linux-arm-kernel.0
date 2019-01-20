Return-Path: <SRS0=lfWu=P4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A392C26641
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 18:51:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A531214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 18:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Vpph3Q6Y";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IJEbEVgx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A531214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4pGkIZmW3QEEqSsW+xIMv9mmwku6S4CjNIfjZTCWI7U=; b=Vpph3Q6Yp/jPAb
	/DkofSOW2ANrtTPUsabBjjzhosop/org7ISNvfMPJC17cS46sGRiCF1ySfj+PBN/obGxMGhV0jx0D
	WU5DMR/ZokmUq2j95ZmTHCcCaSo+R8yF6qPrwkntEFLDRgsUBYLjEvHKdWuHS7A3atfY5DSQHp2gv
	7IsbcdOS0MIoyybBScbYb5afWIjgxVQVBGzJe6bY/DTRqwNt0xMrJ929Kc72wlTcRN/Lape6mgWws
	qrSEbnhQfA2D8MtgNQvPg7x9ewu2lAH5Szc/qijuS0JFThAYAOMjxM9H8QCyRk3Dp84AaB0+lt1vL
	AFpjo6jgBdbSSiWDzSHg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glIBl-0008CQ-EB; Sun, 20 Jan 2019 18:51:21 +0000
Received: from vps0.lunn.ch ([185.16.172.187])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glIBf-0008Be-KH
 for linux-arm-kernel@lists.infradead.org; Sun, 20 Jan 2019 18:51:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; 
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
 bh=F/NoWxBnuEylA+vwK0t2ToezftjRIUcqu5ui+VUsKlg=; 
 b=IJEbEVgxitgjMOELet/b0CjherLfgWaGnZh3KLPXRBmVCWkatjU67OW5OuUM3ZvL00gFcNqUFO2Et+ftBG8xsC0Fi7yToDE3BXhTCRhz4ylVOnN9cpEpuaxggF8NJgQxjofl/9Et6d7tnPtYYHv81xfZsOGEo8Chuqqq99dwkmc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
 (envelope-from <andrew@lunn.ch>)
 id 1glIBX-0005CI-I6; Sun, 20 Jan 2019 19:51:07 +0100
Date: Sun, 20 Jan 2019 19:51:07 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next 1/7] net: phy: Extract genphy_c45_read_abilities
 from marvell10g
Message-ID: <20190120185107.GA19714@lunn.ch>
References: <20190118152352.26417-1-maxime.chevallier@bootlin.com>
 <20190118152352.26417-2-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190118152352.26417-2-maxime.chevallier@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190120_105115_816849_22854767 
X-CRM114-Status: GOOD (  16.01  )
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
Cc: Florian Fainelli <f.fainelli@gmail.com>,
 Antoine Tenart <antoine.tenart@bootlin.com>, netdev@vger.kernel.org,
 gregory.clement@bootlin.com, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org, nadavh@marvell.com, thomas.petazzoni@bootlin.com,
 miquel.raynal@bootlin.com, stefanc@marvell.com, mw@semihalf.com,
 davem@davemloft.net, linux-arm-kernel@lists.infradead.org,
 Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 18, 2019 at 04:23:46PM +0100, Maxime Chevallier wrote:
> Marvell 10G PHY driver has a generic way of initializing the supported
> link modes by reading the PHY's C45 PMA abilities. This can be made
> generic, since these registers are part of the 802.3 specifications.
> 
> This commit extracts the config_init link_mode initialization code from
> marvell10g and uses it to introduce the genphy_c45_read_abilities
> function.

Hi Maxime

I think the idea is good. I just have a few English language
issues/questions.

Capabilities is more often used than abilities. I just wondered if
abilities is taken from the 802.3 specifications?

Also, i wonder if we should include _pma_ in the name? At some point
we might want to do something similar for other sublayers.

> +/**
> + * genphy_c45_read_abilities - read supported link modes from PMA
> + * @phydev: target phy_device struct
> + *
> + * Read the supported link modes from the PMA Status 2 (1.8) register. If bit
> + * 1.8.9 is set, the list of supported modes is completed with the values in the

completed is not the right word. 'is build using the values in the' ?

> + * PMA Extended Abilities (1.11) register, indicating 1000BASET an 10G related
> + * modes. If bit 1.11.14 is set, then the list is also completed with the modes

list is also extended with the modes

> + * in the 2.5G/5G PMA Extended register (1.21), indicating if 2.5GBASET and
> + * 5GBASET are supported.
> + */


Thanks
	Andrew

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
