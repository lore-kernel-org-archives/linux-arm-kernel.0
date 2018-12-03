Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD37C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:11:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D6C620834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VyvSo9Y8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D6C620834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gF5hJLY/t6IqHRXte7C4M+MJF2BGc/HCAGcOXGGPdfA=; b=VyvSo9Y8+KUbQQ
	gBW6kxIxrjHCcFeV5RDL/Ua1YVqIJGMNAAPQDxJi9u1xee6vX8mqHqlEqUQCMc2YOBhVY39gIrVtX
	y9y3bVgWNM3+U6PA9l4l3HydfTwm0/QXSWR5T7t9xpLcaV/1XPWo8Yq/GKa3GxfSGZ1bZbAEnFRQP
	whGzzfRdv2UIZTdo7X+3ylW+sDE8WWu5jt6xvwKceqMEK+LhKz0PlOjtG/TK4biZOm7VPL963fyPc
	Lot79QQ+GuRMBVAWDcx3xWdnkqnntZ4y4nX8t/rOHwVtPgXvOj14lfmiakIhu9BCWB9oW5fvOgDu/
	MYen+CCt9EMgOFqSIjQg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTqof-00065v-NW; Mon, 03 Dec 2018 16:11:25 +0000
Received: from asavdk4.altibox.net ([109.247.116.15])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTqoc-000602-1L
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 16:11:24 +0000
Received: from ravnborg.org (unknown [158.248.194.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by asavdk4.altibox.net (Postfix) with ESMTPS id 5A86C804EA;
 Mon,  3 Dec 2018 17:10:54 +0100 (CET)
Date: Mon, 3 Dec 2018 17:10:52 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v2 3/6] sh: prefer memblock APIs returning virtual address
Message-ID: <20181203161052.GA4244@ravnborg.org>
References: <1543852035-26634-1-git-send-email-rppt@linux.ibm.com>
 <1543852035-26634-4-git-send-email-rppt@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1543852035-26634-4-git-send-email-rppt@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
 a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
 a=kj9zAlcOel0A:10 a=VnNF1IyMAAAA:8 a=FTNaidAvUsMVHdn4hVIA:9
 a=9GetFJ8xNGreKwwT:21 a=sKQTW2iCjVXyVLe6:21 a=CjuIK1q_8ugA:10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_081122_249247_CBC6277A 
X-CRM114-Status: GOOD (  18.78  )
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
Cc: Michal Hocko <mhocko@suse.com>, linux-sh@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-mm@kvack.org,
 Rich Felker <dalias@libc.org>, Paul Mackerras <paulus@samba.org>,
 sparclinux@vger.kernel.org, Vincent Chen <deanbo422@gmail.com>,
 Jonas Bonn <jonas@southpole.se>, linux-c6x-dev@linux-c6x.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Michael Ellerman <mpe@ellerman.id.au>, Russell King <linux@armlinux.org.uk>,
 Mark Salter <msalter@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 openrisc@lists.librecores.org, Greentime Hu <green.hu@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>,
 linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Mike.

On Mon, Dec 03, 2018 at 05:47:12PM +0200, Mike Rapoport wrote:
> Rather than use the memblock_alloc_base that returns a physical address and
> then convert this address to the virtual one, use appropriate memblock
> function that returns a virtual address.
> 
> There is a small functional change in the allocation of then NODE_DATA().
> Instead of panicing if the local allocation failed, the non-local
> allocation attempt will be made.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/sh/mm/init.c | 18 +++++-------------
>  arch/sh/mm/numa.c |  5 ++---
>  2 files changed, 7 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
> index c8c13c77..3576b5f 100644
> --- a/arch/sh/mm/init.c
> +++ b/arch/sh/mm/init.c
> @@ -192,24 +192,16 @@ void __init page_table_range_init(unsigned long start, unsigned long end,
>  void __init allocate_pgdat(unsigned int nid)
>  {
>  	unsigned long start_pfn, end_pfn;
> -#ifdef CONFIG_NEED_MULTIPLE_NODES
> -	unsigned long phys;
> -#endif
>  
>  	get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
>  
>  #ifdef CONFIG_NEED_MULTIPLE_NODES
> -	phys = __memblock_alloc_base(sizeof(struct pglist_data),
> -				SMP_CACHE_BYTES, end_pfn << PAGE_SHIFT);
> -	/* Retry with all of system memory */
> -	if (!phys)
> -		phys = __memblock_alloc_base(sizeof(struct pglist_data),
> -					SMP_CACHE_BYTES, memblock_end_of_DRAM());
> -	if (!phys)
> +	NODE_DATA(nid) = memblock_alloc_try_nid_nopanic(
> +				sizeof(struct pglist_data),
> +				SMP_CACHE_BYTES, MEMBLOCK_LOW_LIMIT,
> +				MEMBLOCK_ALLOC_ACCESSIBLE, nid);
> +	if (!NODE_DATA(nid))
>  		panic("Can't allocate pgdat for node %d\n", nid);
> -
> -	NODE_DATA(nid) = __va(phys);
> -	memset(NODE_DATA(nid), 0, sizeof(struct pglist_data));
The new code will always assign NODE_DATA(nid), where the old
code only assigned NODE_DATA(nid) in the good case.
I dunno if this is an issue, just noticed the difference and
wanted to point it out.

	Sam

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
