Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E3EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:01:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F2F920657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ptYF6Kp9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K7KG7x3D";
	dkim=fail reason="unknown key hash" (0-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="h6bDEpcf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F2F920657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZsEttXiw6FNSNLmUM5ntqzZGgP//xjIREBw1JintQ1M=; b=ptYF6Kp9EOghMv0sFHfrKdMQE
	vwpIE8k/5gHfsU4+6msKK3/Ov2CWJCSTnA5jfyu/iiqLPxhloAyOPyuN5M/+mdxdU/FXVmihP/fk9
	GGEF0mr1FUO8LgubR8VA4eaZsAzHqWl8PBDwfzPZA2BoX/s6IJprw9ttm3+LKSdC94ubihc4zrMFP
	0HJhnCnSiYDgvu8QTPrO7rWkNg+ofzDHs8PTi4UfTGWq6vIAy/Vbvc+tnKzZEHnKR8jtTSLz1PKrz
	3eFfA6uwrP/4UJFAXUjWjAAzNtptudomDZNfrzldFRYuSZ7HufDzJOK7VH3CYeSR2RuSjkPtQph2z
	TPvjXcq6g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjlki-0003u7-Nu; Wed, 16 Jan 2019 14:01:08 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjlkg-0003dJ-3q; Wed, 16 Jan 2019 14:01:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lH8phfL2dc2xvrucZHWB7D4b5ZzaHKfGAG4MvWdpo94=; b=K7KG7x3DD1zJLS4HblAB7RrZgy
 gypiPARPjre5z19rUdVfOCEKX+jY50qmUg2QHmEYx7wDNPrAfnLH8khKEcf8Y2FpPQAlC4kuKjv9B
 7hITVZuaP2h9bZxlF696c8KXxppa2dxC7WUzRpd3zasgEc+ZxrKvsIfBF2yJ+QnFG5CjtfH6Qb1RQ
 qeIrMx0bXhIok8IXO4UKKEZdVcc1v7UIdi3joAgKKh3DwTdCzTJjmcK3b9BLmtYYslZHZFbTpnfl8
 LWE2/Ow/ZPGgqmNZZ0Jisg7KrCzjdboPA77eo8jG92WL+XiovzD+K5lWEfYazvQAzLJ5O4/c7yCXa
 hKZ3KcWw==;
Received: from pegase1.c-s.fr ([93.17.236.30])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjlXN-0006Zw-LM; Wed, 16 Jan 2019 13:47:23 +0000
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43fpRW16Rdz9vBL9;
 Wed, 16 Jan 2019 14:47:19 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=h6bDEpcf; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id vTxn3aznp6JG; Wed, 16 Jan 2019 14:47:19 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43fpRV6xvbz9vBL5;
 Wed, 16 Jan 2019 14:47:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1547646439; bh=lH8phfL2dc2xvrucZHWB7D4b5ZzaHKfGAG4MvWdpo94=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=h6bDEpcfHoPi7+K8iDB5P2D8Msf7Cxay7+XiKbclC3/MBH8MSFbPurZAHmoagmvkW
 Ef/q/jgPKVOgfJwRlPktA6kj61l8TiftNxvgf/CRtWQBZcf2d0rDXPE2LDLtrhQ72n
 qx3IFMrMR7vXjtN8R9DD2KfjwhDzpyEy2mqQ6kN8=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 4DB7F8B84D;
 Wed, 16 Jan 2019 14:47:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id QK8m5vIbXNH2; Wed, 16 Jan 2019 14:47:20 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 4435E8B830;
 Wed, 16 Jan 2019 14:47:17 +0100 (CET)
Subject: Re: [PATCH V2] mm: Introduce GFP_PGTABLE
To: Matthew Wilcox <willy@infradead.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>
References: <1547619692-7946-1-git-send-email-anshuman.khandual@arm.com>
 <20190116065703.GE24149@dhcp22.suse.cz>
 <20190116123018.GF6310@bombadil.infradead.org>
 <07d6a264-dccd-78ab-e8a9-2410bbef7b97@arm.com>
 <20190116131827.GH6310@bombadil.infradead.org>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <521d8511-4c87-49c6-de03-67a71d5bacca@c-s.fr>
Date: Wed, 16 Jan 2019 14:47:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190116131827.GH6310@bombadil.infradead.org>
Content-Language: fr
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_134721_818178_B2672F06 
X-CRM114-Status: GOOD (  23.51  )
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
Cc: mark.rutland@arm.com, christoffer.dall@arm.com, linux-sh@vger.kernel.org,
 peterz@infradead.org, catalin.marinas@arm.com, palmer@sifive.com,
 will.deacon@arm.com, Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
 linux-riscv@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 aneesh.kumar@linux.ibm.com, linux@armlinux.org.uk, mingo@redhat.com,
 linux-arm-kernel@lists.infradead.org, rientjes@google.com,
 dave.hansen@linux.intel.com, greentime@andestech.com, marc.zyngier@arm.com,
 rppt@linux.vnet.ibm.com, shakeelb@google.com, kirill@shutemov.name,
 tglx@linutronix.de, vbabka@suse.cz, ard.biesheuvel@linaro.org,
 linuxppc-dev@lists.ozlabs.org, steve.capper@arm.com,
 linux-kernel@vger.kernel.org, james.morse@arm.com, akpm@linux-foundation.org,
 robin.murphy@arm.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

CgpMZSAxNi8wMS8yMDE5IMOgIDE0OjE4LCBNYXR0aGV3IFdpbGNveCBhIMOpY3JpdMKgOgo+IE9u
IFdlZCwgSmFuIDE2LCAyMDE5IGF0IDA2OjQyOjIyUE0gKzA1MzAsIEFuc2h1bWFuIEtoYW5kdWFs
IHdyb3RlOgo+PiBPbiAwMS8xNi8yMDE5IDA2OjAwIFBNLCBNYXR0aGV3IFdpbGNveCB3cm90ZToK
Pj4+IE9uIFdlZCwgSmFuIDE2LCAyMDE5IGF0IDA3OjU3OjAzQU0gKzAxMDAsIE1pY2hhbCBIb2Nr
byB3cm90ZToKPj4+PiBPbiBXZWQgMTYtMDEtMTkgMTE6NTE6MzIsIEFuc2h1bWFuIEtoYW5kdWFs
IHdyb3RlOgo+Pj4+PiBBbGwgYXJjaGl0ZWN0dXJlcyBoYXZlIGJlZW4gZGVmaW5pbmcgdGhlaXIg
b3duIFBHQUxMT0NfR0ZQIGFzIChHRlBfS0VSTkVMIHwKPj4+Pj4gX19HRlBfWkVSTykgYW5kIHVz
aW5nIGl0IGZvciBhbGxvY2F0aW5nIHBhZ2UgdGFibGUgcGFnZXMuIFRoaXMgY2F1c2VzIHNvbWUK
Pj4+Pj4gY29kZSBkdXBsaWNhdGlvbiB3aGljaCBjYW4gYmUgZWFzaWx5IGF2b2lkZWQuIEdGUF9L
RVJORUwgYWxsb2NhdGVkIGFuZAo+Pj4+PiBjbGVhcmVkIG91dCBwYWdlcyAoX19HRlBfWkVSTykg
YXJlIHJlcXVpcmVkIGZvciBwYWdlIHRhYmxlcyBvbiBhbnkgZ2l2ZW4KPj4+Pj4gYXJjaGl0ZWN0
dXJlLiBUaGlzIGNyZWF0ZXMgYSBuZXcgZ2VuZXJpYyBHRlAgZmxhZyBmbGFnIHdoaWNoIGNhbiBi
ZSB1c2VkCj4+Pj4+IGZvciBhbnkgcGFnZSB0YWJsZSBwYWdlIGFsbG9jYXRpb24uIERvZXMgbm90
IGNhdXNlIGFueSBmdW5jdGlvbmFsIGNoYW5nZS4KPj4+Pj4KPj4+Pj4gR0ZQX1BHVEFCTEUgaXMg
YmVpbmcgYWRkZWQgaW50byBpbmNsdWRlL2FzbS1nZW5lcmljL3BndGFibGUuaCB3aGljaCBpcyB0
aGUKPj4+Pj4gZ2VuZXJpYyBwYWdlIHRhYmUgaGVhZGVyIGp1c3QgdG8gcHJldmVudCBpdCdzIHBv
dGVudGlhbCBtaXN1c2UgYXMgYSBnZW5lcmFsCj4+Pj4+IGFsbG9jYXRpb24gZmxhZyBpZiBpbmNs
dWRlZCBpbiBpbmNsdWRlL2xpbnV4L2dmcC5oLgo+Pj4+Cj4+Pj4gSSBoYXZlbid0IHJldmlld2Vk
IHRoZSBwYXRjaCB5ZXQgYnV0IEkgYW0gd29uZGVyaW5nIHdoZXRoZXIgdGhpcyBpcwo+Pj4+IHJl
YWxseSB3b3J0aCBpdCB3aXRob3V0IGdvaW5nIGFsbCB0aGUgd2F5IGRvd24gdG8gdW5pZnkgdGhl
IGNvbW1vbiBjb2RlCj4+Pj4gYW5kIHJlbW92ZSBtdWNoIG1vcmUgY29kZSBkdXBsaWNhdGlvbi4g
T3IgaXMgdGhpcyBub3QgcG9zc2libGUgZm9yIHNvbWUKPj4+PiByZWFzb24/Cj4+Pgo+Pj4gRXhh
Y3RseSB3aGF0IEkgc3VnZ2VzdGVkIGRvaW5nIGluIHJlc3BvbnNlIHRvIHYxLgo+Pj4KPj4+IEFs
c28sIHRoZSBhcHByb2FjaCB0YWtlbiBoZXJlIGlzIGNyYXp5LiAgeDg2IGhhcyBhIGZlYXR1cmUg
dGhhdCBubyBvdGhlcgo+Pj4gYXJjaGl0ZWN0dXJlIGhhcyBib3RoZXJlZCB0byBpbXBsZW1lbnQg
eWV0IC0tIGFjY291bnRpbmcgcGFnZSB0YWJsZXMKPj4+IHRvIHRoZSBwcm9jZXNzLiAgWWV0IGlu
c3RlYWQgb2Ygc3ByZWFkaW5nIHRoYXQgZ29vZG5lc3MgdG8gYWxsIG90aGVyCj4+PiBhcmNoaXRl
Y3R1cmVzLCBBbnNodW1hbiBoYXMgZ29uZSB0byBtb3JlIGVmZm9ydCB0byBhdm9pZCBkb2luZyB0
aGF0Lgo+Pgo+PiBUaGUgYmFzaWMgb2JqZWN0aXZlIGZvciB0aGlzIHBhdGNoIGlzIHRvIGNyZWF0
ZSBhIGNvbW1vbiBtaW5pbXVtIGFsbG9jYXRpb24KPj4gZmxhZyB0aGF0IGNhbiBiZSB1c2VkIGJ5
IGFyY2hpdGVjdHVyZXMgYnV0IHRoYXQgc3RpbGwgYWxsb3dzIGFyY2hzIHRvIGFkZAo+PiBvbiBh
ZGRpdGlvbmFsIGNvbnN0cmFpbnRzIGlmIHRoZXkgc2VlIGZpdC4gVGhpcyBwYXRjaCBkb2VzIG5v
dCBpbnRlbmQgdG8KPj4gY2hhbmdlIGZ1bmN0aW9uYWxpdHkgZm9yIGFueSBhcmNoLgo+IAo+IEkg
ZGlzYWdyZWUgd2l0aCB5b3VyIG9iamVjdGl2ZS4gIE1ha2luZyBtb3JlIGNvZGUgY29tbW9uIGlz
IGEgZ3JlYXQgaWRlYSwKPiBidXQgdGhpcyBwYXRjaCBpcyB0b28gdW5hbWJpdGlvdXMuICBXZSBz
aG91bGQgYmUgaGVhZGluZyB0b3dhcmRzIG9uZSBvcgo+IHR3byBwYWdlIHRhYmxlIGFsbG9jYXRp
b24gZnVuY3Rpb25zIGluc3RlYWQgb2YgaGF2aW5nIGV2ZXJ5IGFyY2hpdGVjdHVyZSBkbwo+IGl0
cyBvd24gdGhpbmcuCj4gCj4gU28gc3RhcnQgdGhlcmUuICBNb3ZlIHRoZSB4ODYgZnVuY3Rpb24g
aW50byBjb21tb24gY29kZSBhbmQgY29udmVydCBvbmUKPiBvdGhlciBhcmNoaXRlY3R1cmUgdG8g
dXNlIGl0IHRvby4KCkFyZSB3ZSB0YWxraW5nIGFib3V0IHB0ZV9hbGxvY19vbmVfa2VybmVsKCkg
YW5kIHB0ZV9hbGxvY19vbmUoKSA/CgpJJ20gbm90IHN1cmUgeDg2IGZ1bmN0aW9uIGlzIHRoZSBi
ZXN0IGNvbW1vbiBvbmUsIGFzIGl0IHNlZW1zIHRvIAphbGxvY2F0ZSBhIG11bHRpcGxlIG9mIFBB
R0VfU0laRSBvbmx5LgoKU29tZSBhcmNoZXMgbGlrZSBwb3dlcnBjIHVzZSBwYWdldGFibGVzIHdo
aWNoIGFyZSBzbWFsbGVyIHRoYW4gYSBwYWdlLCAKZm9yIGluc3RhbmNlIHBvd2VycGMgOHh4IHVz
ZXMgNGsgcGFnZXRhYmxlcyBldmVuIHdpdGggMTZrIHBhZ2VzLCB3aGljaCAKbWVhbnMgYSBzaW5n
bGUgcGFnZSBjYW4gYmUgdXNlZCBieSA0IHBhZ2V0YWJsZXMuCgpUaGVyZWZvcmUsIEkgd291bGQg
c3VnZ2VzdCB0byBzdGFydCB3aXRoIHBvd2VycGMgZnVuY3Rpb25zLgoKQ2hyaXN0b3BoZQoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtl
cm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5l
bAo=
