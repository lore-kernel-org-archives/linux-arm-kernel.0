Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF7BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:29:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E97BC2054F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BpwhKVjp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E97BC2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-Id:In-Reply-To:MIME-Version:
	References:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WDK7YbpXiQUp0Dk9/zcVb60BfYVTJKlymdpCVgvZ8SM=; b=BpwhKVjphFTb3O
	NJm+mI2kFA9HYiR5KLgTP3md+iy3ElRRYeVjS7MrZpSxMOeyYDi+Pg9cBfhxL9PdyAHg9ntHWg/Zb
	VNUooS150djtrolzQwMpNkq6mc2hgHc3skwaWYq12NiefhyHJTjUJoLJC2/4DG92Eh5vTRwcXavPf
	ehuK82BTTWoEkLrwaQ2eHSbHjJuvZyPggvH5t9AQ0UjHZLJm2h4Cxk35mFOvYekhabHOcU5Cr1Dcf
	BgkuUzEtDxoZIKqmthi1YwjVKkGiD3nscDSbyJQFAvQkNUV5cIL0iM7G2L85CvbiArg7w40btqZIc
	1GgGvZ5pNyyCE16IDpLg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk5rA-0003TR-DA; Thu, 17 Jan 2019 11:29:08 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk5qK-0002nf-QO
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 11:28:20 +0000
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 x0HBOEA0075918
 for <linux-arm-kernel@lists.infradead.org>; Thu, 17 Jan 2019 06:28:13 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2q2qqek5u9-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-arm-kernel@lists.infradead.org>; Thu, 17 Jan 2019 06:28:13 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-arm-kernel@lists.infradead.org> from <rppt@linux.ibm.com>;
 Thu, 17 Jan 2019 11:28:10 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 17 Jan 2019 11:28:07 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0HBS6IU56950948
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 17 Jan 2019 11:28:06 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3510BA4057;
 Thu, 17 Jan 2019 11:28:06 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 77880A404D;
 Thu, 17 Jan 2019 11:28:05 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.236])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Thu, 17 Jan 2019 11:28:05 +0000 (GMT)
Date: Thu, 17 Jan 2019 13:28:03 +0200
From: Mike Rapoport <rppt@linux.ibm.com>
To: Souptick Joarder <jrdr.linux@gmail.com>
Subject: Re: [PATCH] arch/arm/mm: Remove duplicate header
References: <20190107172805.GA8462@jordon-HP-15-Notebook-PC>
 <CAFqt6zbbXvpEEH2rNnLCBpNxEjK3YwNS1kYkyFPBhG7uvsHE1A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFqt6zbbXvpEEH2rNnLCBpNxEjK3YwNS1kYkyFPBhG7uvsHE1A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19011711-0020-0000-0000-00000307B493
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011711-0021-0000-0000-00002158D5AE
Message-Id: <20190117112803.GC3710@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-17_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=923 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901170084
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_032817_414849_18A4A1FB 
X-CRM114-Status: GOOD (  23.02  )
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
Cc: Michal Hocko <mhocko@suse.com>,
 Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 rppt@linux.vnet.ibm.com, Brajeswar Ghosh <brajeswar.linux@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 17, 2019 at 04:53:44PM +0530, Souptick Joarder wrote:
> On Mon, Jan 7, 2019 at 10:54 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
> >
> > Remove duplicate headers which are included twice.
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

Acked-by: Mike Rapoport <rppt@linux.ibm.com>
 
> Any comment on this patch ?
> 
> > ---
> >  arch/arm/mm/mmu.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> > index f5cc1cc..dde3032 100644
> > --- a/arch/arm/mm/mmu.c
> > +++ b/arch/arm/mm/mmu.c
> > @@ -23,7 +23,6 @@
> >  #include <asm/sections.h>
> >  #include <asm/cachetype.h>
> >  #include <asm/fixmap.h>
> > -#include <asm/sections.h>
> >  #include <asm/setup.h>
> >  #include <asm/smp_plat.h>
> >  #include <asm/tlb.h>
> > @@ -36,7 +35,6 @@
> >  #include <asm/mach/arch.h>
> >  #include <asm/mach/map.h>
> >  #include <asm/mach/pci.h>
> > -#include <asm/fixmap.h>
> >
> >  #include "fault.h"
> >  #include "mm.h"
> > --
> > 1.9.1
> >
> 

-- 
Sincerely yours,
Mike.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
