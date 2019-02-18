Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76EAC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:52:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 869ED21479
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ORg7qxxS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 869ED21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=82YZ9vKeMgeIo9/s2aDvyb6DOf9SWJQJWGdcgvg0b9I=; b=ORg7qxxSdeYRc1
	W2isTmXPlT9gUmDkt6e/6rWwk5fz2ehmPiPgb1EhkYWcYSB2aAfKhY/mzFuREgorkKh6yV/jbUi/u
	JfqooKBL35mK1cfCnqzHUIq/4/gfaHQyCSeiVyXmHtWK+01p5KsjePxG0ao9oiOzFoU2cpHzQ771v
	8nuo28uYhz9rkYv4sQPY1TfyXw0sijbEsRq+h09htNaA9mZhWTL3I49m5ko802LaB8biG/dv1nbf2
	QVSViXqeMIvn1ol9/819QlnMcoD/6bcRCDCOxjTZrs2cVP4WomYdMkkcGG6t5oqsremwo9RKtFpEx
	Q3QlGHPguWW2IRQ24QyA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvef3-0000v9-Ol; Mon, 18 Feb 2019 08:52:25 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvef0-0000tu-WF
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 08:52:24 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCC69A78;
 Mon, 18 Feb 2019 00:52:22 -0800 (PST)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com
 [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 42A2A3F589;
 Mon, 18 Feb 2019 00:52:21 -0800 (PST)
Date: Mon, 18 Feb 2019 08:52:17 +0000
From: Marc Zyngier <marc.zyngier@arm.com>
To: Andrew Murray <andrew.murray@arm.com>
Subject: Re: [PATCH v2 0/5] KVM: arm/arm64: add support for chained counters
Message-ID: <20190218085217.4c4ff56f@why.wild-wind.fr.eu.org>
In-Reply-To: <1549299218-44714-1-git-send-email-andrew.murray@arm.com>
References: <1549299218-44714-1-git-send-email-andrew.murray@arm.com>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_005223_036867_B5782004 
X-CRM114-Status: GOOD (  17.17  )
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
Cc: Julien Thierry <julien.thierry@arm.com>, suzuki.poulose@arm.com,
 Christoffer Dall <christoffer.dall@arm.com>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 4 Feb 2019 16:53:33 +0000
Andrew Murray <andrew.murray@arm.com> wrote:

> ARMv8 provides support for chained PMU counters, where an event type
> of 0x001E is set for odd-numbered counters, the event counter will
> increment by one for each overflow of the preceding even-numbered
> counter. Let's emulate this in KVM by creating a 64 bit perf counter
> when a user chains two emulated counters together.
> 
> Testing has been performed by hard-coding hwc->sample_period in
> __hw_perf_event_init (arm_pmu.c) to a small value, this results in
> regular overflows (for non sampling events). The following command
> was then used to measure chained and non-chained instruction cycles:
> 
> perf stat -e armv8_pmuv3/long=1,inst_retired/u \
>           -e armv8_pmuv3/long=0,inst_retired/u dd if=/dev/zero bs=1M \
> 	  count=10 | gzip > /dev/null
> 
> The reported values were identical (and for non-chained was in the
> same ballpark when running on a kernel without this patchset). Debug
> was added to verify that the guest received overflow interrupts for
> the chain counter.

Hi Andrew,

We're getting quite close to the merge window, and I need to wrap up the
pull request pretty soon. If you want this to make it into 5.1, you'll
have to respin it pretty quickly (right now, basically...), addressing
the comments Suzuki and Julien raised.

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
