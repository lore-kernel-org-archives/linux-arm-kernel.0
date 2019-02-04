Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23343C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:55:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E58F720815
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uGGIUUIc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F4Gn0hPG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E58F720815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SuG+TWbaMxycPJ5DpYeH1rUCvyXn8rIyZljNW5vMa2o=; b=uGGIUUIcbYyQYj
	PtlUE1pcqkNdzBLLW6knSA64Xsz17hhhmVF6A8TPkQHqKTT8/e9UTh1MkhZBbBAzh4nCs8SUhG3rt
	QLjLeeo6q/Sxk+nTk1vqIEAebq95l8zYNyygsoa3/TcK/D8L1VshZ6I3xQJ2b0YuhilJjE6t/A4st
	3vAV4HRxto/JKYHHwNHjvpmg/077TjegG6wKlmWD9QhIXZblv+mb3U4SvvBy4h01wcEWEcEju4mNa
	CPaFoAsPeoDoms1VAj1VB5p1n7bIxPW/dtmi8EBD095ruFl56mgB07DmsO40hAjyZ+W+ZGBuvqy/3
	h9V5s3ND12hyRQLsBHTA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqhWy-0006Qv-Ul; Mon, 04 Feb 2019 16:55:36 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqhWx-0006Mf-AU
 for linux-arm-kernel@bombadil.infradead.org; Mon, 04 Feb 2019 16:55:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lfgbh6lsgd5wy6zxRRj3RcizFW7S2atBFph0N7A3NLc=; b=F4Gn0hPG2B2Ab1/M2CbJWlb1+
 H5pM7PqpIo90yLNyM0Ei8THmOB3kT3p9N37rmUeslQpPw+3F8cNUGs49YU/K0zX9YTvrgbFWxFMrR
 luMbKHMluq2MERIy5WqgXE3C9Wuid874G8JoSHDBWDbhCanJ2oSJ0C3nuk3NOHB6G2BwdlJ9YLM5q
 mqzaw4xlCQk7Va2w5SEE5ZET+gZ3bwlERZ4tEvXevfTpF5b1uVMknzEXwkYCskfu4ciPFvBGCUl0M
 PMY1Dr4ki3GDL/amsaQYoHckbdnmbRQFJoTTdwUtOm0of2P4lC3F3CUB4RWCfPdI3yPeIkbHOKSVM
 N60D7ZXGA==;
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqhWu-0002ur-DF
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 16:55:33 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15FF715AD;
 Mon,  4 Feb 2019 08:55:29 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 6D26C3F589; Mon,  4 Feb 2019 08:55:27 -0800 (PST)
Date: Mon, 4 Feb 2019 16:55:24 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [RFC PATCH 1/3] arm64: entry: Remove unneeded need_resched() loop
Message-ID: <20190204165524.GA88568@arrakis.emea.arm.com>
References: <20190131182339.9835-1-valentin.schneider@arm.com>
 <20190131182339.9835-2-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190131182339.9835-2-valentin.schneider@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_115532_530943_AD63C1B1 
X-CRM114-Status: GOOD (  13.04  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Julien Thierry <julien.thierry@arm.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 Julien Grall <julien.grall@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 31, 2019 at 06:23:37PM +0000, Valentin Schneider wrote:
> Since the enabling and disabling of IRQs within preempt_schedule_irq()
> is contained in a need_resched() loop, we don't need the outer arch
> code loop.
> 
> Reported-by: Julien Thierry <julien.thierry@arm.com>
> Reported-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Julien Grall <julien.grall@arm.com>
> Cc: Julien Thierry <julien.thierry@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-arm-kernel@lists.infradead.org

Queued for 5.1. Thanks

-- 
Catalin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
