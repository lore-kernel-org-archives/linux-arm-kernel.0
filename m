Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43B6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:55:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74D9420872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bG3Gq/uF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="JcGQYfCr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74D9420872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aKVX9/qogIowJu3aPi4uBAIwkAxI6dYG9EPhvX2LdAc=; b=bG3Gq/uFiLpjvV
	+N2reWun2pJ7CoUk94VBjTmQRByUJvMZNwhVMgtZOsJ+SgX1Bh9GMgORIBXMhM9f0oC+yAcb2THQY
	O3uaTkpTuPtngwWJ/7SWHl97JUh9UMhD2yPzhdePBHJiNJ63005Vx4r7Nj5fv8DstvcM4ivTezcM4
	c1RgaUaFXoIFak/AnlW8Ga2dVKtbOIqHCNOO3hToYOBsBQnjJ+uWN1FBox35affXPds878fg4H4Xl
	EM7fQJNuduEniWQly+IZTMG4lW7hdA6ymn7rT6hGnMTuRqraP/WL+EDwpdID/omyIZmU0mhg2X9dD
	dUPxTjW5ZshisIcFZ/jA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghyD3-00014k-HA; Fri, 11 Jan 2019 14:54:57 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghyCw-00011j-6E
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 14:54:55 +0000
Received: by mail-it1-x142.google.com with SMTP id w18so2857422ite.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 06:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tycho-ws.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=uJh/pMTsGneTKaKggyvXF+Sg9B2wbRdl3/xWASaoeJw=;
 b=JcGQYfCr0JAkjBFuTWcLasw8AQZ+fTJzH8LyaRL8LAp8Zh8uneEWnO1VqaQLOAjB0r
 HMBtrlwZEzKilvHbM3I3jUn6BVPEyAh64wzW9U/YwxMxpUmcjtg1QRIgJHo++a0v2Fwa
 5cz01rN1NeWfZdn8q+LQgxhtBkyCW7rEauev9VhGi2fimSrQIPyI9sxbIJd3PPxuf1NH
 Uqa59o2TEYkxG4fDOtRajtWdH044la6qzI3LVPnCNFUEUwqNoHYw6/Lh7nlGuEJKSKvy
 mdG4WtIkXb4KuW03qGLNMCDUFjgwEN16yFKRFu38CRWlqqOiQpv1WhIysxhmchpISxMb
 G7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=uJh/pMTsGneTKaKggyvXF+Sg9B2wbRdl3/xWASaoeJw=;
 b=Mt3kafnLflRqCM5/PfgcUxWVIb2TLZ76tbXszO+wAF/QgTg4UUeGKDk5+XZbXEw8MW
 sSqoKfZNw4qgXjTJfHJQjK1b7iElnUJ60VFCMnt5/xLj7qZolYx6+PCAuEpm5JdKZLqA
 S5oubr3njJoxMN4KtpITejiusajAsooKFQ5Av8yZlqrsmkL1SuPWjT2U6xoCaMR15Wnc
 EfTGYu2zbXssjL3/sTLcO86KcXxQ05c5nHYqJ9lmjnUHgALnnPC4U3MZRn9/rEv/fEcu
 YOuvOB0j4kUi5OHETmJRnCg8cGMpSmuf7E/TfLkWdtSRkXeWYNTzaktN0aFTu1RLaAFz
 fdBA==
X-Gm-Message-State: AJcUukdKCFc6kMkg5RGZ6zrTl2YD4GY+iLU0zLA/M2xj+3wuDzVLGI2i
 Ow+wOY2nNo9Qxi/cxnEcF/n2Bw==
X-Google-Smtp-Source: ALg8bN6KCMZX9D782XIM0sEno9u8EK/u/rCjLFpSCEvmMj5+Pt/LjL9iF+g6YFTIunFQgkmw/L9Fjg==
X-Received: by 2002:a24:fe06:: with SMTP id w6mr1349599ith.108.1547218488492; 
 Fri, 11 Jan 2019 06:54:48 -0800 (PST)
Received: from cisco ([2601:282:901:dd7b:c69:9cc7:f9cf:ff1b])
 by smtp.gmail.com with ESMTPSA id l21sm15740077ioh.42.2019.01.11.06.54.46
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 11 Jan 2019 06:54:47 -0800 (PST)
Date: Fri, 11 Jan 2019 07:54:45 -0700
From: Tycho Andersen <tycho@tycho.ws>
To: Khalid Aziz <khalid.aziz@oracle.com>
Subject: Re: [RFC PATCH v7 07/16] arm64/mm, xpfo: temporarily map dcache
 regions
Message-ID: <20190111145445.GA4102@cisco>
References: <cover.1547153058.git.khalid.aziz@oracle.com>
 <eba179acbfdea5a646c5548cb82138c1c3b74aa2.1547153058.git.khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <eba179acbfdea5a646c5548cb82138c1c3b74aa2.1547153058.git.khalid.aziz@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_065450_473245_202D93AF 
X-CRM114-Status: GOOD (  17.14  )
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
Cc: kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
 deepa.srinivasan@oracle.com, steven.sistare@oracle.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com, ak@linux.intel.com,
 hch@lst.de, kanth.ghatraju@oracle.com, jsteckli@amazon.de,
 pradeep.vincent@oracle.com, konrad.wilk@oracle.com, jcm@redhat.com,
 liran.alon@oracle.com, tglx@linutronix.de, chris.hyser@oracle.com,
 linux-arm-kernel@lists.infradead.org, jmattson@google.com, juergh@gmail.com,
 andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org, tyhicks@canonical.com,
 john.haxby@oracle.com, Juerg Haefliger <juerg.haefliger@canonical.com>,
 dwmw@amazon.co.uk, keescook@google.com, torvalds@linux-foundation.org,
 kirill.shutemov@linux.intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 10, 2019 at 02:09:39PM -0700, Khalid Aziz wrote:
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
> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
> ---
>  arch/arm64/mm/flush.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
> index 30695a868107..f12f26b60319 100644
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

Does this still compile with -Wvla? It was a bad hack on my part, and
we should probably just drop it and come up with something else :)

Tycho

>  	if (icache_is_aliasing()) {
> +		xpfo_temp_map(kaddr, len, mapping,
> +			      sizeof(mapping[0]) * num_pages);
>  		__clean_dcache_area_pou(kaddr, len);
> +		xpfo_temp_unmap(kaddr, len, mapping,
> +			        sizeof(mapping[0]) * num_pages);
>  		__flush_icache_all();
>  	} else {
>  		flush_icache_range(addr, addr + len);
> -- 
> 2.17.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
