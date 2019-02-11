Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB48C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:20:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 259012075B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GrkMUWpj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 259012075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r/3nDqtLEOnOyk7NaWzbBVizGNFyOqqQp6dFNsiNnY8=; b=GrkMUWpjDGGkPk
	jDYYhoQZrEnGwyTCmrDJAu4LJCR/4EzzRzWJ/Ub5f4OvYdFeZvC858+ec2WMW4FSR3L/zPZwtPJn8
	MXcDGLKx/N7yKe1JxO5JdMcn8t3NuuMlmevl8lqMIjq023kxXpaPbSD88UYBvQ71dLcg4nKreslhh
	GWxt6Dnu867Pb3QvCnOyP72i/LkCDOrSFEpXVadzXIXpnhQnmvPiU8XquPhuYG4m0qao5GfYU7Une
	NmdhKi6I4VgwVqUxy7fhmQk3Bm9mzs6IBCYdWjuVPpnR8mjo1VO9T2QH5GhXtNepNCuWHi1ISXqu5
	sy5gQH4KJdcWIxg6gFxA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtAZl-0005Fk-H6; Mon, 11 Feb 2019 12:20:41 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtAZi-0005FL-Mv
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 12:20:39 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7F0180D;
 Mon, 11 Feb 2019 04:20:37 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 4B0933F557; Mon, 11 Feb 2019 04:20:35 -0800 (PST)
Date: Mon, 11 Feb 2019 12:20:32 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] arm64: use memblocks_present
Message-ID: <20190211122032.GC165128@arrakis.emea.arm.com>
References: <20190210093738.30923-1-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190210093738.30923-1-peng.fan@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_042038_760113_2F61CA13 
X-CRM114-Status: GOOD (  10.05  )
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
 "logang@deltatee.com" <logang@deltatee.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stefan@agner.ch" <stefan@agner.ch>,
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

I already merged a similar one (see commit
a2c801c53d1682871fba1e037c9d3b0c9fffee8a in -next).

-- 
Catalin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
