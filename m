Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36683C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:06:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED66820851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="N4WrAETH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED66820851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=k/CI80J6q9Bv1YaqMuefzdtXSpP6LCIUwGdfjXASrhY=; b=N4WrAETHo46lvd
	5UZTCm3CCifLJd6MjZmt3oabDCl83r85olhxMFCB2hAAPvZt/aCCEwWXgwXKGPbos0L9LyVfVmDxx
	23d+X9/FOubTwFb5ucGDEeNyOUaJz33Oe2oFdEpwB8zvIJNSbf9D1xluNItx5s70XjQwzrpeAKE1L
	nVNnmqw3kqvn0L7sjRg/ovDCw0Fj6pHq3dJC62qw9FO8VY5J5CE8mnkc1Xd2qfgdY/u1HQBbTYQDD
	NTNPIlipWMEsmRDIp43nDgRC1H8rWDzyPgDUNfpyrlWEJDaG38eWr7GVra39oRfKvIqvurdbLH+Kw
	8VpIvb9ngenT7Ctrl7VA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXURP-0007uI-3y; Thu, 13 Dec 2018 17:06:27 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXUR0-0007m8-HR
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 17:06:04 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 30A008081;
 Thu, 13 Dec 2018 17:05:55 +0000 (UTC)
Date: Thu, 13 Dec 2018 09:05:48 -0800
From: Tony Lindgren <tony@atomide.com>
To: Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH 1/5] ARM: omap2: remove unnecessary boot_lock
Message-ID: <20181213170548.GP6707@atomide.com>
References: <E1gXPaa-00063v-L6@rmk-PC.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1gXPaa-00063v-L6@rmk-PC.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_090602_622349_CCCF2A55 
X-CRM114-Status: UNSURE (   6.76  )
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
Cc: linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

* Russell King <rmk+kernel@armlinux.org.uk> [181213 11:55]:
> The boot_lock is something that was required for ARM development
> platforms to ensure that the delay calibration worked properly.  This
> is not necessary for modern platforms that have better bus bandwidth
> and do not need to calibrate the delay loop for secondary cores.
> Remove the boot_lock entirely.

Yup, you're right, this is unnecessary:

Acked-by: Tony Lindgren <tony@atomide.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
