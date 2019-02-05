Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15ABC282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:33:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A4F920811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dIPowM5k";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDWQic2b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A4F920811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:In-Reply-To:To:References:
	Message-ID:From:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=c5xjir0Cq7pjH+9205k1Mv6qZFxvvK/sO79kQsxdWew=; b=dIPowM5koJVM2X
	EaTABWjkScXCWLA8OpXKO4Cqtqr8o9upInr4CmEzq6nuiWb0ufD59QJFF+mZfz606SQv58EGC6blc
	MA8Civ05vQb21gIIsWpHUExhh9+kAdJxBfhjfVKzRcJsmiqCxku5KAjNucCq+dXIFQBSSja9FG/Ka
	rr9TfHFXXK8/V/VxT7+a5zeNVlIiITg9cfdR9VjmhaM0j6BzlsfYyheroI1/ZEeY4cru/NHBx3NvT
	n09WgwpyMl6VC1816oHfCzcVFXD6Bd+BLnjUoCh3TnJols0xWMyHpCN0BKMkrm1Qmzu07M1bRRHPy
	LjtbYFA5mv02JLW94rhw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr9Hv-0002Sf-OP; Tue, 05 Feb 2019 22:33:55 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr9Ht-0002SB-8p
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 22:33:54 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9C6742077B;
 Tue,  5 Feb 2019 22:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549406032;
 bh=qzergC6+hYLWgiaoMk/LQ3M8CDrLgHgExkuBh5fxX2k=;
 h=Subject:From:Cc:References:To:In-Reply-To:Date:From;
 b=QDWQic2bHPzIQIfMXTxmBFWKTewTDVwzKAEUgt8KTyYNc74j2bGxn/E6YW1rG/o6g
 svCJXmbqij3i4bSqA33tMBAuHdpUxv4boJUw+BVBZrwAN/Dyp/uGhEZd6msTTCFm+E
 V6jXNnxCIyFV73/F9njAQCAnc4XivJFxqXnx6L14=
MIME-Version: 1.0
Subject: Re: [PATCH] clk: imx8mq: Add missing M4 clocks
From: Stephen Boyd <sboyd@kernel.org>
Message-ID: <154940603191.169292.5891261705001667667@swboyd.mtv.corp.google.com>
References: <20190130201725.18961-1-ccaione@baylibre.com>
 <CAOMZO5AU8y1mf1DCMcJ6Y_AN_rP47jx1uVhj9pLRtgL6P70ksw@mail.gmail.com>
 <0590fb7b-4934-9ef8-dce1-6fd251864522@baylibre.com>
User-Agent: alot/0.8
To: Carlo Caione <ccaione@baylibre.com>, Fabio Estevam <festevam@gmail.com>
In-Reply-To: <0590fb7b-4934-9ef8-dce1-6fd251864522@baylibre.com>
Date: Tue, 05 Feb 2019 14:33:51 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_143353_338208_12D053A7 
X-CRM114-Status: UNSURE (   9.55  )
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
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
 linux-clk <linux-clk@vger.kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Carlo Caione (2019-01-31 01:09:52)
> On 30/01/2019 22:46, Fabio Estevam wrote:
> > On Wed, Jan 30, 2019 at 6:17 PM Carlo Caione <ccaione@baylibre.com> wrote:
> >>
> >> The clocks list is missing the clocks for the the M4 core.
> > 
> > There is a repeated "the" in this phrase.
> 
> Ouch! Can I count on the maintainer to fix this while merging? ;)
> 

If I remember....

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
