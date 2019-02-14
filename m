Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4ABC4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:15:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF9792229F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LpbcvmEH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF9792229F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=whzizC/yB0NUXbOkUt2kBJVm1dGUYA83PpuZ4WXZmVk=; b=LpbcvmEHJltkPQ
	kwEI1Zf153xbFoInh0PPyE7u+Ds0OxQ5diSgjbBeBUPPRdiokZBj0s1ZIqjpMhwvv56BH6/vp+UK+
	0veP9imhIPYfZKdM63y8d5J41pQyzWg2LN56X/VQLjKPLRn89RuRyfye2C63vCWg9Nxygh9EAHm4m
	sOfA1tEXPFcw9/ABhlWZCZLTso2hRZfYNrhibnha5hgGGcHDSUvUcgVl0K/7cwAoneCsGvwR1heRA
	ZVDarBxZL6bnh25qqH51x3VWCdH3bmvc2cE9rP3lls/ZFV3Uk6fZbnMd+tAHArPbUa7FakGVMJdRD
	CQNlxGNmamVasvA3+vZw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guQE2-00078Z-UJ; Thu, 14 Feb 2019 23:15:26 +0000
Received: from gateway23.websitewelcome.com ([192.185.48.251])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guQDz-000740-4d
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 23:15:24 +0000
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
 by gateway23.websitewelcome.com (Postfix) with ESMTP id 5C9FD109F5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 17:15:21 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22]) by cmsmtp with SMTP
 id uQDxgMdVuYTGMuQDxgfxAm; Thu, 14 Feb 2019 17:15:21 -0600
X-Authority-Reason: nr=8
Received: from [189.250.119.20] (port=48102 helo=[192.168.1.76])
 by gator4166.hostgator.com with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.91)
 (envelope-from <gustavo@embeddedor.com>)
 id 1guQCk-001i4x-Go; Thu, 14 Feb 2019 17:15:20 -0600
Subject: Re: [PATCH] can: mark expected switch fall-throughs
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
References: <20190129180612.GA28650@embeddedor>
 <432a9399-95f4-e988-5cd2-93340f155fa1@microchip.com>
 <daae008e-35fd-7553-fcb2-7932fe53b959@embeddedor.com>
 <20190214221703.GQ10129@piout.net>
 <a8e53868-2b13-b050-7714-e3e24d18cf00@embeddedor.com>
 <20190214230756.GR10129@piout.net>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Openpgp: preference=signencrypt
Autocrypt: addr=gustavo@embeddedor.com; keydata=
 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
 VtSixD1uOgytAP7RWS474w==
Message-ID: <c597ac66-e79d-50e4-6906-923bd18834e9@embeddedor.com>
Date: Thu, 14 Feb 2019 17:14:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190214230756.GR10129@piout.net>
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
X-Exim-ID: 1guQCk-001i4x-Go
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.76]) [189.250.119.20]:48102
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 28
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_151523_263856_37FB075F 
X-CRM114-Status: GOOD (  17.12  )
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

CgpPbiAyLzE0LzE5IDU6MDcgUE0sIEFsZXhhbmRyZSBCZWxsb25pIHdyb3RlOgo+IE9uIDE0LzAy
LzIwMTkgMTc6MDQ6MDMtMDYwMCwgR3VzdGF2byBBLiBSLiBTaWx2YSB3cm90ZToKPj4KPj4KPj4g
T24gMi8xNC8xOSA0OjE3IFBNLCBBbGV4YW5kcmUgQmVsbG9uaSB3cm90ZToKPj4+IEhpLAo+Pj4K
Pj4+IE9uIDE0LzAyLzIwMTkgMTU6Mzc6MjYtMDYwMCwgR3VzdGF2byBBLiBSLiBTaWx2YSB3cm90
ZToKPj4+Pgo+Pj4+Cj4+Pj4gT24gMS8zMC8xOSAyOjExIEFNLCBOaWNvbGFzLkZlcnJlQG1pY3Jv
Y2hpcC5jb20gd3JvdGU6Cj4+Pj4+IE9uIDI5LzAxLzIwMTkgYXQgMTk6MDYsIEd1c3Rhdm8gQS4g
Ui4gU2lsdmEgd3JvdGU6Cj4+Pj4+PiBJbiBwcmVwYXJhdGlvbiB0byBlbmFibGluZyAtV2ltcGxp
Y2l0LWZhbGx0aHJvdWdoLCBtYXJrIHN3aXRjaCBjYXNlcwo+Pj4+Pj4gd2hlcmUgd2UgYXJlIGV4
cGVjdGluZyB0byBmYWxsIHRocm91Z2guCj4+Pj4+Pgo+Pj4+Pj4gVGhpcyBwYXRjaCBmaXhlcyB0
aGUgZm9sbG93aW5nIHdhcm5pbmdzOgo+Pj4+Pj4KPj4+Pj4+IGRyaXZlcnMvbmV0L2Nhbi9wZWFr
X2NhbmZkL3BlYWtfcGNpZWZkX21haW4uYzo2Njg6Mzogd2FybmluZzogdGhpcyBzdGF0ZW1lbnQg
bWF5IGZhbGwgdGhyb3VnaCBbLVdpbXBsaWNpdC1mYWxsdGhyb3VnaD1dCj4+Pj4+PiBkcml2ZXJz
L25ldC9jYW4vc3BpL21jcDI1MXguYzo4NzU6Nzogd2FybmluZzogdGhpcyBzdGF0ZW1lbnQgbWF5
IGZhbGwgdGhyb3VnaCBbLVdpbXBsaWNpdC1mYWxsdGhyb3VnaD1dCj4+Pj4+PiBkcml2ZXJzL25l
dC9jYW4vdXNiL3BlYWtfdXNiL3BjYW5fdXNiLmM6NDIyOjY6IHdhcm5pbmc6IHRoaXMgc3RhdGVt
ZW50IG1heSBmYWxsIHRocm91Z2ggWy1XaW1wbGljaXQtZmFsbHRocm91Z2g9XQo+Pj4+Pj4gZHJp
dmVycy9uZXQvY2FuL2F0OTFfY2FuLmM6ODk1OjY6IHdhcm5pbmc6IHRoaXMgc3RhdGVtZW50IG1h
eSBmYWxsIHRocm91Z2ggWy1XaW1wbGljaXQtZmFsbHRocm91Z2g9XQo+Pj4+Pj4gZHJpdmVycy9u
ZXQvY2FuL2F0OTFfY2FuLmM6OTUzOjE1OiB3YXJuaW5nOiB0aGlzIHN0YXRlbWVudCBtYXkgZmFs
bCB0aHJvdWdoIFstV2ltcGxpY2l0LWZhbGx0aHJvdWdoPV0KPj4+Pj4+IGRyaXZlcnMvbmV0L2Nh
bi91c2IvcGVha191c2IvcGNhbl91c2IuYzogSW4gZnVuY3Rpb24g4oCYcGNhbl91c2JfZGVjb2Rl
X2Vycm9y4oCZOgo+Pj4+Pj4gZHJpdmVycy9uZXQvY2FuL3VzYi9wZWFrX3VzYi9wY2FuX3VzYi5j
OjQyMjo2OiB3YXJuaW5nOiB0aGlzIHN0YXRlbWVudCBtYXkgZmFsbCB0aHJvdWdoIFstV2ltcGxp
Y2l0LWZhbGx0aHJvdWdoPV0KPj4+Pj4+ICAgICBpZiAobiAmIFBDQU5fVVNCX0VSUk9SX0JVU19M
SUdIVCkgewo+Pj4+Pj4gICAgICAgIF4KPj4+Pj4+IGRyaXZlcnMvbmV0L2Nhbi91c2IvcGVha191
c2IvcGNhbl91c2IuYzo0Mjg6Mjogbm90ZTogaGVyZQo+Pj4+Pj4gICAgY2FzZSBDQU5fU1RBVEVf
RVJST1JfV0FSTklORzoKPj4+Pj4+ICAgIF5+fn4KPj4+Pj4+Cj4+Pj4+PiBXYXJuaW5nIGxldmVs
IDMgd2FzIHVzZWQ6IC1XaW1wbGljaXQtZmFsbHRocm91Z2g9Mwo+Pj4+Pj4KPj4+Pj4+IFRoaXMg
cGF0Y2ggaXMgcGFydCBvZiB0aGUgb25nb2luZyBlZmZvcnRzIHRvIGVuYWJsaW5nCj4+Pj4+PiAt
V2ltcGxpY2l0LWZhbGx0aHJvdWdoLgo+Pj4+Pj4KPj4+Pj4+IE5vdGljZSB0aGF0IGluIHNvbWUg
Y2FzZXMgc3BlbGxpbmcgbWlzdGFrZXMgd2VyZSBmaXhlZC4KPj4+Pj4+IEluIG90aGVyIGNhc2Vz
LCB0aGUgLyogZmFsbCB0aHJvdWdoICovIGNvbW1lbnQgaXMgcGxhY2VkCj4+Pj4+PiBhdCB0aGUg
Ym90dG9tIG9mIHRoZSBjYXNlIHN0YXRlbWVudCwgd2hpY2ggaXMgd2hhdCBHQ0MKPj4+Pj4+IGlz
IGV4cGVjdGluZyB0byBmaW5kLgo+Pj4+Pj4KPj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEd1c3Rhdm8g
QS4gUi4gU2lsdmEgPGd1c3Rhdm9AZW1iZWRkZWRvci5jb20+Cj4+Pj4+PiAtLS0KPj4+Pj4+ICAg
ZHJpdmVycy9uZXQvY2FuL2F0OTFfY2FuLmMgICAgICAgICAgICAgICAgICAgIHwgNiArKysrLS0K
Pj4+Pj4KPj4+Pj4gRm9yIHRoaXMgb25lOgo+Pj4+PiBBY2tlZC1ieTogTmljb2xhcyBGZXJyZSA8
bmljb2xhcy5mZXJyZUBtaWNyb2NoaXAuY29tPgo+Pj4+Pgo+Pj4+Cj4+Pj4gVGhhbmtzLCBOaWNv
bGFzLgo+Pj4+Cj4+Pgo+Pj4gSSB0aG91Z2ggSSBoYWQgYSBkw6lqw6AgdnUgYnV0IHlvdSBhY3R1
YWxseSBzZW50IHRoZSBhdDkxIHBhcnQgdHdpY2UuCj4+Pgo+Pgo+PiBJdCB3YXNuJ3QgaW50ZW50
aW9uYWwuCj4+Cj4+Pj4gRGF2ZToKPj4+Pgo+Pj4+IEkgd29uZGVyIGlmIHlvdSBjYW4gdGFrZSB0
aGlzIHBhdGNoLgo+Pj4+Cj4+Pj4gVGhhbmtzCj4+Pj4gLS0KPj4+PiBHdXN0YXZvCj4+Pj4KPj4+
Pj4+ICAgZHJpdmVycy9uZXQvY2FuL3BlYWtfY2FuZmQvcGVha19wY2llZmRfbWFpbi5jIHwgMiAr
LQo+Pj4+Pj4gICBkcml2ZXJzL25ldC9jYW4vc3BpL21jcDI1MXguYyAgICAgICAgICAgICAgICAg
fCAzICsrLQo+Pj4+Pj4gICBkcml2ZXJzL25ldC9jYW4vdXNiL3BlYWtfdXNiL3BjYW5fdXNiLmMg
ICAgICAgfCAyICstCj4+Pj4+PiAgIDQgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA1
IGRlbGV0aW9ucygtKQo+Pj4+Pj4KPj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9jYW4v
YXQ5MV9jYW4uYyBiL2RyaXZlcnMvbmV0L2Nhbi9hdDkxX2Nhbi5jCj4+Pj4+PiBpbmRleCBkOThj
NjkwNDViMTcuLjE3MThjMjBmOWM5OSAxMDA2NDQKPj4+Pj4+IC0tLSBhL2RyaXZlcnMvbmV0L2Nh
bi9hdDkxX2Nhbi5jCj4+Pj4+PiArKysgYi9kcml2ZXJzL25ldC9jYW4vYXQ5MV9jYW4uYwo+Pj4+
Pj4gQEAgLTkwMiw3ICs5MDIsOCBAQCBzdGF0aWMgdm9pZCBhdDkxX2lycV9lcnJfc3RhdGUoc3Ry
dWN0IG5ldF9kZXZpY2UgKmRldiwKPj4+Pj4+ICAgCQkJCUNBTl9FUlJfQ1JUTF9UWF9XQVJOSU5H
IDoKPj4+Pj4+ICAgCQkJCUNBTl9FUlJfQ1JUTF9SWF9XQVJOSU5HOwo+Pj4+Pj4gICAJCX0KPj4+
Pj4+IC0JY2FzZSBDQU5fU1RBVEVfRVJST1JfV0FSTklORzoJLyogZmFsbHRocm91Z2ggKi8KPj4+
Pj4+ICsJCS8qIGZhbGwgdGhyb3VnaCAqLwo+Pj4+Pj4gKwljYXNlIENBTl9TVEFURV9FUlJPUl9X
QVJOSU5HOgo+Pj4+Pj4gICAJCS8qCj4+Pj4+PiAgIAkJICogZnJvbTogRVJST1JfQUNUSVZFLCBF
UlJPUl9XQVJOSU5HCj4+Pj4+PiAgIAkJICogdG8gIDogRVJST1JfUEFTU0lWRSwgQlVTX09GRgo+
Pj4+Pj4gQEAgLTk1MSw3ICs5NTIsOCBAQCBzdGF0aWMgdm9pZCBhdDkxX2lycV9lcnJfc3RhdGUo
c3RydWN0IG5ldF9kZXZpY2UgKmRldiwKPj4+Pj4+ICAgCQluZXRkZXZfZGJnKGRldiwgIkVycm9y
IEFjdGl2ZVxuIik7Cj4+Pj4+PiAgIAkJY2YtPmNhbl9pZCB8PSBDQU5fRVJSX1BST1Q7Cj4+Pj4+
PiAgIAkJY2YtPmRhdGFbMl0gPSBDQU5fRVJSX1BST1RfQUNUSVZFOwo+Pj4+Pj4gLQljYXNlIENB
Tl9TVEFURV9FUlJPUl9XQVJOSU5HOgkvKiBmYWxsdGhyb3VnaCAqLwo+Pj4KPj4+IFNlcmlvdXNs
eSwgZm9yIHRoYXQgb25lLCB5b3Ugc2hvdWxkIGZpeCB0aGUgY29tcGlsZXIuIFRoZSBmYWxsIHRo
cm91Z2gKPj4KPj4gSSdsbCBwYXNzIHlvdXIgZmVlZGJhY2sgb24gdG8gdGhlIEdDQyBndXlzLgo+
Pgo+Pj4gaXMgbm90IGltcGxpY2l0LCBpdCBpcyBhY3R1YWxseSBxdWl0ZSBleHBsaWNpdCBhbmQg
dGhlIHdhcm5pbmcgaXMgc2ltcGx5Cj4+PiB3cm9uZy4KPj4+Cj4+PiBBbHNvLCB0aGUgZ2NjIGRv
Y3VtZW50YXRpb24gc2F5cyB0aGF0IC1XaW1wbGljaXQtZmFsbHRocm91Z2g9Mwo+Pj4gcmVjb2du
aXplcyAvKiBmYWxsdGhyb3VnaCAqLyBhcyBhIHByb3BlciBmYWxsIHRocm91Z2ggY29tbWVudCAo
YW5kIEkKPj4+IHRlc3RlZCB3aXRoIGdjYyA4LjIpLgo+Pj4KPj4KPj4gWWVhaC4gQnV0IHRoYXQn
cyBub3QgdGhlIHJlbGV2YW50IGNoYW5nZSBpbiB0aGlzIGNhc2UuICBOb3RpY2UgdGhhdCB0aGUK
Pj4gY29tbWVudCB3YXMgbW92ZWQgdG8gdGhlIHZlcnkgYm90dG9tIG9mIHRoZSBwcmV2aW91cyBj
YXNlLgo+Pgo+IAo+IFllcyBhbmQgaXQgZG9lc24ndCBtYXR0ZXIgZm9yIGdjYywgSSB0ZXN0ZWQg
d2l0aCBnY2MgOC4yLgo+IAoKWWVhaC4gQnV0LCBhZ2FpbiwgeW91IGFyZSBtaXNzaW5nIHRoZSBy
ZWxldmFudCBwYXJ0IG9mIHRoZSBwYXRjaC4KCi0tCkd1c3Rhdm8KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBs
aXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
