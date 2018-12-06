Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E437C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:31:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DAFD2146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Dkd2ios2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DAFD2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-Id:In-Reply-To:MIME-Version:
	References:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lB9f4hHxG0v2q2fGx8bBh7tc1boGHjpSRvk5Cr2hacc=; b=Dkd2ios2gmPlzI
	Zp4psvj5bTXEPvPkN0rICWZ0pyE+LRLc/Whr7IK94KrePzSNUjmk1s4ZNFUfs/AeVcJETfUTFI22T
	Np6EoeY7Bvohnl3k/8eb1jHsD8oIZxXpq4MasqtHbuKzwqQeBPcGpcF2aDNNo33aDR9BDJfG+qlAF
	7zA9kDv2QlpZX/jWcs8yTJh0dDiaHGOGI/oi5WXGAf/qgrf79VWPIWnDMiuQVl69PguwUqAqTFOxi
	2SXlWsDYGptrnrXAcDkdUYlE8dpctM7Jo5bWml3A8sKTyZ7gIBRv/DJw5BBNt5TQlu6PzIXff8CYP
	oDe3ZiTWI7p9BbmsXStA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV1F7-0005y7-Ti; Thu, 06 Dec 2018 21:31:33 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV1F5-0005vw-2p
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 21:31:32 +0000
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wB6LTIKl039935
 for <linux-arm-kernel@lists.infradead.org>; Thu, 6 Dec 2018 16:31:14 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2p79pae1w4-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-arm-kernel@lists.infradead.org>; Thu, 06 Dec 2018 16:31:05 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-arm-kernel@lists.infradead.org> from <rppt@linux.ibm.com>;
 Thu, 6 Dec 2018 21:30:40 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 6 Dec 2018 21:30:33 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wB6LUW1u31391866
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 6 Dec 2018 21:30:32 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1BB16A4059;
 Thu,  6 Dec 2018 21:30:32 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AE2AEA4057;
 Thu,  6 Dec 2018 21:30:29 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.206.110])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Thu,  6 Dec 2018 21:30:29 +0000 (GMT)
Date: Thu, 6 Dec 2018 23:30:27 +0200
From: Mike Rapoport <rppt@linux.ibm.com>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v2 5/6] arch: simplify several early memory allocations
References: <1543852035-26634-1-git-send-email-rppt@linux.ibm.com>
 <1543852035-26634-6-git-send-email-rppt@linux.ibm.com>
 <20181203162908.GB4244@ravnborg.org>
 <20181203164920.GB26700@rapoport-lnx>
 <20181206180826.GB19166@ravnborg.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181206180826.GB19166@ravnborg.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18120621-0028-0000-0000-0000032726E3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120621-0029-0000-0000-000023E33A7C
Message-Id: <20181206213026.GA7479@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-06_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=883 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812060180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_133131_252206_7A5359FA 
X-CRM114-Status: GOOD (  27.95  )
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

On Thu, Dec 06, 2018 at 07:08:26PM +0100, Sam Ravnborg wrote:
> On Mon, Dec 03, 2018 at 06:49:21PM +0200, Mike Rapoport wrote:
> > On Mon, Dec 03, 2018 at 05:29:08PM +0100, Sam Ravnborg wrote:
> > > Hi Mike.
> > > 
> > > > index c37955d..2a17665 100644
> > > > --- a/arch/sparc/kernel/prom_64.c
> > > > +++ b/arch/sparc/kernel/prom_64.c
> > > > @@ -34,16 +34,13 @@
> > > >  
> > > >  void * __init prom_early_alloc(unsigned long size)
> > > >  {
> > > > -	unsigned long paddr = memblock_phys_alloc(size, SMP_CACHE_BYTES);
> > > > -	void *ret;
> > > > +	void *ret = memblock_alloc(size, SMP_CACHE_BYTES);
> > > >  
> > > > -	if (!paddr) {
> > > > +	if (!ret) {
> > > >  		prom_printf("prom_early_alloc(%lu) failed\n", size);
> > > >  		prom_halt();
> > > >  	}
> > > >  
> > > > -	ret = __va(paddr);
> > > > -	memset(ret, 0, size);
> > > >  	prom_early_allocated += size;
> > > >  
> > > >  	return ret;
> > > 
> > > memblock_alloc() calls memblock_alloc_try_nid().
> > > And if allocation fails then memblock_alloc_try_nid() calls panic().
> > > So will we ever hit the prom_halt() code?
> > 
> > memblock_phys_alloc_try_nid() also calls panic if an allocation fails. So
> > in either case we never reach prom_halt() code.
> 
> So we have code here we never reach - not nice.
> If the idea is to avoid relying on the panic inside memblock_alloc() then
> maybe replace it with a variant that do not call panic?
> To make it clear what happens.

My plan is to completely remove memblock variants that call panic() and
make the callers check the return value.

I've started to work on it, but with the holidays it progresses slower than
I'd like to.

Since the code here was unreachable for several year, a few more weeks
won't make real difference so I'd prefer to keep the variant with panic()
for now. 
 
> 	Sam
> 

-- 
Sincerely yours,
Mike.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
