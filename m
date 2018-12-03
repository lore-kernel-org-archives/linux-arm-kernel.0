Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140FEC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:28:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB5EF20661
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kdfQN8Xc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB5EF20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-Id:In-Reply-To:MIME-Version:
	References:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=L+jr5TLXRY70d9Gvh87deGlJkcr/x+YjZ3Ke8DZz4Zk=; b=kdfQN8Xc/zZ1Wh
	9dBRLLDJpJV9ME5nOa7hRNhihLlPnEkS3iceY8wAa7//SoTnwYAdf45gtWzonddLRWe1nPOjo/oUu
	zoenx0g1wRJwxfCcqOdg112xwTGvesnI8SN45mXSKNw7CycSLGW013+kvu1MrMANi0Fh9jmfsHOKi
	l/c2C1hxPosnV2D8Std2NmVAZkgn4t/e5+S08xSXPlLl78YAMr27hzZQU0Atctgim2Dqe4sb2pjn9
	HnPMFb8DK5epNv9PA9kknhOBwqAbJycAHgYYDyElaWwrGNOF/sFSQtBDOxKgRQZk9bPxxqbSIhJbp
	Y79bdb9iCpS/98+F14OQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTr5S-0004XB-Vn; Mon, 03 Dec 2018 16:28:46 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTr5P-0004RM-KN
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 16:28:45 +0000
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wB3GPuJq081682
 for <linux-arm-kernel@lists.infradead.org>; Mon, 3 Dec 2018 11:28:32 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2p57n41gfq-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-arm-kernel@lists.infradead.org>; Mon, 03 Dec 2018 11:28:32 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-arm-kernel@lists.infradead.org> from <rppt@linux.ibm.com>;
 Mon, 3 Dec 2018 16:28:28 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 3 Dec 2018 16:28:21 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wB3GSKaf25690160
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 3 Dec 2018 16:28:20 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 99EB6A4054;
 Mon,  3 Dec 2018 16:28:20 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 55F64A4060;
 Mon,  3 Dec 2018 16:28:18 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.206.196])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Mon,  3 Dec 2018 16:28:18 +0000 (GMT)
Date: Mon, 3 Dec 2018 18:28:16 +0200
From: Mike Rapoport <rppt@linux.ibm.com>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v2 3/6] sh: prefer memblock APIs returning virtual address
References: <1543852035-26634-1-git-send-email-rppt@linux.ibm.com>
 <1543852035-26634-4-git-send-email-rppt@linux.ibm.com>
 <20181203161052.GA4244@ravnborg.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181203161052.GA4244@ravnborg.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18120316-4275-0000-0000-000002EB6519
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120316-4276-0000-0000-000037F86955
Message-Id: <20181203162816.GA26700@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-03_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812030154
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_082843_772107_31E3AA35 
X-CRM114-Status: GOOD (  29.16  )
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

On Mon, Dec 03, 2018 at 05:10:52PM +0100, Sam Ravnborg wrote:
> Hi Mike.
> 
> On Mon, Dec 03, 2018 at 05:47:12PM +0200, Mike Rapoport wrote:
> > Rather than use the memblock_alloc_base that returns a physical address and
> > then convert this address to the virtual one, use appropriate memblock
> > function that returns a virtual address.
> > 
> > There is a small functional change in the allocation of then NODE_DATA().
> > Instead of panicing if the local allocation failed, the non-local
> > allocation attempt will be made.
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> >  arch/sh/mm/init.c | 18 +++++-------------
> >  arch/sh/mm/numa.c |  5 ++---
> >  2 files changed, 7 insertions(+), 16 deletions(-)
> > 
> > diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
> > index c8c13c77..3576b5f 100644
> > --- a/arch/sh/mm/init.c
> > +++ b/arch/sh/mm/init.c
> > @@ -192,24 +192,16 @@ void __init page_table_range_init(unsigned long start, unsigned long end,
> >  void __init allocate_pgdat(unsigned int nid)
> >  {
> >  	unsigned long start_pfn, end_pfn;
> > -#ifdef CONFIG_NEED_MULTIPLE_NODES
> > -	unsigned long phys;
> > -#endif
> >  
> >  	get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
> >  
> >  #ifdef CONFIG_NEED_MULTIPLE_NODES
> > -	phys = __memblock_alloc_base(sizeof(struct pglist_data),
> > -				SMP_CACHE_BYTES, end_pfn << PAGE_SHIFT);
> > -	/* Retry with all of system memory */
> > -	if (!phys)
> > -		phys = __memblock_alloc_base(sizeof(struct pglist_data),
> > -					SMP_CACHE_BYTES, memblock_end_of_DRAM());
> > -	if (!phys)
> > +	NODE_DATA(nid) = memblock_alloc_try_nid_nopanic(
> > +				sizeof(struct pglist_data),
> > +				SMP_CACHE_BYTES, MEMBLOCK_LOW_LIMIT,
> > +				MEMBLOCK_ALLOC_ACCESSIBLE, nid);
> > +	if (!NODE_DATA(nid))
> >  		panic("Can't allocate pgdat for node %d\n", nid);
> > -
> > -	NODE_DATA(nid) = __va(phys);
> > -	memset(NODE_DATA(nid), 0, sizeof(struct pglist_data));
> The new code will always assign NODE_DATA(nid), where the old
> code only assigned NODE_DATA(nid) in the good case.
> I dunno if this is an issue, just noticed the difference and
> wanted to point it out.

If the allocation fails the NODE_DATA(nid) remains zero anyway and there is
a panic() call. So I think there is no actual functional change here.

> 	Sam
> 

-- 
Sincerely yours,
Mike.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
