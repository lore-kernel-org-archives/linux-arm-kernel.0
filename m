Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84876C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:30:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D68B2186A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RdddVm74";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kf38ndFX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D68B2186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:References:To:Message-ID:From:
	In-Reply-To:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qGtWKAg2Yf4kBPVuRUja5E90a4G4NiwKnA5XZWfBZ/o=; b=RdddVm74UVcjkl
	8qfXyqMWcc0Tc7I9SrIFzqwndMcfkOHOOc5wwTmN2mNS9Qzyddq679HAsy7TMcCijDtotHP+GaTqD
	FLo/TRStkSA8XfCxj5dLrD/JauzoiAJVBvhXmcMQfR7DypYQttZwvJV9ryXWP5Tt6cHDiQiNOaLLD
	iCJwTmUS5ObrcXfHVqPGozq0WjIf4N0jBYZQ/RuPeL4MAj8hv/TQloy7Ox3v5BKb/iyFQEuqziraF
	8FrJ+isvj4emWuFuPA5FEXX1FGpjHCEXX/ffkuK9OTbT0+2h4yMHcI+R5fpH7L7O2h1x5z7bj3mQZ
	+gscP2/nYKpH2jdvGhDA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grR1k-0001zS-Mk; Wed, 06 Feb 2019 17:30:24 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grR1i-0001xp-CS
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 17:30:23 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AF14D2186A;
 Wed,  6 Feb 2019 17:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549474220;
 bh=J6TvIDHKHiGONHklHeUKYdjl4aG1RkLk9WSFNN4J33Y=;
 h=Cc:Subject:In-Reply-To:From:To:References:Date:From;
 b=Kf38ndFXwnvin+1FL2g162dqS9vpT4h2n5jY0srNq8zDFrTFPppfgZP8jOFnj3ruu
 AsoH7GE+CyuV407FuXIVkBkr79Sbne2Wtp/hCDHTVLxIowZGjQYMBD/kmD4T8R7duY
 4K1i0evQTncDSgdCkSE7CN4wxmZBKeoTnwKMXwpw=
MIME-Version: 1.0
User-Agent: alot/0.8
Subject: Re: [PATCH] clk: imx8mq: Fix the CLKO2 source select list
In-Reply-To: <CAOMZO5BYr_JXZ-ibb5JBvVtF0=Y-cz+qNsPHd0i-kkrC9Ok4ag@mail.gmail.com>
From: Stephen Boyd <sboyd@kernel.org>
Message-ID: <154947421987.74891.17150055410578722741@swboyd.mtv.corp.google.com>
To: Fabio Estevam <festevam@gmail.com>
References: <20190130192102.7065-1-festevam@gmail.com>
 <154940574088.169292.15304825462770873584@swboyd.mtv.corp.google.com>
 <CAOMZO5BYr_JXZ-ibb5JBvVtF0=Y-cz+qNsPHd0i-kkrC9Ok4ag@mail.gmail.com>
Date: Wed, 06 Feb 2019 09:30:19 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_093022_440802_B161C71F 
X-CRM114-Status: UNSURE (   8.00  )
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
Cc: NXP Linux Team <linux-imx@nxp.com>, Sascha Hauer <kernel@pengutronix.de>,
 Rogerio Pimentel <rogerio.silva@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 linux-clk <linux-clk@vger.kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Fabio Estevam (2019-02-05 14:35:49)
> Hi Stephen,
> 
> On Tue, Feb 5, 2019 at 8:29 PM Stephen Boyd <sboyd@kernel.org> wrote:
> 
> > Do I need to fast track this into v5.0 final? Or this is a non-critical
> > fix for something that isn't used right now?
> 
> This is a non-critical fix and it can wait until v5.1.
> 

Alright, thanks!


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
