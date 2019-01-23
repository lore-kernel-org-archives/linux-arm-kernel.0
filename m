Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184B2C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:52:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5E2020861
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ipkkYV0F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5E2020861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7IByPstokKvJau6CtnitjVV5WBLh+CZJUoFvVEfI4SY=; b=ipkkYV0FVkEO4M
	26m/DwB8NoK75uAw9oW5sRz2ARFxXjqaRY70577ij3SVA0Rh+WGMBZs4lcUJipE1i0V2SvSeBDOE2
	chUwMmdB+JxKJ9Y+vcJ2BE2NFH9qTXbUfE+t/FX3Y+net+8PfHbjax5bDzyAW6wzTFAZEMiYxXIsR
	bGCznXJKaRwQcXPYgvYjJoZ1GXzF1u0LHKlgDq52ibXt/gvDQjwCw49TqR+sx+5HoltS77bFOXen6
	QvGQ2+Ym7HgDNqulveO5FBmMy/lJV8SnCkLoPvjwKsTCk7QoUgynvXAmFJozdPl/0u4J+yzqIgtbJ
	D4Rq7rjINrwBAeOBkiqQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmG8t-000291-Il; Wed, 23 Jan 2019 10:52:23 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmG8r-00028X-0a
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 10:52:22 +0000
Received: from lupine.hi.pengutronix.de
 ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <p.zabel@pengutronix.de>)
 id 1gmG8l-0001Ie-Nw; Wed, 23 Jan 2019 11:52:15 +0100
Message-ID: <1548240735.3904.8.camel@pengutronix.de>
Subject: Re: [PATCH v4 2/3] dt-bindings: reset: imx7: Document usage on
 i.MX8MQ SoCs
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Wed, 23 Jan 2019 11:52:15 +0100
In-Reply-To: <CAHQ1cqG+3K+SKptZJ-FQ6xAa+2LMs_W24TEgqyV+9kR_iAz+cg@mail.gmail.com>
References: <20181220010700.8598-1-andrew.smirnov@gmail.com>
 <20181220010700.8598-3-andrew.smirnov@gmail.com>
 <1547743553.4009.16.camel@pengutronix.de>
 <CAHQ1cqG+3K+SKptZJ-FQ6xAa+2LMs_W24TEgqyV+9kR_iAz+cg@mail.gmail.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_025221_216270_D61B83A0 
X-CRM114-Status: GOOD (  13.86  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, Chris Healy <cphealy@gmail.com>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 2019-01-17 at 14:38 -0800, Andrey Smirnov wrote:
[...]
> > To be honest, I don't like these two, I'm not convinced anymore that
> > they actually qualify as reset signals. To me it looks like this is
> > something that the PCIe glue code should handle via syscon like i.MX6.
> > Leonard, Lucas, what do you think?
> 
> OK, one thing to keep in mind about this is that those bits are
> already exposed for i.MX7D and I think (correct me if I am wrong)
> there's no going back there.

That's not a reason to repeat the same mistake for i.MX8QM, but at the
moment I'm still trying to figure out if it actually was a mistake.

> PCIe driver already has the code to use
> those on i.MX7D and, due to high degree of similarity, i.MX8MQ
> actually re-uses the same codepath (at least for
> IMX8MQ_RESET_PCIE_CTRL_APPS_EN).

We can always switch to i.MX6-like direct syscon/GPR manipulation and
just drop the resets from DT.
Since if this is done, it should be done for i.MX7 as well, I see no
reason for this issue to hold up your i.MX8M changes.

regards
Philipp

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
