Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D48C282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 06:08:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FB9E218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 06:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MIHAleoK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="PPRKteYu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FB9E218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=oq9f7tR9U02uhoWVtqdCSEtSfU2a8TS9E9UKD4T3DOY=; b=MIHAleoKjsMp8/s44sEBOjKib
	xl1lIQuTsEGuvflx04I3lKW3OEDCIxybzVGCpctfoDg9N4l5KbSratOd6Lt+swCFEEwVmkYaPFT/6
	gSL03vJvtTtYXQ81vohAtyg2FYcHXNUDx+Rp8vY/PUVOw9ieknL+zkAO0MbC+YyZL25RPrCosp9GY
	UGqde6XkCRVTl3oBh7gqH6G9ep/pjb8IOsE42AlkH2PfOIWks4D7iLgO0Jfwz/w+Pe/kk3ijm4Xm1
	3l/vJjcHNufR6UknEIJMwO8Ld6rczIrhdd+DerpikT1Q3K8snGfCXUcUak8sHWEwY0AxVWlANpOA8
	p9BnMVkFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp5W4-0006nJ-VY; Thu, 31 Jan 2019 06:08:00 +0000
Received: from pegase1.c-s.fr ([93.17.236.30])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp5W0-0006m1-MH; Thu, 31 Jan 2019 06:07:58 +0000
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43qqXN2zD6z9v0y2;
 Thu, 31 Jan 2019 07:07:48 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=PPRKteYu; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 8eQljt9yKxMk; Thu, 31 Jan 2019 07:07:48 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43qqXN19Kmz9v0y0;
 Thu, 31 Jan 2019 07:07:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1548914868; bh=NCah7PD0r/noHO/Uh52qxtNlyFWpGoyRnjJU9LYwodw=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=PPRKteYuUZeYij8URy8Yi6SlDuWnapGXe+mGP4EjcgzMqqNP8EZdSP5FNVjPYInsT
 1SLAJFU3/5dHTmUUvReCIz9Epq15HGwbyMCJ7xsQ51aFHaQlJbFmKmOks3EsEBfY8B
 rAbHZg9+ub3vVM8gaD3FsZGuNpYhHL+xUNVYs/Xg=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E31D88B78D;
 Thu, 31 Jan 2019 07:07:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id UCr4ES66h6TH; Thu, 31 Jan 2019 07:07:48 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 8FD748B74C;
 Thu, 31 Jan 2019 07:07:46 +0100 (CET)
Subject: Re: [PATCH v2 19/21] treewide: add checks for the return value of
 memblock_alloc*()
To: Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org
References: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
 <1548057848-15136-20-git-send-email-rppt@linux.ibm.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <b7c12014-14ae-2a38-900c-41fd145307bc@c-s.fr>
Date: Thu, 31 Jan 2019 07:07:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548057848-15136-20-git-send-email-rppt@linux.ibm.com>
Content-Language: fr
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_220757_023343_8A6B58C9 
X-CRM114-Status: GOOD (  15.46  )
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
 Tony Luck <tony.luck@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-mips@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
 Vineet Gupta <vgupta@synopsys.com>, linux-alpha@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>, openrisc@lists.librecores.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

CgpMZSAyMS8wMS8yMDE5IMOgIDA5OjA0LCBNaWtlIFJhcG9wb3J0IGEgw6ljcml0wqA6Cj4gQWRk
IGNoZWNrIGZvciB0aGUgcmV0dXJuIHZhbHVlIG9mIG1lbWJsb2NrX2FsbG9jKigpIGZ1bmN0aW9u
cyBhbmQgY2FsbAo+IHBhbmljKCkgaW4gY2FzZSBvZiBlcnJvci4KPiBUaGUgcGFuaWMgbWVzc2Fn
ZSByZXBlYXRzIHRoZSBvbmUgdXNlZCBieSBwYW5pY2luZyBtZW1ibG9jayBhbGxvY2F0b3JzIHdp
dGgKPiBhZGp1c3RtZW50IG9mIHBhcmFtZXRlcnMgdG8gaW5jbHVkZSBvbmx5IHJlbGV2YW50IG9u
ZXMuCj4gCj4gVGhlIHJlcGxhY2VtZW50IHdhcyBtb3N0bHkgYXV0b21hdGVkIHdpdGggc2VtYW50
aWMgcGF0Y2hlcyBsaWtlIHRoZSBvbmUKPiBiZWxvdyB3aXRoIG1hbnVhbCBtYXNzYWdpbmcgb2Yg
Zm9ybWF0IHN0cmluZ3MuCj4gCj4gQEAKPiBleHByZXNzaW9uIHB0ciwgc2l6ZSwgYWxpZ247Cj4g
QEAKPiBwdHIgPSBtZW1ibG9ja19hbGxvYyhzaXplLCBhbGlnbik7Cj4gKyBpZiAoIXB0cikKPiAr
IAlwYW5pYygiJXM6IEZhaWxlZCB0byBhbGxvY2F0ZSAlbHUgYnl0ZXMgYWxpZ249MHglbHhcbiIs
IF9fZnVuY19fLAo+IHNpemUsIGFsaWduKTsKPiAKPiBTaWduZWQtb2ZmLWJ5OiBNaWtlIFJhcG9w
b3J0IDxycHB0QGxpbnV4LmlibS5jb20+Cj4gUmV2aWV3ZWQtYnk6IEd1byBSZW4gPHJlbl9ndW9A
Yy1za3kuY29tPiAgICAgICAgICAgICAjIGMtc2t5Cj4gQWNrZWQtYnk6IFBhdWwgQnVydG9uIDxw
YXVsLmJ1cnRvbkBtaXBzLmNvbT4JICAgICAjIE1JUFMKPiBBY2tlZC1ieTogSGVpa28gQ2Fyc3Rl
bnMgPGhlaWtvLmNhcnN0ZW5zQGRlLmlibS5jb20+ICMgczM5MAo+IFJldmlld2VkLWJ5OiBKdWVy
Z2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+ICAgICAgICAgIyBYZW4KPiAtLS0KClsuLi5dCgo+
IGRpZmYgLS1naXQgYS9tbS9zcGFyc2UuYyBiL21tL3NwYXJzZS5jCj4gaW5kZXggN2VhNWRjNi4u
YWQ5NDI0MiAxMDA2NDQKPiAtLS0gYS9tbS9zcGFyc2UuYwo+ICsrKyBiL21tL3NwYXJzZS5jCgpb
Li4uXQoKPiBAQCAtNDI1LDYgKzQzNiwxMCBAQCBzdGF0aWMgdm9pZCBfX2luaXQgc3BhcnNlX2J1
ZmZlcl9pbml0KHVuc2lnbmVkIGxvbmcgc2l6ZSwgaW50IG5pZCkKPiAgIAkJbWVtYmxvY2tfYWxs
b2NfdHJ5X25pZF9yYXcoc2l6ZSwgUEFHRV9TSVpFLAo+ICAgCQkJCQkJX19wYShNQVhfRE1BX0FE
RFJFU1MpLAo+ICAgCQkJCQkJTUVNQkxPQ0tfQUxMT0NfQUNDRVNTSUJMRSwgbmlkKTsKPiArCWlm
ICghc3BhcnNlbWFwX2J1ZikKPiArCQlwYW5pYygiJXM6IEZhaWxlZCB0byBhbGxvY2F0ZSAlbHUg
Ynl0ZXMgYWxpZ249MHglbHggbmlkPSVkIGZyb209JWx4XG4iLAo+ICsJCSAgICAgIF9fZnVuY19f
LCBzaXplLCBQQUdFX1NJWkUsIG5pZCwgX19wYShNQVhfRE1BX0FERFJFU1MpKTsKPiArCgptZW1i
bG9ja19hbGxvY190cnlfbmlkX3JhdygpIGRvZXMgbm90IHBhbmljIChoZWxwIGV4cGxpY2l0bHkg
c2F5czogRG9lcyAKbm90IHplcm8gYWxsb2NhdGVkIG1lbW9yeSwgZG9lcyBub3QgcGFuaWMgaWYg
cmVxdWVzdCBjYW5ub3QgYmUgc2F0aXNmaWVkLikuCgpTdGVwaGVuIFJvdGh3ZWxsIHJlcG9ydHMg
YSBib290IGZhaWx1cmUgZHVlIHRvIHRoaXMgY2hhbmdlLgoKQ2hyaXN0b3BoZQoKPiAgIAlzcGFy
c2VtYXBfYnVmX2VuZCA9IHNwYXJzZW1hcF9idWYgKyBzaXplOwo+ICAgfQo+ICAgCj4gCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2Vy
bmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVs
Cg==
