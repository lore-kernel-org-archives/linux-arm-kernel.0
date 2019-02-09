Return-Path: <SRS0=BTYN=QQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FCDC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 13:22:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E70D21916
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 13:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R1KcMqhu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEXukQHF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E70D21916
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nxkwya72Z7FBxPPdA8AFEHbY7i9BHtpKpmvjSWn/5CI=; b=R1KcMqhuMwt6bL
	BjYZfCwgZM6cvgKtJmcZ7zNAcQnUbIu+sDJQm9VjG7BbCGXIkmJ0BdzWpPr3Dm51xi03dPr5GHyKQ
	V11k8pTcKH/VHwesLl/Aw4eaHUpLR0UYXLdXmKry+pO1ewtcuJRqidruS8tE4/7IsjgOD/ITHW3qu
	IOTEeOX41engY45lhv6sLDVNSZDvvHoSnOj8aWVihWBHiaSjmZkN/6ZqhNrw1wDOBeun1pYtJamH6
	acaW/dhlY+OE+4XHDh0ML1YgHOgERFxGZcvkEHlqSBD8r/9NV2tFG4ybKcH/fJry3skPXHepaZoyJ
	n7x7nrBmqmH+/CidOSOw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsSai-0007us-FW; Sat, 09 Feb 2019 13:22:44 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsSae-0007uW-Hw
 for linux-arm-kernel@lists.infradead.org; Sat, 09 Feb 2019 13:22:42 +0000
Received: by mail-wm1-x342.google.com with SMTP id a62so8387969wmh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 09 Feb 2019 05:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=YKhgG+hRVMP2SdK2Q9vdp473wxfGQlE8YElcW8qOQBE=;
 b=MEXukQHFYReCWYuAccv4GN1zP8yVR3mXAvFkKDFNJR7ZfsnIacCfisAfiR5V8dsg0D
 vjfMrEN4CSGabYd6NvQPz/6kmfiJ5AizAsZ11dX9tarA5EKfLEFtHXgfmCrLWl5L9tBy
 +sQ0/cPsbzr0p3IMZcfMOoge3oZG4iruHXNMLLZtXAikQVWeKOXv6TqiJL4ycTwDnMdK
 6udSjyqodfflhVapJwgcbvx9l+KC88rBMHKNnLOTlgfdQj2ZjQXVCJtmRvGaVz+X9ei4
 Sh1DeCNXOwVkt/yVGcvo3XI0DNd6K8wBb+TW1uq+Z/0a6b11myOI9HYzPJf9BQ7HBOCY
 N9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YKhgG+hRVMP2SdK2Q9vdp473wxfGQlE8YElcW8qOQBE=;
 b=HN6GNmf4ERQ8Pu4TDCGL4gvXAEO3wSrSIKE45c4O7EvIUC0staVRT8/2f3VehZmubj
 C/uhYLVs+UArhNuDQO8DeEMW3adIhDGgr/cDEuHkKaZ2rL0pLgT+Iy/hJwygGAlpZC6u
 wYC67kVkrNNkYnn9ZzagVL7erO7Z24K10NHCqX/yaA5ZuCQzPyMxjzZuromEVZ7WacnJ
 k/7orgtTEU6lxnicFCaCfRSGiROS35vratY/SQZ1uEcv6/d+aKCmT+jK+AwKZP6nsWFQ
 xrwF+7AFk/FpM6/IxsKLkZYsDD7DvyZfuvwrwztkbHArEEoKsegjvHCpgvlIhs3vc1U4
 rqyQ==
X-Gm-Message-State: AHQUAub/ynRFMpWIG1PaKV2ev+Oby1vi4kKgCnj67l2v6LZoivJHHpgQ
 EyNoiqnW7dK4W1LbCma2KN0=
X-Google-Smtp-Source: AHgI3IYC54iQfAxHvnr2IAMXerJE5+VCzC+iCR7vXpR3aRnzwfErywSJmbDhchW4WRnTSchyY4CJlg==
X-Received: by 2002:adf:fd0a:: with SMTP id e10mr21571198wrr.190.1549718557952; 
 Sat, 09 Feb 2019 05:22:37 -0800 (PST)
Received: from ?IPv6:2003:ea:8bf1:e200:aca4:3d:8205:4c97?
 (p200300EA8BF1E200ACA4003D82054C97.dip0.t-ipconnect.de.
 [2003:ea:8bf1:e200:aca4:3d:8205:4c97])
 by smtp.googlemail.com with ESMTPSA id s3sm4624771wmj.23.2019.02.09.05.22.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 09 Feb 2019 05:22:36 -0800 (PST)
Subject: Re: [PATCH net-next v2 00/10] net: phy: Add support for 2.5GBASET PHYs
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
 Andrew Lunn <andrew@lunn.ch>
References: <20190207094939.27369-1-maxime.chevallier@bootlin.com>
From: Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <81c340ea-54b0-1abf-94af-b8dc4ee83e3a@gmail.com>
Date: Sat, 9 Feb 2019 14:22:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190207094939.27369-1-maxime.chevallier@bootlin.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190209_052240_630365_D57B3239 
X-CRM114-Status: GOOD (  25.71  )
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
 gregory.clement@bootlin.com, linux-kernel@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, nadavh@marvell.com,
 thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com, stefanc@marvell.com,
 mw@semihalf.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 07.02.2019 10:49, Maxime Chevallier wrote:
> Hello everyone,
> 
> This is the second iteration of the series introducing support for
> 2.5GBASET and 5GBASET to the network PHY infrastructure.
> 
> These 2 modes are described in the 802.3bz specifications, and allow to
> use 2.5G and 5G speeds on cat5e/cat6 cables.
> 
> The required infrastructure code is added for 2.5GBASET and 5GBASET, but
> only 2.5GBASET support is added to the Marvell10G driver. The reason is
> because the 5GBASER interface mode used to communicate with the MAC
> isn't implemented yet, and therefore this can't be tested.
> 
> This series has seen some rework since last time, see the full details
> in the patches changelog. The main highlights are :
> 
>  - Patch 1 moves the Pause ans Asym_Pause parameters update after
>    calling config_init. This allows us to change the phydev->supported
>    modes in config_init, while still forcing some quirks taken from
>    phydrv->features, to disable unsupported Pause modes. This was
>    proposed by Andrew.
> 
>  - Patch 2 generalizes the way we mask-out modes we don't want to use
>    when forcing the link speed through DT or ethtool, by walking through
>    the PHY settings table, as proposed by Russell.
> 
>  - Patch 4 implements automatic setting of TM, FIBRE and Backplane bits
>    from the list of supported linkmodes.
> 
>  - In Patch 5, we only read abilities from the PMA. Pause parameters
>    aren't built from the genphy_c45_pma_read_abilities, as it was done
>    in the previous iteration of the patch. We also amke use of
>    linkmode_mod_bit to make sure we mask-out unsupported modes.
> 
>  - In Patch 8, we manually check for the PMA device id to see if we have
>    to use a quirk when reading the 2.5G/5G Extended Abilities
> 
> Maxime Chevallier (10):
>   net: phy: Update PHY linkmodes after config_init
>   net: phy: Mask-out non-compatible modes when setting the max-speed
>   net: phy: Move of_set_phy_eee_broken to phy-core.c
>   net: phy: Automatically fill the generic TP, FIBRE and Backplane modes
>   net: phy: Extract genphy_c45_pma_read_abilities from marvell10g
>   net: phy: Add generic support for 2.5GBaseT and 5GBaseT
>   net: phy: marvell10g: Add support for 2.5GBASET
>   net: phy: marvell10g: Force reading of 2.5/5G
>   net: mvpp2: Add 2.5GBaseT support
>   net: phy: marvell10g: add support for the 88x2110 PHY
> 
>  .../net/ethernet/marvell/mvpp2/mvpp2_main.c   |   1 +
>  drivers/net/phy/marvell10g.c                  | 142 +++++------
>  drivers/net/phy/phy-c45.c                     | 111 ++++++++
>  drivers/net/phy/phy-core.c                    |  72 ++++++
>  drivers/net/phy/phy_device.c                  | 237 +++++++++---------
>  include/linux/linkmode.h                      |   6 +
>  include/linux/marvell_phy.h                   |   2 +
>  include/linux/phy.h                           |   3 +
>  include/uapi/linux/mdio.h                     |  16 ++
>  9 files changed, 405 insertions(+), 185 deletions(-)
> 
Hi Maxime,

Andrew and me are working on Aquantia PHY support and he handed over
to me a patch series which includes parts of the first version of your
series. Having said that I'm especially interested in your patches
5 and 6. Because your series is somewhat bigger and there are a few
review comments, preparing the next round may take time.

I'd propose that you extract generic patches being submission-ready
and split the patch series into two. I think the following patches
would be candidates for the first series: 2, 3, 5, 6
(provided they have no dependency on the other patches)
Based on that both of us can go on with our work.

Andrew, what do you think?

Heiner

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
