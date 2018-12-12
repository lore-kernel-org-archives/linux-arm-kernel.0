Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE8DC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 19:35:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79B942086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 19:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HbgMWgSo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79B942086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CqzKPf1iZn4lndhOQFUCkuQHlBS6HPyk3ughUDKHfdI=; b=HbgMWgSoaUQlRr
	13+5CQf0IZBFyBF+kpl54zL4S+QsY4S2EcXQXkXYY7ZE/Edc4Vy5w/KgZvShDyAzejimb12EEbaN9
	2qs1wiAJsz5sl6LbHSDhP7Kqq7zr+d6vz2WJ5yVmhiWZWxj5OGULv9Vq76/IIYQARzb0NcLIwFWd9
	2IWxQdP9YJ0je4w4+J3dU/7Pq6mWu4pHm+B/TbRMcYhc+tlc5MmwYXlwexmj/qwu3W5UIDoxLpx4O
	0T1Gapow1Ln8HMohV0JRCuKmlTEgyeV5+Hc11Z2doacO5N+0J1syiBGHcrTpNnODcBhOK87f0QJ4i
	Iml/10JC5fdi4BI+ZQwQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXAIC-0007aY-0t; Wed, 12 Dec 2018 19:35:36 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXAI8-0007Zu-UM
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 19:35:34 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F7C0A78;
 Wed, 12 Dec 2018 11:35:21 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2E7BE3F59C;
 Wed, 12 Dec 2018 11:35:21 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id AC0201AE0BDC; Wed, 12 Dec 2018 19:35:44 +0000 (GMT)
Date: Wed, 12 Dec 2018 19:35:44 +0000
From: Will Deacon <will.deacon@arm.com>
To: Kristina Martsenko <kristina.martsenko@arm.com>
Subject: Re: [PATCH v6 00/13] ARMv8.3 pointer authentication userspace support
Message-ID: <20181212193544.GB22013@edgewater-inn.cambridge.arm.com>
References: <20181207183931.4285-1-kristina.martsenko@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181207183931.4285-1-kristina.martsenko@arm.com>
User-Agent: Mutt/1.11.1+30 (d10eec459b35) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_113532_995293_5C745251 
X-CRM114-Status: GOOD (  12.45  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Jones <drjones@redhat.com>,
 linux-kernel@vger.kernel.org, Jacob Bramley <jacob.bramley@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Adam Wallis <awallis@codeaurora.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christoffer Dall <christoffer.dall@arm.com>, kvmarm@lists.cs.columbia.edu,
 Cyrill Gorcunov <gorcunov@gmail.com>,
 Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
 Amit Kachhap <amit.kachhap@arm.com>, Dave P Martin <dave.martin@arm.com>,
 linux-arm-kernel@lists.infradead.org, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Kristina,

On Fri, Dec 07, 2018 at 06:39:18PM +0000, Kristina Martsenko wrote:
> This series adds support for the ARMv8.3 pointer authentication extension,
> enabling userspace return address protection with GCC 7 and above.

I've pushed this out to for-next/ptr-auth with the following changes:

  * Rebased onto for-next/core
  * Dropped the GET/SET ptrace requests for now, due to fragile regset usage
  * Moved the user key state from thread_info to thread_struct
  * Removed use of VA_BITS for the PAC mask (doesn't work with 52-bit user VAs)
  * Added a patch to use _BITUL for the bit definitions in sysreg.h
  * Tidied up the HWCAP generation [need to run this past Suzuki]
  * Reduced the number of CPU caps from 6 to 4 [also need to run past Suzuki]
  * Added Reviewed-by tags

I've not merged it into for-next/core yet, because it could use some testing
and review first.

Cheers,

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
