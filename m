Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF38CC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:52:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A091B20879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kbJ50nZM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A091B20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9Axsjnf7DEhgYWO0gVdLldqwP5IAYzVpmNOkNUc66MI=; b=kbJ50nZMZeaXMC
	+/OqmZLe2lrbZ81WfO++dr5vPUttz9SJEElg4EFqfMPuyDjfmPZyZyryDaIstP5d1cVou+2cnljdc
	mDiQRwd9g5tBMT6NOuSteduQMFCgvBF6oEcEN7EJHumnvBnSwHuAR5oX2gkyu4wMT/oDREkiskLWV
	O4sXyd6ySccGan6imON6gAHfm4HTnig7Iful3UPkGR2sxf51upW90tp3StN/rXkba+U0yyjy0VxLG
	G+r7telXrvQrwJf8tJuWTxD+LUNfd3xkAzLVXfdScJpY2qygECb8KYeCi6hhhruIrBX4BbseFHAmu
	HwRlkBfW4db6iAWUv1Bg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXk8l-0000qJ-3C; Fri, 14 Dec 2018 09:52:15 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXk8h-0000pT-ND
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 09:52:12 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4095380D;
 Fri, 14 Dec 2018 01:51:57 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 111AE3F614;
 Fri, 14 Dec 2018 01:51:57 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id 2F47B1AE0DFC; Fri, 14 Dec 2018 09:51:56 +0000 (GMT)
Date: Fri, 14 Dec 2018 09:51:56 +0000
From: Will Deacon <will.deacon@arm.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] arm64: replace arm64-obj-* in Makefile with obj-*
Message-ID: <20181214095155.GA1872@edgewater-inn.cambridge.arm.com>
References: <1544760112-5378-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1544760112-5378-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.11.1+30 (d10eec459b35) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_015211_759852_79B7BAF3 
X-CRM114-Status: GOOD (  14.17  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Masahiro,

On Fri, Dec 14, 2018 at 01:01:52PM +0900, Masahiro Yamada wrote:
> Use the standard obj-$(CONFIG_...) syntex. The behavior is still the
> same.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  arch/arm64/kernel/Makefile | 59 +++++++++++++++++++++++-----------------------
>  1 file changed, 29 insertions(+), 30 deletions(-)

I'm fine with this patch, but I think I'd prefer to apply it at -rc1 so
we don't end up with lots of silly conflicts in the Makefile for any new
files added during the merge window.

Is that ok with you?

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
