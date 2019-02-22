Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6BAC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:58:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D81B207E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a6OmDj2Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D81B207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HzNv56zB0g3g4MYMy16d14ZSeILr8Sdkyo+PQxGUfbw=; b=a6OmDj2YNMgLz/
	iRFcwXSVZen+caq65JiiZSH4qVstOgYvKZwLQkMHW/VMyhHKHhdiUWdDlJNwTmlC2lN+OaQxvYCqz
	k7z4lJr1c/C9Nam0mmD26Y9FKOWevx5AjdMwa09w1fTrsQk2ecK2sm8BJtO8vxHl2t20HeZzsPJEc
	EYWzyGd5/u1tMdT7yRkE3sNDME28tdi875l7soFBlQSDZqhIzboU/Xk23bDuP+BVvMK5QjKlOXq5o
	YNpW00ApMh/Wsn4euTg4lG0ZCqcqZxjizP1K9OVsUl4i+PK56FwxuMKdq7Ep8XIix2Ysni8w87gnQ
	jD8JK5M95wQcxB99X9rw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxAPL-0003tM-Jv; Fri, 22 Feb 2019 12:58:27 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxAPD-0003sy-M3
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 12:58:25 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A988EA78;
 Fri, 22 Feb 2019 04:58:18 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 06E623F690;
 Fri, 22 Feb 2019 04:58:15 -0800 (PST)
Date: Fri, 22 Feb 2019 12:58:13 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH v5 01/23] kernel: Standardize vdso_datapage
Message-ID: <20190222125812.GF42419@lakrids.cambridge.arm.com>
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
 <20190222122430.21180-2-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190222122430.21180-2-vincenzo.frascino@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_045824_195109_390ACA1A 
X-CRM114-Status: GOOD (  14.87  )
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
Cc: linux-arch@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>,
 Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>,
 Dmitry Safonov <0x7f454c46@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Collingbourne <pcc@google.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Vincenzo,

On Fri, Feb 22, 2019 at 12:24:08PM +0000, Vincenzo Frascino wrote:
> +#ifdef __KERNEL__

I believe that __KERNEL__ guards haven't been necessary (in non-UAPI
headers) since the UAPI split, and can be removed.

[...]

> +#include <linux/bits.h>
> +#include <linux/types.h>
> +#include <linux/time.h>

Nit: could we please keep these in alphabetical order?

> +/*
> + * There is one vdso_timestamp object in vvar for each vDSO-accelerated
> + * clock_id. For high-resolution clocks, this encodes the time
> + * corresponding to vdso_data.cycle_last. For coarse clocks this encodes
> + * the actual time.
> + *
> + * To be noticed that for highres clocks nsec is left-shifted by
> + * vdso_data.cs[x].shift.

Nit: this would read better as:

	Note that for highres clocks nsec is left-shifted by
	vdso_data.cs[x].shift.

[...]

> +/*
> + * vdso_data will be accessed by 32 and 64 bit code at the same time
> + * so we should be careful before modifying this structure.
> + */

Perhaps:

/*
 * This structure will be accessed by native and compat vDSOs, so we
 * need to ensure the layout is identical for native and compat code.
 */

... which I think is what you're trrying to say?

Thanks,
Mark.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
