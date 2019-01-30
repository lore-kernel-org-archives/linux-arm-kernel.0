Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED663C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:22:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C02F52087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l639eZbG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C02F52087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2C8p55F/m72vWltAmXFfpwJjhPxBUKj9H6B7hBXZEd4=; b=l639eZbGS8+Igt
	VNsu6wJ1O39rPONpeHeYVkwnIOWCdurs5LoONzv3+TGRcC/oSR/7s2qjqmP6SKdtJRgts/zaEfBuJ
	XCpqkzDJKBpwFG1NPrOznfrcVQcEx0cuThCeNEaUng2U7RdFFFScxI2HDaIDOU3MS5brzPLtNYCBC
	09ffsiZZw1NmSL/KxXq7lZ0wzZr9UuzF1tkHc3uTqwSiYYkqrqkCy4webRnc6NQass+4F+RRTrDB1
	8syZ7/cTkoRMDqCNdaAM3C+cUvCemECMLyRzYvbt37wavT1BSs5CA+Q/2Gr931PepC/CEjevW8ZZv
	OwykPaqhqLrC2xkU9dfw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gouVH-0001qV-4x; Wed, 30 Jan 2019 18:22:27 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gouUr-0001YR-Il
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 18:22:09 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29B0380D;
 Wed, 30 Jan 2019 10:22:01 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A6743F557;
 Wed, 30 Jan 2019 10:21:59 -0800 (PST)
Date: Wed, 30 Jan 2019 18:21:57 +0000
From: Will Deacon <will.deacon@arm.com>
To: Jann Horn <jannh@google.com>
Subject: Re: ARM64 suggestion: reduce the compat address limit (currently
 0x100000000)?
Message-ID: <20190130182157.GP18558@fuggles.cambridge.arm.com>
References: <CAG48ez0QRmU9fGV3x7nceGqBGADNTb66MnG4PW_xu+xnGUqg=g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAG48ez0QRmU9fGV3x7nceGqBGADNTb66MnG4PW_xu+xnGUqg=g@mail.gmail.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_102202_235284_1E960F3E 
X-CRM114-Status: GOOD (  15.78  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 kernel list <linux-kernel@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Jann,

On Wed, Jan 30, 2019 at 05:32:00PM +0100, Jann Horn wrote:
> At the moment, compat tasks running on ARM64 can allocate memory up to
> 0x100000000 (TASK_SIZE_32). Testing on an Android device (with an
> admittedly somewhat old kernel):

[...]

> ffff1000-100000000 rw-p 00000000 00:00 0
> 
> This means that mmap() allocations do not adhere to section 6.5.8 of
> C99 ("If the
> expression P points to an element of an array object and the
> expression Q points to the
> last element of the same array object, the pointer expression Q+1
> compares greater than
> P.") if you treat mmap() allocations as returning an array.

Oh, good point.

> In practice, I've also seen code that does things like computing a
> pointer that is out of bounds by a few bytes and then comparing it
> against the end of the array; while this is UB according to C99, it
> probably makes sense to try to avoid breaking such code.

Agreed, and since the current behaviour isn't something you can portably
rely on anyway, I think we're ok to change it.

> X86-64's compat code uses the limit 0xFFFFe000 (IA32_PAGE_OFFSET),
> which I think makes more sense. Would it make sense to do something
> like the following (untested)?

Can't we just go with 0x100000000 - PAGE_SIZE instead?

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
