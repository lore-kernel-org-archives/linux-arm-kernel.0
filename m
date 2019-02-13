Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F002DC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:51:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD0A1222B2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BWY0dQvt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/K+qi+p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD0A1222B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:Date:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ieCaZq0t4YAhC/s3Gn2UQ6A/uMhOEPdeTlpZjV3JFAo=; b=BWY0dQvtfj0bcy
	jxZBp+Sbwrn+dR9+AYl30lS7qEfsZg4a0is1eq5/9o4p6N10rtgkFUL1MPzCodA07/s8tTPN0D7BZ
	OYBvloKYXHKNG339vG4C2aJW8VYIeGgHCepuUOEpP2CwcMSPAQDYalyIhwAlPsfHA8touh7Gv7Ua+
	HtUMjhOKyOeiLL5Hdbl8DFvYuh7DSgMsyPMe+KR/PvmCSHIAjm1CkA9AdwC8G0qm4ZYAyzJXlIKaq
	q0GDE58/xtV3/FH/X7gapGz4JuU55rEJ7tF8t7Rv/kCAvaCpSqO0oXQnnCsW/3eRNGz/yscMbNlpl
	vxzuQwOELzuqTgXB6tnw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtt4V-00070B-6z; Wed, 13 Feb 2019 11:51:23 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtt4S-0006zo-ID
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 11:51:22 +0000
Received: by mail-lj1-x243.google.com with SMTP id e17-v6so1733275lja.8
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 03:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:date:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=y2TfdZ0yfTGpis63yNWrafK+XaRU06nb4gEkHH7COEE=;
 b=U/K+qi+paWdkDRULPZbGIICjBcrRkimFGR7TkTH7w1oYvIF+e93YHSXDaVWj/b37VA
 UjRTbvEJJ0AToAAHAXAAfJRUCk5rkcnk3F/3SkTbXsdUWx28m7Z7+T2F8lFNQJFo9xmQ
 yAW1oi+5yOG33GEY1qo0lC0ODM7AyCXT0G0/WZEBJzXVm0/A0ebx4dd2dHwXOeqJYWMy
 Sz127F3lpDdjqv8SXg3XcsONDZNgNDVVYfQMm4Xx2/mZa6VEzxn2c3mEgyLX9m8C3WJP
 Ckq+SEd8WJ6Y3CpcLUXcGWyvwI+o0jpqckspDNLT9Kh5W0mRvo2iAi2UwycVxQYkvABN
 oOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=y2TfdZ0yfTGpis63yNWrafK+XaRU06nb4gEkHH7COEE=;
 b=PSVbs79Q9cITBJHTZz3EQ8XFKMpJ4QhhqeLZ7FJkCxPdy6HAOe/3Kmwa3clsxwTY15
 3nQoSi/N4UMkqxIsRqhSdMjI5TNaRyAt39fBek72bmJM/E0dxUsT/WIoEKkLIQXExsIO
 y4hf0/rDRUK8ywI2pCPA6ZfY28EJlrvCDTi+Si1CK7+5j0m6hhMKHrfHDEkGdJZhMRYL
 zUTBOuI90KzXkq21cmI7w5uFm1O6Y7D+HtbX3nwm1aiAi67fnJq6uytRCeSOijD8xQnT
 SI8Q/I469aeUYxF6Wxnm67CRGslK+I6voFYsSDlV6v1vKx/ebzrj5pP8k1/5PmpRljcg
 IPCg==
X-Gm-Message-State: AHQUAubGStv+6Juf1n0XpdCWfHmpGSLbORQY3x2wiZv8v0f1qDDU2PoK
 IHjgaHzp2WadXOigYUdIu7c=
X-Google-Smtp-Source: AHgI3IbKXU2LyicoJFoNlpLhj27pcZqbW7yAjx3ylCb7UMoTN9ouTk+wlHVAd8f1Fftp/hJv13bKLA==
X-Received: by 2002:a2e:2416:: with SMTP id k22-v6mr73769ljk.80.1550058678351; 
 Wed, 13 Feb 2019 03:51:18 -0800 (PST)
Received: from localhost (pat-31-128-146-191.pool.powernet.com.ru.
 [31.128.146.191])
 by smtp.gmail.com with ESMTPSA id q128-v6sm3374469ljq.14.2019.02.13.03.51.17
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 13 Feb 2019 03:51:17 -0800 (PST)
From: Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@marvell.com>
Date: Wed, 13 Feb 2019 14:51:15 +0300
To: Mel Gorman <mgorman@techsingularity.net>
Subject: Re: 5.0-rc kernel hangs on early boot
Message-ID: <20190213115115.GA8928@yury-thinkpad>
References: <20190213082134.GA21834@yury-thinkpad>
 <20190213111409.GN9565@techsingularity.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190213111409.GN9565@techsingularity.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_035120_621699_AD1503BD 
X-CRM114-Status: GOOD (  26.25  )
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
Cc: Andrea Arcangeli <aarcange@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Yury Norov <yury.norov@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 Michal Hocko <mhocko@kernel.org>, linux-arm-kernel@lists.infradead.org,
 David Rientjes <rientjes@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <zi.yan@cs.rutgers.edu>,
 Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 13, 2019 at 11:14:09AM +0000, Mel Gorman wrote:
> On Wed, Feb 13, 2019 at 11:25:40AM +0300, Yury Norov wrote:
> > Hi Mel, all,
> > 
> > My kernel on qemu/arm64 setup hangs at early boot since v5.0-rc1.
> > Backtrace is not too verbose:
> > (gdb) i threads
> >   Id   Target Id         Frame
> > * 1    Thread 1 (CPU#0 [running]) 0xffff000010a49b74 in __delay (cycles=4096)
> >     at arch/arm64/lib/delay.c:49
> >   2    Thread 2 (CPU#1 [halted ]) 0x0000000000000000 in ?? ()
> >   3    Thread 3 (CPU#2 [halted ]) 0x0000000000000000 in ?? ()
> >   4    Thread 4 (CPU#3 [halted ]) 0x0000000000000000 in ?? ()
> > (gdb) bt
> > #0  0xffff000010a49b74 in __delay (cycles=4096) at arch/arm64/lib/delay.c:49
> > Backtrace stopped: previous frame identical to this frame (corrupt stack?)
> > 
> > Reverting the patch
> > 1c30844d2dfe272d58c ("mm: reclaim small amounts of memory when an external
> > fragmentation event occurs") together with following patch
> > 73444bc4d8f92e46a20 ("mm, page_alloc: do not wake kswapd with zone lock held")
> > helps me to boot normally. 
> > 
> 
> Well, that's a bad start to any day. Thanks for tracking it down. Does
> the following patch help? I can't test it properly as I didn't recreate
> your boot image or initrd but this appears to get past the initial boot
> phase at least.

Hi Mel,

The patch works for me. The day gets better indeed. :-)

Tested-by: Yury Norov <yury.norov@gmail.com>

Yury

> ---8<---
> mm, page_alloc: Fix a division by zero error when boosting watermarks
> 
> Yury Norov reported that an arm64 KVM instance could not boot since after
> v5.0-rc1 and could addressed by reverting the patches
> 
> 1c30844d2dfe272d58c ("mm: reclaim small amounts of memory when an external
> 73444bc4d8f92e46a20 ("mm, page_alloc: do not wake kswapd with zone lock held")
> 
> The problem is that a division by zero error is possible if boosting occurs
> either very early in boot or if the high watermark is very small. This
> patch checks for the conditions and avoids boosting in those cases.
> 
> Fixes: 1c30844d2dfe ("mm: reclaim small amounts of memory when an external fragmentation event occurs")
> Reported-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> 
> ---
>  mm/page_alloc.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d295c9bc01a8..ae7e4ba5b9f5 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2170,6 +2170,11 @@ static inline void boost_watermark(struct zone *zone)
>  
>  	max_boost = mult_frac(zone->_watermark[WMARK_HIGH],
>  			watermark_boost_factor, 10000);
> +
> +	/* high watermark be be uninitialised or very small */
> +	if (!max_boost)
> +		return;
> +
>  	max_boost = max(pageblock_nr_pages, max_boost);
>  
>  	zone->watermark_boost = min(zone->watermark_boost + pageblock_nr_pages,
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
