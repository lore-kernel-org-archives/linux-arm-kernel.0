Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B9AC282F6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:35:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F69720663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Bm+TIwTZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F69720663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hJrx335XA40fMJTg4tee2bQOAooAonl3C3NGRQbvYOY=; b=Bm+TIwTZvvpveV
	UpLkQRy/a+4GMUNQceTZA56gj+WnboM1p5E21CVnVr0EDZYaP6ZAH6PibL9nfRmiNGdk+QJIr76k0
	zlSkb0jrF2Jg8Ehzv+YIgS2x5+fDXLe5uAs9O6hTH8KnU21m9wFCP84JxNlivOBEB+di9eHXH+B72
	Kd1j45Vo2mQTXA/H/aHlnjTX7n/GTmrnjp+QgQHTQkgnQduTcANTCSwekU5aXfBtAEAc26Tey8iqk
	+wrAQM+GXwopESWFDeWJ5kJ3vWnMFaZ9QL4/yuKurmBsU4Kf5gmsPWkMupii5kruqqmoxX+0QF13q
	qYN96g7OUp0H+v8R9pow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glWvl-0003RM-Ar; Mon, 21 Jan 2019 10:35:49 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glWvg-0003R0-OQ
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 10:35:46 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 8CA62209EF; Mon, 21 Jan 2019 11:35:41 +0100 (CET)
Received: from bootlin.com (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr
 [90.88.156.87])
 by mail.bootlin.com (Postfix) with ESMTPSA id 1C312207B2;
 Mon, 21 Jan 2019 11:35:31 +0100 (CET)
Date: Mon, 21 Jan 2019 11:35:31 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next 5/7] net: phy: marvell10g: Force reading of
 2.5/5G PMA extended abilities
Message-ID: <20190121113531.7a8b5b51@bootlin.com>
In-Reply-To: <20190120190809.GB19714@lunn.ch>
References: <20190118152352.26417-1-maxime.chevallier@bootlin.com>
 <20190118152352.26417-6-maxime.chevallier@bootlin.com>
 <20190120190809.GB19714@lunn.ch>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_023544_930741_D7B44E4A 
X-CRM114-Status: GOOD (  12.97  )
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

On Sun, 20 Jan 2019 20:08:09 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

>On Fri, Jan 18, 2019 at 04:23:50PM +0100, Maxime Chevallier wrote:
>> As per 802.3bz, if bit 14 of (1.11) "PMA Extended Abilities" indicates
>> whether or not we should read register (1.21) "2.52/5G PMA Extended
>> Abilities", which contains information on the support of 2.5GBASET and
>> 5GBASET.
>> 
>> After testing on several variants of PHYS of this family, it appears
>> that bit 14 in (1.11) isn't always set when it should be.
>> 
>> PHYs 88X3310 (on MacchiatoBin) and 88E2010 do support 2.5G and 5GBASET,
>> but don't have 1.11.14 set. Their register 1.21 is filled with the
>> correct values, indicating 2.5G and 5G support.
>> 
>> PHYs 88X2110 do have their 1.11.14 bit set, as it should.  
>
>Hi Maxime
>
>Is there anything about this in any Errata?

I haven't seen any Errata on that unfortunately.

I also thought about reading (1.4) "PMA/PMD Speed Ability", but the
2.5G and 5G speeds are also reported as not being supported on the
88X3310.

>We potentially have an issue if Marvell have any PHYs in this family
>which don't support 2.5G/5G. Maybe this workaround needs to check the
>IDs and only enable it on device we know are broken.

I agree with you, this might be a better way to handle that issue. For
now, I've only seen that issue on the 3310 and 2010, with PHY IDs
respectively 002b09aa and 002b09ab.

I 'll add a test for ids '002b09aX', hopefully there won't be any PHYs
with these IDs that don't support 2.5/5G.

In that case, there's no need for a separate mv2110_config_init in
patch 7.

Thanks,

Maxime.

>    Andrew



-- 
Maxime Chevallier, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
