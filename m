Return-Path: <SRS0=AzG1=P3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F50AC61CE8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 23:57:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EA1D2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 23:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C95qpg59"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EA1D2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DvdFHuhivQAdZzi1B0EvFOB/Ud/LZCEQv1NIVsVm7A8=; b=C95qpg590SdKgO
	CB6lJioelL2XJH68XDoGH7SpQaPId1GIA69oyJS1ZbFXAis8ETvjeR5YiG7oFCFkhx3wZFVCGlHaa
	dNs1PiSC3xQAPh5Z2kONbcWRMntMi0YFxTVIGSJsn00U7FN+b4FYamdHDa1ZsEsCFo9WIjnHzwWri
	VGDsdw6bUEoabHNnPAjv4n8P1lrfLEr9pP+zMup2sLabAMkNqA0H9823Mi1bE0cPOv7pBu2VPAZy6
	3lUj+ehBnc4ZYc50l6ptVzJJcDmEbpS+A3baEJG6EkB5ZW+m9JPCo6NiOwelL0kosZvY9R2VZQaDR
	rk9AHbE6dU5np5fSYCJQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gl0U8-0005Lk-3w; Sat, 19 Jan 2019 23:57:08 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gl0U2-0005KU-3G
 for linux-arm-kernel@lists.infradead.org; Sat, 19 Jan 2019 23:57:05 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01F38A78;
 Sat, 19 Jan 2019 15:57:00 -0800 (PST)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D89B93F6A8;
 Sat, 19 Jan 2019 15:56:55 -0800 (PST)
Date: Sat, 19 Jan 2019 23:56:52 +0000
From: Will Deacon <will.deacon@arm.com>
To: Firoz Khan <firoz.khan@linaro.org>
Subject: Re: [PATCH 0/3] arm64: system call table generation for asm-generic
Message-ID: <20190119235650.GC26876@brain-police>
References: <1546530025-26014-1-git-send-email-firoz.khan@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1546530025-26014-1-git-send-email-firoz.khan@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190119_155704_122395_427B4568 
X-CRM114-Status: GOOD (  13.53  )
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
Cc: Kate Stewart <kstewart@linuxfoundation.org>, linux-arch@vger.kernel.org,
 arnd@arndb.de, y2038@lists.linaro.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 Philippe Ombredanne <pombredanne@nexb.com>, linux-kernel@vger.kernel.org,
 Stefan Agner <stefan@agner.ch>, marcin.juszkiewicz@linaro.org,
 Russell King <rmk+kernel@armlinux.org.uk>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, deepa.kernel@gmail.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 03, 2019 at 09:10:22PM +0530, Firoz Khan wrote:
> This will be an automated scripts to provide easy support
> for add/modify/delete the system call entry by add in 
> respective *.tbl file.
> 
> System call table generation support for asm-generic is
> provide for arm64 architecture which will use the common
> scripts resides in scripts directory and use syscall.tbl
> syscall_arm32.tbl files as inputs. This implementation 
> will replace asm-generic/unistd.h.
> 
> This patch depends on:
>  https://lore.kernel.org/lkml/1546439331-18646-1-git-send-email-firoz.khan@linaro.org/
>  https://lore.kernel.org/lkml/1546520681-24453-1-git-send-email-firoz.khan@linaro.org/

I'm having a hard time understanding what the benefit of this series is,
given that we only support EABI compat tasks. When adding a new compat
system call, you can't just blindly hook it up without checking whether it
needs a wrapper to deal with any type conversion etc, so really we're just
replacing one table with another as far as I can tell. What am I missing?

I also really don't think we should be generating the 32-bit UAPI headers
from the 64-bit compat system call support (if that's what you're trying to
do -- make headers_check fails with your patches applied). arch/arm/ is the
canonical place for the 32-bit UAPI, and we're just implementing that.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
