Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2087FC282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:55:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E35D62148E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hoaGi86j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E35D62148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=83axh8q9wlHCGD9f4PfxeqQh4hWn04ClUeVG95ga5hk=; b=hoaGi86jn+KOFb
	kfyCabzfQ1O0sBEJ2ZSno9t+8RwWga9EXEw/xv2r4JwKNMP+VYZba5qMoO1Ne9WlnD3cmYZumqPkt
	WNUIOyZ1VH1uPWsqjXy3FZvF+9D/AOfzxovQg/xQw3pc+YhmjcubOWTaVmHXuegcB0jriNbLG3GJx
	/q+p5yPEzYr721PI04AG8YRDRy6A64ln5e2gY/bnp1QxGzCVKDcPy5vHxbx8Hk8As0o3ul+53CLbe
	PqciTfVyv6tIXGtsMsb7YOSBxEvsZWsuUs+Vp1tHvdC5W4jMoDXs6sKC9ogMrF4J4ybCdhSkDq44A
	Va/Ukjc26N/A1Q26PJNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go4ZV-0001lP-Ef; Mon, 28 Jan 2019 10:55:21 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go4ZR-0001km-M4
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 10:55:19 +0000
Received: from lupine.hi.pengutronix.de
 ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <p.zabel@pengutronix.de>)
 id 1go4ZJ-0000YF-N7; Mon, 28 Jan 2019 11:55:09 +0100
Message-ID: <1548672908.6421.1.camel@pengutronix.de>
Subject: Re: [PATCH v5 3/3] reset: imx7: Add support for i.MX8MQ IP block
 variant
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Mon, 28 Jan 2019 11:55:08 +0100
In-Reply-To: <CAHQ1cqFx3b2fTy8YbpwC0fGJYpO4BLO4FW9q-Z2Np1tVktrKpg@mail.gmail.com>
References: <20190122021043.25449-1-andrew.smirnov@gmail.com>
 <20190122021043.25449-4-andrew.smirnov@gmail.com>
 <1548240560.3904.6.camel@pengutronix.de>
 <CAHQ1cqFx3b2fTy8YbpwC0fGJYpO4BLO4FW9q-Z2Np1tVktrKpg@mail.gmail.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_025517_878938_4F50FE3B 
X-CRM114-Status: GOOD (  10.04  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Rob Herring <robh@kernel.org>,
 Richard Zhu <hongxing.zhu@nxp.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "open list:OPEN
 FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, Chris Healy <cphealy@gmail.com>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Andrey,

On Thu, 2019-01-24 at 16:21 -0800, Andrey Smirnov wrote:
> > Thank you, applied all three to reset/next with a small whitespace
> > alignment fix.
> > 
> 
> Thanks again for applying this stuff. If that's not too much to ask,
> would you mind creating an immutable branch, so I could start sending
> patches that depend on "dt-bindings/reset/imx8mq-reset.h" to i.MX tree
> without waiting for it to trickle down? If not, no worries, I'll wait.

Here is an immutable branch containing just the header/dt-binding patch:

  git://git.pengutronix.de/pza/linux reset/imx8mq

regards
Philipp

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
