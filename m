Return-Path: <SRS0=5+Aw=QR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97A7C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 09:55:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79CA620873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 09:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R9ih/3tr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79CA620873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-Id:In-Reply-To:MIME-Version:
	References:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=99fRu7k66B5RCgQRZVWbGx/AkUKWgK0raIwhhu+Q6ZY=; b=R9ih/3tr0qUUQ1
	wCySc9seIPOzczlBEcV2ZPiFGvDgk2b5mHBkplN5aD9N5ZV8bJmhV1N9qdzunMrgjMSFGKMpoEPSw
	GYXke0HZe8izc62nztRgZJ6wYaUBSw3SHVtPEG0nud7UUIPHxrh70RTIsjrBl4PY8lGBMNAwqi65Z
	WSLSDURlooHa2gTM5iSXX/tzJQ29eC3seY8Pfvv3fC/okFMCX1Rm5PBtqcuwnzBJM2R3MaLKK8JIC
	mmg4ZlS/c3/UvzB7Yvyqq1NLzGwyBqOotH2O+/OZhb2Oh/V41c49rLivVghHKiWFeuwAITUZbpc1d
	KemRFvNRomNCCXvxky6Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gslpl-0005AN-9Q; Sun, 10 Feb 2019 09:55:33 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gslph-00059j-IR
 for linux-arm-kernel@lists.infradead.org; Sun, 10 Feb 2019 09:55:31 +0000
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1A9rJpS069935
 for <linux-arm-kernel@lists.infradead.org>; Sun, 10 Feb 2019 04:55:26 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2qjd6k50ju-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-arm-kernel@lists.infradead.org>; Sun, 10 Feb 2019 04:55:26 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-arm-kernel@lists.infradead.org> from <rppt@linux.ibm.com>;
 Sun, 10 Feb 2019 09:55:24 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Sun, 10 Feb 2019 09:55:19 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1A9tIar54657110
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 10 Feb 2019 09:55:18 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8E25E4C050;
 Sun, 10 Feb 2019 09:55:18 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 647D84C046;
 Sun, 10 Feb 2019 09:55:17 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.84])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Sun, 10 Feb 2019 09:55:17 +0000 (GMT)
Date: Sun, 10 Feb 2019 11:55:15 +0200
From: Mike Rapoport <rppt@linux.ibm.com>
To: Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] arm64: use memblocks_present
References: <20190210093738.30923-1-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190210093738.30923-1-peng.fan@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19021009-0028-0000-0000-00000346C58A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021009-0029-0000-0000-00002404DDD0
Message-Id: <20190210095515.GA12403@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-10_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902100077
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190210_015529_730456_0DAD6DA1 
X-CRM114-Status: GOOD (  24.88  )
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
Cc: "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
 "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stefan@agner.ch" <stefan@agner.ch>,
 "logang@deltatee.com" <logang@deltatee.com>,
 "rppt@linux.vnet.ibm.com" <rppt@linux.vnet.ibm.com>,
 "james.morse@arm.com" <james.morse@arm.com>,
 "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
 "van.freenix@gmail.com" <van.freenix@gmail.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "ghackmann@android.com" <ghackmann@android.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Feb 10, 2019 at 09:28:43AM +0000, Peng Fan wrote:
> arm64_memory_present is doing same thing as memblocks_present, so
> let's use common code memblocks_present instead of platform
> specific arm64_memory_present.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  arch/arm64/mm/init.c | 20 +-------------------
>  1 file changed, 1 insertion(+), 19 deletions(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 7205a9085b4d..2302b4093a63 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -285,24 +285,6 @@ int pfn_valid(unsigned long pfn)
>  }
>  EXPORT_SYMBOL(pfn_valid);
>  
> -#ifndef CONFIG_SPARSEMEM
> -static void __init arm64_memory_present(void)
> -{
> -}
> -#else
> -static void __init arm64_memory_present(void)
> -{
> -	struct memblock_region *reg;
> -
> -	for_each_memblock(memory, reg) {
> -		int nid = memblock_get_region_node(reg);
> -
> -		memory_present(nid, memblock_region_memory_base_pfn(reg),
> -				memblock_region_memory_end_pfn(reg));
> -	}
> -}
> -#endif
> -
>  static phys_addr_t memory_limit = PHYS_ADDR_MAX;
>  
>  /*
> @@ -489,7 +471,7 @@ void __init bootmem_init(void)
>  	 * Sparsemem tries to allocate bootmem in memory_present(), so must be
>  	 * done after the fixed reservations.
>  	 */
> -	arm64_memory_present();
> +	memblocks_present();
>  
>  	sparse_init();
>  	zone_sizes_init(min, max);
> -- 
> 2.14.1
> 

-- 
Sincerely yours,
Mike.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
