Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4BBC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:57:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BE1620870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ndmL+Z/m";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h8tCjVnR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BE1620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=31yaxmFgOhTA1LMUQ7TFN3xPJNBVe6YHf4XtU8hOMpk=; b=ndmL+Z/mVfjlLM
	FHoYI2jvoQCGkX+2SDYwtnANxsAeMRrAKcMMQs6AOQ/oJl9HPp64PbCo011oLKZSPcky0Dp/BzFDL
	Kh+tsQ0vffxqllyURlbFDlV30W035EcpmcJukGeUkkrwF8keXEY8WHbjp/KfnemF6B4B+4D2j5L46
	gUlNxAJ/9UokOa7mNR6hyCO4kG2DHu9MTlP+MiHbHaHcjzRYqB7gPMQ9WN7GUa9GvjB52GDVLHbwk
	mAB+cLprzEe7Y/QcDrlu172AElkTvAKqNO3NWWuBYJxH9EGsORJYfqD+MfjYnS3DKpx802mmZyAdT
	TNjKGArkw5eZLP3CTrag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmJxt-0005l2-L5; Wed, 23 Jan 2019 14:57:17 +0000
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmJxm-0005kc-Ji
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 14:57:12 +0000
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0NErfH7103115;
 Wed, 23 Jan 2019 14:56:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=0WzAEL2+nx+ZLQHNgNtnqhO5Hl0kbzE3M/nBLj6qrvo=;
 b=h8tCjVnRme9dM+Wk135i8T/ZfmOBbswLUeguuWpA476j8jFGsnZYs2oEI/ixYZVL1Ban
 P1l7dnMO3no3e+sjrPqGaFIWJj2VWogjSnZEADpX9usnhhmollS6uwuanJyXG3KlU3AL
 oqfUq7xJP+ME3KQlpyKiEauGeU3LvavXC0RnPaQBwoq71Gv6QVIcSQ2Xcmh9hQl+z85P
 ERSOdPyEqpNy1vjJPGYzKxfNHFQxkro5810rwERhvOFqbcCx/mOqBonAptGqOjz6xDfi
 w1sxaaxiLw3SWq3iUxfWjZA14q+TimKxbumIj4bm42M9B4pfe2fLEuK7/5IKLV1q58LP wg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
 by userp2120.oracle.com with ESMTP id 2q3vhrt6u8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Jan 2019 14:56:47 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0NEukfS015615
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Jan 2019 14:56:46 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0NEuhbu032386;
 Wed, 23 Jan 2019 14:56:43 GMT
Received: from Konrads-MacBook-Pro.local (/75.104.64.133)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 23 Jan 2019 06:56:42 -0800
Date: Wed, 23 Jan 2019 09:56:03 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Khalid Aziz <khalid.aziz@oracle.com>
Subject: Re: [RFC PATCH v7 07/16] arm64/mm, xpfo: temporarily map dcache
 regions
Message-ID: <20190123145551.GD19289@Konrads-MacBook-Pro.local>
References: <cover.1547153058.git.khalid.aziz@oracle.com>
 <eba179acbfdea5a646c5548cb82138c1c3b74aa2.1547153058.git.khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <eba179acbfdea5a646c5548cb82138c1c3b74aa2.1547153058.git.khalid.aziz@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9144
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=839
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901230112
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_065710_784904_85546323 
X-CRM114-Status: GOOD (  22.87  )
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
Cc: Tycho Andersen <tycho@docker.com>, kernel-hardening@lists.openwall.com,
 linux-mm@kvack.org, deepa.srinivasan@oracle.com, steven.sistare@oracle.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com, tycho@tycho.ws,
 ak@linux.intel.com, hch@lst.de, kanth.ghatraju@oracle.com, jsteckli@amazon.de,
 pradeep.vincent@oracle.com, jcm@redhat.com, liran.alon@oracle.com,
 tglx@linutronix.de, chris.hyser@oracle.com,
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

Is it possible that the 'len' is more than 32 pages? Or say 1000's
of pages? Which would blow away your stack.

> +	void *mapping[num_pages];
>  
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
