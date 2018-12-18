Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C0CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:46:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6027B21852
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WfMFNTU1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6027B21852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7RsD9tpatSd77vDfIGTJBMaUqeGy/tuyNKChiC3NodY=; b=WfMFNTU1LoCFv7
	uaRvYMzDkUtfvABvjVzuVoqA8PaLJnULJgkj3FbTj8vuJH45egf7GYic6BQecpe4ujqQ0DB+MEM8v
	AwnAEULk6TNOPYSVD9azuTGiEIjze8o5DJL4G3l+ZDS94Qg0wc+2FNLCG1LOJL02+uFlKZFm/cNWh
	6RylacoaDrWzMv0hO0seWhKeFi+YPnP4LvULC3RMDCLY7ffbgWuPKtI9MM9NnoQescAyVSaTNTOJu
	ScQfXA8g85Dcot6QvTbJplvD+e3dor21VsqpdDf3j0kmBKLopXAyx3/Dcy0epxDbepIjMb7Q5HBXG
	f36kMi8wYXuMvQLofL1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZHa8-0007GF-1y; Tue, 18 Dec 2018 15:46:52 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZHZs-00070b-Ee
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 15:46:42 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id E6EF72072C; Tue, 18 Dec 2018 16:46:24 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
 by mail.bootlin.com (Postfix) with ESMTPSA id BBE2B206FF;
 Tue, 18 Dec 2018 16:46:24 +0100 (CET)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 1/6] dt-bindings: ap806: add the cluster clock node in
 the syscon file
References: <20181216094147.6468-1-gregory.clement@bootlin.com>
 <20181216094147.6468-2-gregory.clement@bootlin.com>
 <20181217225044.GA25148@bogus>
Date: Tue, 18 Dec 2018 16:46:25 +0100
In-Reply-To: <20181217225044.GA25148@bogus> (Rob Herring's message of "Mon, 17
 Dec 2018 16:50:44 -0600")
Message-ID: <87efaehm7i.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_074637_286337_4AE87677 
X-CRM114-Status: GOOD (  17.92  )
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
Cc: devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
 Andrew Lunn <andrew@lunn.ch>, Antoine Tenart <antoine.tenart@bootlin.com>,
 Mike Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>,
 linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgUm9iLAogCiBPbiBsdW4uLCBkw6ljLiAxNyAyMDE4LCBSb2IgSGVycmluZyA8cm9iaEBrZXJu
ZWwub3JnPiB3cm90ZToKCj4gT24gU3VuLCBEZWMgMTYsIDIwMTggYXQgMTA6NDE6NDJBTSArMDEw
MCwgR3JlZ29yeSBDTEVNRU5UIHdyb3RlOgo+PiBEb2N1bWVudCB0aGUgZGV2aWNlIHRyZWUgYmlu
ZGluZyBmb3IgdGhlIGNsdXN0ZXIgY2xvY2sgY29udHJvbGxlcnMgZm91bmQKPj4gaW4gdGhlIEFy
bWFkYSA3Sy84SyBTb0NzLgo+PiAKPj4gU2lnbmVkLW9mZi1ieTogR3JlZ29yeSBDTEVNRU5UIDxn
cmVnb3J5LmNsZW1lbnRAYm9vdGxpbi5jb20+Cj4+IC0tLQo+PiAgLi4uL2FybS9tYXJ2ZWxsL2Fw
ODA2LXN5c3RlbS1jb250cm9sbGVyLnR4dCAgIHwgMjIgKysrKysrKysrKysrKysrKysrKwo+PiAg
MSBmaWxlIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKykKPj4gCj4+IGRpZmYgLS1naXQgYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21hcnZlbGwvYXA4MDYtc3lzdGVtLWNv
bnRyb2xsZXIudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tYXJ2
ZWxsL2FwODA2LXN5c3RlbS1jb250cm9sbGVyLnR4dAo+PiBpbmRleCAzZmQyMWJiN2NiMzcuLjhm
MjgxODE2YTZiOCAxMDA2NDQKPj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL2FybS9tYXJ2ZWxsL2FwODA2LXN5c3RlbS1jb250cm9sbGVyLnR4dAo+PiArKysgYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21hcnZlbGwvYXA4MDYtc3lzdGVtLWNv
bnRyb2xsZXIudHh0Cj4+IEBAIC0xMzYsMyArMTM2LDI1IEBAIGFwX3N5c2NvbjE6IHN5c3RlbS1j
b250cm9sbGVyQDZmODAwMCB7Cj4+ICAJCSN0aGVybWFsLXNlbnNvci1jZWxscyA9IDwxPjsKPj4g
IAl9Owo+PiAgfTsKPj4gKwo+PiArQ2x1c3RlciBjbG9ja3M6Cj4+ICstLS0tLS0tLS0tLS0tLS0K
Pj4gKwo+PiArRGV2aWNlIFRyZWUgQ2xvY2sgYmluZGluZ3MgZm9yIGNsdXN0ZXIgY2xvY2sgb2Yg
QVA4MDYgTWFydmVsbC4gRWFjaAo+PiArY2x1c3RlciBjb250YWluIHVwIHRvIDIgQ1BVcyBydW5u
aW5nIGF0IHRoZSBzYW1lIGZyZXF1ZW5jeS4KPj4gKwo+PiArUmVxdWlyZWQgcHJvcGVydGllczoK
Pj4gKy0gY29tcGF0aWJsZTogbXVzdCBiZSAgIm1hcnZlbGwsYXA4MDYtY3B1LWNsb2NrIjsKPj4g
Ky0gI2Nsb2NrLWNlbGxzIDogc2hvdWxkIGJlIHNldCB0byAxLgo+PiArLSBjbG9ja3MgOiBzaGFs
bCBiZSB0aGUgaW5wdXQgcGFyZW50cyBjbG9jayBwaGFuZGxlIGZvciB0aGUgY2xvY2suCj4+ICsK
Pj4gK2FwX3N5c2NvbjE6IHN5c3RlbS1jb250cm9sbGVyQDZmODAwMCB7Cj4+ICsJY29tcGF0aWJs
ZSA9ICJzeXNjb24iLCAic2ltcGxlLW1mZCI7Cj4+ICsJcmVnID0gPDB4NmY4MDAwIDB4MTAwMD47
Cj4+ICsKPj4gKwljcHVfY2xrOiBjbG9jay1jcHUgewo+Cj4gVGhlcmUncyBub3QgYSByZWdpc3Rl
ciBhZGRyZXNzIHJhbmdlIHlvdSBjYW4gdXNlIGV2ZW4gaWYgTGludXggaGFwcGVucyAKPiB0byBu
b3QgbmVlZCBpdCAoY3VycmVudGx5KT8KCldlIGNhbiBhZGQgYW4gb3B0aW9uYWwgcmVnIHByb3Bl
cnR5IGlmIHlvdSB3YW50LCBidXQgdGhlIHdob2xlIHBvaW50IG9mCnRoaXMsIGlzIHRvIGJlIGFi
bGUgdG8gZW5zdXJlIHRoZSBjb21wYXRpYmlsaXR5LiBJbmRlZWQsIHdlIGhhdmUgbm93CmVub3Vn
aCBleHBlcmllbmNlIHRvIGtub3cgdGhhdCB0aGUgaW5mb3JtYXRpb24gd2UgaGF2ZSBmcm9tIHRo
ZQpkYXRhc2hlZXQgaXMgaW5jb21wbGV0ZS4gQW5kIHdoZW4gd2Ugc3RhcnQgdG8gZGVhbCB3aXRo
IGFuIElQIGNhbGxpbmcKInN5c3RlbSBjb250cm9sbGVyIiwgdGhlbiB3ZSBjYW4gZXhwZWN0IGEg
bWl4IGJldHdlZW4gYWxsIHRoZSByZWdpc3RlcnMuCgo+Cj4gVGhlcmUncyBhbHJlYWR5IGEgY2xv
Y2sgbm9kZSB1bmRlciB0aGlzIHN5c2Nvbj8gQXJlIHRoZXkgcmVhbGx5IHNlcGFyYXRlIAo+IHN1
Yi1ibG9ja3M/CgpBY3R1YWxseSB0aGUgb3RoZXIgY2xvY2sgbm9kZSAobWFydmVsbCxhcDgwNi1j
bG9jaykgaXMgdW5kZXIgdGhlIG90aGVyCnN5c2Nvbjogc3lzdGVtIGNvbnRyb2xsZXIgMCB3aXRo
IGdwaW8gYW5kIHBpbmN0cmwsIHdoZXJlYXMgdGhpcyBvbmUKKG1hcnZlbGwsYXA4MDYtY3B1LWNs
b2NrKSwgaXMgdW5kZXIgc3lzdGVtIGNvbnRyb2xsZXIgMSB3aXRoIHRoZXJtYWwuCgpHcmVnb3J5
Cgo+Cj4+ICsJCWNvbXBhdGlibGUgPSAibWFydmVsbCxhcDgwNi1jcHUtY2xvY2siOwo+PiArCQlj
bG9ja3MgPSA8JmFwX2NsayAwPiwgPCZhcF9jbGsgMT47Cj4+ICsJCSNjbG9jay1jZWxscyA9IDwx
PjsKPj4gKwl9Owo+PiArfTsKPj4gLS0gCj4+IDIuMTkuMgo+PiAKCi0tIApHcmVnb3J5IENsZW1l
bnQsIEJvb3RsaW4KRW1iZWRkZWQgTGludXggYW5kIEtlcm5lbCBlbmdpbmVlcmluZwpodHRwOi8v
Ym9vdGxpbi5jb20KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LWFybS1rZXJuZWwK
