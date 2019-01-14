Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3DAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 04:28:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AEAA206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 04:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KPmgxPf6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AEAA206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UXRCA8TyVWnBJsikRXey0si0xmyk/NCyP4Z1m5pTKnU=; b=KPmgxPf6IJdzAX
	Xh4O9PsF5qKfThHFxRi+utOIB7Mn836f9knmYqzaXh0Ik7DDCPpZDr56/wIUYu3pzeo1um1RkWjdo
	sqIjnaNxyiDweUQM2bz0YzE6AC4IeDzG3YO520HiF2L2VwD2+weuXB8QosZjPd8vj4IjuxTaVXb5X
	Mo1GfDLUIlghHuPB6yxPtLgkuv54CPiwnLCBeWc6tbpRKbDhCa6ux/NVM3uHq4u+/FvOKuyDQiJe5
	IkT6QeGMuhEgsKmW2iogfdNRoHXrgMYZfwvEwlXcf/raGfM/6l8yh+DHuC1z46mjRRv42LVRqaJaG
	pavqeEfGxWY75nNVjJUg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gitrP-0005pp-0Q; Mon, 14 Jan 2019 04:28:27 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gitrL-0005pP-Rt
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 04:28:25 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 628C180D;
 Sun, 13 Jan 2019 20:28:22 -0800 (PST)
Received: from [10.162.42.129] (p8cg001049571a15.blr.arm.com [10.162.42.129])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 D48C03F5BD; Sun, 13 Jan 2019 20:28:13 -0800 (PST)
Subject: Re: [PATCH] mm: Introduce GFP_PGTABLE
To: Matthew Wilcox <willy@infradead.org>,
 Christophe Leroy <christophe.leroy@c-s.fr>
References: <1547288798-10243-1-git-send-email-anshuman.khandual@arm.com>
 <20190112121230.GQ6310@bombadil.infradead.org>
 <ddd59fdc-3d8f-4015-e851-e7f099193a1b@c-s.fr>
 <20190112154944.GT6310@bombadil.infradead.org>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <48f81a76-2b2d-5060-d9bc-c42d5b5975c3@arm.com>
Date: Mon, 14 Jan 2019 09:58:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190112154944.GT6310@bombadil.infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190113_202823_919634_1224F2ED 
X-CRM114-Status: GOOD (  14.83  )
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
 marc.zyngier@arm.com, rppt@linux.vnet.ibm.com, shakeelb@google.com,
 kirill@shutemov.name, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
 ard.biesheuvel@linaro.org, linuxppc-dev@lists.ozlabs.org, steve.capper@arm.com,
 linux-kernel@vger.kernel.org, james.morse@arm.com, akpm@linux-foundation.org,
 robin.murphy@arm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 01/12/2019 09:19 PM, Matthew Wilcox wrote:
> On Sat, Jan 12, 2019 at 02:49:29PM +0100, Christophe Leroy wrote:
>> As far as I can see,
>>
>> #define GFP_KERNEL_ACCOUNT (GFP_KERNEL | __GFP_ACCOUNT)
>>
>> So what's the difference between:
>>
>> (GFP_KERNEL_ACCOUNT | __GFP_ZERO) & ~__GFP_ACCOUNT
>>
>> and
>>
>> (GFP_KERNEL | __GFP_ZERO) & ~__GFP_ACCOUNT
> 
> Nothing.  But there's a huge difference in the other parts of that same
> file where GFP_ACCOUNT is _not_ used.
> 
> I think this unification is too small to bother with.  Something I've
> had on my todo list for some time and have not done anything about
> is to actually unify all of the architecture pte/pmd/... allocations.
> There are tricks some architectures use that others would benefit from.

Sure. Could you please elaborate on this ?

Invariably all kernel pgtable page allocations should use GFP_PGTABLE and
all user page table allocation should use (GFP_PGTABLE | __GFP_ACCOUNT).
Ideally there should be default generic functions user_pgtable_gfp() or
kernel_pgtable_gfp() returning these values. Overrides can be provided if
an arch still wants some more control.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
