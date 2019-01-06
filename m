Return-Path: <SRS0=ikCU=PO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95E9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 17:30:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A5CE2070D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 17:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="j/Y/WFjN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A5CE2070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=soulik.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:Date:
	In-Reply-To:From:Subject:Mime-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yrRk0CIUU6kTkgqVGwLsIjJmLRRnRntF534w+9rqUaA=; b=j/Y/WFjNPKEXqs
	e5MevvaDmUlomWcbVtIxjW3mrVhtwG7ittCBdSix8tpVxpFqt5HpTRG+9j0oVcjrnk3SgllOs/onR
	L+uN0djynIOWyG+VSxB/fsPXWZWWiRTY1AXujFRhi+DrrM9ettNwOj6jgbX8Me0x81p82wdaIFJe1
	GFSossQq+BkDjTOxsRk8uox9i41PbnbGN2GgjLYOOQDiOoxitEmZCVkOV7P71jFVmqXIgBXD6Q89L
	NLpaGC/bC7psJHWZjRzV+hupbTVhJn8bPp/juBhYrarzIJZtZa2RyWdWGvjOC+HOekLp1CZSZDZUr
	ljctPkA51Ze7AcY3OCSA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggCFY-0006a4-9W; Sun, 06 Jan 2019 17:30:12 +0000
Received: from kozue.soulik.info ([108.61.200.231])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggCFU-0006BH-U8; Sun, 06 Jan 2019 17:30:10 +0000
Received: from [192.168.0.49] (unknown [192.168.0.49])
 by kozue.soulik.info (Postfix) with ESMTPSA id A637B100F5C;
 Mon,  7 Jan 2019 02:30:42 +0900 (JST)
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 4/4] arm64: dts: rockchip: add video codec for rk3399
From: Ayaka <ayaka@soulik.info>
X-Mailer: iPad Mail (16A404)
In-Reply-To: <CAAEAJfCLxvJWrC1CNiSyLV9y=pOjzUBik5SUD0ZVUcnA-+HobQ@mail.gmail.com>
Date: Mon, 7 Jan 2019 01:29:54 +0800
Message-Id: <85C6CA4D-CC54-422B-BC2B-25EA10701696@soulik.info>
References: <20190105183150.20266-1-ayaka@soulik.info>
 <20190105183150.20266-5-ayaka@soulik.info>
 <50db3bc3faea97182b7fe18b4d9677f7e1563eaa.camel@collabora.com>
 <CAC7DE03-A74C-4154-9443-BC91E6CED02E@soulik.info>
 <f3dcd25bb1c3f0544cb7eedd0b27633d923c0d27.camel@collabora.com>
 <C53B5CFA-2F9C-41E1-BBA8-D63819D0AC3D@soulik.info>
 <CAAEAJfCLxvJWrC1CNiSyLV9y=pOjzUBik5SUD0ZVUcnA-+HobQ@mail.gmail.com>
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190106_093009_195369_F5235A16 
X-CRM114-Status: GOOD (  18.84  )
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
Cc: Hans Verkuil <hverkuil@xs4all.nl>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Tomasz Figa <tfiga@chromium.org>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 myy@miouyouyou.fr, Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 Ezequiel Garcia <ezequiel@collabora.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGVsbG8gRXplcXVpZWwKClNlbnQgZnJvbSBteSBpUGFkCgo+IE9uIEphbiA3LCAyMDE5LCBhdCAx
OjIxIEFNLCBFemVxdWllbCBHYXJjaWEgPGV6ZXF1aWVsQHZhbmd1YXJkaWFzdXIuY29tLmFyPiB3
cm90ZToKPiAKPj4gT24gU3VuLCA2IEphbiAyMDE5IGF0IDEzOjE2LCBBeWFrYSA8YXlha2FAc291
bGlrLmluZm8+IHdyb3RlOgo+PiAKPj4gCj4+IAo+PiBTZW50IGZyb20gbXkgaVBhZAo+PiAKPj4+
IE9uIEphbiA3LCAyMDE5LCBhdCAxMjowNCBBTSwgRXplcXVpZWwgR2FyY2lhIDxlemVxdWllbEBj
b2xsYWJvcmEuY29tPiB3cm90ZToKPj4+IAo+Pj4gT24gU3VuLCAyMDE5LTAxLTA2IGF0IDIzOjA1
ICswODAwLCBBeWFrYSB3cm90ZToKPj4+Pj4gT24gSmFuIDYsIDIwMTksIGF0IDEwOjIyIFBNLCBF
emVxdWllbCBHYXJjaWEgPGV6ZXF1aWVsQGNvbGxhYm9yYS5jb20+IHdyb3RlOgo+Pj4+PiAKPj4+
Pj4gSGkgUmFuZHksCj4+Pj4+IAo+Pj4+PiBUaGFua3MgYSBsb3QgZm9yIHRoaXMgcGF0Y2hlcy4g
VGhleSBhcmUgcmVhbGx5IHVzZWZ1bAo+Pj4+PiB0byBwcm92aWRlIG1vcmUgaW5zaWdodCBpbnRv
IHRoZSBWUFUgaGFyZHdhcmUuCj4+Pj4+IAo+Pj4+PiBUaGlzIGNoYW5nZSB3aWxsIG1ha2UgdGhl
IHZwdSBlbmNvZGVyIGFuZCB2cHUgZGVjb2Rlcgo+Pj4+PiBjb21wbGV0ZWx5IGluZGVwZW5kZW50
LCBjYW4gdGhleSByZWFsbHkgd29yayBpbiBwYXJhbGxlbD8KPj4+PiBBcyBJIHNhaWQgaXQgZGVw
ZW5kcyBvbiB0aGUgcGxhdGZvcm0sIGJ1dCB3aXRoIHRoaXMgcGF0Y2gsIHRoZSB1c2VyIHNwYWNl
IHdvdWxkIHRoaW5rIHRoZXkgY2FuIHdvcmsgYXQgdGhlIHNhbWUgdGltZS4KPj4+IAo+Pj4gCj4+
PiBJIHRoaW5rIHRoZXJlIGlzIHNvbWUgY29uZnVzaW9uLgo+Pj4gCj4+PiBUaGUgZGV2aWNldHJl
ZSBpcyBvbmUgdGhpbmc6IGl0IGlzIGEgaGFyZHdhcmUgcmVwcmVzZW50YXRpb24sCj4+PiBhIHdh
eSB0byBkZXNjcmliZSB0aGUgaGFyZHdhcmUsIGZvciB0aGUga2VybmVsL2Jvb3Rsb2FkZXIgdG8K
Pj4+IHBhcnNlLgo+Pj4gCj4+PiBUaGUgdXNlcnNwYWNlIHZpZXcgd2lsbCBkZXBlbmQgb24gdGhl
IGRyaXZlciBpbXBsZW1lbnRhdGlvbi4KPj4+IAo+Pj4gVGhlIGN1cnJlbnQgZGV2aWNldHJlZSBh
bmQgZHJpdmVyICh3aXRob3V0IHlvdXIgcGF0Y2hlcyksCj4+PiBtb2RlbCB0aGUgVlBVIGFzIGEg
c2luZ2xlIHBpZWNlIG9mIGhhcmR3YXJlLCBleHBvc2luZyBhIGRlY29kZXIKPj4+IGFuZCBhbiBl
bmNvZGVyLgo+Pj4gCj4+PiBUaGUgVjRMIGRyaXZlciB3aWxsIHRoZW4gY3JlYXRlIHR3byB2aWRl
byBkZXZpY2VzLCBpLmUuIC9kZXYvdmlkZW9YCj4+PiBhbmQgL2Rldi92aWRlb1kuIFNvIHVzZXJz
cGFjZSBzZWVzIGFuIGluZGVwZW5kZW50IHZpZXcgb2YgdGhlCj4+PiBkZXZpY2VzLgo+Pj4gCj4+
IEkga25ldyB0aGF0LCB0aGUgcHJvYmxlbSBpcyB0aGF0IHRoZSBkcml2ZXIgc2hvdWxkIG5vdCBh
bHdheXMgY3JlYXRlIGEgZGVjb2RlciBhbmQgZW5jb2RlciBwYWlyLCB0aGV5IG1heSBub3QgZXhp
c3QgYXQgc29tZSBwbGF0Zm9ybXMsIGV2ZW4gc29tZSBwbGF0Zm9ybXMgZG9lc27igJl0IGhhdmUg
YSBlbmNvZGVyLiBZb3UgbWF5IGhhdmUgYSBsb29rIG9uIHRoZSByazMzMjggSSBwb3N0IG9uIHRo
ZSBmaXJzdCBlbWFpbCBhcyBleGFtcGxlLgo+IAo+IFRoYXQgaXMgY29ycmVjdC4gQnV0IHRoYXQg
c3RpbGwgZG9lc24ndCB0YWNrbGUgbXkgcXVlc3Rpb246IGlzIHRoZQo+IGhhcmR3YXJlIGFibGUg
dG8gcnVuIGEgZGVjb2RpbmcgYW5kIGFuIGVuY29kaW5nIGpvYiBpbiBwYXJhbGxlbD8KPiAKRm9y
IHJrMzMyOCwgeWVzLCB5b3Ugc2VlIEkgZGlkbuKAmXQgZHJhdyB0aGVtIGluIHRoZSBzYW1lIGJv
eC4KPiBJZiBub3QsIHRoZW4gaXQncyB3cm9uZyB0byBkZXNjcmliZSB0aGVtIGFzIGluZGVwZW5k
ZW50IGVudGl0aWVzLgo+IAo+Pj4gSG93ZXZlciwgdGhleSBhcmUgaW50ZXJuYWxseSBjb25uZWN0
ZWQsIGFuZCB0aHVzIHdlIGNhbgo+Pj4gZWFzaWx5IGF2b2lkIHR3byBqb2JzIHJ1bm5pbmcgaW4g
cGFyYWxsZWwuCj4+PiAKPj4gVGhhdCBpcyB3aGF0IHRoZSBtcHAgc2VydmljZSBkaWQgaW4gbXkg
cGF0Y2hlcywgaGFuZGluZyB0aGUgcmVsYXRpb25zaGlwIGJldHdlZW4gZWFjaCBkZXZpY2VzLiBB
bmQgaXQgaXMgbm90IGEgZWFzeSB3b3JrLCBtYXliZSBhIDRrIGRlY29kZXIgd291bGQgYmUgYmxv
Y2tlZCBieSBhbm90aGVyIGhpZ2ggZnJhbWUgcmF0ZSBlbmNvZGluZyB3b3JrIG9yIGFub3RoZXIg
ZGVjb2RlciBzZXNzaW9uLiBUaGUgdmVuZG9yIGtlcm5lbCBoYXZlIG1vcmUgd29ycnkgYWJvdXQg
dGhpcywgIGJ1dCBub3QgaW4gdGhpcyB2ZXJzaW9uLgo+IAo+IFJpZ2h0LiBUaGF0IGlzIG9uZSB3
YXkgdG8gZGVzaWduIGl0LiBBbm90aGVyIHdheSBpcyBoYXZpbmcgYSBzaW5nbGUKPiBkZXZpY2V0
cmVlIG5vZGUgZm9yIHRoZSBWUFUgZW5jb2Rlci9kZWNvZGVyICJjb21wbGV4Ii4KTm8sIHlvdSBj
YW7igJl0IGFzc3VtZSB3aGljaCBvbmUgaXMgaW4gdGhlIGNvbWJvIGdyb3VwLCBpdCBjYW4gYmUg
dmFyaW91cy4geW91IHNlZSwgaW4gdGhlIHJrMzMyOCwgdGhlIHZkcHUgaXMgcGFpcmVkIHdpdGgg
YW4gYXZzKyBkZWNvZGVyLiBUaGF0IGlzIHdoeSBJIHVzZSBhIHZpcnR1YWwgZGV2aWNlIHN0YW5k
aW5nIGZvciBzY2hlZHVsZXIuCj4gCj4gVGhhbmtzIGZvciB0aGUgaW5wdXQhCj4gLS0gCj4gRXpl
cXVpZWwgR2FyY8OtYSwgVmFuZ3VhcmRpYVN1cgo+IHd3dy52YW5ndWFyZGlhc3VyLmNvbS5hcgoK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFy
bS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1r
ZXJuZWwK
