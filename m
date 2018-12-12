Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41F6C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 04:48:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74B1320851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 04:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O4qk5SOy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74B1320851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=t229B2y27sjKkTZGJmqojdDKeSryu5v9oyBJpOQN8bU=; b=O4qk5SOyF+c/aJ
	Qu3awGAoweSzK3pEwULMSVzaFECE013k64gJhtsr9a2hrS+lgj4+SHrznPWGVIZ4ZWf7LSGsRt0hs
	k5IONzrDIW3nYZKMvGURFYmESEzyn9kAJKQrnZiHNb23a4DG2FPIIFsjYXTcdmvvb/NAYjwojo6HX
	WWw5RzJSZ8iJ5Bc673vLGHvHFlF49lwqiDGDy7CfRzJ/UWWffXbIkAyh0/IBVzfnTcLFuMHlMTrSh
	t6g84I9jzkwk9It8oyTAhNrlBDS/9LPUavkcxOv0n5+sXit53BCSbaqHtqwkyEy6gOCEhwVQphT1M
	SR+J0CM7ioBGT2BQsbkg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWwS3-0005yH-2F; Wed, 12 Dec 2018 04:48:51 +0000
Received: from ozlabs.org ([203.11.71.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWwRy-0005xC-Pi
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 04:48:48 +0000
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43F4812KnBz9s0n;
 Wed, 12 Dec 2018 15:48:33 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andrew Murray <andrew.murray@arm.com>
Subject: Re: [PATCH 10/10] perf/doc: update design.txt for
 exclude_{host|guest} flags
In-Reply-To: <20181211135903.GG13393@e119886-lin.cambridge.arm.com>
References: <1542363853-13849-1-git-send-email-andrew.murray@arm.com>
 <1542363853-13849-11-git-send-email-andrew.murray@arm.com>
 <87pnv00yuf.fsf@concordia.ellerman.id.au>
 <20181120133202.GH35798@e119886-lin.cambridge.arm.com>
 <87bm5sxqya.fsf@concordia.ellerman.id.au>
 <20181211135903.GG13393@e119886-lin.cambridge.arm.com>
Date: Wed, 12 Dec 2018 15:48:32 +1100
Message-ID: <87sgz3wdsv.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_204847_196548_832F3E73 
X-CRM114-Status: GOOD (  23.43  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Christoffer.Dall@arm.com,
 Peter Zijlstra <peterz@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, x86@kernel.org,
 Will Deacon <will.deacon@arm.com>, linuxppc-dev@lists.ozlabs.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 linux-alpha@vger.kernel.org, "paulus@samba.org" <paulus@samba.org>,
 Thomas Gleixner <tglx@linutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QW5kcmV3IE11cnJheSA8YW5kcmV3Lm11cnJheUBhcm0uY29tPiB3cml0ZXM6Cj4gT24gVHVlLCBE
ZWMgMTEsIDIwMTggYXQgMTA6MDY6NTNQTSArMTEwMCwgTWljaGFlbCBFbGxlcm1hbiB3cm90ZToK
Pj4gWyBSZXZpdmluZyBvbGQgdGhyZWFkLiBdCj4+IAo+PiBBbmRyZXcgTXVycmF5IDxhbmRyZXcu
bXVycmF5QGFybS5jb20+IHdyaXRlczoKPj4gPiBPbiBUdWUsIE5vdiAyMCwgMjAxOCBhdCAxMDoz
MTozNlBNICsxMTAwLCBNaWNoYWVsIEVsbGVybWFuIHdyb3RlOgo+PiA+PiBBbmRyZXcgTXVycmF5
IDxhbmRyZXcubXVycmF5QGFybS5jb20+IHdyaXRlczoKPj4gPj4gCj4+ID4+ID4gVXBkYXRlIGRl
c2lnbi50eHQgdG8gcmVmbGVjdCB0aGUgcHJlc2VuY2Ugb2YgdGhlIGV4Y2x1ZGVfaG9zdAo+PiA+
PiA+IGFuZCBleGNsdWRlX2d1ZXN0IHBlcmYgZmxhZ3MuCj4+ID4+ID4KPj4gPj4gPiBTaWduZWQt
b2ZmLWJ5OiBBbmRyZXcgTXVycmF5IDxhbmRyZXcubXVycmF5QGFybS5jb20+Cj4+ID4+ID4gLS0t
Cj4+ID4+ID4gIHRvb2xzL3BlcmYvZGVzaWduLnR4dCB8IDQgKysrKwo+PiA+PiA+ICAxIGZpbGUg
Y2hhbmdlZCwgNCBpbnNlcnRpb25zKCspCj4+ID4+ID4KPj4gPj4gPiBkaWZmIC0tZ2l0IGEvdG9v
bHMvcGVyZi9kZXNpZ24udHh0IGIvdG9vbHMvcGVyZi9kZXNpZ24udHh0Cj4+ID4+ID4gaW5kZXgg
YTI4ZGNhMi4uN2RlN2Q4MyAxMDA2NDQKPj4gPj4gPiAtLS0gYS90b29scy9wZXJmL2Rlc2lnbi50
eHQKPj4gPj4gPiArKysgYi90b29scy9wZXJmL2Rlc2lnbi50eHQKPj4gPj4gPiBAQCAtMjIyLDYg
KzIyMiwxMCBAQCBUaGUgJ2V4Y2x1ZGVfdXNlcicsICdleGNsdWRlX2tlcm5lbCcgYW5kICdleGNs
dWRlX2h2JyBiaXRzIHByb3ZpZGUgYQo+PiA+PiA+ICB3YXkgdG8gcmVxdWVzdCB0aGF0IGNvdW50
aW5nIG9mIGV2ZW50cyBiZSByZXN0cmljdGVkIHRvIHRpbWVzIHdoZW4gdGhlCj4+ID4+ID4gIENQ
VSBpcyBpbiB1c2VyLCBrZXJuZWwgYW5kL29yIGh5cGVydmlzb3IgbW9kZS4KPj4gPj4gPiAgCj4+
ID4+ID4gK0Z1cnRoZXJtb3JlIHRoZSAnZXhjbHVkZV9ob3N0JyBhbmQgJ2V4Y2x1ZGVfZ3Vlc3Qn
IGJpdHMgcHJvdmlkZSBhIHdheQo+PiA+PiA+ICt0byByZXF1ZXN0IGNvdW50aW5nIG9mIGV2ZW50
cyByZXN0cmljdGVkIHRvIGd1ZXN0IGFuZCBob3N0IGNvbnRleHRzIHdoZW4KPj4gPj4gPiArdXNp
bmcgdmlydHVhbGlzYXRpb24uCj4+ID4+IAo+PiA+PiBIb3cgZG9lcyBleGNsdWRlX2hvc3QgZGlm
ZmVyIGZyb20gZXhjbHVkZV9odiA/Cj4+ID4KPj4gPiBJIGJlbGlldmUgZXhjbHVkZV9ob3N0IC8g
ZXhjbHVkZV9ndWVzdCBhcmUgaW50ZW50ZWQgdG8gZGlzdGluZ3Vpc2gKPj4gPiBiZXR3ZWVuIGhv
c3QgYW5kIGd1ZXN0IGluIHRoZSBob3N0ZWQgaHlwZXJ2aXNvciBjb250ZXh0IChLVk0pLgo+PiAK
Pj4gT0sgeWVhaCwgZnJvbSB0aGUgcGVyZi1saXN0IG1hbiBwYWdlOgo+PiAKPj4gICAgICAgICAg
ICB1IC0gdXNlci1zcGFjZSBjb3VudGluZwo+PiAgICAgICAgICAgIGsgLSBrZXJuZWwgY291bnRp
bmcKPj4gICAgICAgICAgICBoIC0gaHlwZXJ2aXNvciBjb3VudGluZwo+PiAgICAgICAgICAgIEkg
LSBub24gaWRsZSBjb3VudGluZwo+PiAgICAgICAgICAgIEcgLSBndWVzdCBjb3VudGluZyAoaW4g
S1ZNIGd1ZXN0cykKPj4gICAgICAgICAgICBIIC0gaG9zdCBjb3VudGluZyAobm90IGluIEtWTSBn
dWVzdHMpCj4+IAo+PiA+IFdoZXJlYXMgZXhjbHVkZV9odiBhbGxvd3MgdG8gZGlzdGluZ3Vpc2gg
YmV0d2VlbiBndWVzdCBhbmQKPj4gPiBoeXBlcnZpc29yIGluIHRoZSBiYXJlLW1ldGFsIHR5cGUg
aHlwZXJ2aXNvcnMuCj4+IAo+PiBFeGNlcHQgdGhhdCdzIGV4YWN0bHkgbm90IGhvdyB3ZSB1c2Ug
dGhlbSBvbiBwb3dlcnBjIDopCj4+IAo+PiBXZSB1c2UgZXhjbHVkZV9odiB0byBleGNsdWRlICJ0
aGUgaHlwZXJ2aXNvciIsIHJlZ2FyZGxlc3Mgb2Ygd2hldGhlcgo+PiBpdCdzIEtWTSBvciBQb3dl
clZNICh3aGljaCBpcyBhIGJhcmUtbWV0YWwgaHlwZXJ2aXNvcikuCj4+IAo+PiBXZSBkb24ndCB1
c2UgZXhjbHVkZV9ob3N0IC8gZXhjbHVkZV9ndWVzdCBhdCBhbGwsIHdoaWNoIEkgZ3Vlc3MgaXMg
YQo+PiBidWcsIGV4Y2VwdCBJIGRpZG4ndCBrbm93IHRoZXkgZXhpc3RlZCB1bnRpbCB0aGlzIHRo
cmVhZC4KPj4gCj4+IGVnLCBpbiBhIEtWTSBndWVzdDoKPj4gCj4+ICAgJCBwZXJmIHJlY29yZCAt
ZSBjeWNsZXM6RyAvYmluL2Jhc2ggLWMgImZvciBpIGluIHswLi4xMDAwMDB9OyBkbyA6O2RvbmUi
Cj4+ICAgJCBwZXJmIHJlcG9ydCAtRCB8IGdyZXAgLUZjICJkc286IFtoeXBlcnZpc29yXSIKPj4g
ICAxNgo+PiAKPj4gCj4+ID4gSW4gdGhlIGNhc2Ugb2YgYXJtNjQgLSBpZiBWSEUgZXh0ZW5zaW9u
cyBhcmUgcHJlc2VudCB0aGVuIHRoZSBob3N0Cj4+ID4ga2VybmVsIHdpbGwgcnVuIGF0IGEgaGln
aGVyIHByaXZpbGVnZSB0byB0aGUgZ3Vlc3Qga2VybmVsLCBpbiB3aGljaAo+PiA+IGNhc2UgdGhl
cmUgaXMgbm8gZGlzdGluY3Rpb24gYmV0d2VlbiBoeXBlcnZpc29yIGFuZCBob3N0IHNvIHdlIGln
bm9yZQo+PiA+IGV4Y2x1ZGVfaHYuIEJ1dCB3aGVyZSBWSEUgZXh0ZW5zaW9ucyBhcmUgbm90IHBy
ZXNlbnQgdGhlbiB0aGUgaG9zdAo+PiA+IGtlcm5lbCBydW5zIGF0IHRoZSBzYW1lIHByaXZpbGVn
ZSBsZXZlbCBhcyB0aGUgZ3Vlc3QgYW5kIHdlIHVzZSBhCj4+ID4gaGlnaGVyIHByaXZpbGVnZSBs
ZXZlbCB0byBzd2l0Y2ggYmV0d2VlbiB0aGVtIC0gaW4gdGhpcyBjYXNlIHdlIGNhbgo+PiA+IHVz
ZSBleGNsdWRlX2h2IHRvIGRpc2NvdW50IHRoYXQgaHlwZXJ2aXNvciByb2xlIG9mIHN3aXRjaGlu
ZyBiZXR3ZWVuCj4+ID4gZ3Vlc3RzLgo+PiAKPj4gSSBjb3VsZG4ndCBmaW5kIGFueSBhcm02NCBw
ZXJmIGNvZGUgdXNpbmcgZXhjbHVkZV9ob3N0L2d1ZXN0IGF0IGFsbD8KPgo+IENvcnJlY3QgLSBi
dXQgdGhpcyBpcyBpbiBmbGlnaHQgYXMgSSBhbSBjdXJyZW50bHkgYWRkaW5nIHN1cHBvcnQgZm9y
IHRoaXMKPiBzZWUgWzFdLgoKT0ssIHNvIGF0IGxlYXN0IHRoYXQgd2lsbCBiZSBjb25zaXN0ZW50
IGFjcm9zcyBhcm02NCAmIHg4Ni4KCj4+IEFuZCBJIGRvbid0IHNlZSBhbnkgeDg2IGNvZGUgdXNp
bmcgZXhjbHVkZV9odi4KPgo+IEkgY2FuJ3QgZmluZCBhbnkgZWl0aGVyLgoKSSB0aGluayB0aGF0
J3MgYmVjYXVzZSB0aGV5IGRvbid0IG5lZWQgaXQsIGJlY2F1c2UgdGhleSBkb24ndCBsZXQgZ3Vl
c3RzCnByb2dyYW0gdGhlIFBNVSBkaXJlY3RseS4gSXQncyBhbGwgaGFuZGxlZCBieSB0aGUgaG9z
dCBhbmQgdGhlIGhvc3QKZG9lc24ndCBsZXQgdGhlIGd1ZXN0IGNvdW50IGhvc3QgY3ljbGVzIGFu
eXdheS4gQnV0IEkgY291bGQgYmUgd3JvbmcgSSdtCm5vIHg4NiBleHBlcnQuCgo+PiBCdXQgbWF5
YmUgdGhhdCdzIE9LLCBJIGp1c3Qgd29ycnkgdGhpcyBpcyBjb25mdXNpbmcgZm9yIHVzZXJzLgo+
Cj4gVGhlcmUgaXMgc29tZSBleHRyYSBjb250ZXh0IHJlZ2FyZGluZyB0aGlzIHdoZXJlIGV4Y2x1
ZGVfZ3Vlc3QvZXhjbHVkZV9ob3N0Cj4gd2FzIGFkZGVkLCBzZWUgWzJdCgpHb29kIGZpbmQuIEkg
aGFkIGxvb2tlZCBhdCB0aGF0IGNvbW1pdCwgYnV0IHRoZSB0aHJlYWQgb24gdGhlIGxpc3QgaXMK
bW9yZSBpbmZvcm1hdGl2ZS4KCkluIGZhY3QgdGhlcmUgd2FzIGV2ZW4gYSBtYW4gcGFnZSB1cGRh
dGUhIE5ldmVyIG9jY3VycmVkIHRvIG1lIGxvb2sKdGhlcmUgOlAKCmh0dHA6Ly9tYW43Lm9yZy9s
aW51eC9tYW4tcGFnZXMvbWFuMi9wZXJmX2V2ZW50X29wZW4uMi5odG1sCgogICAgICAgZXhjbHVk
ZV9ob3N0IChzaW5jZSBMaW51eCAzLjIpCiAgICAgICAgICAgICAgV2hlbiBjb25kdWN0aW5nIG1l
YXN1cmVtZW50cyB0aGF0IGluY2x1ZGUgcHJvY2Vzc2VzIHJ1bm5pbmcgVk0KICAgICAgICAgICAg
ICBpbnN0YW5jZXMgKGkuZS4sIGhhdmUgZXhlY3V0ZWQgYSBLVk1fUlVOIGlvY3RsKDIpKSwgb25s
eSBtZWHigJAKICAgICAgICAgICAgICBzdXJlIGV2ZW50cyBoYXBwZW5pbmcgaW5zaWRlIGEgZ3Vl
c3QgaW5zdGFuY2UuICBUaGlzIGlzIG9ubHkKICAgICAgICAgICAgICBtZWFuaW5nZnVsIG91dHNp
ZGUgdGhlIGd1ZXN0czsgdGhpcyBzZXR0aW5nIGRvZXMgbm90IGNoYW5nZQogICAgICAgICAgICAg
IGNvdW50cyBnYXRoZXJlZCBpbnNpZGUgb2YgYSBndWVzdC4gIEN1cnJlbnRseSwgdGhpcyBmdW5j
dGlvbuKAkAogICAgICAgICAgICAgIGFsaXR5IGlzIHg4NiBvbmx5LgoKICAgICAgIGV4Y2x1ZGVf
Z3Vlc3QgKHNpbmNlIExpbnV4IDMuMikKICAgICAgICAgICAgICBXaGVuIGNvbmR1Y3RpbmcgbWVh
c3VyZW1lbnRzIHRoYXQgaW5jbHVkZSBwcm9jZXNzZXMgcnVubmluZyBWTQogICAgICAgICAgICAg
IGluc3RhbmNlcyAoaS5lLiwgaGF2ZSBleGVjdXRlZCBhIEtWTV9SVU4gaW9jdGwoMikpLCBkbyBu
b3QKICAgICAgICAgICAgICBtZWFzdXJlIGV2ZW50cyBoYXBwZW5pbmcgaW5zaWRlIGd1ZXN0IGlu
c3RhbmNlcy4gIFRoaXMgaXMgb25seQogICAgICAgICAgICAgIG1lYW5pbmdmdWwgb3V0c2lkZSB0
aGUgZ3Vlc3RzOyB0aGlzIHNldHRpbmcgZG9lcyBub3QgY2hhbmdlCiAgICAgICAgICAgICAgY291
bnRzIGdhdGhlcmVkIGluc2lkZSBvZiBhIGd1ZXN0LiAgQ3VycmVudGx5LCB0aGlzIGZ1bmN0aW9u
4oCQCiAgICAgICAgICAgICAgYWxpdHkgaXMgeDg2IG9ubHkuCgoKV2hpY2ggbWFrZXMgdGhpbmdz
IG11Y2ggY2xlYXJlci4KClBlcmhhcHMgeW91IHdhbnQgdG8gYWRkIGEgcmVmZXJlbmNlIHRvIHRo
ZSBtYW4gcGFnZSBpbiB5b3VyIHRleHQsCnNvbWV0aGluZyBsaWtlPwoKICBGdXJ0aGVybW9yZSB0
aGUgJ2V4Y2x1ZGVfaG9zdCcgYW5kICdleGNsdWRlX2d1ZXN0JyBiaXRzIHByb3ZpZGUgYSB3YXkK
ICB0byByZXF1ZXN0IGNvdW50aW5nIG9mIGV2ZW50cyByZXN0cmljdGVkIHRvIGd1ZXN0IGFuZCBo
b3N0IGNvbnRleHRzIHdoZW4KICB1c2luZyB2aXJ0dWFsaXNhdGlvbi4gU2VlIHRoZSBwZXJmX2V2
ZW50X29wZW4oMikgbWFuIHBhZ2UgZm9yIG1vcmUKICBkZXRhaWwuCgoKY2hlZXJzCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVs
IG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
