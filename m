Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91FAC37123
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:22:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3AEF20861
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="B8Dbba6L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3AEF20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-Id:In-Reply-To:MIME-Version:
	References:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2LuXzjLjFNRucKwCh1dRGc4xprH7z8sFpQ2Bo8hnBRM=; b=B8Dbba6L/nKLrv
	CricWqu7hNNWycvEbyjM9orrw2exexMiVFYBiU1TXwJmp882NWdw0UiFA0hMd8vgIOFkcDsH7qSoi
	jP746vTxjFGN83+hD8tZIurQtvLg79F2GZh0O+r71fwF07jWGoGabv93KZhPcBsWWB97B/rSP47ow
	2WN1Yuv+8K6X7F0UJr0WhOf3KjbBt6q6yBJ5Jb9LforVjEslpoXvoZh0CGelMh/go8EzfLbJZBCJ0
	eWGzB9bGokp0LJw5zhBuoKT2FVokhE48B9GzwPDWetLtvdAAWQMRCR1fxhcNtP6IRD9ekAs2hfGxz
	I2hxW2AfTDNFIB/SmcXA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glh1a-0004Qm-Hi; Mon, 21 Jan 2019 21:22:30 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glh1T-0004Q5-Fw
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 21:22:29 +0000
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0LLJV8C132600
 for <linux-arm-kernel@lists.infradead.org>; Mon, 21 Jan 2019 16:22:21 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2q5nuk05gk-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-arm-kernel@lists.infradead.org>; Mon, 21 Jan 2019 16:22:21 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-arm-kernel@lists.infradead.org> from <rppt@linux.ibm.com>;
 Mon, 21 Jan 2019 21:22:19 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 21 Jan 2019 21:22:15 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0LLMEgk62521572
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 21 Jan 2019 21:22:14 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 07BFF52051;
 Mon, 21 Jan 2019 21:22:14 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.206.250])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 8EF9952050;
 Mon, 21 Jan 2019 21:22:12 +0000 (GMT)
Date: Mon, 21 Jan 2019 23:22:10 +0200
From: Mike Rapoport <rppt@linux.ibm.com>
To: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] ARM: mm: initialize pfn limits with find_limits()
References: <1545954447-22513-1-git-send-email-opendmb@gmail.com>
 <c05d7dcf-ab03-1313-d7b8-d630cdaed167@gmail.com>
 <ab09bcea-a55d-e562-6637-0df909b03e22@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ab09bcea-a55d-e562-6637-0df909b03e22@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19012121-0008-0000-0000-000002B40EC4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012121-0009-0000-0000-00002220382D
Message-Id: <20190121212209.GA16047@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-21_12:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901210166
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_132224_487659_D2E9B53D 
X-CRM114-Status: GOOD (  31.28  )
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
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Doug Berger <opendmb@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Michal Hocko <mhocko@suse.com>,
 Russell King <linux@armlinux.org.uk>,
 "Steven Rostedt \(VMware\)" <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org, Jinbum Park <jinb.park7@gmail.com>,
 Mike Rapoport <rppt@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 21, 2019 at 12:48:09PM -0800, Florian Fainelli wrote:
> On 1/10/19 11:07 AM, Doug Berger wrote:
> > On 12/27/18 3:47 PM, Doug Berger wrote:
> >> The max_low_pfn value must be set before sparse_init() is called to
> >> keep the early memblock allocations and frees balanced for kmemleak
> >> initialization when sparsemem is enabled.
> >>
> >> This commit accomplishes that by replacing the local variables min,
> >> max_low, and max_high with the global limit variables min_low_pfn,
> >> max_low_pfn, and max_pfn respectively in bootmem_init(). The global
> >> variables are initialized directly by find_limits() and used in the
> >> remainder of the function.
> >>
> >> Fixes: 9099daed9c69 ("mm: kmemleak: avoid using __va() on addresses that don't have a lowmem mapping")
> >> Signed-off-by: Doug Berger <opendmb@gmail.com>
> >> ---
> >>  arch/arm/mm/init.c | 20 ++++----------------
> >>  1 file changed, 4 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> >> index 32e4845af2b6..98a733f3a5b9 100644
> >> --- a/arch/arm/mm/init.c
> >> +++ b/arch/arm/mm/init.c
> >> @@ -302,15 +302,12 @@ void __init arm_memblock_init(const struct machine_desc *mdesc)
> >>  
> >>  void __init bootmem_init(void)
> >>  {
> >> -	unsigned long min, max_low, max_high;
> >> -
> >>  	memblock_allow_resize();
> >> -	max_low = max_high = 0;
> >>  
> >> -	find_limits(&min, &max_low, &max_high);
> >> +	find_limits(&min_low_pfn, &max_low_pfn, &max_pfn);
> >>  
> >> -	early_memtest((phys_addr_t)min << PAGE_SHIFT,
> >> -		      (phys_addr_t)max_low << PAGE_SHIFT);
> >> +	early_memtest((phys_addr_t)min_low_pfn << PAGE_SHIFT,
> >> +		      (phys_addr_t)max_low_pfn << PAGE_SHIFT);
> >>  
> >>  	/*
> >>  	 * Sparsemem tries to allocate bootmem in memory_present(),
> >> @@ -328,16 +325,7 @@ void __init bootmem_init(void)
> >>  	 * the sparse mem_map arrays initialized by sparse_init()
> >>  	 * for memmap_init_zone(), otherwise all PFNs are invalid.
> >>  	 */
> >> -	zone_sizes_init(min, max_low, max_high);
> >> -
> >> -	/*
> >> -	 * This doesn't seem to be used by the Linux memory manager any
> >> -	 * more, but is used by ll_rw_block.  If we can get rid of it, we
> >> -	 * also get rid of some of the stuff above as well.
> >> -	 */
> >> -	min_low_pfn = min;
> >> -	max_low_pfn = max_low;
> >> -	max_pfn = max_high;
> >> +	zone_sizes_init(min_low_pfn, max_low_pfn, max_pfn);
> >>  }
> >>  
> >>  /*
> >>
> > 
> > Any feedback on this patch?
> 
> Mike, Catalin, does this looks sensible to you? If so, should this be
> thrown into Russell's patch tracking system?

Makes perfect sense to me, so

Acked-by: Mike Rapoport <rppt@linux.ibm.com>
 
> Thanks
> -- 
> Florian
> 

-- 
Sincerely yours,
Mike.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
