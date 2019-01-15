Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA4EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:42:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7AA920651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dRg+N9M/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RU1yrqUf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7AA920651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yUcO8ddGLN4Xzy5v8fuEjKh/KDuS+npyzqIcDqUfLWM=; b=dRg+N9M/J261yE
	FaZcMge99kwHZD1jV8SY4yz6mEe7py8I8qbXT4ryOBRgT5i2IRpLDSDPsiX6ZsyNMgiBMVwbegujV
	0Gh5CXrDgO8zz5nxzfdHP8pu8+cg98TPqFYDkaYYENKmV9io8/yV1S4PP2G+eaiF3iH6xUbsqLKJI
	7XNcnkTMkPHBOk+7HhjKT6FZtCZ00gk2Ab5jqPEuLtfr0brY/dki3mgmxQ+8n88Kh66SiZk5/XYI4
	9x+EJ3g+3Nwe3+Gq5N7MFoX2XGeWeWBkjMMTY8h/oSchQUb4CjqvNvbWNm371+NbpcxejQKZSPrPH
	B/qup5016auXPupwRQdw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjOzM-0005PS-Jw; Tue, 15 Jan 2019 13:42:44 +0000
Received: from vps0.lunn.ch ([185.16.172.187])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjOzJ-0005P3-DJ
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 13:42:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; 
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
 bh=4e6JffbMdmVpAxrJxwTSdc6ogz9b63R+x0Q7EhzDRMU=; 
 b=RU1yrqUf4RYM7Cm4FAr8Bx13gFpnPNuxwl5JuDRogCo9ZdHzjp14ekENr0X5q2ojpU1xwdLV8UN4dDnbnxn7HmJXZqzV2Oz37EFUWFnqQim2DAIwxj1jbH3iqKeOU7eKSzAqm8LjnD/IoqEpWz9jwxfmAnByFnFewuDPb7DOOCc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
 (envelope-from <andrew@lunn.ch>)
 id 1gjOz7-0005K8-8g; Tue, 15 Jan 2019 14:42:29 +0100
Date: Tue, 15 Jan 2019 14:42:29 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Vid <vladimir.vid@sartura.hr>
Subject: Re: [PATCH v2 1/2] arm64: dts: marvell: Add device tree for uDPU board
Message-ID: <20190115134229.GE19687@lunn.ch>
References: <20190111172055.30451-1-vladimir.vid@sartura.hr>
 <20190115121113.5636-1-vladimir.vid@sartura.hr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190115121113.5636-1-vladimir.vid@sartura.hr>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_054241_604822_E079C230 
X-CRM114-Status: UNSURE (   8.53  )
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
Cc: devicetree@vger.kernel.org, Luis Torres <luis.torres@methode.com>,
 Paul Arola <paul.arola@telus.com>, Scott Roberts <scott.roberts@telus.com>,
 Luka Perkov <luka.perkov@sartura.hr>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Device tree for the uDPU board.
> + * Based on Marvell Armada 3720 development board (DB-88F3720-DDR3)
> + * Copyright (C) 2016 Marvell
> + * Copyright (C) 2018 Methode
> + * Copyright (C) 2018 Telus

2019?

> + *
> + * Vladimir Vid <vladimir.vid@sartura.hr>
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include "armada-372x.dtsi"
> +
> +/ {
> +	model = "Methode uDPU Board";
> +	compatible = "marvell,armada-3720-db", "marvell,armada3720",
> +		     "marvell,armada3710", "methode,udpu";

Compatible strings are sorted as most specific to most generic. So
"methode,udpu" should be first. "marvell,armada-3720-db" can probably
be dropped.

   Andrew

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
