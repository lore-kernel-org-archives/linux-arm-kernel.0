Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02128C4363B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:14:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3FF32086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LaY0R/J3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3FF32086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:
	In-Reply-To:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZinvUrUf4Ice28GOL7A2RI9jOMvj94dvv5XmAewSyTY=; b=LaY0R/J3m6F9UA
	bxk4UFT0VQ+OFsr6OAfWEAmJzL7aDzVYFiSth6zv/U4xRP5SBPdTwip5AfClSN8DHvdMnywReAnVi
	VhWPmYKxlgFnvlbvWJQ2xgeHXxkSVo59ca0dH1oCZ7pTD+H2tCivKPf9QAo0fyqOtds10pdfB4PtE
	aCnlO9UjI794ky3SauyXE7XbVbuEUoo3SwGQBsiVg5bCvj3J+ui5aF9gha/U7Bot0KQmjm9SnxAJM
	61Lwz6syTc+pYOKITlz4ibs8fW5vww0W5hhU/Dv5zQkppBmLXAdnOLafi8VXKPlXsPPJDlcg505ew
	YhJxG5+4LWhvf4/vWaEA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjiDJ-0004gy-RA; Wed, 16 Jan 2019 10:14:25 +0000
Received: from galois.linutronix.de ([2a01:7a0:2:106d:700::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjiDF-0004fc-Dg; Wed, 16 Jan 2019 10:14:23 +0000
Received: from p4fea4364.dip0.t-ipconnect.de ([79.234.67.100] helo=nanos)
 by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
 (Exim 4.80) (envelope-from <tglx@linutronix.de>)
 id 1gjiD3-0004ni-Re; Wed, 16 Jan 2019 11:14:10 +0100
Date: Wed, 16 Jan 2019 11:14:09 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Yixun Lan <yixun.lan@amlogic.com>
Subject: Re: [PATCH 1/3] dt-bindings: reset: Add bindings for the Meson-AXG
 SoC Reset Controller
In-Reply-To: <alpine.DEB.2.21.1811121115520.14703@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1901161112090.1655@nanos.tec.linutronix.de>
References: <20171110084650.31325-1-yixun.lan@amlogic.com>
 <alpine.DEB.2.21.1811121115520.14703@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required, ALL_TRUSTED=-1,
 SHORTCIRCUIT=-0.0001
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_021421_603502_217E3F63 
X-CRM114-Status: GOOD (  13.04  )
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
Cc: Neil Armstrong <narmstrong@baylibre.com>,
 Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 12 Nov 2018, Thomas Gleixner wrote:

Gentle ping.

> Yixun,
> 
> On Fri, 10 Nov 2017, Yixun Lan wrote:
> 
> > +/*
> > + *
> > + * Copyright (c) 2016 BayLibre, SAS.
> > + * Author: Neil Armstrong <narmstrong@baylibre.com>
> > + *
> > + * Copyright (c) 2017 Amlogic, inc.
> > + * Author: Yixun Lan <yixun.lan@amlogic.com>
> > + *
> > + * SPDX-License-Identifier: (GPL-2.0+ OR BSD)
> 
> There are two things wrong:
> 
>   1) The placement. See Documentation/process/license-rules.rst
> 
>   2) BSD is not a valid license id. You really have to decide which BSD
>      variant to use.
> 
> Please get that fixed as especially #2 is broken. The goal of using SPDX is
> to provide reliable license information for compliance tools.

This still is broken:

# scripts/spdxcheck.py include/dt-bindings/
include/dt-bindings/reset/amlogic,meson-axg-reset.h: 9:41 Invalid License ID: BSD

Thanks,

	tglx


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
