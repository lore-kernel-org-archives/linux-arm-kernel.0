Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C215C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 07:40:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4648D21855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 07:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G69B6xRb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4648D21855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=soulik.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:Date:
	In-Reply-To:From:Subject:Mime-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Rxv4cZIWy85EKet66jJVAKeB2wdtWeg8URMhOzTQKAE=; b=G69B6xRbhzp0zQ
	NWfXVVlGA1OpYxc5S/TusT7EI1evuRm/QPvRCUcurHjvRMmQ6O/gCz3Y77PV4bQl2xKlxcuq1Ur+K
	Ks5nVxEz0j1ssSnJmXxxF3HfyH8i0KeGyznf+NPj1EEHu8sWKk7W+7suGuJ5oGCI9hZxtkmjIyEN7
	uWYjot2MMirsXHw+GR0vE9lx9pN713EB5HCmVcd7Y1r8dhY0S8Hwth9TPAc3rgwtDVcaL7iIHCGPK
	xIwzt6H7vRoAn1IURb/xPfx5pt5axOjjE8BDqT1sb5AIdILUz3FAWUglM5M55kiXQy4TjqjrE8LVh
	LSPJasYJYxo+1/XCxhgg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gglzq-00043x-Ga; Tue, 08 Jan 2019 07:40:22 +0000
Received: from kozue.soulik.info ([2001:19f0:7000:8404:5054:ff:fe75:428f])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gglzm-000430-Ns; Tue, 08 Jan 2019 07:40:20 +0000
Received: from [192.168.10.231] (unknown [103.29.142.67])
 by kozue.soulik.info (Postfix) with ESMTPSA id C55A5100F34;
 Tue,  8 Jan 2019 16:40:53 +0900 (JST)
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 4/4] arm64: dts: rockchip: add video codec for rk3399
From: Ayaka <ayaka@soulik.info>
X-Mailer: iPad Mail (16A404)
In-Reply-To: <CAAFQd5AaVonqn92F=Oa_s_5fkn566+xubO5ijqHmnjg7d4j-8A@mail.gmail.com>
Date: Tue, 8 Jan 2019 15:40:08 +0800
Message-Id: <F8ED7EBD-FC71-4E40-98A0-DD239EF9371D@soulik.info>
References: <20190105183150.20266-1-ayaka@soulik.info>
 <20190105183150.20266-5-ayaka@soulik.info>
 <50db3bc3faea97182b7fe18b4d9677f7e1563eaa.camel@collabora.com>
 <CAC7DE03-A74C-4154-9443-BC91E6CED02E@soulik.info>
 <f3dcd25bb1c3f0544cb7eedd0b27633d923c0d27.camel@collabora.com>
 <C53B5CFA-2F9C-41E1-BBA8-D63819D0AC3D@soulik.info>
 <CAAEAJfCLxvJWrC1CNiSyLV9y=pOjzUBik5SUD0ZVUcnA-+HobQ@mail.gmail.com>
 <85C6CA4D-CC54-422B-BC2B-25EA10701696@soulik.info>
 <CAAFQd5AaVonqn92F=Oa_s_5fkn566+xubO5ijqHmnjg7d4j-8A@mail.gmail.com>
To: Tomasz Figa <tfiga@chromium.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_234018_986842_6D4CA819 
X-CRM114-Status: GOOD (  23.27  )
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
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 myy@miouyouyou.fr, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 Ezequiel Garcia <ezequiel@collabora.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

CgpTZW50IGZyb20gbXkgaVBhZAoKPiBPbiBKYW4gOCwgMjAxOSwgYXQgMjozMyBQTSwgVG9tYXN6
IEZpZ2EgPHRmaWdhQGNocm9taXVtLm9yZz4gd3JvdGU6Cj4gCj4+IE9uIE1vbiwgSmFuIDcsIDIw
MTkgYXQgMjozMCBBTSBBeWFrYSA8YXlha2FAc291bGlrLmluZm8+IHdyb3RlOgo+PiAKPj4gSGVs
bG8gRXplcXVpZWwKPj4gCj4+IFNlbnQgZnJvbSBteSBpUGFkCj4+IAo+Pj4+IE9uIEphbiA3LCAy
MDE5LCBhdCAxOjIxIEFNLCBFemVxdWllbCBHYXJjaWEgPGV6ZXF1aWVsQHZhbmd1YXJkaWFzdXIu
Y29tLmFyPiB3cm90ZToKPj4+PiAKPj4+PiBPbiBTdW4sIDYgSmFuIDIwMTkgYXQgMTM6MTYsIEF5
YWthIDxheWFrYUBzb3VsaWsuaW5mbz4gd3JvdGU6Cj4+Pj4gCj4+Pj4gCj4+Pj4gCj4+Pj4gU2Vu
dCBmcm9tIG15IGlQYWQKPj4+PiAKPj4+Pj4gT24gSmFuIDcsIDIwMTksIGF0IDEyOjA0IEFNLCBF
emVxdWllbCBHYXJjaWEgPGV6ZXF1aWVsQGNvbGxhYm9yYS5jb20+IHdyb3RlOgo+Pj4+PiAKPj4+
Pj4gT24gU3VuLCAyMDE5LTAxLTA2IGF0IDIzOjA1ICswODAwLCBBeWFrYSB3cm90ZToKPj4+Pj4+
PiBPbiBKYW4gNiwgMjAxOSwgYXQgMTA6MjIgUE0sIEV6ZXF1aWVsIEdhcmNpYSA8ZXplcXVpZWxA
Y29sbGFib3JhLmNvbT4gd3JvdGU6Cj4+Pj4+Pj4gCj4+Pj4+Pj4gSGkgUmFuZHksCj4+Pj4+Pj4g
Cj4+Pj4+Pj4gVGhhbmtzIGEgbG90IGZvciB0aGlzIHBhdGNoZXMuIFRoZXkgYXJlIHJlYWxseSB1
c2VmdWwKPj4+Pj4+PiB0byBwcm92aWRlIG1vcmUgaW5zaWdodCBpbnRvIHRoZSBWUFUgaGFyZHdh
cmUuCj4+Pj4+Pj4gCj4+Pj4+Pj4gVGhpcyBjaGFuZ2Ugd2lsbCBtYWtlIHRoZSB2cHUgZW5jb2Rl
ciBhbmQgdnB1IGRlY29kZXIKPj4+Pj4+PiBjb21wbGV0ZWx5IGluZGVwZW5kZW50LCBjYW4gdGhl
eSByZWFsbHkgd29yayBpbiBwYXJhbGxlbD8KPj4+Pj4+IEFzIEkgc2FpZCBpdCBkZXBlbmRzIG9u
IHRoZSBwbGF0Zm9ybSwgYnV0IHdpdGggdGhpcyBwYXRjaCwgdGhlIHVzZXIgc3BhY2Ugd291bGQg
dGhpbmsgdGhleSBjYW4gd29yayBhdCB0aGUgc2FtZSB0aW1lLgo+Pj4+PiAKPj4+Pj4gCj4+Pj4+
IEkgdGhpbmsgdGhlcmUgaXMgc29tZSBjb25mdXNpb24uCj4+Pj4+IAo+Pj4+PiBUaGUgZGV2aWNl
dHJlZSBpcyBvbmUgdGhpbmc6IGl0IGlzIGEgaGFyZHdhcmUgcmVwcmVzZW50YXRpb24sCj4+Pj4+
IGEgd2F5IHRvIGRlc2NyaWJlIHRoZSBoYXJkd2FyZSwgZm9yIHRoZSBrZXJuZWwvYm9vdGxvYWRl
ciB0bwo+Pj4+PiBwYXJzZS4KPj4+Pj4gCj4+Pj4+IFRoZSB1c2Vyc3BhY2UgdmlldyB3aWxsIGRl
cGVuZCBvbiB0aGUgZHJpdmVyIGltcGxlbWVudGF0aW9uLgo+Pj4+PiAKPj4+Pj4gVGhlIGN1cnJl
bnQgZGV2aWNldHJlZSBhbmQgZHJpdmVyICh3aXRob3V0IHlvdXIgcGF0Y2hlcyksCj4+Pj4+IG1v
ZGVsIHRoZSBWUFUgYXMgYSBzaW5nbGUgcGllY2Ugb2YgaGFyZHdhcmUsIGV4cG9zaW5nIGEgZGVj
b2Rlcgo+Pj4+PiBhbmQgYW4gZW5jb2Rlci4KPj4+Pj4gCj4+Pj4+IFRoZSBWNEwgZHJpdmVyIHdp
bGwgdGhlbiBjcmVhdGUgdHdvIHZpZGVvIGRldmljZXMsIGkuZS4gL2Rldi92aWRlb1gKPj4+Pj4g
YW5kIC9kZXYvdmlkZW9ZLiBTbyB1c2Vyc3BhY2Ugc2VlcyBhbiBpbmRlcGVuZGVudCB2aWV3IG9m
IHRoZQo+Pj4+PiBkZXZpY2VzLgo+Pj4+PiAKPj4+PiBJIGtuZXcgdGhhdCwgdGhlIHByb2JsZW0g
aXMgdGhhdCB0aGUgZHJpdmVyIHNob3VsZCBub3QgYWx3YXlzIGNyZWF0ZSBhIGRlY29kZXIgYW5k
IGVuY29kZXIgcGFpciwgdGhleSBtYXkgbm90IGV4aXN0IGF0IHNvbWUgcGxhdGZvcm1zLCBldmVu
IHNvbWUgcGxhdGZvcm1zIGRvZXNu4oCZdCBoYXZlIGEgZW5jb2Rlci4gWW91IG1heSBoYXZlIGEg
bG9vayBvbiB0aGUgcmszMzI4IEkgcG9zdCBvbiB0aGUgZmlyc3QgZW1haWwgYXMgZXhhbXBsZS4K
Pj4+IAo+Pj4gVGhhdCBpcyBjb3JyZWN0LiBCdXQgdGhhdCBzdGlsbCBkb2Vzbid0IHRhY2tsZSBt
eSBxdWVzdGlvbjogaXMgdGhlCj4+PiBoYXJkd2FyZSBhYmxlIHRvIHJ1biBhIGRlY29kaW5nIGFu
ZCBhbiBlbmNvZGluZyBqb2IgaW4gcGFyYWxsZWw/Cj4+PiAKPj4gRm9yIHJrMzMyOCwgeWVzLCB5
b3Ugc2VlIEkgZGlkbuKAmXQgZHJhdyB0aGVtIGluIHRoZSBzYW1lIGJveC4KPj4+IElmIG5vdCwg
dGhlbiBpdCdzIHdyb25nIHRvIGRlc2NyaWJlIHRoZW0gYXMgaW5kZXBlbmRlbnQgZW50aXRpZXMu
Cj4+PiAKPj4+Pj4gSG93ZXZlciwgdGhleSBhcmUgaW50ZXJuYWxseSBjb25uZWN0ZWQsIGFuZCB0
aHVzIHdlIGNhbgo+Pj4+PiBlYXNpbHkgYXZvaWQgdHdvIGpvYnMgcnVubmluZyBpbiBwYXJhbGxl
bC4KPj4+Pj4gCj4+Pj4gVGhhdCBpcyB3aGF0IHRoZSBtcHAgc2VydmljZSBkaWQgaW4gbXkgcGF0
Y2hlcywgaGFuZGluZyB0aGUgcmVsYXRpb25zaGlwIGJldHdlZW4gZWFjaCBkZXZpY2VzLiBBbmQg
aXQgaXMgbm90IGEgZWFzeSB3b3JrLCBtYXliZSBhIDRrIGRlY29kZXIgd291bGQgYmUgYmxvY2tl
ZCBieSBhbm90aGVyIGhpZ2ggZnJhbWUgcmF0ZSBlbmNvZGluZyB3b3JrIG9yIGFub3RoZXIgZGVj
b2RlciBzZXNzaW9uLiBUaGUgdmVuZG9yIGtlcm5lbCBoYXZlIG1vcmUgd29ycnkgYWJvdXQgdGhp
cywgIGJ1dCBub3QgaW4gdGhpcyB2ZXJzaW9uLgo+Pj4gCj4+PiBSaWdodC4gVGhhdCBpcyBvbmUg
d2F5IHRvIGRlc2lnbiBpdC4gQW5vdGhlciB3YXkgaXMgaGF2aW5nIGEgc2luZ2xlCj4+PiBkZXZp
Y2V0cmVlIG5vZGUgZm9yIHRoZSBWUFUgZW5jb2Rlci9kZWNvZGVyICJjb21wbGV4Ii4KPj4gTm8s
IHlvdSBjYW7igJl0IGFzc3VtZSB3aGljaCBvbmUgaXMgaW4gdGhlIGNvbWJvIGdyb3VwLCBpdCBj
YW4gYmUgdmFyaW91cy4geW91IHNlZSwgaW4gdGhlIHJrMzMyOCwgdGhlIHZkcHUgaXMgcGFpcmVk
IHdpdGggYW4gYXZzKyBkZWNvZGVyLiBUaGF0IGlzIHdoeSBJIHVzZSBhIHZpcnR1YWwgZGV2aWNl
IHN0YW5kaW5nIGZvciBzY2hlZHVsZXIuCj4gCj4gRmlyc3Qgb2YgYWxsLCB0aGFua3MgZm9yIGFs
bCB0aGUgaW5wdXQuIEhhdmluZyBtb3JlIHVuZGVyc3RhbmRpbmcgb2YKPiB0aGUgaGFyZHdhcmUg
YW5kIHNob3J0Y29taW5ncyBvZiB0aGUgY3VycmVudCBWNEwyIEFQSXMgaXMgcmVhbGx5Cj4gaW1w
b3J0YW50IHRvIGxldCB1cyBmdXJ0aGVyIGV2b2x2ZSB0aGUgQVBJIGFuZCBtYWtlIHN1cmUgdGhh
dCBpdCB3b3Jrcwo+IGZvciBmdXJ0aGVyIHVzZSBjYXNlcy4KSSByZXBsaWVkIHRoZSBwcm9ibGVt
cyBvZiB0aGUgdjRsMiByZXF1ZXN0IEFQSSBpbiB0aGUgb3RoZXIgdGhyZWFkcy4gSSBhbSB3YWl0
aW5nIHRoZSBmZWVkYmFjayBmcm9tIHRob3NlIHRocmVhZHMuCj4gCj4gQXMgZm9yIHRoZSBEZXZp
Y2UgVHJlZSBpdHNlbGYsIGl0IGRvZXNuJ3QgYWx3YXlzIGRlc2NyaWJlIHRoZSBoYXJkd2FyZQo+
IGluIDEwMCUuCkFsc28gcGxlYXNlIG5vdGUgdGhlIG1lcmdlZCBkZXZpY2UgdHJlZSBmb3IgdGhl
IHZpZGVvIGNvZGVjIHdvbuKAmXQgZml4IGZvciBtb3N0IG9mIHRoZSByb2NrY2hpcCBwbGF0Zm9y
bS4KPiBNb3N0IG9mIHRoZSB0aW1lIGl0J3MganVzdCB0aGUgbmVjZXNzYXJ5IGluZm9ybWF0aW9u
IHRvCj4gY2hvb3NlIGFuZCBpbnN0YW50aWF0ZSB0aGUgcmlnaHQgZHJpdmVycyBhbmQgYmluZCB0
byB0aGUgcmlnaHQKPiBoYXJkd2FyZSByZXNvdXJjZXMuIFRoZSBpbmZvcm1hdGlvbiBvbiB3aGlj
aCBoYXJkd2FyZSBpbnN0YW5jZXMgb24gdGhlCj4gU29DIGNhbiB3b3JrIGluZGVwZW5kZW50bHkg
Y2FuIG9mIGNvdXJzZSBiZSBkZXNjcmliZWQgaW4gRFQgKGUuZy4gYnkKPiBzdWItbm9kZXMgb2Yg
YSB2aWRlby1jb2RlYyBjb21wbGV4IE9SIGEgc2V0IG9mIHBoYW5kbGVzLCBlLmcuCj4gcm9ja2No
aXAsc2hhcmVkLWluc3RhbmNlcyksIGJ1dCBpdCdzIGFsc28gcGVyZmVjdGx5IGZpbmUgdG8gZGVm
ZXIgdGhpcwo+IGtpbmQgb2Yga25vd2xlZGdlIHRvIHRoZSBkcml2ZXJzIHRoZW1zZWx2ZXMuCkkg
d2lzaCB0aGVyZSBpcyBhIGNvbW1vbiBtZWNoYW5pc20gZm9yIHRob3NlIGRldmljZSB3b3VsZCBz
aGFyZSBzb21lIHJlc291cmNlcy4gQWx0aG91Z2ggdGhlcmUgaXMgYSBtdWx0aXBsZSBmdW5jdGlv
bnMgZnJhbWV3b3JrLCAgYnV0IHRoYXQgaXMgbm90IEkgd2FudC4gVGhleSBhcmUgbXVsdGlwbGUg
ZnVuY3Rpb25zIGJ1dCB0aGV5IGFyZSB1c2VkIGF0IHRoZSBzYW1lIHRpbWUgbm90IHNlcGFyYXRl
bHkuCj4gCj4gQmVzdCByZWdhcmRzLAo+IFRvbWFzegoKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0Cmxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
