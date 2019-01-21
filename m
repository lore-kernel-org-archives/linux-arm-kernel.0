Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C8DC2F441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:20:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EC1420989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sV7nKgoi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EC1420989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=R2B3Ag9KXaArSaZoks4IrBietNs1XoQjsDxLmsMh0KY=; b=sV7nKgoiB1o2Hj
	SjwmX32/9OPK/gFxXsWUPRgl7z9u9lXxGUVdMPwkqyIoSQ5Lj+LHGuICdcy5ejn49f41zohyZcGgC
	nEvQ/7+sM6kqWSDF+X6Zjp34Fc4oNMGHm9jXdJvVGeUAf0waAADijnjvIA2iv6EVgfEKccoE7Fc0I
	udLbLTjHjU1/hqQFgMarMWN8L78He2tx3sqCIS0/bnUJzQCC+fby8+VvsfdHNCIihNvIVcWGro+Cd
	YoXvx+tDKNrKsrkfNFPn8gwlEfN7592mq1ZpeLL1E36cqsmrQY5U+pJ7c3i4Q7+eK0854NmE80aIi
	vbGt8OB1M1GmpIOCQcpw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glcJ9-0005vn-KI; Mon, 21 Jan 2019 16:20:19 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glcJ6-0005vP-C2
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 16:20:17 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id BF9A4206DC; Mon, 21 Jan 2019 17:20:14 +0100 (CET)
Received: from bootlin.com (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr
 [90.88.156.87])
 by mail.bootlin.com (Postfix) with ESMTPSA id 512BB20397;
 Mon, 21 Jan 2019 17:20:04 +0100 (CET)
Date: Mon, 21 Jan 2019 17:20:04 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next 1/7] net: phy: Extract
 genphy_c45_read_abilities from marvell10g
Message-ID: <20190121172004.78a341f7@bootlin.com>
In-Reply-To: <20190120185107.GA19714@lunn.ch>
References: <20190118152352.26417-1-maxime.chevallier@bootlin.com>
 <20190118152352.26417-2-maxime.chevallier@bootlin.com>
 <20190120185107.GA19714@lunn.ch>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_082016_541266_A7918E2C 
X-CRM114-Status: GOOD (  16.34  )
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

Hello Andrew,

On Sun, 20 Jan 2019 19:51:07 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

>On Fri, Jan 18, 2019 at 04:23:46PM +0100, Maxime Chevallier wrote:
>> Marvell 10G PHY driver has a generic way of initializing the supported
>> link modes by reading the PHY's C45 PMA abilities. This can be made
>> generic, since these registers are part of the 802.3 specifications.
>> 
>> This commit extracts the config_init link_mode initialization code from
>> marvell10g and uses it to introduce the genphy_c45_read_abilities
>> function.  
>
>Hi Maxime
>
>I think the idea is good. I just have a few English language
>issues/questions.

Thanks for the review.

>Capabilities is more often used than abilities. I just wondered if
>abilities is taken from the 802.3 specifications?

Yes, the term 'Ability' is used in the 802.3 specifications, both in
the register names and the descriptions.

>Also, i wonder if we should include _pma_ in the name? At some point
>we might want to do something similar for other sublayers.

You're right, we do read only from the PMA and I see that we could also
to similar thing for the PCS layer, I'll rename the function.

>> +/**
>> + * genphy_c45_read_abilities - read supported link modes from PMA
>> + * @phydev: target phy_device struct
>> + *
>> + * Read the supported link modes from the PMA Status 2 (1.8) register. If bit
>> + * 1.8.9 is set, the list of supported modes is completed with the values in the  
>
>completed is not the right word. 'is build using the values in the' ?

That's better indeed, I'll correct that sentence.

>> + * PMA Extended Abilities (1.11) register, indicating 1000BASET an 10G related
>> + * modes. If bit 1.11.14 is set, then the list is also completed with the modes  
>
>list is also extended with the modes

And that one too.

>> + * in the 2.5G/5G PMA Extended register (1.21), indicating if 2.5GBASET and
>> + * 5GBASET are supported.
>> + */  
>

Thanks,

Maxime

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
