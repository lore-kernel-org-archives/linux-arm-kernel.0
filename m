Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED5EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:40:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 478D720651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T5qpVxps"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 478D720651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ApGXIZWwYOsEk+aTHhquGgvSWRmguCXOolD3L4VTYic=; b=T5qpVxpse2Gcb2
	b+SZnwJpc3MbyoJmhZbQw8QPOgUaMKlrBHHjaWvI+8b1f2JYQEfUGRqG+rSxJ5eAFRa+opgBfPGh6
	P+Vl23urS+bFGLE1xq4joKNDQVZzJMYw6nln84ykkAFOaLrR+TsB+LRz49PTsGybuNCXnOzygP5Ka
	2QU8CgifpxR3dK9gOe4kxWYeLwo4uJ6FC2E45OC9KPIJNlNRoAbvKRV3IhRsMkvqk/z1+5f69luYe
	8eKiARzCbia4UH9qvguN14TRc5ctB320+6yaoSbyfWRsj3/yQAPUyqqw8GBooujflhDd0UUACkTQe
	6mO6ztaX4icbhMmCr4ow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjkU4-0007EC-5a; Wed, 16 Jan 2019 12:39:52 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjkU0-0007Di-9o; Wed, 16 Jan 2019 12:39:49 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E68D80D;
 Wed, 16 Jan 2019 04:39:46 -0800 (PST)
Received: from [10.162.42.129] (p8cg001049571a15.blr.arm.com [10.162.42.129])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 B360B3F5AF; Wed, 16 Jan 2019 04:39:35 -0800 (PST)
Subject: Re: [PATCH V2] mm: Introduce GFP_PGTABLE
To: Christophe Leroy <christophe.leroy@c-s.fr>, linux-mm@kvack.org,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-sh@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-riscv@lists.infradead.org
References: <1547619692-7946-1-git-send-email-anshuman.khandual@arm.com>
 <bc49c0d1-b46c-f03a-baf9-445c417fae8f@c-s.fr>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <f71d23c6-57ee-1ceb-39a1-395a2f24a870@arm.com>
Date: Wed, 16 Jan 2019 18:09:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <bc49c0d1-b46c-f03a-baf9-445c417fae8f@c-s.fr>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_043948_345547_48BFD616 
X-CRM114-Status: GOOD (  10.49  )
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
Cc: mark.rutland@arm.com, mhocko@suse.com, peterz@infradead.org,
 catalin.marinas@arm.com, dave.hansen@linux.intel.com, will.deacon@arm.com,
 aneesh.kumar@linux.ibm.com, linux@armlinux.org.uk, mingo@redhat.com,
 rientjes@google.com, palmer@sifive.com, greentime@andestech.com,
 marc.zyngier@arm.com, rppt@linux.vnet.ibm.com, shakeelb@google.com,
 kirill@shutemov.name, tglx@linutronix.de, vbabka@suse.cz,
 ard.biesheuvel@linaro.org, steve.capper@arm.com, christoffer.dall@arm.com,
 james.morse@arm.com, robin.murphy@arm.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

CgpPbiAwMS8xNi8yMDE5IDEyOjQwIFBNLCBDaHJpc3RvcGhlIExlcm95IHdyb3RlOgo+IAo+IAo+
IExlIDE2LzAxLzIwMTkgw6AgMDc6MjEsIEFuc2h1bWFuIEtoYW5kdWFsIGEgw6ljcml0wqA6Cj4+
IEFsbCBhcmNoaXRlY3R1cmVzIGhhdmUgYmVlbiBkZWZpbmluZyB0aGVpciBvd24gUEdBTExPQ19H
RlAgYXMgKEdGUF9LRVJORUwgfAo+PiBfX0dGUF9aRVJPKSBhbmQgdXNpbmcgaXQgZm9yIGFsbG9j
YXRpbmcgcGFnZSB0YWJsZSBwYWdlcy4gVGhpcyBjYXVzZXMgc29tZQo+PiBjb2RlIGR1cGxpY2F0
aW9uIHdoaWNoIGNhbiBiZSBlYXNpbHkgYXZvaWRlZC4gR0ZQX0tFUk5FTCBhbGxvY2F0ZWQgYW5k
Cj4+IGNsZWFyZWQgb3V0IHBhZ2VzIChfX0dGUF9aRVJPKSBhcmUgcmVxdWlyZWQgZm9yIHBhZ2Ug
dGFibGVzIG9uIGFueSBnaXZlbgo+PiBhcmNoaXRlY3R1cmUuIFRoaXMgY3JlYXRlcyBhIG5ldyBn
ZW5lcmljIEdGUCBmbGFnIGZsYWcgd2hpY2ggY2FuIGJlIHVzZWQKPj4gZm9yIGFueSBwYWdlIHRh
YmxlIHBhZ2UgYWxsb2NhdGlvbi4gRG9lcyBub3QgY2F1c2UgYW55IGZ1bmN0aW9uYWwgY2hhbmdl
Lgo+Pgo+PiBHRlBfUEdUQUJMRSBpcyBiZWluZyBhZGRlZCBpbnRvIGluY2x1ZGUvYXNtLWdlbmVy
aWMvcGd0YWJsZS5oIHdoaWNoIGlzIHRoZQo+PiBnZW5lcmljIHBhZ2UgdGFiZSBoZWFkZXIganVz
dCB0byBwcmV2ZW50IGl0J3MgcG90ZW50aWFsIG1pc3VzZSBhcyBhIGdlbmVyYWwKPj4gYWxsb2Nh
dGlvbiBmbGFnIGlmIGluY2x1ZGVkIGluIGluY2x1ZGUvbGludXgvZ2ZwLmguCj4+Cj4+IFNpZ25l
ZC1vZmYtYnk6IEFuc2h1bWFuIEtoYW5kdWFsIDxhbnNodW1hbi5raGFuZHVhbEBhcm0uY29tPgo+
PiAtLS0KPj4gQnVpbGQgdGVzdGVkIG9uIGFybSwgYXJtNjQsIHBvd2VycGMsIHBvd2VycGM2NGxl
IGFuZCB4ODYuCj4+IEJvb3QgdGVzdGVkIG9uIGFybTY0IGFuZCB4ODYuCj4+Cj4+IENoYW5nZXMg
aW4gVjI6Cj4+Cj4+IC0gTW92ZWQgR0ZQX1BHVEFCTEUgaW50byBpbmNsdWRlL2FzbS1nZW5lcmlj
L3BndGFibGUuaAo+PiAtIE9uIFg4NiBhZGRlZCBfX0dGUF9BQ0NPVU5UIGludG8gR0ZQX1BHVEFC
TEUgYXQgdmFyaW91cyBwbGFjZXMKPj4gLSBSZXBsYWNlZCBwb3NzaWJsZSBmbGFncyBvbiByaXNj
diBhbmQgbmRzMzIgd2l0aCBHRlBfUEdUQUJMRQo+IAo+IENvdWxkIGFsc28gcmVwbGFjZSB0aGUg
ZmxhZ3MgaW4gYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL25vaGFzaC82NC9wZ2FsbG9jLmggd2l0
aCBHRlBfUEdUQUJMRSBpbiBwdGVfYWxsb2Nfb25lX2tlcm5lbCgpIGFuZCBwdGVfYWxsb2Nfb25l
KCkKClN1cmUgd2lsbCBkby4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
