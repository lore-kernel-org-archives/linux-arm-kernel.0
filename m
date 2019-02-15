Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E515C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:48:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F8742192D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OJW2KSXa";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g5aUM/On"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F8742192D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6q0Eue2yw29/sbuAWW4S/77CuIaqMb2Aslna5hwxmwU=; b=OJW2KSXa0ZS8ua
	+KyR4MpdG4XoCv6azL/5/yNsLSwkSAfLfGmbaJ+Jaqgm4DvdQSwW6I6efwQRQd9CiabX/PSewvqhh
	N1tDV3+rBM4Rfs1wP94vuYn4XyS/SuzvXsw3keLJti0+tRP6p+DpCO8wQrDL3G/7R2WHHjaXP9Vus
	Q0RM2RHfIpEn9YvLjx/8ur83giGlz4koLJaHh4KW9tNWBa3tKu3LSvTi2g58xVOvJnEslaXHucxSF
	rG3i3c0F3i1ijNZrHvJgdeLCp//7iEOtj/dIiADTJfTdy0UUFsGhMbavmr3UjM8vbw024T4NFC/03
	5KCjgcIrecpRWUTFOptw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guen1-0005cN-TP; Fri, 15 Feb 2019 14:48:31 +0000
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guemy-0005bz-1M
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 14:48:29 +0000
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1FEhRvN145107;
 Fri, 15 Feb 2019 14:47:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=LEY7b8sXzNhyukf/ItsQKn6GFmrxWnF+Kj6inOmoBHc=;
 b=g5aUM/On3juV/6dNCJ2/OPN3ycrzeV3k+bTRNIwfJ5yfySj0ogZ65V6Ery9ajs+y+1K6
 xQDwcYHlLsxTVGxBV8ZWA3LT2FJhKKd2yIk4Ltc2YEVL1Q8qeDbrVX4rnZKdxo60pC2h
 a+9qBgfNukozi/KUtGkG6l3uJCPI0dsggN1RLy/LdTqBKeYBM6/LDe8OCznIOKL0sGnt
 dSfomHBKKf5Dzv2Zrv1yTCgOfa8hasNabaEVOnl+MwIQ+1JpEb/91xKVgN9JLyGsclyL
 3+8N2FM42kLuumKB62tz2JlM/ZeCqYl8mlM8oMcSNa/aJxdVwcgE7ZEbX+Y+ODel/LYk pQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
 by userp2130.oracle.com with ESMTP id 2qhrekx7nq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Feb 2019 14:47:44 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1FEliLE020615
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Feb 2019 14:47:44 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1FEldPL008491;
 Fri, 15 Feb 2019 14:47:39 GMT
Received: from [192.168.1.16] (/24.9.64.241)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 15 Feb 2019 14:47:39 +0000
Subject: Re: [RFC PATCH v8 08/14] arm64/mm: disable section/contiguous
 mappings if XPFO is enabled
To: Mark Rutland <mark.rutland@arm.com>
References: <cover.1550088114.git.khalid.aziz@oracle.com>
 <0b9624b6c1fe5a31d73a6390e063d551bfebc321.1550088114.git.khalid.aziz@oracle.com>
 <20190215130942.GD53520@lakrids.cambridge.arm.com>
From: Khalid Aziz <khalid.aziz@oracle.com>
Organization: Oracle Corp
Message-ID: <259cac45-3337-d446-5abc-21b694d916e1@oracle.com>
Date: Fri, 15 Feb 2019 07:47:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190215130942.GD53520@lakrids.cambridge.arm.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9167
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902150102
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_064828_170504_FB5DF981 
X-CRM114-Status: GOOD (  26.54  )
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
Cc: mhocko@suse.com, Tycho Andersen <tycho@docker.com>,
 kernel-hardening@lists.openwall.com, peterz@infradead.org,
 catalin.marinas@arm.com, will.deacon@arm.com, dave.hansen@intel.com,
 deepa.srinivasan@oracle.com, steven.sistare@oracle.com,
 joao.m.martins@oracle.com, tglx@linutronix.de, tycho@tycho.ws,
 ak@linux.intel.com, x86@kernel.org, jmorris@namei.org, hch@lst.de,
 kanth.ghatraju@oracle.com, jsteckli@amazon.de, labbott@redhat.com,
 pradeep.vincent@oracle.com, konrad.wilk@oracle.com, jcm@redhat.com,
 liran.alon@oracle.com, luto@kernel.org, boris.ostrovsky@oracle.com,
 chris.hyser@oracle.com, linux-arm-kernel@lists.infradead.org,
 jmattson@google.com, linux-mm@kvack.org, juergh@gmail.com,
 andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org, tyhicks@canonical.com,
 john.haxby@oracle.com, kirill.shutemov@linux.intel.com, keescook@google.com,
 akpm@linux-foundation.org, torvalds@linux-foundation.org, dwmw@amazon.co.uk
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2/15/19 6:09 AM, Mark Rutland wrote:
> Hi,
> 
> On Wed, Feb 13, 2019 at 05:01:31PM -0700, Khalid Aziz wrote:
>> From: Tycho Andersen <tycho@docker.com>
>>
>> XPFO doesn't support section/contiguous mappings yet, so let's disable it
>> if XPFO is turned on.
>>
>> Thanks to Laura Abbot for the simplification from v5, and Mark Rutland for
>> pointing out we need NO_CONT_MAPPINGS too.
>>
>> CC: linux-arm-kernel@lists.infradead.org
>> Signed-off-by: Tycho Andersen <tycho@docker.com>
>> Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>
> 
> There should be no point in this series where it's possible to enable a
> broken XPFO. Either this patch should be merged into the rest of the
> arm64 bits, or it should be placed before the rest of the arm64 bits.
> 
> That's a pre-requisite for merging, and it significantly reduces the
> burden on reviewers.
> 
> In general, a patch series should bisect cleanly. Could you please
> restructure the series to that effect?
> 
> Thanks,
> Mark.

That sounds reasonable to me. I will merge this with patch 5 ("arm64/mm:
Add support for XPFO") for the next version unless there are objections.

Thanks,
Khalid

> 
>> ---
>>  arch/arm64/mm/mmu.c  | 2 +-
>>  include/linux/xpfo.h | 4 ++++
>>  mm/xpfo.c            | 6 ++++++
>>  3 files changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index d1d6601b385d..f4dd27073006 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -451,7 +451,7 @@ static void __init map_mem(pgd_t *pgdp)
>>  	struct memblock_region *reg;
>>  	int flags = 0;
>>  
>> -	if (debug_pagealloc_enabled())
>> +	if (debug_pagealloc_enabled() || xpfo_enabled())
>>  		flags = NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>>  
>>  	/*
>> diff --git a/include/linux/xpfo.h b/include/linux/xpfo.h
>> index 1ae05756344d..8b029918a958 100644
>> --- a/include/linux/xpfo.h
>> +++ b/include/linux/xpfo.h
>> @@ -47,6 +47,8 @@ void xpfo_temp_map(const void *addr, size_t size, void **mapping,
>>  void xpfo_temp_unmap(const void *addr, size_t size, void **mapping,
>>  		     size_t mapping_len);
>>  
>> +bool xpfo_enabled(void);
>> +
>>  #else /* !CONFIG_XPFO */
>>  
>>  static inline void xpfo_kmap(void *kaddr, struct page *page) { }
>> @@ -69,6 +71,8 @@ static inline void xpfo_temp_unmap(const void *addr, size_t size,
>>  }
>>  
>>  
>> +static inline bool xpfo_enabled(void) { return false; }
>> +
>>  #endif /* CONFIG_XPFO */
>>  
>>  #endif /* _LINUX_XPFO_H */
>> diff --git a/mm/xpfo.c b/mm/xpfo.c
>> index 92ca6d1baf06..150784ae0f08 100644
>> --- a/mm/xpfo.c
>> +++ b/mm/xpfo.c
>> @@ -71,6 +71,12 @@ struct page_ext_operations page_xpfo_ops = {
>>  	.init = init_xpfo,
>>  };
>>  
>> +bool __init xpfo_enabled(void)
>> +{
>> +	return !xpfo_disabled;
>> +}
>> +EXPORT_SYMBOL(xpfo_enabled);
>> +
>>  static inline struct xpfo *lookup_xpfo(struct page *page)
>>  {
>>  	struct page_ext *page_ext = lookup_page_ext(page);
>> -- 
>> 2.17.1
>>



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
