Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6F7C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:29:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CCDE2073D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ii7U0txt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CCDE2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ed4B5ymtY/SwDa2YI8oweXqzMzdVlUnQYONR/2JfXy4=; b=ii7U0txtxH4q+2
	TsNg3DYKp+wFtlr4WqB114bKd7ArF/F3/o7/er21p7NWeqVwZQOZMZ6zyiY6aro8hWdbrsaQaT/ig
	jijFffrREKdsUnublA8zXvPoT5IGAJDuXE7pX68rWjRok4/bAQKSX5IkFk29U1MWAxDzH52Igt5rZ
	8hY4EvHYth+1V5c/Jl3r/uDyZkXNrczJRlXyBc6xJr6VYP66HAlAYH/fJIyWySDlZU3zvlJFQgZ3v
	tH5MStpgLVX972SyojFdlP4ICtaKRXF3esMF5ovbl/cbu8WjgId7fkeiOxyvJLcyAYJW5RG2hWBVl
	ThR7xuRUsaoKCcvEo2rg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtsjZ-0005UI-9W; Wed, 13 Feb 2019 11:29:45 +0000
Received: from outbound-smtp12.blacknight.com ([46.22.139.17])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtsjV-0005Tu-Qw
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 11:29:43 +0000
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
 by outbound-smtp12.blacknight.com (Postfix) with ESMTPS id
 E6A3B1C2195 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 11:29:39 +0000 (GMT)
Received: (qmail 8247 invoked from network); 13 Feb 2019 11:29:39 -0000
Received: from unknown (HELO techsingularity.net)
 (mgorman@techsingularity.net@[37.228.225.79])
 by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated);
 13 Feb 2019 11:29:39 -0000
Date: Wed, 13 Feb 2019 11:29:38 +0000
From: Mel Gorman <mgorman@techsingularity.net>
To: Will Deacon <will.deacon@arm.com>
Subject: Re: 5.0-rc kernel hangs on early boot
Message-ID: <20190213112938.GP9565@techsingularity.net>
References: <20190213082134.GA21834@yury-thinkpad>
 <20190213111843.GA1912@brain-police>
 <20190213112141.GO9565@techsingularity.net>
 <20190213112520.GB1912@brain-police>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190213112520.GB1912@brain-police>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_032942_007048_18E1EEB0 
X-CRM114-Status: GOOD (  10.36  )
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
Cc: Andrea Arcangeli <aarcange@redhat.com>, Yury Norov <yury.norov@gmail.com>,
 Vlastimil Babka <vbabka@suse.cz>, Catalin Marinas <catalin.marinas@arm.com>,
 linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
 Zi Yan <zi.yan@cs.rutgers.edu>, David Rientjes <rientjes@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 13, 2019 at 11:25:21AM +0000, Will Deacon wrote:
> > Thanks Will.
> > 
> > While I agree that going OOM early is a problem and would explain why
> > the boosting logic was hit at all, it's still the case that the boosting
> > should not divide by zero. Even if the booting is broken due to a lack
> > of memory, I'd still not prefer to crash due to 1c30844d2dfe272d58c.
> 
> Yup, sorry, our previous mails crossed paths. Your patch looks sensible in
> its own right, I'm just left wondering why we're OOM so early during boot!
> 

I completely agree that it's worth pinning down both issues.

-- 
Mel Gorman
SUSE Labs

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
