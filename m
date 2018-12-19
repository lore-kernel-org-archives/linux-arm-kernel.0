Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD73C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:23:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6214220874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U5MzZGGa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6214220874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XF19MGAnvnzn/5yXzZxYelCEr4BLvLsAnkY3H/6qQyg=; b=U5MzZGGamh6Ldq
	ctYTe0oKbgJcPbZtXgTwP7wlEdpVqfcnxfYVs7275BAzjXgGSqfEQq0+NXZhj6TX8mQUpw+rm067h
	6n6gI2MrBniM5Yg3DTpLi09MX+1LSb/Fsl1rw7FVSdkbP7Ey54a7gEKccANGNJW5oHWFhKPwjIG/r
	1yU27l9sE1IEfWLEyEVIk2zDJYg7Z8+urs0yLXvgSVfIMOh+ct3mk4+mhxamqXD1P4jvv8PN+6SED
	tUhQD9k1k8BN6j6wBAloFS034ZIdrVax5SiQo+LRQFnhwJsqXZNnBmgBNLq5PRSv+i91KKOEUMN9z
	XJaorz4zn0EnJw2yBQKw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZdhO-0005aM-Ky; Wed, 19 Dec 2018 15:23:50 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZdhL-0005ZF-5G
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 15:23:48 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A8FFEBD;
 Wed, 19 Dec 2018 07:23:36 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC5E83F675;
 Wed, 19 Dec 2018 07:23:34 -0800 (PST)
Date: Wed, 19 Dec 2018 15:23:32 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Subject: Re: [PATCH 3/3] arm64/sve: Disentangle <uapi/asm/ptrace.h> from
 <uapi/asm/sigcontext.h>
Message-ID: <20181219152332.GC22067@e103592.cambridge.arm.com>
References: <1544556407-19897-4-git-send-email-Dave.Martin@arm.com>
 <201812151729.IIgleZIH%fengguang.wu@intel.com>
 <20181218121307.GA22067@e103592.cambridge.arm.com>
 <9c409567-1beb-e0cb-3efd-589a869ac7c8@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9c409567-1beb-e0cb-3efd-589a869ac7c8@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_072347_204290_A1ADA6FC 
X-CRM114-Status: GOOD (  19.07  )
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
Cc: kbuild test robot <lkp@intel.com>,
 Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kbuild-all@01.org" <kbuild-all@01.org>, Alan Hayward <Alan.Hayward@arm.com>,
 nd <nd@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 19, 2018 at 03:11:52PM +0000, Szabolcs Nagy wrote:
> On 18/12/2018 12:14, Dave Martin wrote:
> > On Sat, Dec 15, 2018 at 05:20:29PM +0800, kbuild test robot wrote:

[...]

> >>>> ./usr/include/asm/sve_context.h:30: found __[us]{8,16,32,64} type without #include <linux/types.h>
> > 
> > Since the new header is not meant to be included directly (and has a
> > guard to that effect), we don't strictly need to do anything here.
> > 
> > The way to include <asm/sve_context.h> in userspace is via
> > <asm/sigcontext.h> or <asm/ptrace.h>, both of which include
> > <linux/types.h> first.
> > 
> 
> i think there is no need to explicitly prevent the inclusion of
> the header.
> 
> it is enough to have a comment that it's not supposed to be
> included by user code (so the header can be later refactored).
> 
> and then such automated header checks (or whatever other hacks
> ppl do temporarily) can continue to work.

The guard is in linux-next now AFAIK.

Are you saying that it's likely to break something and needs to be
removed, or it is unnecessary but harmless?

Cheers
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
