Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF25C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:56:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED70120883
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kbUV+GgU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED70120883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HUgtnk9tyfwSV+yGa1A4ZUJMnSNUJcjsORXRkWvZ0Q4=; b=kbUV+GgUmiZUkY
	HEJPid7UkNEo7iH4SHXzYJH0xCCc7HNriuD4/s7E4uW4nd76yV1HlCOC4OrsAYFuoUEh9dqCM/ET5
	G5pSG8O6W0cRaeaDbPPYos4Xc9WpluirBvLyALqWJkMnSCK3BRHnbag9wtonCLFyBQ2VWR7C24iw3
	7c+VjBb3Pnsukl3lp4POQAfqDSG1UJTSN39o3jms+KrUdEwNnyBtxYrxkgBC//zZQt3hwf0lpZ4FG
	ip6FgdnEKQ2lbeUHxRRy7pZAQ4q0WoDgwmREM3JxfJ8K88oEJcBmJzfKxggNGP5KBlRdzPFiRnuaq
	jmR1E58tbtxNAJOHbxsw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggufY-0002wf-MI; Tue, 08 Jan 2019 16:56:00 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggufW-0002vw-9G
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 16:55:59 +0000
Received: from lupine.hi.pengutronix.de
 ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <p.zabel@pengutronix.de>)
 id 1ggufT-0002Pc-3V; Tue, 08 Jan 2019 17:55:55 +0100
Message-ID: <1546966555.5406.13.camel@pengutronix.de>
Subject: Re: Need patch dbb3da346e807 in v5.0 kernel
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Dinh Nguyen <dinguyen@kernel.org>
Date: Tue, 08 Jan 2019 17:55:55 +0100
In-Reply-To: <21ba045f-14e9-713f-6690-3e9aa9d332c2@kernel.org>
References: <21ba045f-14e9-713f-6690-3e9aa9d332c2@kernel.org>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_085558_477675_501347AB 
X-CRM114-Status: GOOD (  11.12  )
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
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Dinh,

On Tue, 2019-01-08 at 07:51 -0600, Dinh Nguyen wrote:
> Hi Philipp,
> 
> I was wondering if you can deliver this patch to the v5.0 kernel?

sorry I missed the pull request, I'll ask.

> dbb3da346e807 reset: socfpga: add an early reset driver for SoCFPGA

I assume what you need is not this old version, but b3ca9888f35f
(the one with the "altr,stratix10-rst-mgr" compatible)?

> I was planning on the above patch landing in v5.0, so I had already
> delivered my patch that made the DTS change. Without the above patch,
> the Stratix10 platform cannot completely boot.
> 
> Thanks,
> Dinh

regards
Philipp

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
