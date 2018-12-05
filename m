Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3581AC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 13:00:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1E342081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 13:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J18UPW/+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1E342081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MEE+/XDR86prokhHCGlabIkcfRuhcqy5krS74f4oqR4=; b=J18UPW/+j34xPe
	CYK4drbwH0UVKt164AWoNPGdcKfurbVlQ+avsZaKP4xzA5nQSAb4SE6cC2Dg6ehkjyfmg14wj+2sW
	cMij/C6QZkYQQINjo6qtfru8LHg2pMTgPxbV4cQCana8/WZ38hEByTQ1n+A6CXxg5t0STj930GUXD
	tuL6pxRbjJ4+Hm6IQKk75JVQI00Yow4FfR3h3ZsM4wcRuH5DEOwRyp+4SJDOM182Xyf8rIMEfUUdn
	L+SQO34EiKUJbkEkloerscgtGnC4zKR5igZ9UAB0EX9PwvisnORb4ZYnEyO9eA6skz8VAgumCLNhA
	M/Ce5vUC8EoOkwT/3nfA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUWmq-00020b-C4; Wed, 05 Dec 2018 13:00:20 +0000
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUWmg-0000WH-09; Wed, 05 Dec 2018 13:00:18 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 7CA82B0E5;
 Wed,  5 Dec 2018 12:59:58 +0000 (UTC)
Date: Wed, 5 Dec 2018 13:59:58 +0100
From: Michal Hocko <mhocko@kernel.org>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC 7/7] mm: better document PG_reserved
Message-ID: <20181205125957.GN1286@dhcp22.suse.cz>
References: <20181205122851.5891-1-david@redhat.com>
 <20181205122851.5891-8-david@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181205122851.5891-8-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_050010_458662_DBC081F6 
X-CRM114-Status: GOOD (  22.59  )
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
Cc: linux-s390@vger.kernel.org, yi.z.zhang@linux.intel.com,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Alexander Duyck <alexander.h.duyck@linux.intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>,
 Pavel Tatashin <pasha.tatashin@oracle.com>, linux-mm@kvack.org,
 linux-m68k@lists.linux-m68k.org, linux-mediatek@lists.infradead.org,
 Miles Chen <miles.chen@mediatek.com>,
 Anthony Yznaga <anthony.yznaga@oracle.com>, linux-riscv@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed 05-12-18 13:28:51, David Hildenbrand wrote:
> The usage of PG_reserved and how PG_reserved pages are to be treated is
> burried deep down in different parts of the kernel. Let's shine some light
> onto these details by documenting (most?) current users and expected
> behavior.
> 
> I don't see a reason why we have to document "Some of them might not even
> exist". If there is a user, we should document it. E.g. for balloon
> drivers we now use PG_offline to indicate that a page might currently
> not be backed by memory in the hypervisor. And that is independent from
> PG_reserved.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Anthony Yznaga <anthony.yznaga@oracle.com>
> Cc: Miles Chen <miles.chen@mediatek.com>
> Cc: yi.z.zhang@linux.intel.com
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

This looks like an improvement. The essential part is that PG_reserved
page belongs to its user and no generic code should touch it. The rest
is a description of current users which I haven't checked due to to lack
of time but yeah, I like the updated wording because I have seen
multiple people confused from the swapped out part which is not true for
many many years. I have tried to dig out when it was actually the case
but failed.

So I cannot give my Ack because I didn't really do a real review but I
like this FWIW.

> ---
>  include/linux/page-flags.h | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 68b8495e2fbc..112526f5ba61 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -17,8 +17,22 @@
>  /*
>   * Various page->flags bits:
>   *
> - * PG_reserved is set for special pages, which can never be swapped out. Some
> - * of them might not even exist...
> + * PG_reserved is set for special pages. The "struct page" of such a page
> + * should in general not be touched (e.g. set dirty) except by their owner.
> + * Pages marked as PG_reserved include:
> + * - Kernel image (including vDSO) and similar (e.g. BIOS, initrd)
> + * - Pages allocated early during boot (bootmem, memblock)
> + * - Zero pages
> + * - Pages that have been associated with a zone but are not available for
> + *   the page allocator (e.g. excluded via online_page_callback())
> + * - Pages to exclude from the hibernation image (e.g. loaded kexec images)
> + * - MMIO pages (communicate with a device, special caching strategy needed)
> + * - MCA pages on ia64 (pages with memory errors)
> + * - Device memory (e.g. PMEM, DAX, HMM)
> + * Some architectures don't allow to ioremap pages that are not marked
> + * PG_reserved (as they might be in use by somebody else who does not respect
> + * the caching strategy). Consequently, PG_reserved for a page mapped into
> + * user space can indicate the zero page, the vDSO, MMIO pages or device memory.
>   *
>   * The PG_private bitflag is set on pagecache pages if they contain filesystem
>   * specific data (which is normally at page->private). It can be used by
> -- 
> 2.17.2
> 

-- 
Michal Hocko
SUSE Labs

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
