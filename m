Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0922EC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:29:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B828B214C1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a9QtabBO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B828B214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UMKUHnZ9AuPvci+QhVErWTQdLLGbd+OxDpzVSbdeaJE=; b=a9QtabBOQUaWOg
	Ts3hvn0IC1a9SXxBBX97MpLENeH2qaTJWY0DpvsnkFni3xgArwMEIUqMktYn/Ee4OHLuW10zihkcD
	0dStgwFqzHzAlGxHYEropWzOyMpr6izMLMs5bGH3R/+0YKJ8jyQZ/7XpkwjFsYFvS3ctgIvLkfDYq
	/fea4yYyVPyn52cWuk3xs+HEfzPA4xq8gTSrB5DhRxigQx35UYXZtDEtaSGxY6R16UcMBShjcxnnc
	X8+FwioQLO5N999Bi1ifNNWEFfUsyEhRB7OsbWRB4MYBIDqFOpd/jAmIWPsGjghXeSwYKcI4wd44R
	Ekv5MwQPj7v+7JI4pi/w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUuf3-0007aR-Ru; Thu, 06 Dec 2018 14:29:53 +0000
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUuex-0007Ot-CM
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 14:29:51 +0000
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 53D453082142;
 Thu,  6 Dec 2018 14:29:36 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D56AF69117;
 Thu,  6 Dec 2018 14:29:34 +0000 (UTC)
Date: Thu, 6 Dec 2018 15:29:32 +0100
From: Andrew Jones <drjones@redhat.com>
To: peng.hao2@zte.com.cn
Subject: Re: [PATCH] kvm/arm: return 0 when the number of objects is not
 lessthan min
Message-ID: <20181206142932.kmt3srhncfpyznu5@kamzik.brq.redhat.com>
References: <20181205083236.5tzhnxfhi4h4nknn@kamzik.brq.redhat.com>
 <201812060956304771332@zte.com.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201812060956304771332@zte.com.cn>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Thu, 06 Dec 2018 14:29:36 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_062947_436561_4E7D06A7 
X-CRM114-Status: GOOD (  21.72  )
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
Cc: marc.zyngier@arm.com, linux-kernel@vger.kernel.org,
 christoffer.dall@arm.com, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu
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

Oh, I see now. This is the case where we can do enough allocating to over
the min line, but fail before we get to the max.

Thanks,
drew

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
