Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52549C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:55:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1931720834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IaBgHjun"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1931720834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-Id:In-Reply-To:MIME-Version:
	References:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FJFSDYxyfeObrtEFuK1aW4oCEDAUJ2LlyHcmRFbk12I=; b=IaBgHjunKYKshD
	toGfIMdvJApyamVaaSISzf/46KOto5ycMnugO2iIR62saWpUjyQdFEW9DzjUL8iRaWS67s6a7lTsN
	va1y39dAZ9+m2eNWDh+bBO3mNzGqYyVQxu/vfYABySs/d9zuRpmLFdZRzfVMo/7hp8aqD76i/HBhR
	0atbvZ878sECsCGAE9B16III1XJ1B1OhWnlM3hOf5009e0zAuz5Kvw6hyI8v6iUpHnZRtzH5VNDbe
	kcCRjPayFym21msCTTLYaAUeRBxueo4MRK4Ny6QWOmTc7qhyk3PVrpAjpmzO2XRoKpnO4CZYj91WB
	JFPbLybFty5suejG6b/A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTrVQ-0001Mx-Vs; Mon, 03 Dec 2018 16:55:36 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTrVN-0001LB-3B
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 16:55:35 +0000
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wB3Gik91029940
 for <linux-arm-kernel@lists.infradead.org>; Mon, 3 Dec 2018 11:55:21 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2p57n432vp-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-arm-kernel@lists.infradead.org>; Mon, 03 Dec 2018 11:55:21 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-arm-kernel@lists.infradead.org> from <rppt@linux.ibm.com>;
 Mon, 3 Dec 2018 16:55:18 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 3 Dec 2018 16:55:10 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wB3Gt9iC55312584
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 3 Dec 2018 16:55:09 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8C32FA4054;
 Mon,  3 Dec 2018 16:55:09 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 39F55A405C;
 Mon,  3 Dec 2018 16:55:07 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.206.196])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Mon,  3 Dec 2018 16:55:07 +0000 (GMT)
Date: Mon, 3 Dec 2018 18:55:04 +0200
From: Mike Rapoport <rppt@linux.ibm.com>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 6/6] arm, unicore32: remove early_alloc*() wrappers
References: <1543852035-26634-1-git-send-email-rppt@linux.ibm.com>
 <1543852035-26634-7-git-send-email-rppt@linux.ibm.com>
 <CABGGisySdgSma1bSF2Bk586Vf461o-U2f3w9UMgHJcVucQ0oFA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CABGGisySdgSma1bSF2Bk586Vf461o-U2f3w9UMgHJcVucQ0oFA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18120316-0028-0000-0000-000003256811
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120316-0029-0000-0000-000023E16D02
Message-Id: <20181203165504.GC26700@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-03_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812030157
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_085533_248643_CB0C16CC 
X-CRM114-Status: GOOD (  25.44  )
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
Cc: mhocko@suse.com, linux-sh@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-mm@kvack.org,
 dalias@libc.org, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
 deanbo422@gmail.com, jonas@southpole.se, linux-c6x-dev@linux-c6x.org,
 ysato@users.sourceforge.jp, Michael Ellerman <mpe@ellerman.id.au>,
 linux@armlinux.org.uk, msalter@redhat.com, Arnd Bergmann <arnd@arndb.de>,
 stefan.kristiansson@saunalahti.fi, openrisc@lists.librecores.org,
 Greentime Hu <green.hu@gmail.com>, shorne@gmail.com, gxt@pku.edu.cn,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Michal Simek <monstr@monstr.eu>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 03, 2018 at 10:27:02AM -0600, Rob Herring wrote:
> On Mon, Dec 3, 2018 at 9:48 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
> >
> > On arm and unicore32i the early_alloc_aligned() and and early_alloc() are
> > oneliner wrappers for memblock_alloc.
> >
> > Replace their usage with direct call to memblock_alloc.
> >
> > Suggested-by: Christoph Hellwig <hch@infradead.org>
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> >  arch/arm/mm/mmu.c       | 11 +++--------
> >  arch/unicore32/mm/mmu.c | 12 ++++--------
> >  2 files changed, 7 insertions(+), 16 deletions(-)
> >
> > diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> > index 0a04c9a5..57de0dd 100644
> > --- a/arch/arm/mm/mmu.c
> > +++ b/arch/arm/mm/mmu.c
> > @@ -719,14 +719,9 @@ EXPORT_SYMBOL(phys_mem_access_prot);
> >
> >  #define vectors_base() (vectors_high() ? 0xffff0000 : 0)
> >
> > -static void __init *early_alloc_aligned(unsigned long sz, unsigned long align)
> > -{
> > -       return memblock_alloc(sz, align);
> > -}
> > -
> >  static void __init *early_alloc(unsigned long sz)
> 
> Why not get rid of this wrapper like you do on unicore?

ARM has early_alloc() and late_alloc() callbacks which in the end are
passed as a parameter to alloc_init_pXd() functions. 

Removing early_alloc() would require refactoring all the page table
allocation code.
 
> >  {
> > -       return early_alloc_aligned(sz, sz);
> > +       return memblock_alloc(sz, sz);
> >  }
> 

-- 
Sincerely yours,
Mike.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
