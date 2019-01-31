Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5F8C282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 07:07:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72E7E20870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 07:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DTLeZmCz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="rCd82aqn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72E7E20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zZqFF6i7KpveszZ8iPbGKqKvA6afFYxEr9qDTBMW0LQ=; b=DTLeZmCzQNb7pdjBKILdo+aY0
	YGdvjn5Ssu+XkuGEQAV59vxIBTU0qbYLKL4OezNn9Aktalt2UlQF7r2TpgAIOqfjZlrPzqxGNA46O
	wE8MY1xCfssAgnusZleJqN9Tv2BZcOShqZg+Ww7X5lkp0eqJOTu8LfxOX2tvyRwLC72t5rRQqSFC+
	Oqmjg9HXVG+mLji2Nr/3h6nwx1CHn6kQBQMgdGafuv5URTngsGupIKXgBwxCBUl1Celj6lKap8VEs
	tfgO21dKsce959gxePWc9gyQHb4igb4dydyAG61BMh2UJH80GOUpFrT3ZsuREOt6npCUx+Vse5gho
	BrwkM+a0A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp6Rm-0008QJ-72; Thu, 31 Jan 2019 07:07:38 +0000
Received: from pegase1.c-s.fr ([93.17.236.30])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp6Ri-0008Pl-59; Thu, 31 Jan 2019 07:07:35 +0000
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43qrsH3KnTz9v0Ql;
 Thu, 31 Jan 2019 08:07:31 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=rCd82aqn; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id DAzsBnhWoB9O; Thu, 31 Jan 2019 08:07:31 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43qrsH1tsMz9v0Qj;
 Thu, 31 Jan 2019 08:07:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1548918451; bh=MXHl21tpazUCycYGJIF5K2H108fXMrwBKp0kMfVZOHU=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=rCd82aqnCmgVKey8lh2qo7e2czYPgKR5K0SsqXWaaG+aPdVhNoJAHK8cvl05jNaLQ
 01Tbj78zc0z794OUHngjeqyEvlUQI7ONSfsFOcwtpy8Q//8zmi0Zwd5Q5S7O8IAO0Y
 J0iKKRNhFMGd08UKWW9aHyiQ2pzFvIMvvFhWRBCY=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 176168B78D;
 Thu, 31 Jan 2019 08:07:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 9D0PmJeNjYuQ; Thu, 31 Jan 2019 08:07:31 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 075218B74C;
 Thu, 31 Jan 2019 08:07:29 +0100 (CET)
Subject: Re: [PATCH v2 19/21] treewide: add checks for the return value of
 memblock_alloc*()
To: Mike Rapoport <rppt@linux.ibm.com>
References: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
 <1548057848-15136-20-git-send-email-rppt@linux.ibm.com>
 <b7c12014-14ae-2a38-900c-41fd145307bc@c-s.fr>
 <20190131064139.GB28876@rapoport-lnx>
 <8838f7ab-998b-6d78-02a8-a53f8a3619d9@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <d5e4ff5b-d33a-e641-8159-d4f83bc28d0b@c-s.fr>
Date: Thu, 31 Jan 2019 08:07:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <8838f7ab-998b-6d78-02a8-a53f8a3619d9@c-s.fr>
Content-Language: fr
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_230734_494698_DFAECF59 
X-CRM114-Status: GOOD (  16.76  )
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
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
 Petr Mladek <pmladek@suse.com>, linux-sh@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>,
 sparclinux@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Weinberger <richard@nod.at>, x86@kernel.org,
 Russell King <linux@armlinux.org.uk>, kasan-dev@googlegroups.com,
 Geert Uytterhoeven <geert@linux-m68k.org>, Mark Salter <msalter@redhat.com>,
 Dennis Zhou <dennis@kernel.org>, Matt Turner <mattst88@gmail.com>,
 linux-snps-arc@lists.infradead.org, uclinux-h8-devel@lists.sourceforge.jp,
 devicetree@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-xtensa@linux-xtensa.org, linux-um@lists.infradead.org,
 linux-m68k@lists.linux-m68k.org, Rob Herring <robh+dt@kernel.org>,
 Greentime Hu <green.hu@gmail.com>, xen-devel@lists.xenproject.org,
 Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>,
 linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>,
 Tony Luck <tony.luck@intel.com>, linux-mm@kvack.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-mips@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
 Vineet Gupta <vgupta@synopsys.com>, linux-alpha@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>, openrisc@lists.librecores.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

CgpMZSAzMS8wMS8yMDE5IMOgIDA3OjQ0LCBDaHJpc3RvcGhlIExlcm95IGEgw6ljcml0wqA6Cj4g
Cj4gCj4gTGUgMzEvMDEvMjAxOSDDoCAwNzo0MSwgTWlrZSBSYXBvcG9ydCBhIMOpY3JpdMKgOgo+
PiBPbiBUaHUsIEphbiAzMSwgMjAxOSBhdCAwNzowNzo0NkFNICswMTAwLCBDaHJpc3RvcGhlIExl
cm95IHdyb3RlOgo+Pj4KPj4+Cj4+PiBMZSAyMS8wMS8yMDE5IMOgIDA5OjA0LCBNaWtlIFJhcG9w
b3J0IGEgw6ljcml0wqA6Cj4+Pj4gQWRkIGNoZWNrIGZvciB0aGUgcmV0dXJuIHZhbHVlIG9mIG1l
bWJsb2NrX2FsbG9jKigpIGZ1bmN0aW9ucyBhbmQgY2FsbAo+Pj4+IHBhbmljKCkgaW4gY2FzZSBv
ZiBlcnJvci4KPj4+PiBUaGUgcGFuaWMgbWVzc2FnZSByZXBlYXRzIHRoZSBvbmUgdXNlZCBieSBw
YW5pY2luZyBtZW1ibG9jayAKPj4+PiBhbGxvY2F0b3JzIHdpdGgKPj4+PiBhZGp1c3RtZW50IG9m
IHBhcmFtZXRlcnMgdG8gaW5jbHVkZSBvbmx5IHJlbGV2YW50IG9uZXMuCj4+Pj4KPj4+PiBUaGUg
cmVwbGFjZW1lbnQgd2FzIG1vc3RseSBhdXRvbWF0ZWQgd2l0aCBzZW1hbnRpYyBwYXRjaGVzIGxp
a2UgdGhlIG9uZQo+Pj4+IGJlbG93IHdpdGggbWFudWFsIG1hc3NhZ2luZyBvZiBmb3JtYXQgc3Ry
aW5ncy4KPj4+Pgo+Pj4+IEBACj4+Pj4gZXhwcmVzc2lvbiBwdHIsIHNpemUsIGFsaWduOwo+Pj4+
IEBACj4+Pj4gcHRyID0gbWVtYmxvY2tfYWxsb2Moc2l6ZSwgYWxpZ24pOwo+Pj4+ICsgaWYgKCFw
dHIpCj4+Pj4gK8KgwqDCoMKgIHBhbmljKCIlczogRmFpbGVkIHRvIGFsbG9jYXRlICVsdSBieXRl
cyBhbGlnbj0weCVseFxuIiwgX19mdW5jX18sCj4+Pj4gc2l6ZSwgYWxpZ24pOwo+Pj4+Cj4+Pj4g
U2lnbmVkLW9mZi1ieTogTWlrZSBSYXBvcG9ydCA8cnBwdEBsaW51eC5pYm0uY29tPgo+Pj4+IFJl
dmlld2VkLWJ5OiBHdW8gUmVuIDxyZW5fZ3VvQGMtc2t5LmNvbT7CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgIyBjLXNreQo+Pj4+IEFja2VkLWJ5OiBQYXVsIEJ1cnRvbiA8cGF1bC5idXJ0b25AbWlw
cy5jb20+wqDCoMKgwqDCoMKgwqDCoCAjIE1JUFMKPj4+PiBBY2tlZC1ieTogSGVpa28gQ2Fyc3Rl
bnMgPGhlaWtvLmNhcnN0ZW5zQGRlLmlibS5jb20+ICMgczM5MAo+Pj4+IFJldmlld2VkLWJ5OiBK
dWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+wqDCoMKgwqDCoMKgwqDCoCAjIFhlbgo+Pj4+
IC0tLQo+Pj4KPj4+IFsuLi5dCj4+Pgo+Pj4+IGRpZmYgLS1naXQgYS9tbS9zcGFyc2UuYyBiL21t
L3NwYXJzZS5jCj4+Pj4gaW5kZXggN2VhNWRjNi4uYWQ5NDI0MiAxMDA2NDQKPj4+PiAtLS0gYS9t
bS9zcGFyc2UuYwo+Pj4+ICsrKyBiL21tL3NwYXJzZS5jCj4+Pgo+Pj4gWy4uLl0KPj4+Cj4+Pj4g
QEAgLTQyNSw2ICs0MzYsMTAgQEAgc3RhdGljIHZvaWQgX19pbml0IHNwYXJzZV9idWZmZXJfaW5p
dCh1bnNpZ25lZCAKPj4+PiBsb25nIHNpemUsIGludCBuaWQpCj4+Pj4gwqDCoMKgwqDCoMKgwqDC
oMKgIG1lbWJsb2NrX2FsbG9jX3RyeV9uaWRfcmF3KHNpemUsIFBBR0VfU0laRSwKPj4+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBfX3BhKE1BWF9E
TUFfQUREUkVTUyksCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgTUVNQkxPQ0tfQUxMT0NfQUNDRVNTSUJMRSwgbmlkKTsKPj4+PiArwqDCoMKg
IGlmICghc3BhcnNlbWFwX2J1ZikKPj4+PiArwqDCoMKgwqDCoMKgwqAgcGFuaWMoIiVzOiBGYWls
ZWQgdG8gYWxsb2NhdGUgJWx1IGJ5dGVzIGFsaWduPTB4JWx4IG5pZD0lZCAKPj4+PiBmcm9tPSVs
eFxuIiwKPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgX19mdW5jX18sIHNpemUsIFBB
R0VfU0laRSwgbmlkLCBfX3BhKE1BWF9ETUFfQUREUkVTUykpOwo+Pj4+ICsKPj4+Cj4+PiBtZW1i
bG9ja19hbGxvY190cnlfbmlkX3JhdygpIGRvZXMgbm90IHBhbmljIChoZWxwIGV4cGxpY2l0bHkg
c2F5czogCj4+PiBEb2VzIG5vdAo+Pj4gemVybyBhbGxvY2F0ZWQgbWVtb3J5LCBkb2VzIG5vdCBw
YW5pYyBpZiByZXF1ZXN0IGNhbm5vdCBiZSBzYXRpc2ZpZWQuKS4KPj4KPj4gIkRvZXMgbm90IHBh
bmljIiBkb2VzIG5vdCBtZWFuIGl0IGFsd2F5cyBzdWNjZWVkcy4KPiAKPiBJIGFncmVlLCBidXQg
YXQgbGVhc3QgaGVyZSB5b3UgYXJlIGNoYW5naW5nIHRoZSBiZWhhdmlvdXIgYnkgbWFraW5nIGl0
IAo+IHBhbmljIGV4cGxpY2l0bHkuIEFyZSB3ZSBzdXJlIHRoZXJlIGFyZSBub3QgY2FzZXMgd2hl
cmUgdGhlIHN5c3RlbSBjb3VsZCAKPiBqdXN0IGNvbnRpbnVlIGZ1bmN0aW9ubmluZyA/IE1heWJl
IGEgV0FSTl9PTigpIHdvdWxkIGJlIGVub3VnaCB0aGVyZSA/CgpMb29raW5nIG1vcmUgaW4gZGV0
YWlscywgaXQgbG9va3MgbGlrZSBldmVyeXRoaW5nIGlzIGRvbmUgdG8gbGl2ZSB3aXRoIApzcGFy
c2VtYXBfYnVmIE5VTEwsIGFsbCBmdW5jdGlvbnMgdXNpbmcgaXQgY2hlY2sgaXQgc28gaGF2aW5n
IGl0IE5VTEwgCnNob3VsZG4ndCBpbXBseSBhIHBhbmljIEkgYmVsaWV2ZSwgc2VlIGNvZGUgYmVs
b3cuCgpzdGF0aWMgdm9pZCAqc3BhcnNlbWFwX2J1ZiBfX21lbWluaXRkYXRhOwpzdGF0aWMgdm9p
ZCAqc3BhcnNlbWFwX2J1Zl9lbmQgX19tZW1pbml0ZGF0YTsKCnN0YXRpYyB2b2lkIF9faW5pdCBz
cGFyc2VfYnVmZmVyX2luaXQodW5zaWduZWQgbG9uZyBzaXplLCBpbnQgbmlkKQp7CglXQVJOX09O
KHNwYXJzZW1hcF9idWYpOwkvKiBmb3Jnb3QgdG8gY2FsbCBzcGFyc2VfYnVmZmVyX2ZpbmkoKT8g
Ki8KCXNwYXJzZW1hcF9idWYgPQoJCW1lbWJsb2NrX2FsbG9jX3RyeV9uaWRfcmF3KHNpemUsIFBB
R0VfU0laRSwKCQkJCQkJX19wYShNQVhfRE1BX0FERFJFU1MpLAoJCQkJCQlNRU1CTE9DS19BTExP
Q19BQ0NFU1NJQkxFLCBuaWQpOwoJc3BhcnNlbWFwX2J1Zl9lbmQgPSBzcGFyc2VtYXBfYnVmICsg
c2l6ZTsKfQoKc3RhdGljIHZvaWQgX19pbml0IHNwYXJzZV9idWZmZXJfZmluaSh2b2lkKQp7Cgl1
bnNpZ25lZCBsb25nIHNpemUgPSBzcGFyc2VtYXBfYnVmX2VuZCAtIHNwYXJzZW1hcF9idWY7CgoJ
aWYgKHNwYXJzZW1hcF9idWYgJiYgc2l6ZSA+IDApCgkJbWVtYmxvY2tfZnJlZV9lYXJseShfX3Bh
KHNwYXJzZW1hcF9idWYpLCBzaXplKTsKCXNwYXJzZW1hcF9idWYgPSBOVUxMOwp9Cgp2b2lkICog
X19tZW1pbml0IHNwYXJzZV9idWZmZXJfYWxsb2ModW5zaWduZWQgbG9uZyBzaXplKQp7Cgl2b2lk
ICpwdHIgPSBOVUxMOwoKCWlmIChzcGFyc2VtYXBfYnVmKSB7CgkJcHRyID0gUFRSX0FMSUdOKHNw
YXJzZW1hcF9idWYsIHNpemUpOwoJCWlmIChwdHIgKyBzaXplID4gc3BhcnNlbWFwX2J1Zl9lbmQp
CgkJCXB0ciA9IE5VTEw7CgkJZWxzZQoJCQlzcGFyc2VtYXBfYnVmID0gcHRyICsgc2l6ZTsKCX0K
CXJldHVybiBwdHI7Cn0KCgpDaHJpc3RvcGhlCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
