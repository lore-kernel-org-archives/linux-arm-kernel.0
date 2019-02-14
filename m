Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4948CC10F04
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:54:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B83B222DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MyPFPIVv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="u3Xdu4ln"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B83B222DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TzOwcfHfzzSbwZzgxj6FsRQjKb/gMiucVXKbYb+KzIE=; b=MyPFPIVv3MeVfE
	vbT9tS16hC0spEYkXQADLJhXN7zRk57N3xXq7pl0CXOXmBaiv6pDRCA3S+jBMxb2Ci39+QAFlHnN/
	mejhiuO67zLw6G1RmtbLXYGb6CbiiU/7WxtN+HSnUXzEYL80aM43EziGu1rCQ0PJf/lyH4JBfiXTd
	vEbrEqTAb72YuWjhksGA+uW0o4y3XDr6Y0alBCd9n1VkZLLN9hbQ3kI8sbCEVi1tHIxn2otgQUcAC
	810EpnkB0cd7blEvmnNrOhKL1Z9cXAewMaj+pfzauH6PKj4hLSZnil/LMVBvcpBf+L97zHQ8ABHSJ
	MEg7hhgzwHo1cgeneWXA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guJLb-0005eF-JT; Thu, 14 Feb 2019 15:54:47 +0000
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guJLY-0005dq-M7
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 15:54:46 +0000
Received: by mail-qk1-x741.google.com with SMTP id w204so3864437qka.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 07:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tycho-ws.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=UxpB070xHwgFaz8ZioJlkVPdIwCn2gbKu7LNAeSS6hg=;
 b=u3Xdu4lng/T/Gddu8kOlLDHAmHcvkyWWI4olRQ6e3+63jOFKa3TrUFKCYSYyeHMLRW
 AxMWjlLusOvDFUizEOvKVSn/6JIvmVruc/v7wuL2n2UFAKcoseE925gAwNgdEsjh0FXF
 BFgZ2BSuYxU/3fXZmcfo62o9UHBBhsOBMeW+rBqgQGxuZ5/q9jkVFWuUHOeMOtadIPYa
 mKOc17H6jeF4u8pbR/3RLnuKZDP/5ctpY1/gqU4XsmU62XJ1zhJ84Qlz7rCufBIAveSY
 tsALfedeUly/vMkW63SDvnToU0I0eHJgJuBM0ntr+kO2HeiYWtBD4uOjk/K4v+K3MwIB
 iknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=UxpB070xHwgFaz8ZioJlkVPdIwCn2gbKu7LNAeSS6hg=;
 b=IAPYBGH7mVt+VUl/UC8qJ9GkLQoMkzDBl3OlnVR4LkIeImp4RgrhX2j9oc0K5UIsG+
 g0y9J2Vr7Odx10iiBMBrMLqrfItCwvtuEZNSxLhfAQmHKoVaAXfD88XELOeTSgX37nN7
 zona1cyEtLRm1Mo0g+gkuBn3NzoHGcxZ20TOLiFz7ZxKIMeMJnkinY9HttkBC7lRXUNA
 HE3hHBE2llbttirF2DZ8W89EEYlBI+Xsn0y0Hj7eKbREa0SmQ72vfc55/jizt69iRMcQ
 ywaM9f+NPAWlRXvCxbMCqcYtLuN8UJ8R0aGcQJFVkiJVEkSO9Gv5uJNpj04/sEXUd2uN
 ifSw==
X-Gm-Message-State: AHQUAuaVNq00F/Gig/SVhRLR0S3IsZpqR6QfuvzydxAJf1B0qZl14QQn
 IJItWXqY+gm7NWbtRjz+GGljnQ==
X-Google-Smtp-Source: AHgI3Ia7LCGDDCLU8MkYwq8iNCqWM6Mj9BVMP6XN30zlJ0Pv4QGuWGPK3u/Aux2QKEcButsn/HeXEg==
X-Received: by 2002:a37:62c5:: with SMTP id w188mr3321934qkb.294.1550159682636; 
 Thu, 14 Feb 2019 07:54:42 -0800 (PST)
Received: from cisco ([192.241.255.151])
 by smtp.gmail.com with ESMTPSA id 32sm1660511qto.55.2019.02.14.07.54.37
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 14 Feb 2019 07:54:41 -0800 (PST)
Date: Thu, 14 Feb 2019 08:54:35 -0700
From: Tycho Andersen <tycho@tycho.ws>
To: Khalid Aziz <khalid.aziz@oracle.com>
Subject: Re: [RFC PATCH v8 07/14] arm64/mm, xpfo: temporarily map dcache
 regions
Message-ID: <20190214155435.GA15694@cisco>
References: <cover.1550088114.git.khalid.aziz@oracle.com>
 <ea50404604bdbe1547601b6ea0af89e3da8886b0.1550088114.git.khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ea50404604bdbe1547601b6ea0af89e3da8886b0.1550088114.git.khalid.aziz@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_075444_784006_DFB11C51 
X-CRM114-Status: GOOD (  19.46  )
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
Cc: mhocko@suse.com, kernel-hardening@lists.openwall.com, peterz@infradead.org,
 catalin.marinas@arm.com, will.deacon@arm.com, dave.hansen@intel.com,
 deepa.srinivasan@oracle.com, steven.sistare@oracle.com, tglx@linutronix.de,
 ak@linux.intel.com, kirill.shutemov@linux.intel.com, x86@kernel.org,
 jmorris@namei.org, hch@lst.de, kanth.ghatraju@oracle.com, jsteckli@amazon.de,
 labbott@redhat.com, pradeep.vincent@oracle.com, konrad.wilk@oracle.com,
 jcm@redhat.com, liran.alon@oracle.com, luto@kernel.org,
 boris.ostrovsky@oracle.com, chris.hyser@oracle.com,
 linux-arm-kernel@lists.infradead.org, jmattson@google.com, linux-mm@kvack.org,
 juergh@gmail.com, andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
 tyhicks@canonical.com, john.haxby@oracle.com,
 Juerg Haefliger <juerg.haefliger@canonical.com>, oao.m.martins@oracle.com,
 keescook@google.com, akpm@linux-foundation.org, torvalds@linux-foundation.org,
 dwmw@amazon.co.uk
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Wed, Feb 13, 2019 at 05:01:30PM -0700, Khalid Aziz wrote:
> From: Juerg Haefliger <juerg.haefliger@canonical.com>
> 
> If the page is unmapped by XPFO, a data cache flush results in a fatal
> page fault, so let's temporarily map the region, flush the cache, and then
> unmap it.
> 
> v6: actually flush in the face of xpfo, and temporarily map the underlying
>     memory so it can be flushed correctly
> 
> CC: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
> Signed-off-by: Tycho Andersen <tycho@docker.com>
> ---
>  arch/arm64/mm/flush.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
> index 30695a868107..fad09aafd9d5 100644
> --- a/arch/arm64/mm/flush.c
> +++ b/arch/arm64/mm/flush.c
> @@ -20,6 +20,7 @@
>  #include <linux/export.h>
>  #include <linux/mm.h>
>  #include <linux/pagemap.h>
> +#include <linux/xpfo.h>
>  
>  #include <asm/cacheflush.h>
>  #include <asm/cache.h>
> @@ -28,9 +29,15 @@
>  void sync_icache_aliases(void *kaddr, unsigned long len)
>  {
>  	unsigned long addr = (unsigned long)kaddr;
> +	unsigned long num_pages = XPFO_NUM_PAGES(addr, len);
> +	void *mapping[num_pages];

What version does this build on? Presumably -Wvla will cause an error
here, but,

>  	if (icache_is_aliasing()) {
> +		xpfo_temp_map(kaddr, len, mapping,
> +			      sizeof(mapping[0]) * num_pages);
>  		__clean_dcache_area_pou(kaddr, len);

Here, we map the pages to some random address via xpfo_temp_map(),
then pass the *original* address (which may not have been mapped) to
__clean_dcache_area_pou(). So I think this whole approach is wrong.

If we want to do it this way, it may be that we need some
xpfo_map_contiguous() type thing, but since we're just going to flush
it anyway, that seems a little crazy. Maybe someone who knows more
about arm64 knows a better way?

Tycho

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
