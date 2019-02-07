Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04E6C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:51:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD82F2147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cI9CO6zC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD82F2147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/HZL/2JCmmwIjHGcg+l6dzDFXGslCc3LWgM8vdtKPhc=; b=cI9CO6zC9SdJ8pliNipTo9Y7h
	mz7RlFkhiXsFPvhGKZ+ALVkHzd9aB9DN9jTkSl95ouWRmPCBXPoNekAiOseU58zqeygu0c4HN4qNs
	cGqKSMg1FlNMmOmafJFEnT2kg8BTY86b5LJCNZSbxmO40SCzXUJVK5vVSILT5doxfe2intDrKpTFZ
	YanmA8nA9oRDPCIpYTvUulTokG9TlXw3WJnksmMMCyGaxT4wHr9oURyhVNI25e2ADiRl7AnIasDFr
	fuyNjXF4yqmuR2Jjt53mhmy5G4EFdJCfhwTLAiZw4hcq/j82kfhnfDMx0G8BTMwq30ZX0Q5QDgCWG
	BvDmoC9wA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grphw-0007cu-I2; Thu, 07 Feb 2019 19:51:36 +0000
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grphs-0007cb-LG
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 19:51:34 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 0053EAE4B;
 Thu,  7 Feb 2019 19:51:29 +0000 (UTC)
Date: Thu, 7 Feb 2019 11:51:19 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH-tip 00/22] locking/rwsem: Rework rwsem-xadd & enable new
 rwsem features
Message-ID: <20190207195119.lglz4lb7cnf4ndn2@linux-r8p5>
References: <1549566446-27967-1-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1549566446-27967-1-git-send-email-longman@redhat.com>
User-Agent: NeoMutt/20180323
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_115132_840498_3CC5B8D5 
X-CRM114-Status: UNSURE (   7.53  )
X-CRM114-Notice: Please train this message.
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
Cc: linux-arch@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 linux-ia64@vger.kernel.org, Tim Chen <tim.c.chen@linux.intel.com>,
 Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, linux-hexagon@vger.kernel.org,
 x86@kernel.org, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>, linux-alpha@vger.kernel.org,
 sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 07 Feb 2019, Waiman Long wrote:
> 30 files changed, 1197 insertions(+), 1594 deletions(-)

Performance numbers on numerous workloads, pretty please.

I'll go and throw this at my mmap_sem intensive workloads
I've collected.

Thanks,
Davidlohr

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
