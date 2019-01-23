Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BC1C282C5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:42:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41F6E21841
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CqOdUIFu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41F6E21841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZVqiljwgEvBvbgrWTGqDzC2ndiJqw+1T11tpyVPEhRw=; b=CqOdUIFumkuYuV
	Ee0TLaNaPMHOlW/i6/GVYavDJCQK9TqCQePZOcEzY5r/8vje2SI2AzpSj4A5nF7MIiGoxeL8tLl3n
	1pJ7rCWG65GwnUi8qBHhdxfq5k7Nhc8SM4q+EZpzqgaH7cOlSW8n/gNNHvBJtbjlFKQ59e6ET9/HN
	F5Vjv2l4D21/VJwrwjipYO2fOXINuAeYpuB8WDsOfnpZulTWPjFrCruMahrKWQsVJgkKxfokmmxxp
	9dm1Uh1eqHvqGi1pl8onWgyGmlfxYt3a5HTaJ8zavXlfkcO4jkdwxix6sLqNMSyky5D6NSGRwtMjo
	mvv7fmP4rpSjJ39B+FKQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmF2k-0005Ih-N5; Wed, 23 Jan 2019 09:41:58 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmF2h-0005Hw-I7
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 09:41:56 +0000
Received: from lupine.hi.pengutronix.de
 ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <p.zabel@pengutronix.de>)
 id 1gmF2d-00010z-9U; Wed, 23 Jan 2019 10:41:51 +0100
Message-ID: <1548236510.3904.3.camel@pengutronix.de>
Subject: Re: [PATCH reset-next 0/2] reset: brcmstb: Misc fixes
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org
Date: Wed, 23 Jan 2019 10:41:50 +0100
In-Reply-To: <20190123003345.13750-1-f.fainelli@gmail.com>
References: <20190123003345.13750-1-f.fainelli@gmail.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_014155_765736_7E57231E 
X-CRM114-Status: GOOD (  10.68  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, "open list:OPEN FIRMWARE AND
 FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
 sfr@canb.auug.org.au, rdunlap@infradead.org, paul.gortmaker@windriver.com,
 Rob Herring <robh+dt@kernel.org>,
 "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <bcm-kernel-feedback-list@broadcom.com>, linux-next@vger.kernel.org,
 Gregory Fong <gregory.0xf0@gmail.com>,
 Brian Norris <computersforpeace@gmail.com>, "moderated
 list:BROADCOM BCM7XXX ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 2019-01-22 at 16:33 -0800, Florian Fainelli wrote:
> Hi Philipp,
> 
> These two patches fix some recent issues brought up by Paul and Randy,
> feel free to squash into c196cdc7659d ("reset: Add Broadcom STB SW_INIT
> reset controller driver") since this is only in reset/next and
> linux-next so far.

If you want this squashed, feel free to submit an updated version of the
original patches and I'll replace them. That way I don't have to decide
how to stitch (or drop) the commit messages.

thanks
Philipp

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
