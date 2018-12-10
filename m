Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A868C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:52:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D75B20821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UVDrQY7B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D75B20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qbUUMjssWVnfVH6VlSAGbfuKYC2DgjWj7X5VTBRiwCg=; b=UVDrQY7BsRubVC
	VMHfTTRtBXHY1xp8cmjdKE9YW2cwka00r1G6tJPAw28fto6J6jweIGT3xvjaVD+HmgP3ACkxeZe+c
	vEyzbUGs143hHFpXcBDpZhdKLRfhppzoOU0IXSuxpBLcADfEYQpkyrOP5T5HeE0H5ArI8cL+ZF+bb
	U049Vf8ho6gVOREZLZi7D5yxjeFpYWj8IFa7+vXvx5ZsY6EdeaGzs+YWR+FMFYLvnzL1fwmFNsMeS
	RR+gcAG9WbLdg6F+Gw/ZtKoEj/N3YsO6xYGyv4oBiGKytRFtPXJSdFhXVSbTcQhNmGepo6uWsUSGV
	JanDNBCUbkabCez2d9VQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWVLT-0002PM-NV; Mon, 10 Dec 2018 23:52:15 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWVLQ-0002NN-EO
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 23:52:14 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C4CA15AD;
 Mon, 10 Dec 2018 15:52:01 -0800 (PST)
Received: from localhost (unknown [10.37.6.11])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8BC5E3F6A8;
 Mon, 10 Dec 2018 15:52:00 -0800 (PST)
Date: Mon, 10 Dec 2018 23:51:58 +0000
From: Andrew Murray <andrew.murray@arm.com>
To: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v3 00/12] perf/core: Generalise event exclusion checking
Message-ID: <20181210235158.GD13393@e119886-lin.cambridge.arm.com>
References: <1544114849-47266-1-git-send-email-andrew.murray@arm.com>
 <20181207172516.GB2044@edgewater-inn.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181207172516.GB2044@edgewater-inn.cambridge.arm.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_155212_489073_CF9C2014 
X-CRM114-Status: GOOD (  21.89  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Shawn Guo <shawnguo@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
 Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>,
 Matt Turner <mattst88@gmail.com>, suzuki.poulose@arm.com,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Richard Henderson <rth@twiddle.net>, robin.murphy@arm.com,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 07, 2018 at 05:25:17PM +0000, Will Deacon wrote:
> On Thu, Dec 06, 2018 at 04:47:17PM +0000, Andrew Murray wrote:
> > Many PMU drivers do not have the capability to exclude counting events
> > that occur in specific contexts such as idle, kernel, guest, etc. These
> > drivers indicate this by returning an error in their event_init upon
> > testing the events attribute flags.
> > 
> > However this approach requires that each time a new event modifier is
> > added to perf, all the perf drivers need to be modified to indicate that
> > they don't support the attribute. This results in additional boiler-plate
> > code common to many drivers that needs to be maintained. Furthermore the
> > drivers are not consistent with regards to the error value they return
> > when reporting unsupported attributes.
> > 
> > This patchset allow PMU drivers to advertise their inability to exclude
> > based on context via a new capability: PERF_PMU_CAP_NO_EXCLUDE. This
> > allows the perf core to reject requests for exclusion events where there
> > is no support in the PMU.
> > 
> > This is a functional change, in particular:
> > 
> >  - Some drivers will now additionally (but correctly) report unsupported
> >    exclusion flags. It's typical for existing userspace tools such as
> >    perf to handle such errors by retrying the system call without the
> >    unsupported flags.
> > 
> >  - Drivers that do not support any exclusion that previously reported
> >    -EPERM or -EOPNOTSUPP will now report -EINVAL - this is consistent
> >    with the majority and results in userspace perf retrying without
> >    exclusion.
> > 
> > All drivers touched by this patchset have been compile tested.
> 
> For the bits under arch/arm/ and drivers/perf:
> 
> Acked-by: Will Deacon <will.deacon@arm.com>
> 
> Note that I've queued the TX2 uncore PMU for 4.21 [1], which could also
> benefit from your new flag.

Ah thanks for pointing this out, I'll send a patch in due course.

Thanks,

Andrwe Murray

> 
> Will
> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/commit/?h=for-next/perf&id=69c32972d59388c041268e8206e8eb1acff29b9a

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
