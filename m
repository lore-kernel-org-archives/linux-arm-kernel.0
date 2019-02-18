Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97108C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:10:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F6D92077B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UMYErizT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F6D92077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gVF57woMm7tvcRIJLR75jMORJWH4hEBxg88qvWmitg4=; b=UMYErizT8puSAl
	A63diIjJwo9+guISXAseHEncLUruuwGZJflxySBWRGdg80HzmqCr3I+PJvHQv7g1lnYExTA3ECRfv
	4/XV7+YNCuSZ6Wsp4dBkxfBsrlzlHCkn46gZ3FF8D0+XiVegFEKctnFwm5hS9+ZQs6ZE4OiB/3xWl
	7IJUz9gy5HrvYRQ5WavBokuk2W3Mjj+qevQ/9/u6NlQ8MYwGygTMA/KzKOFzyp/xAx7H5l0DyUrFO
	oSnEP6NIhqzx9hMMedV8NCwcSbbyHFf2gQo8avS7O2CvBDVArHbEN7QGVZk0+7QXSducrGkiawEyd
	K+2SJaL0ojTKB5XTyTmg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvhl1-0001Mo-7i; Mon, 18 Feb 2019 12:10:47 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvhkp-00015m-7M
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 12:10:39 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C580780D;
 Mon, 18 Feb 2019 04:10:28 -0800 (PST)
Received: from localhost (unknown [10.37.6.16])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3644D3F720;
 Mon, 18 Feb 2019 04:10:28 -0800 (PST)
Date: Mon, 18 Feb 2019 12:10:26 +0000
From: Andrew Murray <andrew.murray@arm.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v2 0/5] KVM: arm/arm64: add support for chained counters
Message-ID: <20190218121026.GI54124@e119886-lin.cambridge.arm.com>
References: <1549299218-44714-1-git-send-email-andrew.murray@arm.com>
 <20190218085217.4c4ff56f@why.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190218085217.4c4ff56f@why.wild-wind.fr.eu.org>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_041035_566231_38470E5E 
X-CRM114-Status: GOOD (  20.90  )
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

On Mon, Feb 18, 2019 at 08:52:17AM +0000, Marc Zyngier wrote:
> On Mon, 4 Feb 2019 16:53:33 +0000
> Andrew Murray <andrew.murray@arm.com> wrote:
> 
> > ARMv8 provides support for chained PMU counters, where an event type
> > of 0x001E is set for odd-numbered counters, the event counter will
> > increment by one for each overflow of the preceding even-numbered
> > counter. Let's emulate this in KVM by creating a 64 bit perf counter
> > when a user chains two emulated counters together.
> > 
> > Testing has been performed by hard-coding hwc->sample_period in
> > __hw_perf_event_init (arm_pmu.c) to a small value, this results in
> > regular overflows (for non sampling events). The following command
> > was then used to measure chained and non-chained instruction cycles:
> > 
> > perf stat -e armv8_pmuv3/long=1,inst_retired/u \
> >           -e armv8_pmuv3/long=0,inst_retired/u dd if=/dev/zero bs=1M \
> > 	  count=10 | gzip > /dev/null
> > 
> > The reported values were identical (and for non-chained was in the
> > same ballpark when running on a kernel without this patchset). Debug
> > was added to verify that the guest received overflow interrupts for
> > the chain counter.
> 
> Hi Andrew,
> 
> We're getting quite close to the merge window, and I need to wrap up the
> pull request pretty soon. If you want this to make it into 5.1, you'll
> have to respin it pretty quickly (right now, basically...), addressing
> the comments Suzuki and Julien raised.
> 

Thanks for the prompt, I'll send this out very shortly.

Thanks,

Andrew Murray

> Thanks,
> 
> 	M.
> -- 
> Without deviation from the norm, progress is not possible.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
