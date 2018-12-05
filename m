Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE327C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:22:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA8DB213A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dhaOJA1I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA8DB213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-Id:In-Reply-To:MIME-Version:
	References:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+2PZA74tzaDkYGjGvjLt4HThQPDxBEokvM+8YtIuUEM=; b=dhaOJA1I2Pwvkq
	8thYhat/VGT0go5tG2ONkVDtAh9kfa4fD0Cd9QrYZ6IGSUEr0TDot4sFtVtj7re40i2PQNAEOvmMu
	QvchCS7lYzixNRCtDjzAI7ueHabVB4vIXMWzhNi+2R18GdeALvQoiQFZ2iJ+LB19en7tmGyfgFXD4
	nv0fgWbCjXVnfsNaLeEyLvQwF0beMltmO84Ezq6ezhTQjUzoH11H9eOh3LbTuKeSYftyt+WgQo5iA
	rb5Oo86W/Aa3Zd3TA5TYPO4afbXlgkxbWkDBWEpufRow2Rbd7jHpfJUq2BDpg6pfOA1U64+JuIiei
	8jDlayxXiM71hilNDAtQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUedF-0005Q5-Fo; Wed, 05 Dec 2018 21:22:57 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUedB-0005O6-LV
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 21:22:55 +0000
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wB5LEWWn125806
 for <linux-arm-kernel@lists.infradead.org>; Wed, 5 Dec 2018 16:22:41 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2p6ktp7njh-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-arm-kernel@lists.infradead.org>; Wed, 05 Dec 2018 16:22:40 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-arm-kernel@lists.infradead.org> from <rppt@linux.ibm.com>;
 Wed, 5 Dec 2018 21:22:39 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 5 Dec 2018 21:22:32 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wB5LMVLH56098844
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 5 Dec 2018 21:22:31 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CFAD5A405B;
 Wed,  5 Dec 2018 21:22:31 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 96EF2A4060;
 Wed,  5 Dec 2018 21:22:29 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.206.89])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Wed,  5 Dec 2018 21:22:29 +0000 (GMT)
Date: Wed, 5 Dec 2018 23:22:27 +0200
From: Mike Rapoport <rppt@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 1/6] powerpc: prefer memblock APIs returning virtual
 address
References: <1543852035-26634-1-git-send-email-rppt@linux.ibm.com>
 <1543852035-26634-2-git-send-email-rppt@linux.ibm.com>
 <87woophasy.fsf@concordia.ellerman.id.au>
 <20181204171327.GL26700@rapoport-lnx>
 <87mupkkv3b.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87mupkkv3b.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18120521-0028-0000-0000-00000326A21B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120521-0029-0000-0000-000023E2B09E
Message-Id: <20181205212226.GF19181@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-05_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812050186
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_132253_833236_130811D9 
X-CRM114-Status: GOOD (  36.45  )
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
 Russell King <linux@armlinux.org.uk>, Mark Salter <msalter@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>,
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

On Wed, Dec 05, 2018 at 11:37:44PM +1100, Michael Ellerman wrote:
> Mike Rapoport <rppt@linux.ibm.com> writes:
> > On Tue, Dec 04, 2018 at 08:59:41PM +1100, Michael Ellerman wrote:
> >> Hi Mike,
> >> 
> >> Thanks for trying to clean these up.
> >> 
> >> I think a few could be improved though ...
> >> 
> >> Mike Rapoport <rppt@linux.ibm.com> writes:
> >> > diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
> >> > index 913bfca..fa884ad 100644
> >> > --- a/arch/powerpc/kernel/paca.c
> >> > +++ b/arch/powerpc/kernel/paca.c
> >> > @@ -42,17 +42,15 @@ static void *__init alloc_paca_data(unsigned long size, unsigned long align,
> >> >  		nid = early_cpu_to_node(cpu);
> >> >  	}
> >> >  
> >> > -	pa = memblock_alloc_base_nid(size, align, limit, nid, MEMBLOCK_NONE);
> >> > -	if (!pa) {
> >> > -		pa = memblock_alloc_base(size, align, limit);
> >> > -		if (!pa)
> >> > -			panic("cannot allocate paca data");
> >> > -	}
> >> > +	ptr = memblock_alloc_try_nid_raw(size, align, MEMBLOCK_LOW_LIMIT,
> >> > +					 limit, nid);
> >> > +	if (!ptr)
> >> > +		panic("cannot allocate paca data");
> >>   
> >> The old code doesn't zero, but two of the three callers of
> >> alloc_paca_data() *do* zero the whole allocation, so I'd be happy if we
> >> did it in here instead.
> >
> > I looked at the callers and couldn't tell if zeroing memory in
> > init_lppaca() would be ok.
> > I'll remove the _raw here.
>   
> Thanks.
> 
> >> That would mean we could use memblock_alloc_try_nid() avoiding the need
> >> to panic() manually.
> >
> > Actual, my plan was to remove panic() from all memblock_alloc* and make all
> > callers to check the returned value.
> > I believe it's cleaner and also allows more meaningful panic messages. Not
> > mentioning the reduction of memblock code.
> 
> Hmm, not sure.
> 
> I see ~200 calls to the panicking functions, that seems like a lot of
> work to change all those.

Yeah, I know :)

> And I think I disagree on the "more meaningful panic message". This is a
> perfect example, compare:
> 
> 	panic("cannot allocate paca data");
> to:
> 	panic("%s: Failed to allocate %llu bytes align=0x%llx nid=%d from=%pa max_addr=%pa\n",
> 	      __func__, (u64)size, (u64)align, nid, &min_addr, &max_addr);
> 
> The former is basically useless, whereas the second might at least give
> you a hint as to *why* the allocation failed.

We can easily keep the memblock message, just make it pr_err instead of
panic.
The message at the call site can show where the problem was without the
need to dive into the stack dump.

> I know it's kind of odd for a function to panic() rather than return an
> error, but memblock is kind of special because it's so early in boot.
> Most of these allocations have to succeed to get the system up and
> running.

The downside of having panic() inside some memblock functions is that it
makes the API way too bloated. And, at least currently, it's inconsistent.
For instance memblock_alloc_try_nid_raw() does not panic, but
memblock_alloc_try_nid() does.

When it was about 2 functions and a wrapper, it was perfectly fine, but
since than memblock has three sets of partially overlapping APIs with
endless convenience wrappers.

I believe that patching up ~200 calls is worth the reduction of memblock
API to saner size.

Another thing, the absence of check for return value for memory allocation
is not only odd, but it also makes the code obfuscated.
 
> cheers
> 

-- 
Sincerely yours,
Mike.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
