Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0453C2F421
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:36:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 791EB20870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uJzWIxUb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 791EB20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HuMPKixGutzhasbiAdrQvYvQnJA51nCd1oxj/eUemRk=; b=uJzWIxUboHmKG3
	a76MTHiV0pFlzSbyCFzTgoRXBnWDNBIC9C0yQfImkWOiMItsKcQAhQNCEtbB2kr4QeRxmzsRypUlN
	zDgpR8pJ3uHOZkQjFPrV2+fNjoSJkvJQRYhC+eWpsy0KJN0oKVJ5S8wGfaCqUbDgP+UrYC1OmQJq+
	cu6B3Pv3rYWQZn9J39skGPvQ2Glg9FOyusTsytHgCh8MA/sfUboRcta3DsVLDu4j4kKWOviTR1HOO
	X2ACyX8sDVc/ZbhsFpnHmlYF9/PpWbXmHQpIRJaRrFA4un0Ix7pgj+6YWFgKXPJMgiEWiqh6T2yZP
	tPTUBzJXtIQU44q4Y+kg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glcYq-0007a7-Jl; Mon, 21 Jan 2019 16:36:32 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glcYn-0007ZL-6R
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 16:36:30 +0000
Received: from lupine.hi.pengutronix.de
 ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <p.zabel@pengutronix.de>)
 id 1glcYh-0005TT-Vh; Mon, 21 Jan 2019 17:36:23 +0100
Message-ID: <1548088583.3287.14.camel@pengutronix.de>
Subject: Re: [PATCH v2 2/2] reset: Add Broadcom STB SW_INIT reset controller
 driver
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Scott Branden <scott.branden@broadcom.com>, Florian Fainelli
 <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org
Date: Mon, 21 Jan 2019 17:36:23 +0100
In-Reply-To: <7bc8d9ee-5be1-1765-55dd-b7407cff962f@broadcom.com>
References: <20190115184406.3164-1-f.fainelli@gmail.com>
 <20190115184406.3164-3-f.fainelli@gmail.com>
 <7bc8d9ee-5be1-1765-55dd-b7407cff962f@broadcom.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_083629_400740_A61F8DDF 
X-CRM114-Status: GOOD (  19.47  )
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
 Rob Herring <robh+dt@kernel.org>,
 "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <bcm-kernel-feedback-list@broadcom.com>, Gregory Fong <gregory.0xf0@gmail.com>,
 Brian Norris <computersforpeace@gmail.com>, "moderated
 list:BROADCOM BCM7XXX ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Scott,

On Wed, 2019-01-16 at 10:15 -0800, Scott Branden wrote:
> On 2019-01-15 10:44 a.m., Florian Fainelli wrote:
> > Add support for resetting blocks through the Linux reset controller
> > subsystem when reset lines are provided through a SW_INIT-style reset
> > controller on Broadcom STB SoCs.
> > 
> > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> > ---
> >   drivers/reset/Kconfig         |   7 ++
> >   drivers/reset/Makefile        |   1 +
> >   drivers/reset/reset-brcmstb.c | 130 ++++++++++++++++++++++++++++++++++
> >   3 files changed, 138 insertions(+)
> >   create mode 100644 drivers/reset/reset-brcmstb.c
> > 
> > diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> > index 2e01bd833ffd..1ca03c57e049 100644
> > --- a/drivers/reset/Kconfig
> > +++ b/drivers/reset/Kconfig
> > @@ -40,6 +40,13 @@ config RESET_BERLIN
> >   	help
> >   	  This enables the reset controller driver for Marvell Berlin SoCs.
> >   
> > +config RESET_BRCMSTB
> > +	bool "Broadcom STB reset controller" if COMPILE_TEST
> 
> Could this even be:
> 
> depends on ARCH_BRCMSTB || COMPILE_TEST

I don't think this is necessary. Since the symbol is non-interactive if
COMPILE_TEST is disabled, it just vanishes when both are disabled.

> > +	default ARCH_BRCMSTB

And if it is actually needed, it defaults to the correct value.

regards
Philipp

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
