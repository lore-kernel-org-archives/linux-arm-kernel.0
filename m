Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01B0C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:38:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC92120850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UKc7n4nW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC92120850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4cgNnvve5tMsjD93S3mppgG+BnloakeeUYVwPU8omZA=; b=UKc7n4nW7RHV8a
	bQQXHv+4sTtM3H2qkriy7D78nxfsZqEbgFPOP0IYfKQtIkFL9VBXO9hnVXwcOlFbecAG7p5pvvnSx
	5X1WsSE4XRBoBrFNRixEXJNNZGi/8cD9ADe8E3ruk6yjrj8rAwr17uSUeN8HxmzQdtfzU8ZpQIf01
	0p+jqAyIbmaocCNMVRZkv/4Oex2Ck4Ap1LiLPo3t3//cx8FEDUmco31JLbayTuFfxSFUG/cYLWfb2
	yW4me4LYaIXBqdok3OD5GeBOx9s07UZ3TwVuGWAMjjkyvhfWjBKr5XzAOvTqxdme2g3U1jEpdbi+X
	A3G9reHRyW+xIZABdIGQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUWRS-0007rY-SJ; Wed, 05 Dec 2018 12:38:14 +0000
Received: from ozlabs.org ([203.11.71.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUWRM-0007oC-V7
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 12:38:12 +0000
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 438ytd6ssyz9s3C;
 Wed,  5 Dec 2018 23:37:45 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v2 1/6] powerpc: prefer memblock APIs returning virtual
 address
In-Reply-To: <20181204171327.GL26700@rapoport-lnx>
References: <1543852035-26634-1-git-send-email-rppt@linux.ibm.com>
 <1543852035-26634-2-git-send-email-rppt@linux.ibm.com>
 <87woophasy.fsf@concordia.ellerman.id.au>
 <20181204171327.GL26700@rapoport-lnx>
Date: Wed, 05 Dec 2018 23:37:44 +1100
Message-ID: <87mupkkv3b.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_043809_405124_C70A7E46 
X-CRM114-Status: GOOD (  16.35  )
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

Mike Rapoport <rppt@linux.ibm.com> writes:
> On Tue, Dec 04, 2018 at 08:59:41PM +1100, Michael Ellerman wrote:
>> Hi Mike,
>> 
>> Thanks for trying to clean these up.
>> 
>> I think a few could be improved though ...
>> 
>> Mike Rapoport <rppt@linux.ibm.com> writes:
>> > diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
>> > index 913bfca..fa884ad 100644
>> > --- a/arch/powerpc/kernel/paca.c
>> > +++ b/arch/powerpc/kernel/paca.c
>> > @@ -42,17 +42,15 @@ static void *__init alloc_paca_data(unsigned long size, unsigned long align,
>> >  		nid = early_cpu_to_node(cpu);
>> >  	}
>> >  
>> > -	pa = memblock_alloc_base_nid(size, align, limit, nid, MEMBLOCK_NONE);
>> > -	if (!pa) {
>> > -		pa = memblock_alloc_base(size, align, limit);
>> > -		if (!pa)
>> > -			panic("cannot allocate paca data");
>> > -	}
>> > +	ptr = memblock_alloc_try_nid_raw(size, align, MEMBLOCK_LOW_LIMIT,
>> > +					 limit, nid);
>> > +	if (!ptr)
>> > +		panic("cannot allocate paca data");
>>   
>> The old code doesn't zero, but two of the three callers of
>> alloc_paca_data() *do* zero the whole allocation, so I'd be happy if we
>> did it in here instead.
>
> I looked at the callers and couldn't tell if zeroing memory in
> init_lppaca() would be ok.
> I'll remove the _raw here.
  
Thanks.

>> That would mean we could use memblock_alloc_try_nid() avoiding the need
>> to panic() manually.
>
> Actual, my plan was to remove panic() from all memblock_alloc* and make all
> callers to check the returned value.
> I believe it's cleaner and also allows more meaningful panic messages. Not
> mentioning the reduction of memblock code.

Hmm, not sure.

I see ~200 calls to the panicking functions, that seems like a lot of
work to change all those.

And I think I disagree on the "more meaningful panic message". This is a
perfect example, compare:

	panic("cannot allocate paca data");
to:
	panic("%s: Failed to allocate %llu bytes align=0x%llx nid=%d from=%pa max_addr=%pa\n",
	      __func__, (u64)size, (u64)align, nid, &min_addr, &max_addr);

The former is basically useless, whereas the second might at least give
you a hint as to *why* the allocation failed.

I know it's kind of odd for a function to panic() rather than return an
error, but memblock is kind of special because it's so early in boot.
Most of these allocations have to succeed to get the system up and
running.

cheers

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
