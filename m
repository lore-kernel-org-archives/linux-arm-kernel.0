Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C054C4151A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:52:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DFD020838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OsBDScuF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DFD020838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QKQ2GzrqEm+qifE+gThZIz7qyKYsVVO8MzJFCx/pDpI=; b=OsBDScuF5o0wFo
	tcDEDwq1r0NgKS2cmRJhI5lbEnAdoNZNjjrn53JRSrpJhl7w9pKAQ1TsviarHYr00X955qncQOL6D
	FzRBAbB4TJWFzwnIlD4dEJAIS77wQk3bXWA04yzgrrvYi/h2oTwCWSzGAWhjLQ1LxD6Xra6cvW9+g
	oDMBVp+XY19xtevtqt7Wm+hULHHBoMlXEAebyKd0q6TZvdmFUYnxcZC+S/4VPquxW8/uYvIu9Wu4q
	xzpPCxplmmD4p10k+g3hvf2qfD1FWym5ky205QSh7aC8XDeGLEM5ji9qxDdsviq3VBUEIvkxI93Be
	GRocKTBLtzBnoVLMM0Cg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt9CS-0005iT-HX; Mon, 11 Feb 2019 10:52:32 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt9CO-0005i2-UE
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 10:52:30 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DBB5A78;
 Mon, 11 Feb 2019 02:52:26 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABD1D3F557;
 Mon, 11 Feb 2019 02:52:22 -0800 (PST)
Date: Mon, 11 Feb 2019 10:52:14 +0000
From: Will Deacon <will.deacon@arm.com>
To: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] locking/rwsem: Remove arch specific rwsem files
Message-ID: <20190211105214.GA30880@fuggles.cambridge.arm.com>
References: <1549850450-10171-1-git-send-email-longman@redhat.com>
 <a610aeb2-b1cb-0d57-8078-97d1051481f9@redhat.com>
 <20190211071159.GA55579@gmail.com>
 <20190211103927.GA118071@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190211103927.GA118071@gmail.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_025228_976285_C38337E2 
X-CRM114-Status: GOOD (  11.68  )
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
Cc: linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
 Davidlohr Bueso <dave@stgolabs.net>, linux-hexagon@vger.kernel.org,
 x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
 Waiman Long <longman@redhat.com>, linux-xtensa@linux-xtensa.org,
 Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Tim Chen <tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 11, 2019 at 11:39:27AM +0100, Ingo Molnar wrote:
> 
> * Ingo Molnar <mingo@kernel.org> wrote:
> 
> > Sounds good to me - I've merged this patch, will push it out after 
> > testing.
> 
> Based on Peter's feedback I'm delaying this - performance testing on at 
> least one key ll/sc arch would be nice indeed.

Once Waiman has posted a new version, I can take it for a spin on some
arm64 boxen if he shares his workload.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
