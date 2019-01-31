Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC80C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 06:44:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3861420881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 06:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="drRTknzM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="JMZ+vLjQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3861420881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=8dr4vUDHkDrfiUS+cBbFlU+L5q5bm2stRM1DVeSH8E4=; b=drRTknzMJF9deUMUAaPtEeIhq
	RWeMhHcrq4HlHh34J02zhmLh0tFVl/Y+SMiDQqIoot9WxpdqB3iKcGQlMN2pRaZMK9DqTQq8+xYcs
	hUzGE+4rl7cm2/Xn4xBQT/6Ga9W80daEocujYuY1ayVDWerWPmvtUnjiRXi1ZPBDyRZo4FoqnVOaT
	AyF9136F+nF1g18XoxSXXZnDr9Ds8R7T0n5D2LlrnAkXYNUPWpgbGyBPae799S5mePTIpzXEw2GJn
	QkFkxpCTLfC9utX2+MzjzM/Mf+v6uE+9thiSTcZVu3e1kYK0lqSM6JyH6RNKCHrpjrQ57BvXE7EMu
	yqwyhCQSA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp65F-0000cE-Vo; Thu, 31 Jan 2019 06:44:21 +0000
Received: from pegase1.c-s.fr ([93.17.236.30])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp65C-0000bm-T2; Thu, 31 Jan 2019 06:44:20 +0000
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43qrLS1Crsz9v0QW;
 Thu, 31 Jan 2019 07:44:16 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=JMZ+vLjQ; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id GE1BryDiLvL6; Thu, 31 Jan 2019 07:44:16 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43qrLR6vTNz9v0QV;
 Thu, 31 Jan 2019 07:44:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1548917056; bh=cOJiyexC4RhzV3nLmw1xVDcK744oiB5d7rgry5+gXoM=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=JMZ+vLjQ76kryo0d4/3v/CDV0aIlsMdhbsiuclC0eKE0XnqOavCGYfranMcArXvgZ
 dV45OC8eZ/80eWqgb+hc9/o9z1Khd3UH2cqOEZvxMsXqASyrcPNuh48OKAIU0LEGhU
 t5oaxwZcm23sWI0poHri1Vgox0AoX9rAx2aliPUM=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id BA4FF8B78E;
 Thu, 31 Jan 2019 07:44:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id ETfFXp9TLqKY; Thu, 31 Jan 2019 07:44:16 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 8915D8B74C;
 Thu, 31 Jan 2019 07:44:14 +0100 (CET)
Subject: Re: [PATCH v2 19/21] treewide: add checks for the return value of
 memblock_alloc*()
To: Mike Rapoport <rppt@linux.ibm.com>
References: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
 <1548057848-15136-20-git-send-email-rppt@linux.ibm.com>
 <b7c12014-14ae-2a38-900c-41fd145307bc@c-s.fr>
 <20190131064139.GB28876@rapoport-lnx>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <8838f7ab-998b-6d78-02a8-a53f8a3619d9@c-s.fr>
Date: Thu, 31 Jan 2019 07:44:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131064139.GB28876@rapoport-lnx>
Content-Language: fr
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_224419_235114_756DF059 
X-CRM114-Status: GOOD (  15.03  )
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

CgpMZSAzMS8wMS8yMDE5IMOgIDA3OjQxLCBNaWtlIFJhcG9wb3J0IGEgw6ljcml0wqA6Cj4gT24g
VGh1LCBKYW4gMzEsIDIwMTkgYXQgMDc6MDc6NDZBTSArMDEwMCwgQ2hyaXN0b3BoZSBMZXJveSB3
cm90ZToKPj4KPj4KPj4gTGUgMjEvMDEvMjAxOSDDoCAwOTowNCwgTWlrZSBSYXBvcG9ydCBhIMOp
Y3JpdMKgOgo+Pj4gQWRkIGNoZWNrIGZvciB0aGUgcmV0dXJuIHZhbHVlIG9mIG1lbWJsb2NrX2Fs
bG9jKigpIGZ1bmN0aW9ucyBhbmQgY2FsbAo+Pj4gcGFuaWMoKSBpbiBjYXNlIG9mIGVycm9yLgo+
Pj4gVGhlIHBhbmljIG1lc3NhZ2UgcmVwZWF0cyB0aGUgb25lIHVzZWQgYnkgcGFuaWNpbmcgbWVt
YmxvY2sgYWxsb2NhdG9ycyB3aXRoCj4+PiBhZGp1c3RtZW50IG9mIHBhcmFtZXRlcnMgdG8gaW5j
bHVkZSBvbmx5IHJlbGV2YW50IG9uZXMuCj4+Pgo+Pj4gVGhlIHJlcGxhY2VtZW50IHdhcyBtb3N0
bHkgYXV0b21hdGVkIHdpdGggc2VtYW50aWMgcGF0Y2hlcyBsaWtlIHRoZSBvbmUKPj4+IGJlbG93
IHdpdGggbWFudWFsIG1hc3NhZ2luZyBvZiBmb3JtYXQgc3RyaW5ncy4KPj4+Cj4+PiBAQAo+Pj4g
ZXhwcmVzc2lvbiBwdHIsIHNpemUsIGFsaWduOwo+Pj4gQEAKPj4+IHB0ciA9IG1lbWJsb2NrX2Fs
bG9jKHNpemUsIGFsaWduKTsKPj4+ICsgaWYgKCFwdHIpCj4+PiArIAlwYW5pYygiJXM6IEZhaWxl
ZCB0byBhbGxvY2F0ZSAlbHUgYnl0ZXMgYWxpZ249MHglbHhcbiIsIF9fZnVuY19fLAo+Pj4gc2l6
ZSwgYWxpZ24pOwo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IE1pa2UgUmFwb3BvcnQgPHJwcHRAbGlu
dXguaWJtLmNvbT4KPj4+IFJldmlld2VkLWJ5OiBHdW8gUmVuIDxyZW5fZ3VvQGMtc2t5LmNvbT4g
ICAgICAgICAgICAgIyBjLXNreQo+Pj4gQWNrZWQtYnk6IFBhdWwgQnVydG9uIDxwYXVsLmJ1cnRv
bkBtaXBzLmNvbT4JICAgICAjIE1JUFMKPj4+IEFja2VkLWJ5OiBIZWlrbyBDYXJzdGVucyA8aGVp
a28uY2Fyc3RlbnNAZGUuaWJtLmNvbT4gIyBzMzkwCj4+PiBSZXZpZXdlZC1ieTogSnVlcmdlbiBH
cm9zcyA8amdyb3NzQHN1c2UuY29tPiAgICAgICAgICMgWGVuCj4+PiAtLS0KPj4KPj4gWy4uLl0K
Pj4KPj4+IGRpZmYgLS1naXQgYS9tbS9zcGFyc2UuYyBiL21tL3NwYXJzZS5jCj4+PiBpbmRleCA3
ZWE1ZGM2Li5hZDk0MjQyIDEwMDY0NAo+Pj4gLS0tIGEvbW0vc3BhcnNlLmMKPj4+ICsrKyBiL21t
L3NwYXJzZS5jCj4+Cj4+IFsuLi5dCj4+Cj4+PiBAQCAtNDI1LDYgKzQzNiwxMCBAQCBzdGF0aWMg
dm9pZCBfX2luaXQgc3BhcnNlX2J1ZmZlcl9pbml0KHVuc2lnbmVkIGxvbmcgc2l6ZSwgaW50IG5p
ZCkKPj4+ICAgCQltZW1ibG9ja19hbGxvY190cnlfbmlkX3JhdyhzaXplLCBQQUdFX1NJWkUsCj4+
PiAgIAkJCQkJCV9fcGEoTUFYX0RNQV9BRERSRVNTKSwKPj4+ICAgCQkJCQkJTUVNQkxPQ0tfQUxM
T0NfQUNDRVNTSUJMRSwgbmlkKTsKPj4+ICsJaWYgKCFzcGFyc2VtYXBfYnVmKQo+Pj4gKwkJcGFu
aWMoIiVzOiBGYWlsZWQgdG8gYWxsb2NhdGUgJWx1IGJ5dGVzIGFsaWduPTB4JWx4IG5pZD0lZCBm
cm9tPSVseFxuIiwKPj4+ICsJCSAgICAgIF9fZnVuY19fLCBzaXplLCBQQUdFX1NJWkUsIG5pZCwg
X19wYShNQVhfRE1BX0FERFJFU1MpKTsKPj4+ICsKPj4KPj4gbWVtYmxvY2tfYWxsb2NfdHJ5X25p
ZF9yYXcoKSBkb2VzIG5vdCBwYW5pYyAoaGVscCBleHBsaWNpdGx5IHNheXM6IERvZXMgbm90Cj4+
IHplcm8gYWxsb2NhdGVkIG1lbW9yeSwgZG9lcyBub3QgcGFuaWMgaWYgcmVxdWVzdCBjYW5ub3Qg
YmUgc2F0aXNmaWVkLikuCj4gCj4gIkRvZXMgbm90IHBhbmljIiBkb2VzIG5vdCBtZWFuIGl0IGFs
d2F5cyBzdWNjZWVkcy4KCkkgYWdyZWUsIGJ1dCBhdCBsZWFzdCBoZXJlIHlvdSBhcmUgY2hhbmdp
bmcgdGhlIGJlaGF2aW91ciBieSBtYWtpbmcgaXQgCnBhbmljIGV4cGxpY2l0bHkuIEFyZSB3ZSBz
dXJlIHRoZXJlIGFyZSBub3QgY2FzZXMgd2hlcmUgdGhlIHN5c3RlbSBjb3VsZCAKanVzdCBjb250
aW51ZSBmdW5jdGlvbm5pbmcgPyBNYXliZSBhIFdBUk5fT04oKSB3b3VsZCBiZSBlbm91Z2ggdGhl
cmUgPwoKQ2hyaXN0b3BoZQoKPiAgIAo+PiBTdGVwaGVuIFJvdGh3ZWxsIHJlcG9ydHMgYSBib290
IGZhaWx1cmUgZHVlIHRvIHRoaXMgY2hhbmdlLgo+IAo+IFBsZWFzZSBzZWUgbXkgcmVwbHkgb24g
dGhhdCB0aHJlYWQuCj4gCj4+IENocmlzdG9waGUKPj4KPj4+ICAgCXNwYXJzZW1hcF9idWZfZW5k
ID0gc3BhcnNlbWFwX2J1ZiArIHNpemU7Cj4+PiAgIH0KPj4+Cj4+Cj4gCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxp
bmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
