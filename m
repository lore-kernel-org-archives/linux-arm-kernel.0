Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3E3C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 15:49:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C5F32086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 15:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LmP7dYlo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C5F32086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DS000DQOtOWhlp0nrDOD77Bv7eKXmtUTkekOySiIYs0=; b=LmP7dYloADAX0u
	H2nSyNZhoSX+3E6anZ2ErsGKn4VYHNGdBaTiGL4DokpZ6XZ2z9+OSJmDshIuopYRmDoG9GDfyX9bp
	YAMoyP2PAzQ1DevLJ+VQwoFIcIdvDtj5XTHft/57xCVmX7SDqloT0OlgKut3NvobvTjgKuqcoOyn3
	ozvdixDCIULI9K0aOwmUCC4znylD5isg1apJ+EZ9n5tpdXvSZ2If6JyRJ6lJ9i1SdDPHBJRkFUqSV
	cr7oeCiojoUV7UgYbHNZ/a0l5C5Qzbxb2ZBUALIApGvtjdzTrR8yh7EfaK4bY7LccXSfDUnsJbaV9
	1QCa/IvMvnvQGJlBzzKw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giLXk-0000Sh-4j; Sat, 12 Jan 2019 15:49:52 +0000
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
 Hat Linux)) id 1giLXc-0000SR-TQ; Sat, 12 Jan 2019 15:49:44 +0000
Date: Sat, 12 Jan 2019 07:49:44 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH] mm: Introduce GFP_PGTABLE
Message-ID: <20190112154944.GT6310@bombadil.infradead.org>
References: <1547288798-10243-1-git-send-email-anshuman.khandual@arm.com>
 <20190112121230.GQ6310@bombadil.infradead.org>
 <ddd59fdc-3d8f-4015-e851-e7f099193a1b@c-s.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ddd59fdc-3d8f-4015-e851-e7f099193a1b@c-s.fr>
User-Agent: Mutt/1.9.2 (2017-12-15)
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
Cc: mark.rutland@arm.com, mhocko@suse.com, linux-sh@vger.kernel.org,
 peterz@infradead.org, catalin.marinas@arm.com, dave.hansen@linux.intel.com,
 will.deacon@arm.com, christoffer.dall@arm.com, linux-mm@kvack.org,
 kvmarm@lists.cs.columbia.edu, aneesh.kumar@linux.ibm.com,
 linux@armlinux.org.uk, mingo@redhat.com, vbabka@suse.cz, rientjes@google.com,
 Anshuman Khandual <anshuman.khandual@arm.com>, marc.zyngier@arm.com,
 rppt@linux.vnet.ibm.com, shakeelb@google.com, kirill@shutemov.name,
 tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
 ard.biesheuvel@linaro.org, linuxppc-dev@lists.ozlabs.org, steve.capper@arm.com,
 linux-kernel@vger.kernel.org, james.morse@arm.com, akpm@linux-foundation.org,
 robin.murphy@arm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Jan 12, 2019 at 02:49:29PM +0100, Christophe Leroy wrote:
> As far as I can see,
> 
> #define GFP_KERNEL_ACCOUNT (GFP_KERNEL | __GFP_ACCOUNT)
> 
> So what's the difference between:
> 
> (GFP_KERNEL_ACCOUNT | __GFP_ZERO) & ~__GFP_ACCOUNT
> 
> and
> 
> (GFP_KERNEL | __GFP_ZERO) & ~__GFP_ACCOUNT

Nothing.  But there's a huge difference in the other parts of that same
file where GFP_ACCOUNT is _not_ used.

I think this unification is too small to bother with.  Something I've
had on my todo list for some time and have not done anything about
is to actually unify all of the architecture pte/pmd/... allocations.
There are tricks some architectures use that others would benefit from.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
