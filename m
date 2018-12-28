Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D681C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 04:58:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37B3A20879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 04:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mE+O9JGc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37B3A20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZFUIoW01t5rm7qtme2foel0PCRTUecJ37LFb8oWMlpQ=; b=mE+O9JGcAHJwe7
	c3LNDVrgI88XMTBShIn9+m5b16iZWMzi0piR7aQ2awr2nBeJMUTqNkOvBgk7IC7uRSua4wYY3yvwm
	ceT395r7z4rwNu9QXnqryyffdHp7dmvd72hsJ64JVg4s1UzDMRPP2NGb4PTakeacKs4A6DSFSqSbq
	BGrGBWLHAZfYP6oFG0oTuvO6Za/knR6OU/KL70qDHW/y1VARPnlH1i1GN3QLXaNaTs/nWRx8BKAUs
	QFA0OkkCc9TFhN45R1rqrq2GIelECNTLkYOZQpOykxU2FYNs/wNnhmqnAGERPonXiQHwesL/DvE0p
	CtRpZ0nCUNm/glwQGW/w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gckDv-0005K9-H9; Fri, 28 Dec 2018 04:58:15 +0000
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gckDr-0005Gp-2a; Fri, 28 Dec 2018 04:58:13 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 65D6FAC9C;
 Fri, 28 Dec 2018 04:57:56 +0000 (UTC)
Subject: Re: [PATCH v5 6/6] net: lorawan: List LORAWAN in menuconfig
To: Alexander Aring <aring@mojatatu.com>, Xue Liu <liuxuenetmail@gmail.com>
References: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
 <20181216101858.9585-7-starnight@g.ncu.edu.tw>
 <CAJuUDwtS3c7NhcNqijyFNtZeupO2HLQ8ZuMA1a-azEQL5yHjng@mail.gmail.com>
 <8bfdccbf-fb47-daa5-fbd0-ed16a3d6d334@suse.de>
 <CAJuUDwsypFMEbTXZO+NwQ_FnD1wsO3ZRc3dthZphFGJ-u0n_=Q@mail.gmail.com>
 <20181224153205.ycr2zdrjbyklulfh@x220t>
From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=afaerber@suse.de; prefer-encrypt=mutual; keydata=
 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
Organization: SUSE Linux GmbH
Message-ID: <57bead63-bc4e-4dfe-57a9-9875600f5e37@suse.de>
Date: Fri, 28 Dec 2018 05:57:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181224153205.ycr2zdrjbyklulfh@x220t>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181227_205811_414043_678FA0DB 
X-CRM114-Status: GOOD (  18.79  )
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
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
 Dollar Chen <dollar.chen@wtmec.com>, linux-lpwan@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jian-Hong Pan <starnight@g.ncu.edu.tw>,
 Ken Yu <ken.yu@rakwireless.com>, linux-wpan - ML <linux-wpan@vger.kernel.org>,
 "David S . Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgQWxleGFuZGVyIGFuZCBYdWUgTGl1LAoKQW0gMjQuMTIuMTggdW0gMTY6MzIgc2NocmllYiBB
bGV4YW5kZXIgQXJpbmc6Cj4gT24gVHVlLCBEZWMgMTgsIDIwMTggYXQgMDI6NTA6NThQTSArMDEw
MCwgWHVlIExpdSB3cm90ZToKPj4gT24gTW9uLCAxNyBEZWMgMjAxOCBhdCAxNToxOSwgQW5kcmVh
cyBGw6RyYmVyIDxhZmFlcmJlckBzdXNlLmRlPiB3cm90ZToKPj4+IEFtIDE3LjEyLjE4IHVtIDA5
OjUwIHNjaHJpZWIgWHVlIExpdToKPj4+PiBJIGhhdmUgYSBxdWVzdGlvbiBhYm91dCB0aGUgYXJj
aGl0ZWN0dXJlIG9mIHlvdXIgbW9kdWxlLiBBRkFJSyBMb1JhV0FOCj4+Pj4gaXMgYWxyZWFkeSB0
aGUgTUFDIExheWVyIGFib3ZlIHRoZSBMb1JhIHRlY2hub2xvZ3kuIFdoeSBkbyB5b3Ugd2FudCB0
bwo+Pj4+IG1ha2UgYSBuZXcgbGF5ZXIgY2FsbGVkICJtYWNsb3Jhd2FuIiA/Cj4+Pgo+Pj4gSSBo
YWQgYXNrZWQgSmlhbi1Ib25nIHRvIHNlcGFyYXRlIGJldHdlZW4gaGlzIHNvZnQtTUFDIGltcGxl
bWVudGF0aW9uCj4+PiBhbmQgdGhlIGNvbW1vbiBiaXRzIG5lZWRlZCB0byBkcml2ZSBoYXJkLU1B
QyBpbXBsZW1lbnRhdGlvbnMgZm91bmQgb24KPj4+IHNldmVyYWwgb2YgdGhlIGhhcmR3YXJlIG1v
ZHVsZXMgbWFkZSBhdmFpbGFibGUgdG8gbWUuCj4+Pgo+PiBBcyBhIHJlZmVyZW5jZSBMaW51eCA4
MDIuMTEgdXNlcyBjZmc4MDIxMSB0byB0YWxrIHdpdGggaGFyZC1NQUMgZGV2aWNlcy4KPj4gV2Ug
bWF5IGFsc28gdXNlIHRoZSBuYW1lIOKAnGNmZ2xvcmHigJ0gZm9yIGhhcmQtTUFDIGltcGxlbWVu
dGF0aW9uLgo+IAo+IFRoZXJlIGV4aXN0cyBhbHNvIGEgY2ZnODAyMTU0LiA6LSkKPiAKPiBOb3Rl
IHRoYXQgY2ZnODAyMTEgaXMgYWxzbyBmb3IgcHJvdmlkaW5nIGEgYmFja3dhcmRzY29tcGF0aWJp
bGl0eSB0byB0aGUKPiB3aXJlbGVzcyBpb2N0bCgpIGludGVyZmFjZS4KPiAKPiBJbiB0aGVvcnkg
aXQncyBzaW1wbGU6Cj4gCj4gbmV0bGluayBBUEkgLT4gU29mdE1BQyAobWFjRk9PQkFSIGxheWVy
KSAtPiBjZmdGT09CQVIgaW1wbGVtZW50YXRpb24gLT4gZHJpdmVyIGxheWVyCj4gICAgICAgICAg
ICAgXC0+IEhhcmRNQUMgKGRyaXZlciBsYXllcikgLT4gY2ZnRk9PQkFSIGltcGxlbWVudGF0aW9u
CgpTbyBob3cgZG9lcyBjZmdGT09CQVIgcmVsYXRlIHRvIG5sRk9PQkFSIG5vdz8gR2l2ZW4gdGhh
dCB3ZSB3ZXJlIHRvbGQgdG8KdXNlIG5ldGxpbmsgYW5kIHBvaW50ZWQgdG8gc29tZSBubDgwMndo
YXRldmVyLCBJIGFtIGNvbmZ1c2VkIGFib3V0IHR3bwpwZW9wbGUgbm93IGNhbGxpbmcgZm9yIGNm
Zy4gV2UgaGF2ZSBhbiBubGxvcmEgc3R1YmJlZCBpbiBsaW51eC1sb3JhLmdpdCwKYW5kIEkgd2Fz
IGV4cGVjdGluZyB0byBzZWUgYW4gbmxsb3Jhd2FuwrkgZWl0aGVyIGluIHRoaXMgc2VyaWVzIG9y
IG9uCnRvcC4gSWYgeW91J3JlIHN1Z2dlc3RpbmcgdG8gcmVuYW1lIHRoZW0gdGVjaG5vbG9neS1u
ZXV0cmFsLCB0aGVuIHBsZWFzZQpzYXkgc28gY2xlYXJseSAtIG90aGVyd2lzZSBpdCBzb3VuZHMg
dG8gbWUgbGlrZSB5b3UgZGlkbid0IGFjdHVhbGx5IGxvb2sKYXQgdGhlIHN0YWdlZCBjb2RlIHll
dCBvciBkaWRuJ3QgcmVhZCBvdXIgcHJldmlvdXMgZGlzY3Vzc2lvbnMgYW5kIGxlYWQKb3VyIGNv
bnRyaWJ1dG9ycyB0byByZWludmVudCB0aGluZ3Mgd2UgYWxyZWFkeSBoYXZlLi4uCgpXZSByZWFs
bHkgbmVlZCB0byBjb21wbGV0ZSB0aGUgbGF5ZXJzIGZyb20gdGhlIGdyb3VuZCB1cCBiZWZvcmUg
d2UgZ2V0Cmxvc3QgaW4gbW9yZSBuaWNlLXRvLWhhdmUgdXBwZXIgbGF5ZXJzOiBGb3IgTG9SYVdB
TiB0aGF0IG1lYW5zIHdlIG5lZWQKdG8gaGF2ZSBUWCBhbmQgUlggd29ya2luZyBmb3IgTG9SYSBf
YW5kXyBGU0suIHN4MTI3NiBzdGlsbCBoYXMgbG90cyBvZgpoYXJkY29kZWQgc3R1ZmYgZnJvbSBt
eSBvd24gdGVzdGluZyB0aGF0IG5lZWRzIHRvIGhvb2sgaW50byBubGxvcmEsIGFuZApGU0sgZXhp
c3RzIG9ubHkgYXMgRVRIX1BfRlNLIGNvbnN0YW50IHNvIGZhciwgd2l0aCBubyBjb25jZXB0IGZv
cgpzd2l0Y2hpbmcgbW9kZXMgeWV0ICh3aGljaCBhcyBtZW50aW9uZWQgaW4gbXkgcHJlc2VudGF0
aW9uwrkgbmVlZHMgdG8gZ28KdmlhIHNsZWVwIG1vZGUsIGxvc2luZyBtb3N0IHJlZ2lzdGVyIHNl
dHRpbmdzKSBub3IgYW55IG5ldGxpbmsgc3VwcG9ydC4KTm90IGFsbCBkcml2ZXJzIG5lZWQgdG8g
YmUgYXQgdGhlIHNhbWUgaW1wbGVtZW50YXRpb24gbGV2ZWwsIG9mIGNvdXJzZSwKYnV0IHdlIG5l
ZWQgYXQgbGVhc3Qgb25lIHRoYXQncyBmYXIgZW5vdWdoIHRvIHZhbGlkYXRlIHN1Y2ggcGF0Y2hl
cy4KCkFuZCBzZWVpbmcgdGhhdCBJIGp1c3QgZm91bmQgYSBtYWpvciBidWcgaW4gc3gxMjc2IGRy
aXZlcidzIFRYIHBhdGgsCmFwcGFyZW50bHkgbm8gb25lIGFwYXJ0IGZyb20gbWUgaXMgdGVzdGlu
ZyB0aGF0IGRyaXZlciAtIHN4MTI4eCBhbmQKc3gxMzAxIHdlcmUgbm90IHlldCBjb21wbGV0ZSBl
bm91Z2ggdG8gdHJhbnNtaXQsIGFuZCBkdWUgdG8gdGhlIG9wZW4Kc29ja2V0IGFkZHJlc3MvcHJv
dG9jb2wgZGlzY3Vzc2lvbnMgbm9uZSBjYW4gcmVjZWl2ZSB5ZXQsIHNvIGFzIEppcmkKaGludGVk
LCB0aGlzIExvUmFXQU4gc29mdC1NQUMgcGF0Y2ggc2VyaWVzIGNhbid0IGhhdmUgYmVlbgpydW50
aW1lLXRlc3RlZCBhZ2FpbnN0IGFueSBzdGFnZWQgZHJpdmVyIGF0IGFsbCEgID0+IFtSRkMgbG9y
YS1uZXh0IHY1IDYvNl0KClRoZXJlZm9yZSBJIHRob3VnaHQgaW4gb3VyIGNhc2Ugc29tZSBoYXJk
LU1BQyBtYXkgYmUgZWFzaWVyIHRvIHZhbGlkYXRlCkxvUmFXQU4gc29ja2V0cyAocGF0Y2ggMS82
KSwgdG8gYXZvaWQgYSBkZXBlbmRlbmN5IG9uIGNvbXBsZXRpbmcgdGhlIE1BQwppbXBsZW1lbnRh
dGlvbiBmaXJzdC4gRm9yIGV4YW1wbGUsIGlNODgwLCBSRjEyNzZUUyBhbmQgMzIwMDEzNTMgYXJl
IHB1cmUKTG9SYVdBTiBtb2R1bGVzIHdpdGhvdXQgcmF3IExvUmEgc3VwcG9ydC4gKFdoZXJlYXMg
bWFueSBvdGhlcnMgc3VwcG9ydApib3RoIGFuZCBJJ20gc3RpbGwgbG9va2luZyBmb3IgaW5wdXQg
b24gaG93IHRvIGJlc3QgZGVhbCB3aXRoIHRoYXQgLQpjdXJyZW50bHkgZXhwb3NpbmcgdGhlbSBh
cyBMb1JhIGRldmljZXMgZm9yIG1heGltYWwgZmxleGliaWxpdHkuKQoKUmVnYXJkcywKQW5kcmVh
cwoKwrkKaHR0cHM6Ly9ldmVudHMubGludXhmb3VuZGF0aW9uLm9yZy93cC1jb250ZW50L3VwbG9h
ZHMvMjAxNy8xMi9FTENFMjAxOF9Mb1JhX2ZpbmFsX0FuZHJlYXMtRmFyYmVyLnBkZgpodHRwczov
L3d3dy55b3V0dWJlLmNvbS93YXRjaD92PUpqZWw2NXNaTzlNCgotLSAKU1VTRSBMaW51eCBHbWJI
LCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcsIEdlcm1hbnkKR0Y6IEZlbGl4IEltZW5k
w7ZyZmZlciwgSmFuZSBTbWl0aGFyZCwgR3JhaGFtIE5vcnRvbgpIUkIgMjEyODQgKEFHIE7DvHJu
YmVyZykKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxp
bnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LWFybS1rZXJuZWwK
