Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DEBFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 13:50:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D20772084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 13:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sU1OE1Af"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D20772084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IEbjzopFNA79qh8QCrlqikR6NwDQ1p6HGGEmRi3xVu0=; b=sU1OE1AfeFO/E0IrM/ktdqTWe
	0Ei2jqdI3S0lcy6mogv3hP9SBRNdf01IgD73UGzOTYcpLYZIiGlYzgiNJ5V0dzMmmOYFoa8IFkGyb
	rZMUyt12bJaJ1JLJ66IX13qd3GPjFcZmGseWKSIy4i59jbNs8vWG8ENthg4yd5ReqnSUYp6XWDOnW
	i0kV/76ig1P0kc96cZOgRq6pvFM50evF2pY1s+HTOF8Blh7huUTSRlr5JcjsbQTXBkUMlL+1wfSKh
	qDRjZRLXRn5n9HqIrnwXd9JvgG5J8/ciB/u5f3CXFP3U8lmk3Oc7g4FlLWkULtVPaXjIC6englp6E
	W1280yIUw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giJfg-0005Kv-FX; Sat, 12 Jan 2019 13:49:56 +0000
Received: from [93.17.236.30] (helo=pegase1.c-s.fr)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giJfX-0005Gi-Mj
 for linux-arm-kernel@lists.infradead.org; Sat, 12 Jan 2019 13:49:54 +0000
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43cLgq65Zjz9vBmP;
 Sat, 12 Jan 2019 14:49:27 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 8olI-kILdexS; Sat, 12 Jan 2019 14:49:27 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43cLgq5BBkz9vBmN;
 Sat, 12 Jan 2019 14:49:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id CC2268B77F;
 Sat, 12 Jan 2019 14:49:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id zFSHdAazdoZD; Sat, 12 Jan 2019 14:49:30 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 7A89F8B74C;
 Sat, 12 Jan 2019 14:49:29 +0100 (CET)
Subject: Re: [PATCH] mm: Introduce GFP_PGTABLE
To: Matthew Wilcox <willy@infradead.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>
References: <1547288798-10243-1-git-send-email-anshuman.khandual@arm.com>
 <20190112121230.GQ6310@bombadil.infradead.org>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <ddd59fdc-3d8f-4015-e851-e7f099193a1b@c-s.fr>
Date: Sat, 12 Jan 2019 14:49:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190112121230.GQ6310@bombadil.infradead.org>
Content-Language: fr
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_054947_887934_E55480C3 
X-CRM114-Status: UNSURE (   9.10  )
X-CRM114-Notice: Please train this message.
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
Cc: mark.rutland@arm.com, mhocko@suse.com, linux-sh@vger.kernel.org,
 peterz@infradead.org, catalin.marinas@arm.com, dave.hansen@linux.intel.com,
 will.deacon@arm.com, christoffer.dall@arm.com, linux-mm@kvack.org,
 kvmarm@lists.cs.columbia.edu, aneesh.kumar@linux.ibm.com,
 linux@armlinux.org.uk, mingo@redhat.com, vbabka@suse.cz, rientjes@google.com,
 marc.zyngier@arm.com, rppt@linux.vnet.ibm.com, shakeelb@google.com,
 kirill@shutemov.name, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
 ard.biesheuvel@linaro.org, linuxppc-dev@lists.ozlabs.org, steve.capper@arm.com,
 linux-kernel@vger.kernel.org, james.morse@arm.com, akpm@linux-foundation.org,
 robin.murphy@arm.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

CgpMZSAxMi8wMS8yMDE5IMOgIDEzOjEyLCBNYXR0aGV3IFdpbGNveCBhIMOpY3JpdMKgOgo+IE9u
IFNhdCwgSmFuIDEyLCAyMDE5IGF0IDAzOjU2OjM4UE0gKzA1MzAsIEFuc2h1bWFuIEtoYW5kdWFs
IHdyb3RlOgo+PiBBbGwgYXJjaGl0ZWN0dXJlcyBoYXZlIGJlZW4gZGVmaW5pbmcgdGhlaXIgb3du
IFBHQUxMT0NfR0ZQIGFzIChHRlBfS0VSTkVMIHwKPj4gX19HRlBfWkVSTykgYW5kIHVzaW5nIGl0
IGZvciBhbGxvY2F0aW5nIHBhZ2UgdGFibGUgcGFnZXMuCj4gCj4gRXhjZXB0IHRoYXQncyBub3Qg
dHJ1ZS4KPiAKPj4gKysrIGIvYXJjaC94ODYvbW0vcGd0YWJsZS5jCj4+IEBAIC0xMywxOSArMTMs
MTcgQEAgcGh5c19hZGRyX3QgcGh5c2ljYWxfbWFzayBfX3JvX2FmdGVyX2luaXQgPSAoMVVMTCA8
PCBfX1BIWVNJQ0FMX01BU0tfU0hJRlQpIC0gMTsKPj4gICBFWFBPUlRfU1lNQk9MKHBoeXNpY2Fs
X21hc2spOwo+PiAgICNlbmRpZgo+PiAgIAo+PiAtI2RlZmluZSBQR0FMTE9DX0dGUCAoR0ZQX0tF
Uk5FTF9BQ0NPVU5UIHwgX19HRlBfWkVSTykKPj4gLQo+PiAgICNpZmRlZiBDT05GSUdfSElHSFBU
RQo+IAo+IC4uLgo+IAo+PiAgIHB0ZV90ICpwdGVfYWxsb2Nfb25lX2tlcm5lbChzdHJ1Y3QgbW1f
c3RydWN0ICptbSkKPj4gICB7Cj4+IC0JcmV0dXJuIChwdGVfdCAqKV9fZ2V0X2ZyZWVfcGFnZShQ
R0FMTE9DX0dGUCAmIH5fX0dGUF9BQ0NPVU5UKTsKPj4gKwlyZXR1cm4gKHB0ZV90ICopX19nZXRf
ZnJlZV9wYWdlKEdGUF9QR1RBQkxFICYgfl9fR0ZQX0FDQ09VTlQpOwo+PiAgIH0KCkFzIGZhciBh
cyBJIGNhbiBzZWUsCgojZGVmaW5lIEdGUF9LRVJORUxfQUNDT1VOVCAoR0ZQX0tFUk5FTCB8IF9f
R0ZQX0FDQ09VTlQpCgpTbyB3aGF0J3MgdGhlIGRpZmZlcmVuY2UgYmV0d2VlbjoKCihHRlBfS0VS
TkVMX0FDQ09VTlQgfCBfX0dGUF9aRVJPKSAmIH5fX0dGUF9BQ0NPVU5UCgphbmQKCihHRlBfS0VS
TkVMIHwgX19HRlBfWkVSTykgJiB+X19HRlBfQUNDT1VOVAoKQ2hyaXN0b3BoZQoKPiAKPiBJIHRo
aW5rIHg4NiB3YXMgdGhlIG9ubHkgb2RkIG9uZSBvdXQgaGVyZSwgYnV0IHlvdSdsbCBuZWVkIHRv
IHRyeSBhZ2FpbiAuLi4KPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
