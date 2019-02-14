Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F76C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:15:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 503E9222DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UF7N32/U";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Vf/BYccQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 503E9222DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=uLTzfcjNNJw5P9sT8FY9ca6KHVdcM10hVTkDqvNB9Q4=; b=UF7N32/UMpysDHtcxDo63SEQL
	pps7gf9XoNNyy8YCfqDkEZEmpb+JZvpCBGiFk4WcI8P4ADr9QCu0M9Lh//bLLJ6HbocTu2h9AU9ZU
	3+z6gt29wqTamKXm9UdHIZXT7dYqkg4/cWbeB1DiXBq8Ef1XjdujlthPmXoZO6f9LasSsEi4pl+H1
	tk8ImXY4MnZzdcThzKAIcYwSJ0FtMDf4hQJFGs3OfWqQ6XyYH53r5qoM+DoJkyKUjyl0eD+yAH0oe
	uBkl7QeiFJaJTG8GO9oA/1R0y6H6G8b5o1ewjhoDrr0UeLFaY5dzyE2m8TaIWIZD1R/oLFA1ewfBB
	iCRnRWTtA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guKbC-0005px-2T; Thu, 14 Feb 2019 17:14:58 +0000
Received: from aserp2130.oracle.com ([141.146.126.79])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guKb9-0005pe-6j
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 17:14:56 +0000
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1EH8iu1128927;
 Thu, 14 Feb 2019 17:14:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type; s=corp-2018-07-02;
 bh=GPxjRJQ4nY/8hYRHeyx7OooRpexTZeYSMFLDEjWGis0=;
 b=Vf/BYccQKk09j22ZvF46tD522PEycqZx1/ExzdyhvsoyMIJPJZJUEByFrYlJo83d1lV4
 EujEJr6xCdFsaO58BJZRAPMKUGypUHTM9tCrYgdCwLd19rac7dyWNdd0H5ZLzE6dpP4o
 ALn+jD2GZLgOwZKuw5nQ+75FUfn1F4TuCzuwH7Idm6kjVX2dW2fM7hB/SZzZyTwn0pvl
 I5lOt32nWZumsTN8aX4EQJ6XKjFb4sbON0Q+JbcU6VK03vhIC2uEAac42rSW5ErRLNVo
 r0F/wvXic7CrpWALH2CdJRKbzSi4jxUzO+zZHdEh173g2tRa7Jp3yApXtT9IvktKeKQE LA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
 by aserp2130.oracle.com with ESMTP id 2qhre5sa0a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Feb 2019 17:14:03 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1EHE1li015167
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Feb 2019 17:14:01 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1EHDwUM009120;
 Thu, 14 Feb 2019 17:13:59 GMT
Received: from [192.168.1.16] (/24.9.64.241)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 14 Feb 2019 09:13:58 -0800
Subject: Re: [RFC PATCH v8 03/14] mm, x86: Add support for eXclusive Page
 Frame Ownership (XPFO)
To: Peter Zijlstra <peterz@infradead.org>, juergh@gmail.com, jsteckli@amazon.de
References: <cover.1550088114.git.khalid.aziz@oracle.com>
 <8275de2a7e6b72d19b1cd2ec5d71a42c2c7dd6c5.1550088114.git.khalid.aziz@oracle.com>
 <20190214105631.GJ32494@hirez.programming.kicks-ass.net>
From: Khalid Aziz <khalid.aziz@oracle.com>
Organization: Oracle Corp
Message-ID: <e157e274-1bdf-0987-bfe9-21c9301578ab@oracle.com>
Date: Thu, 14 Feb 2019 10:13:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190214105631.GJ32494@hirez.programming.kicks-ass.net>
Content-Type: multipart/mixed; boundary="------------5EB9E0AEF4F8AD7EE9E16E15"
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9167
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902140116
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_091455_342271_A986A896 
X-CRM114-Status: GOOD (  18.07  )
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
 kernel-hardening@lists.openwall.com, catalin.marinas@arm.com,
 will.deacon@arm.com, dave.hansen@intel.com, deepa.srinivasan@oracle.com,
 steven.sistare@oracle.com, tglx@linutronix.de, tycho@tycho.ws,
 ak@linux.intel.com, kirill.shutemov@linux.intel.com, x86@kernel.org,
 jmorris@namei.org, hch@lst.de, kanth.ghatraju@oracle.com, labbott@redhat.com,
 pradeep.vincent@oracle.com, konrad.wilk@oracle.com, jcm@redhat.com,
 liran.alon@oracle.com, luto@kernel.org, boris.ostrovsky@oracle.com,
 chris.hyser@oracle.com, linux-arm-kernel@lists.infradead.org,
 jmattson@google.com, Marco Benatto <marco.antonio.780@gmail.com>,
 linux-mm@kvack.org, andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
 tyhicks@canonical.com, john.haxby@oracle.com,
 Juerg Haefliger <juerg.haefliger@canonical.com>, oao.m.martins@oracle.com,
 keescook@google.com, akpm@linux-foundation.org, torvalds@linux-foundation.org,
 dwmw@amazon.co.uk
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This is a multi-part message in MIME format.
--------------5EB9E0AEF4F8AD7EE9E16E15
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/14/19 3:56 AM, Peter Zijlstra wrote:
> On Wed, Feb 13, 2019 at 05:01:26PM -0700, Khalid Aziz wrote:
>>  static inline void *kmap_atomic(struct page *page)
>>  {
>> +	void *kaddr;
>> +
>>  	preempt_disable();
>>  	pagefault_disable();
>> +	kaddr =3D page_address(page);
>> +	xpfo_kmap(kaddr, page);
>> +	return kaddr;
>>  }
>>  #define kmap_atomic_prot(page, prot)	kmap_atomic(page)
>> =20
>>  static inline void __kunmap_atomic(void *addr)
>>  {
>> +	xpfo_kunmap(addr, virt_to_page(addr));
>>  	pagefault_enable();
>>  	preempt_enable();
>>  }
>=20
> How is that supposed to work; IIRC kmap_atomic was supposed to be
> IRQ-safe.
>=20

Ah, the spin_lock in in xpfo_kmap() can be problematic in interrupt
context. I will see if I can fix that.

Juerg, you wrote the original code and understand what you were trying
to do here. If you have ideas on how to tackle this, I would very much
appreciate it.

>> +/* Per-page XPFO house-keeping data */
>> +struct xpfo {
>> +	unsigned long flags;	/* Page state */
>> +	bool inited;		/* Map counter and lock initialized */
>=20
> What's sizeof(_Bool) ? Why can't you use a bit in that flags word?
>=20
>> +	atomic_t mapcount;	/* Counter for balancing map/unmap requests */
>> +	spinlock_t maplock;	/* Lock to serialize map/unmap requests */
>> +};
>=20
> Without that bool, the structure would be 16 bytes on 64bit, which seem=
s
> like a good number.
>=20

Patch 11 ("xpfo, mm: remove dependency on CONFIG_PAGE_EXTENSION") cleans
all this up. If the original authors of these two patches, Juerg
Haefliger and Julian Stecklina, are ok with it, I would like to combine
the two patches in one.

>> +void xpfo_kmap(void *kaddr, struct page *page)
>> +{
>> +	struct xpfo *xpfo;
>> +
>> +	if (!static_branch_unlikely(&xpfo_inited))
>> +		return;
>> +
>> +	xpfo =3D lookup_xpfo(page);
>> +
>> +	/*
>> +	 * The page was allocated before page_ext was initialized (which mea=
ns
>> +	 * it's a kernel page) or it's allocated to the kernel, so nothing t=
o
>> +	 * do.
>> +	 */
>> +	if (!xpfo || unlikely(!xpfo->inited) ||
>> +	    !test_bit(XPFO_PAGE_USER, &xpfo->flags))
>> +		return;
>> +
>> +	spin_lock(&xpfo->maplock);
>> +
>> +	/*
>> +	 * The page was previously allocated to user space, so map it back
>> +	 * into the kernel. No TLB flush required.
>> +	 */
>> +	if ((atomic_inc_return(&xpfo->mapcount) =3D=3D 1) &&
>> +	    test_and_clear_bit(XPFO_PAGE_UNMAPPED, &xpfo->flags))
>> +		set_kpte(kaddr, page, PAGE_KERNEL);
>> +
>> +	spin_unlock(&xpfo->maplock);
>> +}
>> +EXPORT_SYMBOL(xpfo_kmap);
>> +
>> +void xpfo_kunmap(void *kaddr, struct page *page)
>> +{
>> +	struct xpfo *xpfo;
>> +
>> +	if (!static_branch_unlikely(&xpfo_inited))
>> +		return;
>> +
>> +	xpfo =3D lookup_xpfo(page);
>> +
>> +	/*
>> +	 * The page was allocated before page_ext was initialized (which mea=
ns
>> +	 * it's a kernel page) or it's allocated to the kernel, so nothing t=
o
>> +	 * do.
>> +	 */
>> +	if (!xpfo || unlikely(!xpfo->inited) ||
>> +	    !test_bit(XPFO_PAGE_USER, &xpfo->flags))
>> +		return;
>> +
>> +	spin_lock(&xpfo->maplock);
>> +
>> +	/*
>> +	 * The page is to be allocated back to user space, so unmap it from =
the
>> +	 * kernel, flush the TLB and tag it as a user page.
>> +	 */
>> +	if (atomic_dec_return(&xpfo->mapcount) =3D=3D 0) {
>> +		WARN(test_bit(XPFO_PAGE_UNMAPPED, &xpfo->flags),
>> +		     "xpfo: unmapping already unmapped page\n");
>> +		set_bit(XPFO_PAGE_UNMAPPED, &xpfo->flags);
>> +		set_kpte(kaddr, page, __pgprot(0));
>> +		xpfo_flush_kernel_tlb(page, 0);
>> +	}
>> +
>> +	spin_unlock(&xpfo->maplock);
>> +}
>> +EXPORT_SYMBOL(xpfo_kunmap);
>=20
> And these here things are most definitely not IRQ-safe.
>=20

Got it. I will work on this.

Thanks,
Khalid


--------------5EB9E0AEF4F8AD7EE9E16E15
Content-Type: application/pgp-keys;
 name="pEpkey.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="pEpkey.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
+Wrj8Rwom6h21PXZRKnlkis7ibQfE+TxqOI7vg=3D=3D
=3DnPqY
-----END PGP PUBLIC KEY BLOCK-----

--------------5EB9E0AEF4F8AD7EE9E16E15
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--------------5EB9E0AEF4F8AD7EE9E16E15--

