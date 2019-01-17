Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2370C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:56:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 710EB20855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EUc/Wtfp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 710EB20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QnOPTNqRXTzd3A3lwSNjCaM5LDaasRf0vu+pe7i8QkM=; b=EUc/Wtfp/1jDqe
	LqjOAcOVLFboK4teFZia28p0X5HO1QvEbIqlpcLMmcO0YvfAxXk+QKmwZGDD9HDUQZIXcsIDEu1zw
	AcdVczVUmmUmWkFUDYqlru9Qh+D2bBr0v6x3WSFpdH2U4t57yM8HrbM1PGUUrjgl0eOujpcS+HWcF
	+T+NYW15XF6R7HiYhkCCOKb8OfRzi9B2CsxZHWFeFhulkKKwzYAbAei7DA+1dba2hLeZUr32AOoiw
	8q88m6jW57Nov0kojOnPULUl/anrk5m5kmeyxvf9rMVz1G5GhYgTXMGa+1A/PjZ1abceUOVMRcMTf
	nSX80l/peAntNtAh6l9w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk4Po-00036F-Vn; Thu, 17 Jan 2019 09:56:48 +0000
Received: from ozlabs.org ([2401:3900:2:1::2])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk4Pl-00035E-6O; Thu, 17 Jan 2019 09:56:46 +0000
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43gKGp5Rwwz9sBn;
 Thu, 17 Jan 2019 20:56:34 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH V2] mm: Introduce GFP_PGTABLE
In-Reply-To: <20190116123018.GF6310@bombadil.infradead.org>
References: <1547619692-7946-1-git-send-email-anshuman.khandual@arm.com>
 <20190116065703.GE24149@dhcp22.suse.cz>
 <20190116123018.GF6310@bombadil.infradead.org>
Date: Thu, 17 Jan 2019 20:56:34 +1100
Message-ID: <87tvi74nfx.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_015645_464933_74FE764D 
X-CRM114-Status: GOOD (  10.93  )
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
Cc: mark.rutland@arm.com, linux-sh@vger.kernel.org, peterz@infradead.org,
 catalin.marinas@arm.com, dave.hansen@linux.intel.com, will.deacon@arm.com,
 christoffer.dall@arm.com, linux-mm@kvack.org, linux-riscv@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, aneesh.kumar@linux.ibm.com,
 greentime@andestech.com, linux@armlinux.org.uk, mingo@redhat.com,
 vbabka@suse.cz, rientjes@google.com, palmer@sifive.com,
 Anshuman Khandual <anshuman.khandual@arm.com>, marc.zyngier@arm.com,
 rppt@linux.vnet.ibm.com, shakeelb@google.com, kirill@shutemov.name,
 tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
 ard.biesheuvel@linaro.org, robin.murphy@arm.com, steve.capper@arm.com,
 linux-kernel@vger.kernel.org, james.morse@arm.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Matthew Wilcox <willy@infradead.org> writes:

> On Wed, Jan 16, 2019 at 07:57:03AM +0100, Michal Hocko wrote:
>> On Wed 16-01-19 11:51:32, Anshuman Khandual wrote:
>> > All architectures have been defining their own PGALLOC_GFP as (GFP_KERNEL |
>> > __GFP_ZERO) and using it for allocating page table pages. This causes some
>> > code duplication which can be easily avoided. GFP_KERNEL allocated and
>> > cleared out pages (__GFP_ZERO) are required for page tables on any given
>> > architecture. This creates a new generic GFP flag flag which can be used
>> > for any page table page allocation. Does not cause any functional change.
>> > 
>> > GFP_PGTABLE is being added into include/asm-generic/pgtable.h which is the
>> > generic page tabe header just to prevent it's potential misuse as a general
>> > allocation flag if included in include/linux/gfp.h.
>> 
>> I haven't reviewed the patch yet but I am wondering whether this is
>> really worth it without going all the way down to unify the common code
>> and remove much more code duplication. Or is this not possible for some
>> reason?
>
> Exactly what I suggested doing in response to v1.
>
> Also, the approach taken here is crazy.  x86 has a feature that no other
> architecture has bothered to implement yet -- accounting page tables
> to the process.

powerpc does __GFP_ACCOUNT for user page tables too. Shamelessly cribbed
from the x86 version of course :)

cheers

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
