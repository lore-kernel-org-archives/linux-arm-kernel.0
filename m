Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6332CC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 10:08:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 264062082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 10:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Soqv/tVZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 264062082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hellion.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2ekXTeBRut6sd8+k5FUbojZhYiolBVKe99UHJDjpyUE=; b=Soqv/tVZvXMDx8
	+mbZRKNXlsGntm6n4MYE79ykid+3Gee9nb5eQBGKdB0i7qjtOfbeS8BJbRwQffSIqVEUPk6PWvvSC
	VAOcH6iHIn7M6LWGGYTszNUsCqPAPM9CIMFPrxVutm0FGhAolNdxAzM+5LcDcKdNavD3GNuWzXhEL
	iLQU1y54M4bIWynQqgbTWp7pM++JzZ2eTJ5Mzh61jYCcuLiEtytkT4yrlcFO/syx+Gyhaoj7SH9vh
	nfzwKtkt+PiW7uKpLgJODnMD6gm4gpm1aU/lqQyZ100xOQN3HwzvhrTpAqQOj2XuEd5BXuNdfXyHO
	4welONiQukyG/pz+93YQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVZWp-0000R7-6V; Sat, 08 Dec 2018 10:08:07 +0000
Received: from benson.default.arb33.uk0.bigv.io ([2001:41c9:1:41d::16])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVZWm-0000QO-7H
 for linux-arm-kernel@lists.infradead.org; Sat, 08 Dec 2018 10:08:06 +0000
Received: from cpc91198-cmbg18-2-0-cust103.5-4.cable.virginm.net
 ([81.98.98.104] helo=dagon.hellion.org.uk)
 by benson.default.arb33.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.84_2)
 (envelope-from <ijc@hellion.org.uk>)
 id 1gVZWE-0002H0-Lc; Sat, 08 Dec 2018 10:07:30 +0000
Message-ID: <87316941f5cbc2482fcb7faf55e88cb801ddace3.camel@hellion.org.uk>
Subject: Re: Moving ARM dts files
From: Ian Campbell <ijc@hellion.org.uk>
To: Rob Herring <robh@kernel.org>, arm@kernel.org
Date: Sat, 08 Dec 2018 10:07:29 +0000
In-Reply-To: <20181204183649.GA5716@bogus>
References: <20181204183649.GA5716@bogus>
X-Mailer: Evolution 3.28.5-1 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_020804_397704_7F934C44 
X-CRM114-Status: UNSURE (   8.63  )
X-CRM114-Notice: Please train this message.
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
Cc: Andrew Lunn <andrew@lunn.ch>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Kevin Hilman <khilman@kernel.org>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Michal Simek <michal.simek@xilinx.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Joel Stanley <joel@jms.id.au>, Andy Gross <andy.gross@linaro.org>,
 devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
 Simon Horman <horms@verge.net.au>, linux-arm-kernel@lists.infradead.org,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 Andreas =?ISO-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
 Daniel Mack <daniel@zonque.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 2018-12-04 at 12:36 -0600, Rob Herring wrote:
> I've put together a script to move the dts files and update the 
> makefiles.

Anything here which the split-devicetree tree[0] needs to care about?

I think this is all just about file movement contained entirely
underneath arch/arm/boot/dts, in which case the answer *should* be
"no".

Ian.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
