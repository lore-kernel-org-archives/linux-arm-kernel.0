Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49413C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:13:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B2D22086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hJluMyA0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B2D22086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ncH/zHB40OxjqR3H+38EVduBwmCeob2S/xwCQN14YQU=; b=hJluMyA00gw151
	gHMe3+WfwiFraKkGLCNW3d1LXVv7fDywuHfZa5x0xb+aFwwlwQbrfbHVJwOfQe4NceTaSUA0vdUjm
	uT/Ze9PmWtPuMyoxPUjjr0WiYdIWuSbEN101xucWRziOHEMqpnsOznOh7jL67svtlCvuI3J/FMIjW
	+jYE04rBKgdDqXotVVMDzo6kkie2XVOy+lW/0mZHbmaphsqC+yl7fqnSC1s67DGwtmFWwroUjAyyi
	H6RLNhSEwSeH7KgIAZY0p+C94+5NEsIpxjHX/UO70sk1AZQ9vsgTfhdlpdaUgalidsIlgh2szY2Ny
	FThp4A0yMGumgKEYRwuw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWLNP-00026q-3D; Mon, 10 Dec 2018 13:13:35 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWLNL-000266-2Z
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 13:13:32 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1561E15AB;
 Mon, 10 Dec 2018 05:13:20 -0800 (PST)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A3DC3F575;
 Mon, 10 Dec 2018 05:13:19 -0800 (PST)
Date: Mon, 10 Dec 2018 14:13:17 +0100
From: Christoffer Dall <christoffer.dall@arm.com>
To: peng.hao2@zte.com.cn
Subject: Re: [PATCH] kvm/arm: return 0 when the number of objects is not
 lessthan min
Message-ID: <20181210131317.GP30263@e113682-lin.lund.arm.com>
References: <20181205083236.5tzhnxfhi4h4nknn@kamzik.brq.redhat.com>
 <201812060956304771332@zte.com.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201812060956304771332@zte.com.cn>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_051331_122572_ADE94781 
X-CRM114-Status: GOOD (  22.88  )
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
Cc: marc.zyngier@arm.com, drjones@redhat.com, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 06, 2018 at 09:56:30AM +0800, peng.hao2@zte.com.cn wrote:
> >On Wed, Dec 05, 2018 at 09:15:51AM +0800, Peng Hao wrote:
> >> Return 0 when there is enough kvm_mmu_memory_cache object.
> >>
> >> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> >> ---
> >>  virt/kvm/arm/mmu.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> >> index ed162a6..fcda0ce 100644
> >> --- a/virt/kvm/arm/mmu.c
> >> +++ b/virt/kvm/arm/mmu.c
> >> @@ -127,7 +127,7 @@ static int mmu_topup_memory_cache(struct kvm_mmu_memory_cache *cache,
> >>      while (cache->nobjs < max) {
> >>          page = (void *)__get_free_page(PGALLOC_GFP);
> >>          if (!page)
> >> -            return -ENOMEM;
> >> +            return cache->nobjs >= min ? 0 : -ENOMEM;
> >
> >This condition will never be true here, as the exact same condition is
> >already checked above, and if it had been true, then we wouldn't be here.
> >
> >What problem are you attempting to solve?
> >
> if (cache->nobjs >= min)                      ------here cache->nobjs<min,it can continue downward 
>      return 0;
> while (cache->nobjs < max) {
>     page = (void *)__get_free_page(PGALLOC_GFP);
>     if (!page)
>        return -ENOMEM;                         -----here it is possible that  (cache->nobjs >= min) and (cache->nobjs<max)
>     cache->objects[cache->nobjs++] = page; ---here cache->nobjs increasing
>   }
> 
> I just think the logic of this function is to return 0 as long as (cache->nobjs >= min).
> thanks.

That's not the intention, nor is it on any of the other architectures
implementing the same thing (this one goes on the list of stuff we
should be sharing between architectures).

The idea is that you fill up the cache when it goes below min, and you
are always able to fill up to max.

If you're not able to fill up to max, then your system is seriously low
on memory and continuing to run this VM is not likely to be a good idea,
so you might as well tell user space to do something now instead of
waiting until the situation is even worse.


Thanks,

    Christoffer

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
