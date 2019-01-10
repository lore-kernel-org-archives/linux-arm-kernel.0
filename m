Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE921C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:16:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA96F214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MCRNN1Qt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA96F214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sB9T3iZEeRI3Yuq6hrC4HNDx8gSMs7XlWZYfqteJ8lE=; b=MCRNN1QtH0HYUq
	5Pw/OQNfxVXphDhfJN84XHwuyipt5mfNNjBNuzfdgYgbMFCo6s8dktiFbFWAv73oSj939aRf0GSYv
	/NaPrsHUaaA5W6SXrBNNT+SYn7eAln5iE5Bt63oGuYN/fmy8TDsyuqV+u62IKF/i1UW3Hn+VoiDvW
	hU+CLR98G+X+r9m0VJiVR3d9ykxqVeo7F8M465369BRbWUz/pdzt2p7EN63ROKFcbFu7KJZvNxiWW
	/izsPkSmL1g4xs2hGJl/rqFqo/WBOlCvt/3FooeO+lt8ZZReX1mkbE+viy7/a7c1REpY67u/kfzuB
	6KLxAiFnzzFdDe2jZwIA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghb7x-0002Td-TB; Thu, 10 Jan 2019 14:16:09 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghb7u-0002TI-RS
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 14:16:08 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09F831596;
 Thu, 10 Jan 2019 06:16:06 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E75C03F5AF;
 Thu, 10 Jan 2019 06:16:03 -0800 (PST)
Subject: Re: [PATCH v3 4/7] arm64: add sysfs vulnerability show for meltdown
To: Jeremy Linton <jeremy.linton@arm.com>, linux-arm-kernel@lists.infradead.org
References: <20190109235544.2992426-1-jeremy.linton@arm.com>
 <20190109235544.2992426-5-jeremy.linton@arm.com>
 <8c8b564a-1d65-bc18-73fb-58b349a47800@arm.com>
 <7e843245-56c0-d7c1-38ba-27ff231a500a@arm.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <fbcfae96-6cca-2a7a-a91b-8ffcc1a4c803@arm.com>
Date: Thu, 10 Jan 2019 14:16:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <7e843245-56c0-d7c1-38ba-27ff231a500a@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_061606_896224_B5EA9F31 
X-CRM114-Status: GOOD (  19.46  )
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
Cc: stefan.wahren@i2se.com, mlangsdo@redhat.com, suzuki.poulose@arm.com,
 marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, steven.price@arm.com, ykaukab@suse.de,
 dave.martin@arm.com, shankerd@codeaurora.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

CgpPbiAxMC8wMS8yMDE5IDE0OjEwLCBKZXJlbXkgTGludG9uIHdyb3RlOgo+IEhpIEp1bGllbiwK
PiAKPiBPbiAwMS8xMC8yMDE5IDAzOjIzIEFNLCBKdWxpZW4gVGhpZXJyeSB3cm90ZToKPj4gSGkg
SmVyZW15LAo+Pgo+PiBPbiAwOS8wMS8yMDE5IDIzOjU1LCBKZXJlbXkgTGludG9uIHdyb3RlOgo+
Pj4gRGlzcGxheSB0aGUgbWl0aWdhdGlvbiBzdGF0dXMgaWYgYWN0aXZlLCBvdGhlcndpc2UKPj4+
IGFzc3VtZSB0aGUgY3B1IGlzIHNhZmUgdW5sZXNzIGl0IGRvZXNuJ3QgaGF2ZSBDU1YzCj4+PiBh
bmQgaXNuJ3QgaW4gb3VyIHdoaXRlbGlzdC4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBKZXJlbXkg
TGludG9uIDxqZXJlbXkubGludG9uQGFybS5jb20+Cj4+PiAtLS0KPj4+IMKgIGFyY2gvYXJtNjQv
a2VybmVsL2NwdWZlYXR1cmUuYyB8IDMyICsrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0t
Cj4+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkK
Pj4+Cj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9rZXJuZWwvY3B1ZmVhdHVyZS5jCj4+PiBi
L2FyY2gvYXJtNjQva2VybmVsL2NwdWZlYXR1cmUuYwo+Pj4gaW5kZXggYWI3ODRkN2EwMDgzLi5l
ZjdiYmM0OWVmNzggMTAwNjQ0Cj4+PiAtLS0gYS9hcmNoL2FybTY0L2tlcm5lbC9jcHVmZWF0dXJl
LmMKPj4+ICsrKyBiL2FyY2gvYXJtNjQva2VybmVsL2NwdWZlYXR1cmUuYwo+Pj4gQEAgLTk0NCw4
ICs5NDQsMTIgQEAgaGFzX3VzZWFibGVfY25wKGNvbnN0IHN0cnVjdAo+Pj4gYXJtNjRfY3B1X2Nh
cGFiaWxpdGllcyAqZW50cnksIGludCBzY29wZSkKPj4+IMKgwqDCoMKgwqAgcmV0dXJuIGhhc19j
cHVpZF9mZWF0dXJlKGVudHJ5LCBzY29wZSk7Cj4+PiDCoCB9Cj4+PiDCoCArLyogZGVmYXVsdCB2
YWx1ZSBpcyBpbnZhbGlkIHVudGlsIHVubWFwX2tlcm5lbF9hdF9lbDAoKSBydW5zICovCj4+PiAr
c3RhdGljIGJvb2wgX19tZWx0ZG93bl9zYWZlID0gdHJ1ZTsKPj4+ICsKPj4+IMKgICNpZmRlZiBD
T05GSUdfVU5NQVBfS0VSTkVMX0FUX0VMMAo+Pj4gwqAgc3RhdGljIGludCBfX2twdGlfZm9yY2Vk
OyAvKiAwOiBub3QgZm9yY2VkLCA+MDogZm9yY2VkIG9uLCA8MDoKPj4+IGZvcmNlZCBvZmYgKi8K
Pj4+ICtleHRlcm4gdWludCBhcm02NF9yZXF1ZXN0ZWRfdnVsbl9hdHRyczsKPj4+IMKgIMKgIHN0
YXRpYyBib29sIGlzX2NwdV9tZWx0ZG93bl9zYWZlKHZvaWQpCj4+PiDCoCB7Cj4+PiBAQCAtOTcy
LDYgKzk3NiwxNCBAQCBzdGF0aWMgYm9vbCB1bm1hcF9rZXJuZWxfYXRfZWwwKGNvbnN0IHN0cnVj
dAo+Pj4gYXJtNjRfY3B1X2NhcGFiaWxpdGllcyAqZW50cnksCj4+PiDCoCB7Cj4+PiDCoMKgwqDC
oMKgIGNoYXIgY29uc3QgKnN0ciA9ICJjb21tYW5kIGxpbmUgb3B0aW9uIjsKPj4+IMKgICvCoMKg
wqAgYm9vbCBtZWx0ZG93bl9zYWZlID0gaXNfY3B1X21lbHRkb3duX3NhZmUoKSB8fAo+Pj4gK8Kg
wqDCoMKgwqDCoMKgIGhhc19jcHVpZF9mZWF0dXJlKGVudHJ5LCBzY29wZSk7Cj4+PiArCj4+PiAr
wqDCoMKgIGlmICghbWVsdGRvd25fc2FmZSkKPj4+ICvCoMKgwqDCoMKgwqDCoCBfX21lbHRkb3du
X3NhZmUgPSBmYWxzZTsKPj4+ICsKPj4+ICvCoMKgwqAgYXJtNjRfcmVxdWVzdGVkX3Z1bG5fYXR0
cnMgfD0gVlVMTl9NRUxURE9XTjsKPj4+ICsKPj4+IMKgwqDCoMKgwqAgLyoKPj4+IMKgwqDCoMKg
wqDCoCAqIEZvciByZWFzb25zIHRoYXQgYXJlbid0IGVudGlyZWx5IGNsZWFyLCBlbmFibGluZyBL
UFRJIG9uIENhdml1bQo+Pj4gwqDCoMKgwqDCoMKgICogVGh1bmRlclggbGVhZHMgdG8gYXBwYXJl
bnQgSS1jYWNoZSBjb3JydXB0aW9uIG9mIGtlcm5lbAo+Pj4gdGV4dCwgd2hpY2gKPj4+IEBAIC05
OTMsMTEgKzEwMDUsNyBAQCBzdGF0aWMgYm9vbCB1bm1hcF9rZXJuZWxfYXRfZWwwKGNvbnN0IHN0
cnVjdAo+Pj4gYXJtNjRfY3B1X2NhcGFiaWxpdGllcyAqZW50cnksCj4+PiDCoMKgwqDCoMKgIGlm
IChJU19FTkFCTEVEKENPTkZJR19SQU5ET01JWkVfQkFTRSkpCj4+PiDCoMKgwqDCoMKgwqDCoMKg
wqAgcmV0dXJuIHRydWU7Cj4+PiDCoCAtwqDCoMKgIGlmIChpc19jcHVfbWVsdGRvd25fc2FmZSgp
KQo+Pj4gLcKgwqDCoMKgwqDCoMKgIHJldHVybiBmYWxzZTsKPj4+IC0KPj4+IC3CoMKgwqAgLyog
RGVmZXIgdG8gQ1BVIGZlYXR1cmUgcmVnaXN0ZXJzICovCj4+PiAtwqDCoMKgIHJldHVybiAhaGFz
X2NwdWlkX2ZlYXR1cmUoZW50cnksIHNjb3BlKTsKPj4+ICvCoMKgwqAgcmV0dXJuICFtZWx0ZG93
bl9zYWZlOwo+Pj4gwqAgfQo+Pj4gwqAgwqAgc3RhdGljIHZvaWQKPj4+IEBAIC0yMDY1LDMgKzIw
NzMsMTcgQEAgc3RhdGljIGludCBfX2luaXQgZW5hYmxlX21yc19lbXVsYXRpb24odm9pZCkKPj4+
IMKgIH0KPj4+IMKgIMKgIGNvcmVfaW5pdGNhbGwoZW5hYmxlX21yc19lbXVsYXRpb24pOwo+Pj4g
Kwo+Pj4gKyNpZmRlZiBDT05GSUdfR0VORVJJQ19DUFVfVlVMTkVSQUJJTElUSUVTCj4+PiArc3Np
emVfdCBjcHVfc2hvd19tZWx0ZG93bihzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdAo+Pj4gZGV2
aWNlX2F0dHJpYnV0ZSAqYXR0ciwKPj4+ICvCoMKgwqDCoMKgwqDCoCBjaGFyICpidWYpCj4+PiAr
ewo+Pj4gK8KgwqDCoCBpZiAoYXJtNjRfa2VybmVsX3VubWFwcGVkX2F0X2VsMCgpKQo+Pj4gK8Kg
wqDCoMKgwqDCoMKgIHJldHVybiBzcHJpbnRmKGJ1ZiwgIk1pdGlnYXRpb246IEtQVElcbiIpOwo+
Pj4gKwo+Pj4gK8KgwqDCoCBpZiAoX19tZWx0ZG93bl9zYWZlKQo+Pj4gK8KgwqDCoMKgwqDCoMKg
IHJldHVybiBzcHJpbnRmKGJ1ZiwgIk5vdCBhZmZlY3RlZFxuIik7Cj4+Cj4+IEFuIGlzc3VlIEkg
c2VlIGlzIHRoYXQgd2UgZG9uJ3QgZXZlbiBib3RoZXIgdG8gY2hlY2sgaXQgdGhhdCBDUFVzIGFy
ZQo+PiBtZWx0ZG93biBzYWZlIGlmIENPTkZJR19VTk1BUF9LRVJORUxfQVRfRUwwIGlzIG5vdCBk
ZWZpbmVkIGJ1dCBoZXJlCj4+IHdlJ2xsIGFkdmVydGlzZSB0aGF0IHRoZSBzeXN0ZW0gaXMgbWVs
dGRvd24gc2FmZS4KPiAKPiBUaGF0IGNoZWNrIGlzbid0IG5lY2Vzc2FyeSBhbnltb3JlIGJlY2F1
c2UgdGhlIHN5c2ZzIGF0dHJpYnV0ZSBpcyBvbmx5Cj4gcG9wdWxhdGVkIGlmIHVubWFwX2tlcm5l
bF9hdF9lbDAoKSBydW5zIChhc3N1bWluZyBJIGhhdmVuJ3QgbWVzc2VkCj4gc29tZXRoaW5nIHVw
KS4gVGhhdCB3YXMgRGF2ZS9XaWxsJ3Mgc3VnZ2VzdGlvbnMgaW4gdGhlIGxhc3QgdGhyZWFkIGFi
b3V0Cj4gaG93IHRvIGhhbmRsZSB0aGlzIGNhc2UuCj4gCgpPaCByaWdodCwgSSBtaXNzZWQgdGhh
dCBiaXQuIFNvcnJ5IGZvciB0aGUgbm9pc2UuCgo+Pgo+PiBJIHRoaW5rIHRoYXQgY2hlY2tpbmcg
d2hldGhlciB3ZSBrbm93IHRoYXQgQ1BVcyBhcmUgbWVsdGRvd24gc2FmZSBzaG91bGQKPj4gYmUg
c2VwYXJhdGVkIGZyb20gd2hldGhlciBtaXRpZ2F0aW9uIGlzIGFwcGxpZWQuCj4+Cj4+IFNvbWVv
bmUgd2hvIGtub3dzIHRoaW5rcyB0aGVpciBDUFVzIGFyZSBpbiB0aGUgd2hpdGUgbGlzdCBtaWdo
dCB3YW50IHRvCj4+IGNvbXBpbGUgb3V0IGNvZGUgdGhhdCBkb2VzIHRoZSBrcHRpLCBidXQgaXQg
d291bGQgYmUgZ29vZCB0byBnaXZlIHRoZW0gYQo+PiBwcm9wZXIgZGlhZ25vc3RpYyB3aGV0aGVy
IHRoZXkgd2VyZSB3cm9uZyBvciBub3QuCj4+Cj4+IENoZWVycywKPj4KPiAKCi0tIApKdWxpZW4g
VGhpZXJyeQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtYXJtLWtlcm5lbAo=
