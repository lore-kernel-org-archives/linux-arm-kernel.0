Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8576AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 07:06:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EE3120578
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 07:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pGA4WIf+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EE3120578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hilscher.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=l9Z7PDVoop7FhYXh2AkXZ+Pn2Ruqwwztgo4Tyd5C8M0=; b=pGA4WIf+QdaTM4vFrr5O26yZo
	j+EuGaF+KKfuIjF3Wd5hk+G234BU36VkPb1oYyIgvLFsmH984XNYKK2SITvRgi5Xsa667HgiiUNNv
	G9iewZ0Pvf1NIC6ykgt/FmyrHoF+IdgZXC/1N/CSFMWvU4qmgNvV7bh3R7JobA0JGOaTcdtHILaqJ
	gZu+EKXrg8hOg0uVlVlqsqWDndDgSza3NGvu1uMZJ4h5lkytNLaDZ5zcvOaV35i4CYR0VS5Ax5EUl
	bCJslVYAv5wDYRyq+ltBzx9gkj23eWt8pBCCitNfURsJ8Fl8mgau3bivfouNLV1NK7tcgYqEfnuUO
	Xpvc/H9sw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjInQ-0005fB-K7; Tue, 15 Jan 2019 07:06:00 +0000
Received: from mx01.hilscher.com ([46.189.19.166])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjInM-0005ej-Os
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 07:05:58 +0000
Received: from [10.13.5.83] (10.13.5.83) by maiser03.hilscher.local
 (192.168.100.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 15
 Jan 2019 08:05:47 +0100
Subject: Re: Hilscher NetX mach-netx refactorings
To: Linus Walleij <linus.walleij@linaro.org>
References: <CACRpkdb-zphMyZbGh5XYy2A6B1224BGFmTwr0Bm98G3oM0MeoQ@mail.gmail.com>
 <CAK8P3a08TV+sQhsCPjkXh6wOKEpLfGLqVo9+FHoXzDVXs_bY7A@mail.gmail.com>
 <CACRpkdZ7KSmgTYP8a_RUJAWKzuc652OZ420Lq4ZnzkCuESLZ2Q@mail.gmail.com>
 <b5e70ac4-4cf8-9abe-ec30-7d225089caf0@hilscher.com>
 <CACRpkdYnbCmfTVB_aFX-vhkbWma=60U0D6pKZ8bcKdxCdSXdyA@mail.gmail.com>
From: Michael Trensch <MTrensch@hilscher.com>
Message-ID: <39b5ad22-7e78-20f5-164b-30df943ce79f@hilscher.com>
Date: Tue, 15 Jan 2019 08:05:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdYnbCmfTVB_aFX-vhkbWma=60U0D6pKZ8bcKdxCdSXdyA@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [10.13.5.83]
X-ClientProxiedBy: maiser03.hilscher.local (192.168.100.44) To
 maiser03.hilscher.local (192.168.100.44)
X-GFI-SMTP-Submission: 1
X-GFI-SMTP-HelloDomain: [10.13.5.83]
X-GFI-SMTP-RemoteIP: 10.13.5.83
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_230556_864246_960A6052 
X-CRM114-Status: GOOD (  16.73  )
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
Cc: Ladislav Michl <ladis@linux-mips.org>, Arnd Bergmann <arnd@arndb.de>,
 Robert Schwebel <r.schwebel@pengutronix.de>, nagasureshkumarrelli@gmail.com,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Olof Johansson <olof@lixom.net>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgTGludXMsCgpPbiAxNC4wMS4yMDE5IDE1OjIyLCBMaW51cyBXYWxsZWlqIHdyb3RlOgo+IFNv
IGEgcHJlc3NpbmcgcXVlc3Rpb24gaXMgd2hldGhlciBpdCBpcyBPSyB3aXRoIEhpbHNjaGVyIHRo
YXQgd2UKPiBkZWNvbWlzc2lvbi9kZWxldGUgdGhlIGN1cnJlbnQgc3VwcG9ydCBjb2RlIGZvciBO
ZXRYCj4gbnhka24sIG54ZGI1MDAgYW5kIG54ZWI1MDBobWk/IE9yIGFyZSB0aGVzZSBwcm9kdWN0
cyB0aGF0Cj4gc3RpbGwgc2VlIGFjdGl2ZSBkZXBsb3ltZW50IChuZXcgZGVzaWducykgYW5kIG1h
aW50ZW5hbmNlCj4gaW4gdGhlIGxvbmcgdGVybSAoNS0xMCB5ZWFycyBmcm9tIG5vdyk/Cj4KSXQn
cyBvayBmcm9tIEhpbHNjaGVyIHNpZGUuIEkndmUgdGFsa2VkIHRvIG91ciBDRU8gYW5kIGhlIGlz
IGZpbmUgd2l0aApkcm9wcGluZyBpdC4gVGhvc2UgYm9hcmRzIGFyZSBub3QgcHJvZHVjZWQgYW55
bW9yZSBhbmQgb3VyIG5ldyBBc2ljcwooZS5nLiBuZXRYNDAwMCBhbmQgdXBjb21pbmcpIHdpbGwg
cmVwbGFjZSBuZXRYMTAwLzUwMCBpbiB0aGUgbG9uZyB0ZXJtLgpPdXIgQXNpY3MgdXN1YWxseSBo
YXZlIGEgZ3VhcmFudGVlZCBsaWZlY3ljbGUgb2YgMTAgeWVhcnMgYW5kIG5ldFgxMDAKaGFzIGJl
ZW4gYXJvdW5kIHNpbmNlIDIwMDYsIGlmIEkgcmVtZW1iZXIgY29ycmVjdGx5LCBzbyB3ZSBkb24n
dCBleHBlY3QKbWFueSBuZXcgbGludXggcHJvamVjdHMgYXJpc2luZywgd2l0aCB0aGUgbmVlZCBm
b3IgdGhlIG5ld2VzdCBrZXJuZWwuCk9sZCBrZXJuZWwgdmVyc2lvbiB3aWxsIHN0aWxsIGJlIHdv
cmtpbmcgdGhvdWdoLgoKPiBPSyEgQnV0IHdoZW4geW91IGhhdmUgdGltZSBhbmQgcmVzb3VyY2Vz
LCBwbGVhc2UgY29uc2lkZXIgdG8KPiB3b3JrIHdpdGggdGhlIGtlcm5lbCBjb21tdW5pdHkgdG8g
Z2V0IHRoZSBib2FyZCBzdXBwb3J0IHVwc3RyZWFtLgo+CldlIHdhbnQgdG8gd29yayB3aXRoIHRo
ZSBjb21tdW5pdHkgbm93IGFuZCBpbiB0aGUgZnV0dXJlLCBidXQgZm9yCm5ldFg0MDAwIHdlIGZp
cnN0IG5lZWRlZCB0byBnZXQgdGhpcyBTb0Mgd29ya2luZy4gSXQgdG9vayBtYW55CmRldmVsb3Bt
ZW50IGN5Y2xlcyB0byBnZXQgYWxsIGltcGxlbWVudGF0aW9uIHdvcmtpbmcgYW5kIG5vdyBpdCBz
ZWVtcyB0bwpoYXZlIHNldHRsZWQgc28gd2UgY2FuIHRoaW5rIGFib3V0IHN0ZXAgdHdvLiBuZXRY
NDAwMCBGaW5hbCAod2l0aCBhbGwKcmVxdWlyZWQgY2hhbmdlcykgd2FzIHJlbGVhc2VkIGVuZCBv
ZiBsYXN0IHllYXIuCgpNYWluIHByb2JsZW0gd291bGQgaGF2ZSBiZWVuIHRoZSBjb250aW51b3Vz
IGNoYW5nZSBvZiB0aGUgQXNpYyBkdXJpbmcKZGV2ZWxvcG1lbnQgYW5kIG1vcmUgb3IgbGVzcyBj
b25zdGFudCBjaGFuZ2VzIHRvIGtlcm5lbCBzb3VyY2VzLiBJIHRoaW5rCnRoaXMgd291bGQgaGF2
ZSBjYXVzZWQgc29tZSBsYXVnaGluZyBvbiB0aGUgbWFpbGluZyBsaXN0IGlmIHdlIHN1Ym1pdCBh
CnBhdGNoIG9uZSBkYXkgYW5kIGRvIGl0IHRoZSBjb21wbGV0ZSBvdGhlciB3YXkgcm91bmQgd2l0
aCB0aGUgbmV4dAoocG9zc2libHkgbm9uLXB1YmxpYykgc3RlcHBpbmcgb2YgdGhlIEFzaWMuIEJ1
dCBwcm9iYWJseSB0aGF0J3MganVzdCBteQpwZXJzb25hbCBmZWVsaW5nLgoKVGhhbmtzIGZvciBh
bGwgeW91ciB2YWx1YWJsZSBpbnB1dC4gSSB3aWxsIHRha2UgYSBsb29rIGFuIHNlZSB3aGF0IEkg
Y2FuCmRvIGFib3V0IGl0LgoKCk1pdCBmcmV1bmRsaWNoZW4gR3LDvMOfZW4gLyBCZXN0IHJlZ2Fy
ZHMKCk1pY2hhZWwgVHJlbnNjaAotLQpNaWNoYWVsIFRyZW5zY2ggfCBuZXRYIFN5c3RlbQpQaG9u
ZTogKzQ5ICgwKSA2MTkwIDk5MDctMCB8IEZheDogKzQ5ICgwKSA2MTkwIDk5MDctNTAKCkhpbHNj
aGVyIEdlc2VsbHNjaGFmdCBmw7xyIFN5c3RlbWF1dG9tYXRpb24gbWJIICAgfCAgUmhlaW5zdHJh
c3NlIDE1ICB8ICA2NTc5NSBIYXR0ZXJzaGVpbSAgfCAgR2VybWFueSAgfCAgd3d3LmhpbHNjaGVy
LmNvbTxodHRwOi8vd3d3LmhpbHNjaGVyLmNvbT4KU2l0eiBkZXIgR2VzZWxsc2NoYWZ0IC8gcGxh
Y2Ugb2YgYnVzaW5lc3M6IEhhdHRlcnNoZWltICB8ICBHZXNjaMOkZnRzZsO8aHJlciAvIG1hbmFn
aW5nIGRpcmVjdG9yOiBEaXBsLi1JbmcuIEhhbnMtSsO8cmdlbiBIaWxzY2hlcgpIYW5kZWxzcmVn
aXN0ZXIgLyBjb21tZXJjaWFsIHJlZ2lzdGVyOiBGcmFua2Z1cnQgQiAyNjg3MyAgfCAgVXN0LiBJ
ZG5yLiAvIFZBVCBOby46IERFMTEzODUyNzE1ClJlZ2lzdGVyZ2VyaWNodCAvIHJlZ2lzdGVyIGNv
dXJ0OiBBbXRzZ2VyaWNodCBGcmFua2Z1cnQvTWFpbgoKSW1wb3J0YW50IEluZm9ybWF0aW9uOgpU
aGlzIGUtbWFpbCBtZXNzYWdlIGluY2x1ZGluZyBpdHMgYXR0YWNobWVudHMgY29udGFpbnMgY29u
ZmlkZW50aWFsIGFuZCBsZWdhbGx5IHByb3RlY3RlZCBpbmZvcm1hdGlvbiBzb2xlbHkgaW50ZW5k
ZWQgZm9yIHRoZSBhZGRyZXNzZWUuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCBhZGRyZXNz
ZWUgb2YgdGhpcyBtZXNzYWdlLCBwbGVhc2UgY29udGFjdCB0aGUgYWRkcmVzc2VyIGltbWVkaWF0
ZWx5IGFuZCBkZWxldGUgdGhpcyBtZXNzYWdlIGluY2x1ZGluZyBpdHMgYXR0YWNobWVudHMuIFRo
ZSB1bmF1dGhvcml6ZWQgZGlzc2VtaW5hdGlvbiwgY29weWluZyBhbmQgY2hhbmdlIG9mIHRoaXMg
ZS1tYWlsIGFyZSBzdHJpY3RseSBmb3JiaWRkZW4uIFRoZSBhZGRyZXNzZXIgc2hhbGwgbm90IGJl
IGxpYWJsZSBmb3IgdGhlIGNvbnRlbnQgb2Ygc3VjaCBjaGFuZ2VkIGUtbWFpbHMuCgpXaWNodGln
ZXIgSGlud2VpczoKRGllc2UgRS1NYWlsIGVpbnNjaGxpZcOfbGljaCBpaHJlciBBbmjDpG5nZSBl
bnRow6RsdCB2ZXJ0cmF1bGljaGUgdW5kIHJlY2h0bGljaCBnZXNjaMO8dHp0ZSBJbmZvcm1hdGlv
bmVuLCBkaWUgbnVyIGbDvHIgZGVuIEFkcmVzc2F0ZW4gYmVzdGltbXQgc2luZC4gU29sbHRlbiBT
aWUgbmljaHQgZGVyIGJlemVpY2huZXRlIEFkcmVzc2F0IHNlaW4sIHNvIHRlaWxlbiBTaWUgZGll
cyBiaXR0ZSBkZW0gQWJzZW5kZXIgdW1nZWhlbmQgbWl0IHVuZCBsw7ZzY2hlbiBTaWUgZGllc2Ug
TmFjaHJpY2h0IHVuZCBpaHJlIEFuaMOkbmdlLiBEaWUgdW5iZWZ1Z3RlIFdlaXRlcmdhYmUsIGRh
cyBBbmZlcnRpZ2VuIHZvbiBLb3BpZW4gdW5kIGplZGUgVmVyw6RuZGVydW5nIGRlciBFLU1haWwg
aXN0IHVudGVyc2FndC4gRGVyIEFic2VuZGVyIGhhZnRldCBuaWNodCBmw7xyIEluaGFsdGUgdm9u
IHZlcsOkbmRlcnRlbiBFLU1haWxzLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
