Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D686EC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:49:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98B562190A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rjSMAoKP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98B562190A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0tNkv4vP8L1AqxmVptbdi8Pk1fcJM/H9nFfP4YybF7w=; b=rjSMAoKPFx3QQ5
	47lHaUZFn47suDYGow7osxIOcxLqS4Cj51GL3OxBxcFHeLyLaXppEC1Mw6e6caQzqLp4YVzAvaIiX
	Dn6bqLij5xO9uuBS60+7/M3KoFx5Tgc+j05vdJjbLFdeLUmya7H0vO9XJDlqHFDn+ORYOgZZQs+58
	5NsNylLLSVotzzhSV08gvhQLMv3wLXDKNszPPnsW2wIDlRZ8rgqJYH6Ym2idLil008CH3fauButxF
	Leoo7gTf6G+Vbmx2u+v13CHPKmi8hg7z1kywnU2yf3IQMLQyW9NkNzYOt2OlYKR/7NVyZkbNFQsHP
	587qvIk76h2+9C7juxrw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grkzU-0001hj-6C; Thu, 07 Feb 2019 14:49:24 +0000
Received: from relay8-d.mail.gandi.net ([217.70.183.201])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grkzQ-0001gq-Cd
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 14:49:22 +0000
X-Originating-IP: 90.88.22.177
Received: from bootlin.com (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr
 [90.88.22.177]) (Authenticated sender: maxime.chevallier@bootlin.com)
 by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 6EB971BF20A;
 Thu,  7 Feb 2019 14:49:11 +0000 (UTC)
Date: Thu, 7 Feb 2019 15:49:10 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next v2 04/10] net: phy: Automatically fill the
 generic TP, FIBRE and Backplane modes
Message-ID: <20190207154910.697a8761@bootlin.com>
In-Reply-To: <20190207140939.GI32483@lunn.ch>
References: <20190207094939.27369-1-maxime.chevallier@bootlin.com>
 <20190207094939.27369-5-maxime.chevallier@bootlin.com>
 <20190207140939.GI32483@lunn.ch>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_064920_582739_960F2976 
X-CRM114-Status: GOOD (  13.71  )
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

On Thu, 7 Feb 2019 15:09:39 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

>On Thu, Feb 07, 2019 at 10:49:33AM +0100, Maxime Chevallier wrote:
>> PHY advertised and supported linkmodes contain both specific modes such
>> as 1000BASET Half/Full and generic ones such as TP that represent a
>> class of modes.
>> 
>> Since some modes such as Fibre, TP or Backplane match a wide range of
>> specific modes, we can automatically set these bits if one of the
>> specific modes it corresponds to is present in the list.
>> 
>> The 'TP' bit is set whenever there's a BaseT linkmode in
>> phydev->supported.
>> 
>> The 'FIBRE' bit is set for BaseL, BaseS and BaseE linkmodes.
>> 
>> Finally, the 'Backplane' is set whenever a BaseK mode is supported.  
>
>Hi Maxime
>
>Interesting idea.
>
>But what exactly are we supposed to be representing here?  That PHY
>can do these modes, or that the port exists on the device? The
>marvell10g can do fibre, but do all boards have an SFP/SFF, or do some
>only have an RJ-45 for TP? Are there boards without TP and just
>SFP/SFF?

My understanding is that this would represent what the PHY is capable
of, at least when set in the supported field, but I agree that this
doesn't reflect what's on the device.

I extrapolated this logic from the ability detection in marvell10g,
that would set these bits according to the abilities reported by the
PHY. This was done based on the PHY register values, instead of the
linkmodes in the 'supported' field.

>Is there documentation in ethtool which gives a clue as to what is
>expected?

Not really, at least to my knowledge. I think this would be used by
"ethtool -s ethX port tp|fibre|aui|etc". Maybe this could be useful if
we decide to implement port selection with ethtool on the MCBin, but I'm
getting a bit ahead of myself.

Thanks,

Maxime

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
