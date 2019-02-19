Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AD1C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 02:58:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 729F421479
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 02:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HwQTbC4Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 729F421479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:From:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zGmJNQ8xQ5z2oPFJrOGdL3zoyZ2T0GeZGpdn7U47EoA=; b=HwQTbC4ZLhdZFP
	scY+SO13qZpj9ZvPcQA7dvhm8ou/TBBoRTBS9tDglhyYgJPp19PwIwXb9Kny1vEI8Kp5jB9OvdTXW
	zoiS6OTOJDt1OxPYfcR2V55s5+jITyXvKg+isRrZ6PBE0LCrgUPdTwFz4FHGbzNSu/6rFF/WUZrcA
	x65TewxvMBTUQojc3i99lXYmzh+Ybxu5m2riKtRN7KynfpkDHYfDTmKD6LSU5V+9mOE3B+ZLIwlu2
	y4kavDeGW6eIGyTa4wWWs7WzvYoiznJ0dXnjc7DQ8BHfVkeakpsF4M2ERNnZjUm7uM7mf8fjWnVjR
	Binj6PaqM+vLHZbI/WhA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvvbW-0006OK-AT; Tue, 19 Feb 2019 02:57:54 +0000
Received: from gateway23.websitewelcome.com ([192.185.50.141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvvbS-0006NY-DT
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 02:57:51 +0000
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
 by gateway23.websitewelcome.com (Postfix) with ESMTP id 428354AB2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 20:57:47 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22]) by cmsmtp with SMTP
 id vvbPgf58Z2PzOvvbPg84PS; Mon, 18 Feb 2019 20:57:47 -0600
X-Authority-Reason: nr=8
Received: from [189.250.119.20] (port=51730 helo=[192.168.1.76])
 by gator4166.hostgator.com with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.91)
 (envelope-from <gustavo@embeddedor.com>)
 id 1gvvbO-000B1C-M3; Mon, 18 Feb 2019 20:57:46 -0600
Subject: Re: [PATCH] can: mark expected switch fall-throughs
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Nicolas.Ferre@microchip.com, wg@grandegger.com, mkl@pengutronix.de,
 davem@davemloft.net, alexandre.belloni@bootlin.com,
 Ludovic.Desroches@microchip.com
References: <20190129180612.GA28650@embeddedor>
 <432a9399-95f4-e988-5cd2-93340f155fa1@microchip.com>
 <daae008e-35fd-7553-fcb2-7932fe53b959@embeddedor.com>
Openpgp: preference=signencrypt
Autocrypt: addr=gustavo@embeddedor.com; keydata=
 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
 VtSixD1uOgytAP7RWS474w==
Message-ID: <638c5b62-ac3e-21d3-4ac4-0fad0ef8d9e8@embeddedor.com>
Date: Mon, 18 Feb 2019 20:57:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <daae008e-35fd-7553-fcb2-7932fe53b959@embeddedor.com>
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
X-Exim-ID: 1gvvbO-000B1C-M3
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.76]) [189.250.119.20]:51730
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 19
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_185750_539104_8CE792B4 
X-CRM114-Status: GOOD (  15.57  )
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
Cc: Kees Cook <keescook@chromium.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-can@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGksCgpGcmllbmRseSBwaW5nOgoKRGF2ZSwgSSB3b25kZXIgaWYgeW91IGNhbiB0YWtlIHRoaXMu
CgpUaGFua3MKLS0KR3VzdGF2bwoKT24gMi8xNC8xOSAzOjM3IFBNLCBHdXN0YXZvIEEuIFIuIFNp
bHZhIHdyb3RlOgo+IAo+IAo+IE9uIDEvMzAvMTkgMjoxMSBBTSwgTmljb2xhcy5GZXJyZUBtaWNy
b2NoaXAuY29tIHdyb3RlOgo+PiBPbiAyOS8wMS8yMDE5IGF0IDE5OjA2LCBHdXN0YXZvIEEuIFIu
IFNpbHZhIHdyb3RlOgo+Pj4gSW4gcHJlcGFyYXRpb24gdG8gZW5hYmxpbmcgLVdpbXBsaWNpdC1m
YWxsdGhyb3VnaCwgbWFyayBzd2l0Y2ggY2FzZXMKPj4+IHdoZXJlIHdlIGFyZSBleHBlY3Rpbmcg
dG8gZmFsbCB0aHJvdWdoLgo+Pj4KPj4+IFRoaXMgcGF0Y2ggZml4ZXMgdGhlIGZvbGxvd2luZyB3
YXJuaW5nczoKPj4+Cj4+PiBkcml2ZXJzL25ldC9jYW4vcGVha19jYW5mZC9wZWFrX3BjaWVmZF9t
YWluLmM6NjY4OjM6IHdhcm5pbmc6IHRoaXMgc3RhdGVtZW50IG1heSBmYWxsIHRocm91Z2ggWy1X
aW1wbGljaXQtZmFsbHRocm91Z2g9XQo+Pj4gZHJpdmVycy9uZXQvY2FuL3NwaS9tY3AyNTF4LmM6
ODc1Ojc6IHdhcm5pbmc6IHRoaXMgc3RhdGVtZW50IG1heSBmYWxsIHRocm91Z2ggWy1XaW1wbGlj
aXQtZmFsbHRocm91Z2g9XQo+Pj4gZHJpdmVycy9uZXQvY2FuL3VzYi9wZWFrX3VzYi9wY2FuX3Vz
Yi5jOjQyMjo2OiB3YXJuaW5nOiB0aGlzIHN0YXRlbWVudCBtYXkgZmFsbCB0aHJvdWdoIFstV2lt
cGxpY2l0LWZhbGx0aHJvdWdoPV0KPj4+IGRyaXZlcnMvbmV0L2Nhbi9hdDkxX2Nhbi5jOjg5NTo2
OiB3YXJuaW5nOiB0aGlzIHN0YXRlbWVudCBtYXkgZmFsbCB0aHJvdWdoIFstV2ltcGxpY2l0LWZh
bGx0aHJvdWdoPV0KPj4+IGRyaXZlcnMvbmV0L2Nhbi9hdDkxX2Nhbi5jOjk1MzoxNTogd2Fybmlu
ZzogdGhpcyBzdGF0ZW1lbnQgbWF5IGZhbGwgdGhyb3VnaCBbLVdpbXBsaWNpdC1mYWxsdGhyb3Vn
aD1dCj4+PiBkcml2ZXJzL25ldC9jYW4vdXNiL3BlYWtfdXNiL3BjYW5fdXNiLmM6IEluIGZ1bmN0
aW9uIOKAmHBjYW5fdXNiX2RlY29kZV9lcnJvcuKAmToKPj4+IGRyaXZlcnMvbmV0L2Nhbi91c2Iv
cGVha191c2IvcGNhbl91c2IuYzo0MjI6Njogd2FybmluZzogdGhpcyBzdGF0ZW1lbnQgbWF5IGZh
bGwgdGhyb3VnaCBbLVdpbXBsaWNpdC1mYWxsdGhyb3VnaD1dCj4+PiAgICAgaWYgKG4gJiBQQ0FO
X1VTQl9FUlJPUl9CVVNfTElHSFQpIHsKPj4+ICAgICAgICBeCj4+PiBkcml2ZXJzL25ldC9jYW4v
dXNiL3BlYWtfdXNiL3BjYW5fdXNiLmM6NDI4OjI6IG5vdGU6IGhlcmUKPj4+ICAgIGNhc2UgQ0FO
X1NUQVRFX0VSUk9SX1dBUk5JTkc6Cj4+PiAgICBefn5+Cj4+Pgo+Pj4gV2FybmluZyBsZXZlbCAz
IHdhcyB1c2VkOiAtV2ltcGxpY2l0LWZhbGx0aHJvdWdoPTMKPj4+Cj4+PiBUaGlzIHBhdGNoIGlz
IHBhcnQgb2YgdGhlIG9uZ29pbmcgZWZmb3J0cyB0byBlbmFibGluZwo+Pj4gLVdpbXBsaWNpdC1m
YWxsdGhyb3VnaC4KPj4+Cj4+PiBOb3RpY2UgdGhhdCBpbiBzb21lIGNhc2VzIHNwZWxsaW5nIG1p
c3Rha2VzIHdlcmUgZml4ZWQuCj4+PiBJbiBvdGhlciBjYXNlcywgdGhlIC8qIGZhbGwgdGhyb3Vn
aCAqLyBjb21tZW50IGlzIHBsYWNlZAo+Pj4gYXQgdGhlIGJvdHRvbSBvZiB0aGUgY2FzZSBzdGF0
ZW1lbnQsIHdoaWNoIGlzIHdoYXQgR0NDCj4+PiBpcyBleHBlY3RpbmcgdG8gZmluZC4KPj4+Cj4+
PiBTaWduZWQtb2ZmLWJ5OiBHdXN0YXZvIEEuIFIuIFNpbHZhIDxndXN0YXZvQGVtYmVkZGVkb3Iu
Y29tPgo+Pj4gLS0tCj4+PiAgIGRyaXZlcnMvbmV0L2Nhbi9hdDkxX2Nhbi5jICAgICAgICAgICAg
ICAgICAgICB8IDYgKysrKy0tCj4+Cj4+IEZvciB0aGlzIG9uZToKPj4gQWNrZWQtYnk6IE5pY29s
YXMgRmVycmUgPG5pY29sYXMuZmVycmVAbWljcm9jaGlwLmNvbT4KPj4KPiAKPiBUaGFua3MsIE5p
Y29sYXMuCj4gCj4gRGF2ZToKPiAKPiBJIHdvbmRlciBpZiB5b3UgY2FuIHRha2UgdGhpcyBwYXRj
aC4KPiAKPiBUaGFua3MKPiAtLQo+IEd1c3Rhdm8KPiAKPj4+ICAgZHJpdmVycy9uZXQvY2FuL3Bl
YWtfY2FuZmQvcGVha19wY2llZmRfbWFpbi5jIHwgMiArLQo+Pj4gICBkcml2ZXJzL25ldC9jYW4v
c3BpL21jcDI1MXguYyAgICAgICAgICAgICAgICAgfCAzICsrLQo+Pj4gICBkcml2ZXJzL25ldC9j
YW4vdXNiL3BlYWtfdXNiL3BjYW5fdXNiLmMgICAgICAgfCAyICstCj4+PiAgIDQgZmlsZXMgY2hh
bmdlZCwgOCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQo+Pj4KPj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL25ldC9jYW4vYXQ5MV9jYW4uYyBiL2RyaXZlcnMvbmV0L2Nhbi9hdDkxX2Nhbi5j
Cj4+PiBpbmRleCBkOThjNjkwNDViMTcuLjE3MThjMjBmOWM5OSAxMDA2NDQKPj4+IC0tLSBhL2Ry
aXZlcnMvbmV0L2Nhbi9hdDkxX2Nhbi5jCj4+PiArKysgYi9kcml2ZXJzL25ldC9jYW4vYXQ5MV9j
YW4uYwo+Pj4gQEAgLTkwMiw3ICs5MDIsOCBAQCBzdGF0aWMgdm9pZCBhdDkxX2lycV9lcnJfc3Rh
dGUoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwKPj4+ICAgCQkJCUNBTl9FUlJfQ1JUTF9UWF9XQVJO
SU5HIDoKPj4+ICAgCQkJCUNBTl9FUlJfQ1JUTF9SWF9XQVJOSU5HOwo+Pj4gICAJCX0KPj4+IC0J
Y2FzZSBDQU5fU1RBVEVfRVJST1JfV0FSTklORzoJLyogZmFsbHRocm91Z2ggKi8KPj4+ICsJCS8q
IGZhbGwgdGhyb3VnaCAqLwo+Pj4gKwljYXNlIENBTl9TVEFURV9FUlJPUl9XQVJOSU5HOgo+Pj4g
ICAJCS8qCj4+PiAgIAkJICogZnJvbTogRVJST1JfQUNUSVZFLCBFUlJPUl9XQVJOSU5HCj4+PiAg
IAkJICogdG8gIDogRVJST1JfUEFTU0lWRSwgQlVTX09GRgo+Pj4gQEAgLTk1MSw3ICs5NTIsOCBA
QCBzdGF0aWMgdm9pZCBhdDkxX2lycV9lcnJfc3RhdGUoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwK
Pj4+ICAgCQluZXRkZXZfZGJnKGRldiwgIkVycm9yIEFjdGl2ZVxuIik7Cj4+PiAgIAkJY2YtPmNh
bl9pZCB8PSBDQU5fRVJSX1BST1Q7Cj4+PiAgIAkJY2YtPmRhdGFbMl0gPSBDQU5fRVJSX1BST1Rf
QUNUSVZFOwo+Pj4gLQljYXNlIENBTl9TVEFURV9FUlJPUl9XQVJOSU5HOgkvKiBmYWxsdGhyb3Vn
aCAqLwo+Pj4gKwkJLyogZmFsbCB0aHJvdWdoICovCj4+PiArCWNhc2UgQ0FOX1NUQVRFX0VSUk9S
X1dBUk5JTkc6Cj4+PiAgIAkJcmVnX2lkciA9IEFUOTFfSVJRX0VSUkEgfCBBVDkxX0lSUV9XQVJO
IHwgQVQ5MV9JUlFfQk9GRjsKPj4+ICAgCQlyZWdfaWVyID0gQVQ5MV9JUlFfRVJSUDsKPj4+ICAg
CQlicmVhazsKPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9jYW4vcGVha19jYW5mZC9wZWFr
X3BjaWVmZF9tYWluLmMgYi9kcml2ZXJzL25ldC9jYW4vcGVha19jYW5mZC9wZWFrX3BjaWVmZF9t
YWluLmMKPj4+IGluZGV4IGM0NThkNWZkYzhkMy4uZTRmNGQ2NWE3NmI0IDEwMDY0NAo+Pj4gLS0t
IGEvZHJpdmVycy9uZXQvY2FuL3BlYWtfY2FuZmQvcGVha19wY2llZmRfbWFpbi5jCj4+PiArKysg
Yi9kcml2ZXJzL25ldC9jYW4vcGVha19jYW5mZC9wZWFrX3BjaWVmZF9tYWluLmMKPj4+IEBAIC02
NjgsNyArNjY4LDcgQEAgc3RhdGljIGludCBwY2llZmRfY2FuX3Byb2JlKHN0cnVjdCBwY2llZmRf
Ym9hcmQgKnBjaWVmZCkKPj4+ICAgCQlwY2llZmRfY2FuX3dyaXRlcmVnKHByaXYsIENBTkZEX0NM
S19TRUxfODBNSFosCj4+PiAgIAkJCQkgICAgUENJRUZEX1JFR19DQU5fQ0xLX1NFTCk7Cj4+PiAg
IAo+Pj4gLQkJLyogZmFsbHRob3VnaCAqLwo+Pj4gKwkJLyogZmFsbCB0aHJvdWdoICovCj4+PiAg
IAljYXNlIENBTkZEX0NMS19TRUxfODBNSFo6Cj4+PiAgIAkJcHJpdi0+dWNhbi5jYW4uY2xvY2su
ZnJlcSA9IDgwICogMTAwMCAqIDEwMDA7Cj4+PiAgIAkJYnJlYWs7Cj4+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9uZXQvY2FuL3NwaS9tY3AyNTF4LmMgYi9kcml2ZXJzL25ldC9jYW4vc3BpL21jcDI1
MXguYwo+Pj4gaW5kZXggZTkwODE3NjA4NjQ1Li4xNzI1N2M3M2MzMDIgMTAwNjQ0Cj4+PiAtLS0g
YS9kcml2ZXJzL25ldC9jYW4vc3BpL21jcDI1MXguYwo+Pj4gKysrIGIvZHJpdmVycy9uZXQvY2Fu
L3NwaS9tY3AyNTF4LmMKPj4+IEBAIC04NzUsNyArODc1LDggQEAgc3RhdGljIGlycXJldHVybl90
IG1jcDI1MXhfY2FuX2lzdChpbnQgaXJxLCB2b2lkICpkZXZfaWQpCj4+PiAgIAkJCWlmIChuZXdf
c3RhdGUgPj0gQ0FOX1NUQVRFX0VSUk9SX1dBUk5JTkcgJiYKPj4+ICAgCQkJICAgIG5ld19zdGF0
ZSA8PSBDQU5fU1RBVEVfQlVTX09GRikKPj4+ICAgCQkJCXByaXYtPmNhbi5jYW5fc3RhdHMuZXJy
b3Jfd2FybmluZysrOwo+Pj4gLQkJY2FzZSBDQU5fU1RBVEVfRVJST1JfV0FSTklORzoJLyogZmFs
bHRocm91Z2ggKi8KPj4+ICsJCQkvKiBmYWxsIHRocm91Z2ggKi8KPj4+ICsJCWNhc2UgQ0FOX1NU
QVRFX0VSUk9SX1dBUk5JTkc6Cj4+PiAgIAkJCWlmIChuZXdfc3RhdGUgPj0gQ0FOX1NUQVRFX0VS
Uk9SX1BBU1NJVkUgJiYKPj4+ICAgCQkJICAgIG5ld19zdGF0ZSA8PSBDQU5fU1RBVEVfQlVTX09G
RikKPj4+ICAgCQkJCXByaXYtPmNhbi5jYW5fc3RhdHMuZXJyb3JfcGFzc2l2ZSsrOwo+Pj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2Nhbi91c2IvcGVha191c2IvcGNhbl91c2IuYyBiL2RyaXZl
cnMvbmV0L2Nhbi91c2IvcGVha191c2IvcGNhbl91c2IuYwo+Pj4gaW5kZXggMTMyMzhhNzJhMzM4
Li5lY2E3ODU1MzJiNmIgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL25ldC9jYW4vdXNiL3BlYWtf
dXNiL3BjYW5fdXNiLmMKPj4+ICsrKyBiL2RyaXZlcnMvbmV0L2Nhbi91c2IvcGVha191c2IvcGNh
bl91c2IuYwo+Pj4gQEAgLTQyMyw3ICs0MjMsNyBAQCBzdGF0aWMgaW50IHBjYW5fdXNiX2RlY29k
ZV9lcnJvcihzdHJ1Y3QgcGNhbl91c2JfbXNnX2NvbnRleHQgKm1jLCB1OCBuLAo+Pj4gICAJCQlu
ZXdfc3RhdGUgPSBDQU5fU1RBVEVfRVJST1JfV0FSTklORzsKPj4+ICAgCQkJYnJlYWs7Cj4+PiAg
IAkJfQo+Pj4gLQkJLyogZWxzZTogZmFsbCB0aHJvdWdoICovCj4+PiArCQkvKiBmYWxsIHRocm91
Z2ggKi8KPj4+ICAgCj4+PiAgIAljYXNlIENBTl9TVEFURV9FUlJPUl9XQVJOSU5HOgo+Pj4gICAJ
CWlmIChuICYgUENBTl9VU0JfRVJST1JfQlVTX0hFQVZZKSB7Cj4+Pgo+Pgo+PgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBt
YWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
