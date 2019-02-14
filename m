Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19158C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:04:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCDDA218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eNH3zgP+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCDDA218D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:Subject:From:References:To:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ikFdodm5ggVrwfPSofyeCpZfiQs/4UnMAAyqhZ7QAB8=; b=eNH3zgP+vMXiC8
	/rkpV29gzhzvJpQzZ6+nX656z6w7EwWHQiT7hNJtw8xo+zrJNJQGeiSeffgSIdEs8i5Qte0W2fVVp
	6uSgUKI9vOVhEItBmw8RiR/e2DzJGdcFg+rwwzeWVBOOS6Q29JQRR0E7HVPCyOurWqjKdgM56x7RV
	Xy4Q2nKhYUd7z9nTVAdMSchx2eYa+h1OST091cFYrtijE1a7lZNiY0U3q6j/LqUhhdlJ3+1IQNMnf
	dNSRKjiYNKyyQ/3Ak11qc6sg3/QFGA/4F3zvlUK3dUw0OdBMv+ieeDEy6z2OhzkJaImb8vIlpCrnL
	Vt5/oahWryVcmRhSMyTg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guQ38-0000zs-Ps; Thu, 14 Feb 2019 23:04:10 +0000
Received: from gateway23.websitewelcome.com ([192.185.50.120])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guQ36-0000zO-8F
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 23:04:09 +0000
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
 by gateway23.websitewelcome.com (Postfix) with ESMTP id E71CBBADB
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 17:04:06 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22]) by cmsmtp with SMTP
 id uQ34gPNSvdnCeuQ34gO6Es; Thu, 14 Feb 2019 17:04:06 -0600
X-Authority-Reason: nr=8
Received: from [189.250.119.20] (port=46938 helo=[192.168.1.76])
 by gator4166.hostgator.com with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.91)
 (envelope-from <gustavo@embeddedor.com>)
 id 1guQ33-001d8J-QB; Thu, 14 Feb 2019 17:04:05 -0600
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
References: <20190129180612.GA28650@embeddedor>
 <432a9399-95f4-e988-5cd2-93340f155fa1@microchip.com>
 <daae008e-35fd-7553-fcb2-7932fe53b959@embeddedor.com>
 <20190214221703.GQ10129@piout.net>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Openpgp: preference=signencrypt
Autocrypt: addr=gustavo@embeddedor.com; keydata=
 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
 VtSixD1uOgytAP7RWS474w==
Subject: Re: [PATCH] can: mark expected switch fall-throughs
Message-ID: <a8e53868-2b13-b050-7714-e3e24d18cf00@embeddedor.com>
Date: Thu, 14 Feb 2019 17:04:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190214221703.GQ10129@piout.net>
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.infradead.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.119.20
X-Source-L: No
X-Exim-ID: 1guQ33-001d8J-QB
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.76]) [189.250.119.20]:46938
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 9
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_150408_372522_8FF9FCD5 
X-CRM114-Status: GOOD (  18.97  )
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
Cc: linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
 netdev@vger.kernel.org, linux-can@vger.kernel.org,
 Ludovic.Desroches@microchip.com, mkl@pengutronix.de,
 linux-arm-kernel@lists.infradead.org, davem@davemloft.net, wg@grandegger.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

CgpPbiAyLzE0LzE5IDQ6MTcgUE0sIEFsZXhhbmRyZSBCZWxsb25pIHdyb3RlOgo+IEhpLAo+IAo+
IE9uIDE0LzAyLzIwMTkgMTU6Mzc6MjYtMDYwMCwgR3VzdGF2byBBLiBSLiBTaWx2YSB3cm90ZToK
Pj4KPj4KPj4gT24gMS8zMC8xOSAyOjExIEFNLCBOaWNvbGFzLkZlcnJlQG1pY3JvY2hpcC5jb20g
d3JvdGU6Cj4+PiBPbiAyOS8wMS8yMDE5IGF0IDE5OjA2LCBHdXN0YXZvIEEuIFIuIFNpbHZhIHdy
b3RlOgo+Pj4+IEluIHByZXBhcmF0aW9uIHRvIGVuYWJsaW5nIC1XaW1wbGljaXQtZmFsbHRocm91
Z2gsIG1hcmsgc3dpdGNoIGNhc2VzCj4+Pj4gd2hlcmUgd2UgYXJlIGV4cGVjdGluZyB0byBmYWxs
IHRocm91Z2guCj4+Pj4KPj4+PiBUaGlzIHBhdGNoIGZpeGVzIHRoZSBmb2xsb3dpbmcgd2Fybmlu
Z3M6Cj4+Pj4KPj4+PiBkcml2ZXJzL25ldC9jYW4vcGVha19jYW5mZC9wZWFrX3BjaWVmZF9tYWlu
LmM6NjY4OjM6IHdhcm5pbmc6IHRoaXMgc3RhdGVtZW50IG1heSBmYWxsIHRocm91Z2ggWy1XaW1w
bGljaXQtZmFsbHRocm91Z2g9XQo+Pj4+IGRyaXZlcnMvbmV0L2Nhbi9zcGkvbWNwMjUxeC5jOjg3
NTo3OiB3YXJuaW5nOiB0aGlzIHN0YXRlbWVudCBtYXkgZmFsbCB0aHJvdWdoIFstV2ltcGxpY2l0
LWZhbGx0aHJvdWdoPV0KPj4+PiBkcml2ZXJzL25ldC9jYW4vdXNiL3BlYWtfdXNiL3BjYW5fdXNi
LmM6NDIyOjY6IHdhcm5pbmc6IHRoaXMgc3RhdGVtZW50IG1heSBmYWxsIHRocm91Z2ggWy1XaW1w
bGljaXQtZmFsbHRocm91Z2g9XQo+Pj4+IGRyaXZlcnMvbmV0L2Nhbi9hdDkxX2Nhbi5jOjg5NTo2
OiB3YXJuaW5nOiB0aGlzIHN0YXRlbWVudCBtYXkgZmFsbCB0aHJvdWdoIFstV2ltcGxpY2l0LWZh
bGx0aHJvdWdoPV0KPj4+PiBkcml2ZXJzL25ldC9jYW4vYXQ5MV9jYW4uYzo5NTM6MTU6IHdhcm5p
bmc6IHRoaXMgc3RhdGVtZW50IG1heSBmYWxsIHRocm91Z2ggWy1XaW1wbGljaXQtZmFsbHRocm91
Z2g9XQo+Pj4+IGRyaXZlcnMvbmV0L2Nhbi91c2IvcGVha191c2IvcGNhbl91c2IuYzogSW4gZnVu
Y3Rpb24g4oCYcGNhbl91c2JfZGVjb2RlX2Vycm9y4oCZOgo+Pj4+IGRyaXZlcnMvbmV0L2Nhbi91
c2IvcGVha191c2IvcGNhbl91c2IuYzo0MjI6Njogd2FybmluZzogdGhpcyBzdGF0ZW1lbnQgbWF5
IGZhbGwgdGhyb3VnaCBbLVdpbXBsaWNpdC1mYWxsdGhyb3VnaD1dCj4+Pj4gICAgIGlmIChuICYg
UENBTl9VU0JfRVJST1JfQlVTX0xJR0hUKSB7Cj4+Pj4gICAgICAgIF4KPj4+PiBkcml2ZXJzL25l
dC9jYW4vdXNiL3BlYWtfdXNiL3BjYW5fdXNiLmM6NDI4OjI6IG5vdGU6IGhlcmUKPj4+PiAgICBj
YXNlIENBTl9TVEFURV9FUlJPUl9XQVJOSU5HOgo+Pj4+ICAgIF5+fn4KPj4+Pgo+Pj4+IFdhcm5p
bmcgbGV2ZWwgMyB3YXMgdXNlZDogLVdpbXBsaWNpdC1mYWxsdGhyb3VnaD0zCj4+Pj4KPj4+PiBU
aGlzIHBhdGNoIGlzIHBhcnQgb2YgdGhlIG9uZ29pbmcgZWZmb3J0cyB0byBlbmFibGluZwo+Pj4+
IC1XaW1wbGljaXQtZmFsbHRocm91Z2guCj4+Pj4KPj4+PiBOb3RpY2UgdGhhdCBpbiBzb21lIGNh
c2VzIHNwZWxsaW5nIG1pc3Rha2VzIHdlcmUgZml4ZWQuCj4+Pj4gSW4gb3RoZXIgY2FzZXMsIHRo
ZSAvKiBmYWxsIHRocm91Z2ggKi8gY29tbWVudCBpcyBwbGFjZWQKPj4+PiBhdCB0aGUgYm90dG9t
IG9mIHRoZSBjYXNlIHN0YXRlbWVudCwgd2hpY2ggaXMgd2hhdCBHQ0MKPj4+PiBpcyBleHBlY3Rp
bmcgdG8gZmluZC4KPj4+Pgo+Pj4+IFNpZ25lZC1vZmYtYnk6IEd1c3Rhdm8gQS4gUi4gU2lsdmEg
PGd1c3Rhdm9AZW1iZWRkZWRvci5jb20+Cj4+Pj4gLS0tCj4+Pj4gICBkcml2ZXJzL25ldC9jYW4v
YXQ5MV9jYW4uYyAgICAgICAgICAgICAgICAgICAgfCA2ICsrKystLQo+Pj4KPj4+IEZvciB0aGlz
IG9uZToKPj4+IEFja2VkLWJ5OiBOaWNvbGFzIEZlcnJlIDxuaWNvbGFzLmZlcnJlQG1pY3JvY2hp
cC5jb20+Cj4+Pgo+Pgo+PiBUaGFua3MsIE5pY29sYXMuCj4+Cj4gCj4gSSB0aG91Z2ggSSBoYWQg
YSBkw6lqw6AgdnUgYnV0IHlvdSBhY3R1YWxseSBzZW50IHRoZSBhdDkxIHBhcnQgdHdpY2UuCj4g
CgpJdCB3YXNuJ3QgaW50ZW50aW9uYWwuCgo+PiBEYXZlOgo+Pgo+PiBJIHdvbmRlciBpZiB5b3Ug
Y2FuIHRha2UgdGhpcyBwYXRjaC4KPj4KPj4gVGhhbmtzCj4+IC0tCj4+IEd1c3Rhdm8KPj4KPj4+
PiAgIGRyaXZlcnMvbmV0L2Nhbi9wZWFrX2NhbmZkL3BlYWtfcGNpZWZkX21haW4uYyB8IDIgKy0K
Pj4+PiAgIGRyaXZlcnMvbmV0L2Nhbi9zcGkvbWNwMjUxeC5jICAgICAgICAgICAgICAgICB8IDMg
KystCj4+Pj4gICBkcml2ZXJzL25ldC9jYW4vdXNiL3BlYWtfdXNiL3BjYW5fdXNiLmMgICAgICAg
fCAyICstCj4+Pj4gICA0IGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlv
bnMoLSkKPj4+Pgo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9jYW4vYXQ5MV9jYW4uYyBi
L2RyaXZlcnMvbmV0L2Nhbi9hdDkxX2Nhbi5jCj4+Pj4gaW5kZXggZDk4YzY5MDQ1YjE3Li4xNzE4
YzIwZjljOTkgMTAwNjQ0Cj4+Pj4gLS0tIGEvZHJpdmVycy9uZXQvY2FuL2F0OTFfY2FuLmMKPj4+
PiArKysgYi9kcml2ZXJzL25ldC9jYW4vYXQ5MV9jYW4uYwo+Pj4+IEBAIC05MDIsNyArOTAyLDgg
QEAgc3RhdGljIHZvaWQgYXQ5MV9pcnFfZXJyX3N0YXRlKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYs
Cj4+Pj4gICAJCQkJQ0FOX0VSUl9DUlRMX1RYX1dBUk5JTkcgOgo+Pj4+ICAgCQkJCUNBTl9FUlJf
Q1JUTF9SWF9XQVJOSU5HOwo+Pj4+ICAgCQl9Cj4+Pj4gLQljYXNlIENBTl9TVEFURV9FUlJPUl9X
QVJOSU5HOgkvKiBmYWxsdGhyb3VnaCAqLwo+Pj4+ICsJCS8qIGZhbGwgdGhyb3VnaCAqLwo+Pj4+
ICsJY2FzZSBDQU5fU1RBVEVfRVJST1JfV0FSTklORzoKPj4+PiAgIAkJLyoKPj4+PiAgIAkJICog
ZnJvbTogRVJST1JfQUNUSVZFLCBFUlJPUl9XQVJOSU5HCj4+Pj4gICAJCSAqIHRvICA6IEVSUk9S
X1BBU1NJVkUsIEJVU19PRkYKPj4+PiBAQCAtOTUxLDcgKzk1Miw4IEBAIHN0YXRpYyB2b2lkIGF0
OTFfaXJxX2Vycl9zdGF0ZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAo+Pj4+ICAgCQluZXRkZXZf
ZGJnKGRldiwgIkVycm9yIEFjdGl2ZVxuIik7Cj4+Pj4gICAJCWNmLT5jYW5faWQgfD0gQ0FOX0VS
Ul9QUk9UOwo+Pj4+ICAgCQljZi0+ZGF0YVsyXSA9IENBTl9FUlJfUFJPVF9BQ1RJVkU7Cj4+Pj4g
LQljYXNlIENBTl9TVEFURV9FUlJPUl9XQVJOSU5HOgkvKiBmYWxsdGhyb3VnaCAqLwo+IAo+IFNl
cmlvdXNseSwgZm9yIHRoYXQgb25lLCB5b3Ugc2hvdWxkIGZpeCB0aGUgY29tcGlsZXIuIFRoZSBm
YWxsIHRocm91Z2gKCkknbGwgcGFzcyB5b3VyIGZlZWRiYWNrIG9uIHRvIHRoZSBHQ0MgZ3V5cy4K
Cj4gaXMgbm90IGltcGxpY2l0LCBpdCBpcyBhY3R1YWxseSBxdWl0ZSBleHBsaWNpdCBhbmQgdGhl
IHdhcm5pbmcgaXMgc2ltcGx5Cj4gd3JvbmcuCj4gCj4gQWxzbywgdGhlIGdjYyBkb2N1bWVudGF0
aW9uIHNheXMgdGhhdCAtV2ltcGxpY2l0LWZhbGx0aHJvdWdoPTMKPiByZWNvZ25pemVzIC8qIGZh
bGx0aHJvdWdoICovIGFzIGEgcHJvcGVyIGZhbGwgdGhyb3VnaCBjb21tZW50IChhbmQgSQo+IHRl
c3RlZCB3aXRoIGdjYyA4LjIpLgo+IAoKWWVhaC4gQnV0IHRoYXQncyBub3QgdGhlIHJlbGV2YW50
IGNoYW5nZSBpbiB0aGlzIGNhc2UuICBOb3RpY2UgdGhhdCB0aGUKY29tbWVudCB3YXMgbW92ZWQg
dG8gdGhlIHZlcnkgYm90dG9tIG9mIHRoZSBwcmV2aW91cyBjYXNlLgoKVGhhbmtzCi0tCkd1c3Rh
dm8KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4
LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFy
bS1rZXJuZWwK
