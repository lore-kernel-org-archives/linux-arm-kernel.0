Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B83C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:06:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6F6920844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DAULb6HN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6F6920844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7zWOR83UHuAozc2g125zwPEG2TVRL+ttGm/yDsl935c=; b=DAULb6HNvnJYEr
	9R6HhR7evAoc2/I1brs1KGRPR1rfgktPfVIudFu+qO2rPQeIPKeUkwgq/NpHcEsiDNW2gdlX3ZxD2
	xJzA6OqXHgUVMt6tKMStCovFmHp9DeEe5RX+g+WOTFUaN261KZd3WeMEpBKyNU8+HB04LnTqLO+U8
	rAAzoK9hEePvG40jy6M4AzYRMZ+u2yPzdBWK/F3fdzLas52g2ith6/tTySVhfXrIZT0gu97ibiszb
	MSWhGiyUADwtTtq7XfD2xflDrMn52yGw2XgAfOpU04qChxQzDFY+PHl6KYlFnF9WHcNAxLH5zgDuw
	fYh7eodHAHJ3WtKf3Fbw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt9Pu-0004BY-T2; Mon, 11 Feb 2019 11:06:26 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt9Pn-00043i-7V
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 11:06:23 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4208AA78;
 Mon, 11 Feb 2019 03:06:18 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B64783F557;
 Mon, 11 Feb 2019 03:06:15 -0800 (PST)
Date: Mon, 11 Feb 2019 11:06:13 +0000
From: Will Deacon <will.deacon@arm.com>
To: Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] arm64: use memblocks_present
Message-ID: <20190211110613.GC30880@fuggles.cambridge.arm.com>
References: <20190210093738.30923-1-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190210093738.30923-1-peng.fan@nxp.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_030619_538465_4C4846B8 
X-CRM114-Status: GOOD (  12.50  )
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
Cc: "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
 "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stefan@agner.ch" <stefan@agner.ch>,
 "logang@deltatee.com" <logang@deltatee.com>,
 "rppt@linux.vnet.ibm.com" <rppt@linux.vnet.ibm.com>,
 "james.morse@arm.com" <james.morse@arm.com>,
 "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
 "van.freenix@gmail.com" <van.freenix@gmail.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "ghackmann@android.com" <ghackmann@android.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Feb 10, 2019 at 09:28:43AM +0000, Peng Fan wrote:
> arm64_memory_present is doing same thing as memblocks_present, so
> let's use common code memblocks_present instead of platform
> specific arm64_memory_present.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/mm/init.c | 20 +-------------------
>  1 file changed, 1 insertion(+), 19 deletions(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Catalin -- can you pick this one up, please?

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
