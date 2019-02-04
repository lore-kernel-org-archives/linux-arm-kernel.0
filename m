Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E586C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:48:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0E6E2082E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n+Df1z2T";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="clBCs0el"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0E6E2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tronnes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zXnmqKtUpxiZNMeBHbL9Qqgzme1XOjoHs5FQu4oS44U=; b=n+Df1z2T0SViS/
	8VPCLcsCHbI4wKAh7hkOUMMKE0zMgQWLPywhtLlTSaMvEt2OP4XWYN/RrbI1piONfgmvVHqUKW5WO
	OIn9inoDYldJdqV5zkW5fJCBQg08zy2kBD1w0b+YuPE4Z9ZInKCwfIaEvEIQzOnfw8Fi57NWtrlE9
	zdfoP/dYcmx+mwpD7y/ywX7RWP9hf6JR/SAVRLA/CzDIq49xUcrhnyL2gMWmIjyR0AW8a5jmhXIN2
	304O9htotqmSkk3DVFm5JLoIytxh3U7quenGJaBHhNk75mdnInwFJxNThAsxL0uEF+9YzdMALU0aC
	H6yr3e1/4ovrDD0CciiQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqgUG-0000oY-JS; Mon, 04 Feb 2019 15:48:44 +0000
Received: from smtp.domeneshop.no ([2a01:5b40:0:3005::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqgUC-0000mH-3v; Mon, 04 Feb 2019 15:48:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org;
 s=ds201810; 
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject;
 bh=vM4zaRCSFYez/fLsfgtUQXFQb+ZnDKztu0LPvtDTigU=; 
 b=clBCs0el35tPmPXIml8UxiP6Y3t+Jy9ZznlZOZjcCdLMTQHe6ybKzAUKhR0YhOEKcqzqBpx6n59Rtyoa6sP8trdzGDlpXn6DYb/j7VyiIvvmzvAq/BJOiAugOnem3BsqYJ6Jq6vaAA4cfssE5IQQfD9w7+MmponvY5upqqoLVknJB/jFlMb5NzIJ7moCIXH5Lkx6iqIEpTSEXzI9d8Y/PKUpsQhceVJCo4yG/VJjf349HDtNAhNnCrZftREyrMGKARnHeg4xYvggQdfmkyvKg1e8K2H3pYWlUhnM9/xoj9hktnDJYhMjlgDKzpFyNvWEAlyiqrBOCHzkS1B1XMcbRA==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:52685
 helo=[192.168.10.176])
 by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.84_2) (envelope-from <noralf@tronnes.org>)
 id 1gqgU7-0007q4-1s; Mon, 04 Feb 2019 16:48:35 +0100
Subject: Re: [PATCH] drm/rockchip: Use drm_fbdev_generic_setup()
To: Rob Herring <robh@kernel.org>
References: <20190202170711.29471-1-robh@kernel.org>
 <bebcbda6-1059-857b-4e7d-9751248f6804@tronnes.org>
 <CAL_JsqL-7bOCS+T1xuJBmSgwRN1shCSNeQPxreCH76_s9hEYWw@mail.gmail.com>
From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <db0058ac-19df-95b9-18e9-6b5089f6cde3@tronnes.org>
Date: Mon, 4 Feb 2019 16:48:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqL-7bOCS+T1xuJBmSgwRN1shCSNeQPxreCH76_s9hEYWw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_074840_342028_B71242BB 
X-CRM114-Status: GOOD (  23.55  )
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
Cc: =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
 David Airlie <airlied@linux.ie>, Sandy Huang <hjc@rock-chips.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 Daniel Vetter <daniel@ffwll.ch>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

CgpEZW4gMDQuMDIuMjAxOSAxNi4wMSwgc2tyZXYgUm9iIEhlcnJpbmc6Cj4gT24gU2F0LCBGZWIg
MiwgMjAxOSBhdCAxMjoyMiBQTSBOb3JhbGYgVHLDuG5uZXMgPG5vcmFsZkB0cm9ubmVzLm9yZz4g
d3JvdGU6Cj4+IERlbiAwMi4wMi4yMDE5IDE4LjA3LCBza3JldiBSb2IgSGVycmluZzoKPj4+IE90
aGVyIHRoYW4gdXNpbmcgYSByb2NrY2hpcF9nZW1fb2JqZWN0IGRpcmVjdGx5LCB0aGUgUm9ja2No
aXAgZmJkZXYKPj4+IHNldHVwIGhhcyBub3RoaW5nIHNwZWNpYWwgYW5kIGNhbiBiZSBjb252ZXJ0
ZWQgdG8gdXNlIHRoZSBnZW5lcmljIGZiZGV2Cj4+PiBlbXVsYXRpb24gaW5zdGVhZC4KPiAKPiBb
Li4uXQo+IAo+Pj4gLXN0YXRpYyBpbnQgcm9ja2NoaXBfZHJtX2ZiZGV2X2NyZWF0ZShzdHJ1Y3Qg
ZHJtX2ZiX2hlbHBlciAqaGVscGVyLAo+Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBzdHJ1Y3QgZHJtX2ZiX2hlbHBlcl9zdXJmYWNlX3NpemUgKnNpemVzKQo+Pj4gLXsKPj4+
IC0gICAgIHN0cnVjdCByb2NrY2hpcF9kcm1fcHJpdmF0ZSAqcHJpdmF0ZSA9IHRvX2RybV9wcml2
YXRlKGhlbHBlcik7Cj4+PiAtICAgICBzdHJ1Y3QgZHJtX21vZGVfZmJfY21kMiBtb2RlX2NtZCA9
IHsgMCB9Owo+Pj4gLSAgICAgc3RydWN0IGRybV9kZXZpY2UgKmRldiA9IGhlbHBlci0+ZGV2Owo+
Pj4gLSAgICAgc3RydWN0IHJvY2tjaGlwX2dlbV9vYmplY3QgKnJrX29iajsKPj4+IC0gICAgIHN0
cnVjdCBkcm1fZnJhbWVidWZmZXIgKmZiOwo+Pj4gLSAgICAgdW5zaWduZWQgaW50IGJ5dGVzX3Bl
cl9waXhlbDsKPj4+IC0gICAgIHVuc2lnbmVkIGxvbmcgb2Zmc2V0Owo+Pj4gLSAgICAgc3RydWN0
IGZiX2luZm8gKmZiaTsKPj4+IC0gICAgIHNpemVfdCBzaXplOwo+Pj4gLSAgICAgaW50IHJldDsK
Pj4+IC0KPj4+IC0gICAgIGJ5dGVzX3Blcl9waXhlbCA9IERJVl9ST1VORF9VUChzaXplcy0+c3Vy
ZmFjZV9icHAsIDgpOwo+Pj4gLQo+Pj4gLSAgICAgbW9kZV9jbWQud2lkdGggPSBzaXplcy0+c3Vy
ZmFjZV93aWR0aDsKPj4+IC0gICAgIG1vZGVfY21kLmhlaWdodCA9IHNpemVzLT5zdXJmYWNlX2hl
aWdodDsKPj4+IC0gICAgIG1vZGVfY21kLnBpdGNoZXNbMF0gPSBzaXplcy0+c3VyZmFjZV93aWR0
aCAqIGJ5dGVzX3Blcl9waXhlbDsKPj4+IC0gICAgIG1vZGVfY21kLnBpeGVsX2Zvcm1hdCA9IGRy
bV9tb2RlX2xlZ2FjeV9mYl9mb3JtYXQoc2l6ZXMtPnN1cmZhY2VfYnBwLAo+Pj4gLSAgICAgICAg
ICAgICBzaXplcy0+c3VyZmFjZV9kZXB0aCk7Cj4+PiAtCj4+PiAtICAgICBzaXplID0gbW9kZV9j
bWQucGl0Y2hlc1swXSAqIG1vZGVfY21kLmhlaWdodDsKPj4+IC0KPj4+IC0gICAgIHJrX29iaiA9
IHJvY2tjaGlwX2dlbV9jcmVhdGVfb2JqZWN0KGRldiwgc2l6ZSwgdHJ1ZSk7Cj4+Cj4+IEkgZG9u
J3QgdGhpbmsgdGhlIGdlbmVyaWMgZW11bGF0aW9uIGluIGl0J3MgY3VycmVudCBmb3JtIHdpbGwg
d29yayBmb3IKPj4gcm9ja2NoaXAuIHJvY2tjaGlwIHRyZWF0cyBmYmRldiBidWZmZXJzIGFuZCBk
dW1iIGJ1ZmZlcnMgZGlmZmVyZW50bHkuIElmCj4+IGl0IHVzZXMgRE1BIGJ1ZmZlcnMsIHRoZW4g
dGhlIGR1bWIgYnVmZmVyIGNhbid0IGdldCBhIHZpcnR1YWwgYWRkcmVzcy4KPiAKPiBZZXMsIHlv
dSBhcmUgcmlnaHQuIEkgdGVzdGVkIHRoZSBpb21tdSBjYXNlLgo+IAo+PiBGcm9tIHJvY2tjaGlw
X2dlbV9hbGxvY19kbWEoKToKPj4KPj4gICAgICAgICBpZiAoIWFsbG9jX2ttYXApCj4+ICAgICAg
ICAgICAgICAgICBya19vYmotPmRtYV9hdHRycyB8PSBETUFfQVRUUl9OT19LRVJORUxfTUFQUElO
RzsKPj4KPj4gRnJvbSByb2NrY2hpcF9nZW1fcHJpbWVfdm1hcCgpOgo+Pgo+PiAgICAgICAgIGlm
IChya19vYmotPmRtYV9hdHRycyAmIERNQV9BVFRSX05PX0tFUk5FTF9NQVBQSU5HKQo+PiAgICAg
ICAgICAgICAgICAgcmV0dXJuIE5VTEw7Cj4+Cj4+IE1heWJlIGl0J3MgcG9zc2libGUgdG8gdm1h
cCBhIGJ1ZmZlciBjcmVhdGVkIHVzaW5nIGRtYV9hbGxvY19hdHRycygpCj4+IGFmdGVyIHRoZSBh
bGxvY2F0aW9uPwo+IAo+IEl0IHNob3VsZCBiZSBwb3NzaWJsZSBJIHRoaW5rIGFzIHRoYXQgaXMg
d2hhdAo+IGRybV9nZW1fY21hX3ByaW1lX2ltcG9ydF9zZ190YWJsZV92bWFwKCkgZG9lcy4gT25l
IHByb2JsZW0gdGhvdWdoIGlzCj4geW91IG1heSBhbHJlYWR5IGhhdmUgYSBtYXBwaW5nIGJlY2F1
c2UgRE1BX0FUVFJfTk9fS0VSTkVMX01BUFBJTkcgaXMKPiBqdXN0IGEgc3VnZ2VzdGlvbiAob25s
eSAzMi1iaXQgQVJNIGltcGxlbWVudHMpIGFuZCB0aGVyZSdzIG5vdCBhIHdheQo+IHRvIHRlbGwg
aWYgeW91IGdvdCBhIG1hcHBpbmcgb3Igbm90LiBNYXliZSBpdCdzIG5vdCBhbGwgdGhhdCBpbXBv
cnRhbnQKPiBpZiB0aGVyZSBhcmUgMiBtYXBwaW5ncyBiZWNhdXNlIEkgdGhpbmsgb25seSBmYmNv
biBuZWVkcyBhIGtlcm5lbAo+IG1hcHBpbmcuCj4gCj4gTXkgZm9sbG93LXVwIHRvIHRoaXMgd2Fz
IGdvaW5nIHRvIGJlIGNvbnZlcnRpbmcgUm9ja2NoaXAgdG8gdXNlIENNQQo+IGFuZCB0aGUgc2ht
ZW0gaGVscGVycy4gU28gSSB3YXMgYWxyZWFkeSB3b25kZXJpbmcgYWJvdXQgd2hhdCB0byBkbwo+
IHdpdGggRE1BX0FUVFJfTk9fS0VSTkVMX01BUFBJTkcuIFRoZXJlJ3Mgc2V2ZXJhbCBkcml2ZXJz
IG5vdCB1c2luZyBDTUEKPiBqdXN0IHRvIHNldCBETUFfQVRUUl9OT19LRVJORUxfTUFQUElORy4g
U28gaXQgd291bGQgYmUgZ29vZCB0byBjb21lIHVwCj4gd2l0aCBhIHNvbHV0aW9uIGhlcmUuCj4g
CgpIZXJlJ3MgcGFydCBvZiBhIGRpc2N1c3Npb24gY29uY2VybmluZyB0aGUgbWVkaWF0ZWsgZHJp
dmVyIChjb3VsZG4ndApmaW5kIGl0IGluIHRoZSBkcmktZGV2ZWwgYXJjaGl2ZXMpOgoKUmU6IFtQ
QVRDSF0gZHJtL21lZGlhdGVrOiBBZGQgTVRLIEZyYW1lYnVmZmVyLURldmljZSAobXQ3NjIzKQoK
PiBPbiBGcmksIDIwMTktMDEtMTEgYXQgMTc6MDcgKzAxMDAsIE5vcmFsZiBUcsO4bm5lcyB3cm90
ZToKLi4uCj4gPiBUaGUgcHJvYmxlbSBoZXJlIGlzIHRoYXQgdGhpcyBkcml2ZXIgZG9lc24ndCBt
YXAgYSB2aXJ0dWFsIGFkZHJlc3MgZm9yCj4gPiBpdHMgYnVmZmVyczoKPiA+IAltdGtfZ2VtLT5k
bWFfYXR0cnMgfD0gRE1BX0FUVFJfTk9fS0VSTkVMX01BUFBJTkc7Cj4gPgo+ID4gUHJvYmFibHkg
YmVjYXVzZSBvZiBsaW1pdGVkIHZpcnR1YWwgYWRkcmVzcyBzcGFjZS4KPiA+IHJvY2tjaGlwIGlz
IGluIHRoZSBzYW1lIHNpdHVhdGlvbi4KPiA+Cj4gPiBJJ20gYXdhcmUgb2YgdGhpcyBzaG9ydGNv
bWluZyBvZiB0aGUgZ2VuZXJpYyBlbXVsYXRpb24sIGJ1dCBJIGRvbid0IHNlZQo+ID4gaG93IGl0
IGNhbiBiZSBzb2x2ZWQgd2l0aG91dCB1c2luZyBzb21la2luZCBvZiBmbGFnIGF0dGFjaGVkIHRv
IHRoZSBkdW1iCj4gPiBidWZmZXIgY3JlYXRpb24gcmVxdWVzdC4KPgo+IFRoZSB2aXJ0dWFsIGFk
ZHJlc3Mgc3BhY2UgaXMgbGltaXRlZCBzbyB3ZSBkbyBub3QgbWFwIGl0IGJ5IGRlZmF1bHQuIEkK
PiBhbHNvIHNlZSB0aGUgc2hvcnRjb21pbmcgb2YgdGhlIGdlbmVyaWMgZW11bGF0aW9uLCBzbyBJ
IHdvdWxkIHJlZmVyIHRvCj4gcm9ja2NoaXAgdG8gaW1wbGVtZW50IHRoaXMgbWFwcGluZy4KPgo+
IFJlZ2FyZHMsCj4gQ0sKCk5vcmFsZi4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
