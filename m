Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EFCC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:14:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3681721850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ED7DzTsT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3681721850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rB7dNr4lo3iSo6GTSR1U/ZzmY8pGzHNgP/PAZvbsQ2k=; b=ED7DzTsT5w3A4z
	UzHXym7YiyxDlipX/XHWw3cNLi+cRS4eRTwg8zJQEy3/2dSm3Rt9HE6qQIrHVaqJpgjttpNmXPi17
	o53Sa6BCuuCjp7dIPpnxXcNZhI9NOSjyNlYmtNzRbxpS9bDFWzBnUL2281YQ/5WysDNkBO7x7ugrm
	VoWHCrQ6xY7yQtaTjTThZ+xggN6JCzo3t1TxrJOWcmtvHNWwqeCbZdQeGNdcPjpHxLeZ3LN96HRld
	8xb7aNygqtYDvl+vl09zV4wnYMu/uVCWMLJu+/cieKyVJNwubFtAAq08q/SL1ql0RiAUoT2jaCFZy
	VApbVvG6m3xBQ/mMiJ5w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZEGa-0003EP-Hs; Tue, 18 Dec 2018 12:14:28 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZEGX-0003DQ-IN
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 12:14:27 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E1C980D;
 Tue, 18 Dec 2018 04:14:11 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 943A33F575;
 Tue, 18 Dec 2018 04:14:09 -0800 (PST)
Date: Tue, 18 Dec 2018 12:14:03 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 3/3] arm64/sve: Disentangle <uapi/asm/ptrace.h> from
 <uapi/asm/sigcontext.h>
Message-ID: <20181218121307.GA22067@e103592.cambridge.arm.com>
References: <1544556407-19897-4-git-send-email-Dave.Martin@arm.com>
 <201812151729.IIgleZIH%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201812151729.IIgleZIH%fengguang.wu@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_041425_611313_7BBF50B1 
X-CRM114-Status: GOOD (  21.28  )
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
Cc: Szabolcs Nagy <szabolcs.nagy@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, kbuild-all@01.org,
 Alan Hayward <alan.hayward@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Dec 15, 2018 at 05:20:29PM +0800, kbuild test robot wrote:
> Hi Dave,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on arm64/for-next/core]
> [also build test WARNING on v4.20-rc6 next-20181214]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Dave-Martin/arm64-sve-UAPI-Disentangle-ptrace-h-from-sigcontext-h/20181214-225154
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
> config: arm64-allmodconfig (attached as .config)
> compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=arm64 
> 
> All warnings (new ones prefixed by >>):
> 
> >> ./usr/include/asm/sve_context.h:30: found __[us]{8,16,32,64} type without #include <linux/types.h>

Since the new header is not meant to be included directly (and has a
guard to that effect), we don't strictly need to do anything here.

The way to include <asm/sve_context.h> in userspace is via
<asm/sigcontext.h> or <asm/ptrace.h>, both of which include
<linux/types.h> first.


Ironically, the type casts in sve_context.h that necessitate this
#include are probably not needed either.  I misunderstood the C
standard as indicating that if vq is a 16-bit type (which is the case
in some places) then the result of multiplying it by something may be
truncated to 16 bits.  This is not the case: the operands of * are
promoted at least to int first, and int is large enough to hold the
result of these multiplication for all valid vq values.

Removing the cast causes some otherwise __u32 expressions to become
ints (albeit with the same numeric value).

This affects semantics and code generation, so it's probably safest
not to touch these casts now given that they have already been exposed
as UAPI.

We should probably add the #include for cleanliness, but nothing should
break if we don't.

Cheers
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
