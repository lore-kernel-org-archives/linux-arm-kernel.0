Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFB5C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 06:22:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 388AC2145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 06:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mTO9nel9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 388AC2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-Id:In-Reply-To:MIME-Version:
	References:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ngQw1hzYuLTQ5mCI/DqcZ77MJZ851Q5hn0hE1TWKv0I=; b=mTO9nel9yOTTlf
	5YexeU7P6M/9yD2NyfA4jDpO4EwhHq/tpg6ZnmCLHnYlDrCSsMsJTCn5kVoA4TRf6ZY0rua2isJGX
	7jrWVH06BfuwDT+Kbvp58lGvif1PlxZ8CyFU+lABRzYo2BK4+jJOxvTOiH4UoUUnUXWYHEqEmDJNc
	+HFwhDvCY51zePTyTWqDs3zzt67PgzZzu8s/Sj1/aGQs7I5tSB7wELS2LxyVPP+BpPkw/I3bofLV8
	9YPaemYalDk8XtsHSweEmb6WufU0DlfpH3LWfTrOi+w1gKc+HjME2W9KK/655CQl1az7zxWWKiw9l
	GYtZgOvF4NWHLU86IaTA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gThd7-0003ks-Jx; Mon, 03 Dec 2018 06:22:53 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gThd4-0003bU-Dl
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 06:22:52 +0000
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wB36IiPZ001319
 for <linux-arm-kernel@lists.infradead.org>; Mon, 3 Dec 2018 01:22:39 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2p4xhf1h42-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-arm-kernel@lists.infradead.org>; Mon, 03 Dec 2018 01:22:39 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-arm-kernel@lists.infradead.org> from <rppt@linux.ibm.com>;
 Mon, 3 Dec 2018 06:22:37 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 3 Dec 2018 06:22:28 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wB36MRI758785956
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 3 Dec 2018 06:22:27 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4A2BBAE056;
 Mon,  3 Dec 2018 06:22:27 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 43AF4AE055;
 Mon,  3 Dec 2018 06:22:24 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.204.137])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Mon,  3 Dec 2018 06:22:24 +0000 (GMT)
Date: Mon, 3 Dec 2018 08:22:22 +0200
From: Mike Rapoport <rppt@linux.ibm.com>
To: Souptick Joarder <jrdr.linux@gmail.com>
Subject: Re: [PATCH v2 1/9] mm: Introduce new vm_insert_range API
References: <20181202061944.GA3094@jordon-HP-15-Notebook-PC>
 <20181202111313.GC6959@rapoport-lnx>
 <CAFqt6zbvyaPF3tUA1-=RsfSM14p7Rx5NgQqAeW5-JUfd+NrJ2g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFqt6zbvyaPF3tUA1-=RsfSM14p7Rx5NgQqAeW5-JUfd+NrJ2g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18120306-4275-0000-0000-000002EB1F9D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120306-4276-0000-0000-000037F8206B
Message-Id: <20181203062222.GF6959@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-03_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812030062
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_222250_590502_4A168D99 
X-CRM114-Status: GOOD (  41.58  )
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
Cc: Michal Hocko <mhocko@suse.com>, Heiko Stuebner <heiko@sntech.de>,
 Peter Zijlstra <peterz@infradead.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
 linux1394-devel@lists.sourceforge.net,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, oleksandr_andrushchenko@epam.com,
 joro@8bytes.org, Russell King - ARM Linux <linux@armlinux.org.uk>,
 Matthew Wilcox <willy@infradead.org>, airlied@linux.ie,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 treding@nvidia.com, linux-media@vger.kernel.org,
 Kees Cook <keescook@chromium.org>, pawel@osciak.com,
 Rik van Riel <riel@surriel.com>, iommu@lists.linux-foundation.org,
 rppt@linux.vnet.ibm.com, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 mchehab@kernel.org, iamjoonsoo.kim@lge.com, vbabka@suse.cz,
 Juergen Gross <jgross@suse.com>, hjc@rock-chips.com, xen-devel@lists.xen.org,
 Kyungmin Park <kyungmin.park@samsung.com>, stefanr@s5r6.in-berlin.de,
 Andrew Morton <akpm@linux-foundation.org>, robin.murphy@arm.com,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 03, 2018 at 09:51:45AM +0530, Souptick Joarder wrote:
> Hi Mike,
> 
> On Sun, Dec 2, 2018 at 4:43 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> >
> > On Sun, Dec 02, 2018 at 11:49:44AM +0530, Souptick Joarder wrote:
> > > Previouly drivers have their own way of mapping range of
> > > kernel pages/memory into user vma and this was done by
> > > invoking vm_insert_page() within a loop.
> > >
> > > As this pattern is common across different drivers, it can
> > > be generalized by creating a new function and use it across
> > > the drivers.
> > >
> > > vm_insert_range is the new API which will be used to map a
> > > range of kernel memory/pages to user vma.
> > >
> > > This API is tested by Heiko for Rockchip drm driver, on rk3188,
> > > rk3288, rk3328 and rk3399 with graphics.
> > >
> > > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > > Reviewed-by: Matthew Wilcox <willy@infradead.org>
> > > Tested-by: Heiko Stuebner <heiko@sntech.de>
> > > ---
> > >  include/linux/mm_types.h |  3 +++
> > >  mm/memory.c              | 38 ++++++++++++++++++++++++++++++++++++++
> > >  mm/nommu.c               |  7 +++++++
> > >  3 files changed, 48 insertions(+)
> > >
> > > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > > index 5ed8f62..15ae24f 100644
> > > --- a/include/linux/mm_types.h
> > > +++ b/include/linux/mm_types.h
> > > @@ -523,6 +523,9 @@ extern void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
> > >  extern void tlb_finish_mmu(struct mmu_gather *tlb,
> > >                               unsigned long start, unsigned long end);
> > >
> > > +int vm_insert_range(struct vm_area_struct *vma, unsigned long addr,
> > > +                     struct page **pages, unsigned long page_count);
> > > +
> >
> > This seem to belong to include/linux/mm.h, near vm_insert_page()
> 
> Ok, I will change it. Apart from this change does it looks good ?

With this change you can add

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
 
> >
> > >  static inline void init_tlb_flush_pending(struct mm_struct *mm)
> > >  {
> > >       atomic_set(&mm->tlb_flush_pending, 0);
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index 15c417e..84ea46c 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -1478,6 +1478,44 @@ static int insert_page(struct vm_area_struct *vma, unsigned long addr,
> > >  }
> > >
> > >  /**
> > > + * vm_insert_range - insert range of kernel pages into user vma
> > > + * @vma: user vma to map to
> > > + * @addr: target user address of this page
> > > + * @pages: pointer to array of source kernel pages
> > > + * @page_count: number of pages need to insert into user vma
> > > + *
> > > + * This allows drivers to insert range of kernel pages they've allocated
> > > + * into a user vma. This is a generic function which drivers can use
> > > + * rather than using their own way of mapping range of kernel pages into
> > > + * user vma.
> > > + *
> > > + * If we fail to insert any page into the vma, the function will return
> > > + * immediately leaving any previously-inserted pages present.  Callers
> > > + * from the mmap handler may immediately return the error as their caller
> > > + * will destroy the vma, removing any successfully-inserted pages. Other
> > > + * callers should make their own arrangements for calling unmap_region().
> > > + *
> > > + * Context: Process context. Called by mmap handlers.
> > > + * Return: 0 on success and error code otherwise
> > > + */
> > > +int vm_insert_range(struct vm_area_struct *vma, unsigned long addr,
> > > +                     struct page **pages, unsigned long page_count)
> > > +{
> > > +     unsigned long uaddr = addr;
> > > +     int ret = 0, i;
> > > +
> > > +     for (i = 0; i < page_count; i++) {
> > > +             ret = vm_insert_page(vma, uaddr, pages[i]);
> > > +             if (ret < 0)
> > > +                     return ret;
> > > +             uaddr += PAGE_SIZE;
> > > +     }
> > > +
> > > +     return ret;
> > > +}
> > > +EXPORT_SYMBOL(vm_insert_range);
> > > +
> > > +/**
> > >   * vm_insert_page - insert single page into user vma
> > >   * @vma: user vma to map to
> > >   * @addr: target user address of this page
> > > diff --git a/mm/nommu.c b/mm/nommu.c
> > > index 749276b..d6ef5c7 100644
> > > --- a/mm/nommu.c
> > > +++ b/mm/nommu.c
> > > @@ -473,6 +473,13 @@ int vm_insert_page(struct vm_area_struct *vma, unsigned long addr,
> > >  }
> > >  EXPORT_SYMBOL(vm_insert_page);
> > >
> > > +int vm_insert_range(struct vm_area_struct *vma, unsigned long addr,
> > > +                     struct page **pages, unsigned long page_count)
> > > +{
> > > +     return -EINVAL;
> > > +}
> > > +EXPORT_SYMBOL(vm_insert_range);
> > > +
> > >  /*
> > >   *  sys_brk() for the most part doesn't need the global kernel
> > >   *  lock, except when an application is doing something nasty
> > > --
> > > 1.9.1
> > >
> >
> > --
> > Sincerely yours,
> > Mike.
> >
> 

-- 
Sincerely yours,
Mike.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
