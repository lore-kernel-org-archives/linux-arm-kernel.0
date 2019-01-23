Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B226C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:15:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 222F821019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qFFZMlxQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 222F821019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OFnjNzYp4WriVO7p0rLIucSc/PkDrrjSOi74vjCSW2A=; b=qFFZMlxQcoPOIf
	0tZmpigWz7UEgqzQ8N7JLKQXPY8DHxn+W6++guk79xClytW4TM0ik06HOy0pBtKDKhSrRuZuq8SJi
	ISiqVFsLUnh0vhHAYuCDYYMTzxT2/zq/dzQDPCIolC+JvE4fX2luTk+H1kCow0YW0OyBVorNF5/W/
	A7f7Nu96xlTwZeP2xosnMMbzrFSedjbZqYCYW2DHPAL6rpKJhHlUfPKQtFvoh6SHYu7ls/fgnSjzR
	J3YoYaLmrJuFZYt/bsfFPQRpFOUSv1YBgE/BXK0Mr/c3WJ0xjSUBMomicP5EZ6uBpbPtIdBOdnZkm
	l47wNmr5QZBgnb/9ZJUQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmN3s-0007zy-D7; Wed, 23 Jan 2019 18:15:40 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmN3o-0007zF-UP
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 18:15:38 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54DF2EBD;
 Wed, 23 Jan 2019 10:15:34 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 218243F237; Wed, 23 Jan 2019 10:15:32 -0800 (PST)
Date: Wed, 23 Jan 2019 18:15:30 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will.deacon@arm.com>
Subject: Re: [Qestion] Softlockup when send IPI to other CPUs
Message-ID: <20190123181530.GA234790@arrakis.emea.arm.com>
References: <95C141B25E7AB14BA042DCCC556C0E6501620A47@dggeml529-mbx.china.huawei.com>
 <20190119235825.GG26876@brain-police>
 <20190121142127.GD29504@arrakis.emea.arm.com>
 <20190122054400.GB6445@brain-police>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190122054400.GB6445@brain-police>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_101536_994685_52D3D9EB 
X-CRM114-Status: GOOD (  20.61  )
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
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "Wangkefeng \(Kevin\)" <wangkefeng.wang@huawei.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 chenwandun <chenwandun@huawei.com>, anshuman.khandual@arm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 22, 2019 at 05:44:02AM +0000, Will Deacon wrote:
> On Mon, Jan 21, 2019 at 02:21:28PM +0000, Catalin Marinas wrote:
> > arm64: Do not issue IPIs for user executable ptes
> > 
> > From: Catalin Marinas <catalin.marinas@arm.com>
> > 
> > Commit 3b8c9f1cdfc5 ("arm64: IPI each CPU after invalidating the I-cache
> > for kernel mappings") was aimed at fixing the I-cache invalidation for
> > kernel mappings. However, it inadvertently caused all cache maintenance
> > for user mappings via set_pte_at() -> __sync_icache_dcache() to call
> > kick_all_cpus_sync().
> > 
> > Fixes: 3b8c9f1cdfc5 ("arm64: IPI each CPU after invalidating the I-cache for kernel mappings")
> > Cc: <stable@vger.kernel.org> # 4.19.x-
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > ---
> >  arch/arm64/include/asm/cacheflush.h |    2 +-
> >  arch/arm64/kernel/probes/uprobes.c  |    2 +-
> >  arch/arm64/mm/flush.c               |   14 ++++++++++----
> >  3 files changed, 12 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
> > index 19844211a4e6..18e92d9dacd4 100644
> > --- a/arch/arm64/include/asm/cacheflush.h
> > +++ b/arch/arm64/include/asm/cacheflush.h
> > @@ -80,7 +80,7 @@ extern void __clean_dcache_area_poc(void *addr, size_t len);
> >  extern void __clean_dcache_area_pop(void *addr, size_t len);
> >  extern void __clean_dcache_area_pou(void *addr, size_t len);
> >  extern long __flush_cache_user_range(unsigned long start, unsigned long end);
> > -extern void sync_icache_aliases(void *kaddr, unsigned long len);
> > +extern void sync_icache_aliases(void *kaddr, unsigned long len, bool sync);
> 
> I'd much prefer just adding something like sync_user_icache_aliases(), which
> would avoid the IPI, since bool arguments tend to make the callsites
> unreadable imo.

I wonder whether we need the IPI for uprobes and ptrace. I would say we
can avoid it for ptrace since normally the debugged thread should be
stopped. I think it's different for uprobes but changing the text of a
live thread doesn't come with many guarantees anyway. So I'm tempted to
simply change sync_icache_aliases() to not issue an IPI at all, in which
case we wouldn't even need the bool argument; it's only used for user
addresses. So the new diff would be (the text is the same):

diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
index 30695a868107..5c9073bace83 100644
--- a/arch/arm64/mm/flush.c
+++ b/arch/arm64/mm/flush.c
@@ -33,7 +33,11 @@ void sync_icache_aliases(void *kaddr, unsigned long len)
 		__clean_dcache_area_pou(kaddr, len);
 		__flush_icache_all();
 	} else {
-		flush_icache_range(addr, addr + len);
+		/*
+		 * Don't issue kick_all_cpus_sync() after I-cache invalidation
+		 * for user mappings.
+		 */
+		__flush_icache_range(addr, addr + len);
 	}
 }
 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
