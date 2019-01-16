Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2770FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:40:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1D442082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RYEyrzKi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1D442082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=USug3whORF3hNeet1G74GVV2p3kCuwI9Kly2+k0oRSk=; b=RYEyrzKiuTtXk1
	o/PuL8znuri2E4ZoUvDkymzB0jWx4FdqPFFLNA7J4tfscs1Hk+mV5uShXDfD4MDRkTS730sJAkFRv
	XHFnNbHzHEduBRcwVtHaqDBoYCu/84t1UKjuNUKqS5chxurIn7jujdXbZpB4+diTARscoLapkn4AV
	wMyxzbmfdU101SVwz7T0L+ASkfDzgGlz5VJp2Ush2xCay76sGeRjlS2JQptDlClj3JHUp8MsMH4AV
	VGKTuQ4pHQHggEl+atLAXZlT+RPn0HHPfv0de9EEH8dva/8Q8R5OG1sRbtPcG43ckZAjv6OmtMV3A
	/oYy0hM0t/e0WLVPNcPg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjlQY-0008DD-Ip; Wed, 16 Jan 2019 13:40:18 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjlQU-0008CY-Qe
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 13:40:16 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5A5780D;
 Wed, 16 Jan 2019 05:40:13 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 443C43F70D;
 Wed, 16 Jan 2019 05:40:12 -0800 (PST)
Date: Wed, 16 Jan 2019 13:40:07 +0000
From: Will Deacon <will.deacon@arm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v2 0/4] arm64: kprobes: Update blacklist checking on arm64
Message-ID: <20190116134007.GA15255@fuggles.cambridge.arm.com>
References: <154753341900.31541.8135985235882849464.stgit@devbox>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <154753341900.31541.8135985235882849464.stgit@devbox>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_054014_870258_98456A4A 
X-CRM114-Status: GOOD (  17.10  )
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
Cc: Pratyush Anand <panand@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, James Morse <james.morse@arm.com>,
 "David A . Long" <dave.long@linaro.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Masami,

On Tue, Jan 15, 2019 at 03:23:39PM +0900, Masami Hiramatsu wrote:
> Hello,
> 
> Here is the v2 series of update of the kprobe blacklist
> checking on arm64.
> 
> I found that some blacklist checking code were mis-placed in
> arch_prepare_kprobe() and arch_within_kprobe_blacklist().
> Since the blacklist just filters by symbol, smaller than the
> symbol, like extable must be checked in arch_prepare_kprobe().
> Also, all function (symbol) level check must be done by blacklist.
> 
> For arm64, it checks the extable entry address in blacklist
> and exception/irqentry function in arch_prepare_kprobe().
> And, RODATA check is unneeded since kernel/kprobes.c
> already ensures the probe address is in kernel-text area.
> 
> In v2, I updated [1/4]'s description and added James'
> Reviewed-by. Also, in this version, I added a patch which
> uses arch_populate_kprobe_blacklist() instead of
> arch_within_kprobe_blacklist() so that user can see the full
> list of blacklisted symbols under the debugfs.

Assuming these are targetting the arm64 tree, are you intending to get them
merged for 5.0?

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
