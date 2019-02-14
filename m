Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112E4C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:08:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D300F21B68
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fvvIpvf2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D300F21B68
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hHKl/HD7BR26+REMdz+LSazRSNOQyO/lfCxxXv4yBKA=; b=fvvIpvf2j4j/rT
	CdcmFJEvfe4FlRmQhbZnRti+l8IakLU31+NiNDv5MYIsEJ+0lT0eDPhZ/8NK5jkogwNCWncH8vVSb
	9jyMY+EO+x7aZdYY3IE2srzmfKldJ1K+rc2Pc5PKMrYNO8e6Sw8y4pZKnewWZPizC6xkoPZKXhXQ8
	u6Sr81xh3rAdrcaZaoWKhkziCT+FN8C9gmpTrkdhdJrrPPQQE/OMkIIcXGfWkoETCU3sdTmxDAO/7
	7J5l7NfGTtJt1T3+ocVqgQr1GOEqd2GEIZGGUsmCVOqXDYcr6pQ6jifNlxxYA4x5iOi1EHRxAKDs7
	nUnBzIsvFY42QRwCsw4A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guQ6z-0003Mf-D6; Thu, 14 Feb 2019 23:08:09 +0000
Received: from relay1-d.mail.gandi.net ([217.70.183.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guQ6v-0003Ig-J5
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 23:08:07 +0000
X-Originating-IP: 86.202.231.219
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr
 [86.202.231.219])
 (Authenticated sender: alexandre.belloni@bootlin.com)
 by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 548C6240004;
 Thu, 14 Feb 2019 23:07:57 +0000 (UTC)
Date: Fri, 15 Feb 2019 00:07:56 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] can: mark expected switch fall-throughs
Message-ID: <20190214230756.GR10129@piout.net>
References: <20190129180612.GA28650@embeddedor>
 <432a9399-95f4-e988-5cd2-93340f155fa1@microchip.com>
 <daae008e-35fd-7553-fcb2-7932fe53b959@embeddedor.com>
 <20190214221703.GQ10129@piout.net>
 <a8e53868-2b13-b050-7714-e3e24d18cf00@embeddedor.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a8e53868-2b13-b050-7714-e3e24d18cf00@embeddedor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_150805_922049_59F346E6 
X-CRM114-Status: GOOD (  23.05  )
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

T24gMTQvMDIvMjAxOSAxNzowNDowMy0wNjAwLCBHdXN0YXZvIEEuIFIuIFNpbHZhIHdyb3RlOgo+
IAo+IAo+IE9uIDIvMTQvMTkgNDoxNyBQTSwgQWxleGFuZHJlIEJlbGxvbmkgd3JvdGU6Cj4gPiBI
aSwKPiA+IAo+ID4gT24gMTQvMDIvMjAxOSAxNTozNzoyNi0wNjAwLCBHdXN0YXZvIEEuIFIuIFNp
bHZhIHdyb3RlOgo+ID4+Cj4gPj4KPiA+PiBPbiAxLzMwLzE5IDI6MTEgQU0sIE5pY29sYXMuRmVy
cmVAbWljcm9jaGlwLmNvbSB3cm90ZToKPiA+Pj4gT24gMjkvMDEvMjAxOSBhdCAxOTowNiwgR3Vz
dGF2byBBLiBSLiBTaWx2YSB3cm90ZToKPiA+Pj4+IEluIHByZXBhcmF0aW9uIHRvIGVuYWJsaW5n
IC1XaW1wbGljaXQtZmFsbHRocm91Z2gsIG1hcmsgc3dpdGNoIGNhc2VzCj4gPj4+PiB3aGVyZSB3
ZSBhcmUgZXhwZWN0aW5nIHRvIGZhbGwgdGhyb3VnaC4KPiA+Pj4+Cj4gPj4+PiBUaGlzIHBhdGNo
IGZpeGVzIHRoZSBmb2xsb3dpbmcgd2FybmluZ3M6Cj4gPj4+Pgo+ID4+Pj4gZHJpdmVycy9uZXQv
Y2FuL3BlYWtfY2FuZmQvcGVha19wY2llZmRfbWFpbi5jOjY2ODozOiB3YXJuaW5nOiB0aGlzIHN0
YXRlbWVudCBtYXkgZmFsbCB0aHJvdWdoIFstV2ltcGxpY2l0LWZhbGx0aHJvdWdoPV0KPiA+Pj4+
IGRyaXZlcnMvbmV0L2Nhbi9zcGkvbWNwMjUxeC5jOjg3NTo3OiB3YXJuaW5nOiB0aGlzIHN0YXRl
bWVudCBtYXkgZmFsbCB0aHJvdWdoIFstV2ltcGxpY2l0LWZhbGx0aHJvdWdoPV0KPiA+Pj4+IGRy
aXZlcnMvbmV0L2Nhbi91c2IvcGVha191c2IvcGNhbl91c2IuYzo0MjI6Njogd2FybmluZzogdGhp
cyBzdGF0ZW1lbnQgbWF5IGZhbGwgdGhyb3VnaCBbLVdpbXBsaWNpdC1mYWxsdGhyb3VnaD1dCj4g
Pj4+PiBkcml2ZXJzL25ldC9jYW4vYXQ5MV9jYW4uYzo4OTU6Njogd2FybmluZzogdGhpcyBzdGF0
ZW1lbnQgbWF5IGZhbGwgdGhyb3VnaCBbLVdpbXBsaWNpdC1mYWxsdGhyb3VnaD1dCj4gPj4+PiBk
cml2ZXJzL25ldC9jYW4vYXQ5MV9jYW4uYzo5NTM6MTU6IHdhcm5pbmc6IHRoaXMgc3RhdGVtZW50
IG1heSBmYWxsIHRocm91Z2ggWy1XaW1wbGljaXQtZmFsbHRocm91Z2g9XQo+ID4+Pj4gZHJpdmVy
cy9uZXQvY2FuL3VzYi9wZWFrX3VzYi9wY2FuX3VzYi5jOiBJbiBmdW5jdGlvbiDigJhwY2FuX3Vz
Yl9kZWNvZGVfZXJyb3LigJk6Cj4gPj4+PiBkcml2ZXJzL25ldC9jYW4vdXNiL3BlYWtfdXNiL3Bj
YW5fdXNiLmM6NDIyOjY6IHdhcm5pbmc6IHRoaXMgc3RhdGVtZW50IG1heSBmYWxsIHRocm91Z2gg
Wy1XaW1wbGljaXQtZmFsbHRocm91Z2g9XQo+ID4+Pj4gICAgIGlmIChuICYgUENBTl9VU0JfRVJS
T1JfQlVTX0xJR0hUKSB7Cj4gPj4+PiAgICAgICAgXgo+ID4+Pj4gZHJpdmVycy9uZXQvY2FuL3Vz
Yi9wZWFrX3VzYi9wY2FuX3VzYi5jOjQyODoyOiBub3RlOiBoZXJlCj4gPj4+PiAgICBjYXNlIENB
Tl9TVEFURV9FUlJPUl9XQVJOSU5HOgo+ID4+Pj4gICAgXn5+fgo+ID4+Pj4KPiA+Pj4+IFdhcm5p
bmcgbGV2ZWwgMyB3YXMgdXNlZDogLVdpbXBsaWNpdC1mYWxsdGhyb3VnaD0zCj4gPj4+Pgo+ID4+
Pj4gVGhpcyBwYXRjaCBpcyBwYXJ0IG9mIHRoZSBvbmdvaW5nIGVmZm9ydHMgdG8gZW5hYmxpbmcK
PiA+Pj4+IC1XaW1wbGljaXQtZmFsbHRocm91Z2guCj4gPj4+Pgo+ID4+Pj4gTm90aWNlIHRoYXQg
aW4gc29tZSBjYXNlcyBzcGVsbGluZyBtaXN0YWtlcyB3ZXJlIGZpeGVkLgo+ID4+Pj4gSW4gb3Ro
ZXIgY2FzZXMsIHRoZSAvKiBmYWxsIHRocm91Z2ggKi8gY29tbWVudCBpcyBwbGFjZWQKPiA+Pj4+
IGF0IHRoZSBib3R0b20gb2YgdGhlIGNhc2Ugc3RhdGVtZW50LCB3aGljaCBpcyB3aGF0IEdDQwo+
ID4+Pj4gaXMgZXhwZWN0aW5nIHRvIGZpbmQuCj4gPj4+Pgo+ID4+Pj4gU2lnbmVkLW9mZi1ieTog
R3VzdGF2byBBLiBSLiBTaWx2YSA8Z3VzdGF2b0BlbWJlZGRlZG9yLmNvbT4KPiA+Pj4+IC0tLQo+
ID4+Pj4gICBkcml2ZXJzL25ldC9jYW4vYXQ5MV9jYW4uYyAgICAgICAgICAgICAgICAgICAgfCA2
ICsrKystLQo+ID4+Pgo+ID4+PiBGb3IgdGhpcyBvbmU6Cj4gPj4+IEFja2VkLWJ5OiBOaWNvbGFz
IEZlcnJlIDxuaWNvbGFzLmZlcnJlQG1pY3JvY2hpcC5jb20+Cj4gPj4+Cj4gPj4KPiA+PiBUaGFu
a3MsIE5pY29sYXMuCj4gPj4KPiA+IAo+ID4gSSB0aG91Z2ggSSBoYWQgYSBkw6lqw6AgdnUgYnV0
IHlvdSBhY3R1YWxseSBzZW50IHRoZSBhdDkxIHBhcnQgdHdpY2UuCj4gPiAKPiAKPiBJdCB3YXNu
J3QgaW50ZW50aW9uYWwuCj4gCj4gPj4gRGF2ZToKPiA+Pgo+ID4+IEkgd29uZGVyIGlmIHlvdSBj
YW4gdGFrZSB0aGlzIHBhdGNoLgo+ID4+Cj4gPj4gVGhhbmtzCj4gPj4gLS0KPiA+PiBHdXN0YXZv
Cj4gPj4KPiA+Pj4+ICAgZHJpdmVycy9uZXQvY2FuL3BlYWtfY2FuZmQvcGVha19wY2llZmRfbWFp
bi5jIHwgMiArLQo+ID4+Pj4gICBkcml2ZXJzL25ldC9jYW4vc3BpL21jcDI1MXguYyAgICAgICAg
ICAgICAgICAgfCAzICsrLQo+ID4+Pj4gICBkcml2ZXJzL25ldC9jYW4vdXNiL3BlYWtfdXNiL3Bj
YW5fdXNiLmMgICAgICAgfCAyICstCj4gPj4+PiAgIDQgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRp
b25zKCspLCA1IGRlbGV0aW9ucygtKQo+ID4+Pj4KPiA+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L25ldC9jYW4vYXQ5MV9jYW4uYyBiL2RyaXZlcnMvbmV0L2Nhbi9hdDkxX2Nhbi5jCj4gPj4+PiBp
bmRleCBkOThjNjkwNDViMTcuLjE3MThjMjBmOWM5OSAxMDA2NDQKPiA+Pj4+IC0tLSBhL2RyaXZl
cnMvbmV0L2Nhbi9hdDkxX2Nhbi5jCj4gPj4+PiArKysgYi9kcml2ZXJzL25ldC9jYW4vYXQ5MV9j
YW4uYwo+ID4+Pj4gQEAgLTkwMiw3ICs5MDIsOCBAQCBzdGF0aWMgdm9pZCBhdDkxX2lycV9lcnJf
c3RhdGUoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwKPiA+Pj4+ICAgCQkJCUNBTl9FUlJfQ1JUTF9U
WF9XQVJOSU5HIDoKPiA+Pj4+ICAgCQkJCUNBTl9FUlJfQ1JUTF9SWF9XQVJOSU5HOwo+ID4+Pj4g
ICAJCX0KPiA+Pj4+IC0JY2FzZSBDQU5fU1RBVEVfRVJST1JfV0FSTklORzoJLyogZmFsbHRocm91
Z2ggKi8KPiA+Pj4+ICsJCS8qIGZhbGwgdGhyb3VnaCAqLwo+ID4+Pj4gKwljYXNlIENBTl9TVEFU
RV9FUlJPUl9XQVJOSU5HOgo+ID4+Pj4gICAJCS8qCj4gPj4+PiAgIAkJICogZnJvbTogRVJST1Jf
QUNUSVZFLCBFUlJPUl9XQVJOSU5HCj4gPj4+PiAgIAkJICogdG8gIDogRVJST1JfUEFTU0lWRSwg
QlVTX09GRgo+ID4+Pj4gQEAgLTk1MSw3ICs5NTIsOCBAQCBzdGF0aWMgdm9pZCBhdDkxX2lycV9l
cnJfc3RhdGUoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwKPiA+Pj4+ICAgCQluZXRkZXZfZGJnKGRl
diwgIkVycm9yIEFjdGl2ZVxuIik7Cj4gPj4+PiAgIAkJY2YtPmNhbl9pZCB8PSBDQU5fRVJSX1BS
T1Q7Cj4gPj4+PiAgIAkJY2YtPmRhdGFbMl0gPSBDQU5fRVJSX1BST1RfQUNUSVZFOwo+ID4+Pj4g
LQljYXNlIENBTl9TVEFURV9FUlJPUl9XQVJOSU5HOgkvKiBmYWxsdGhyb3VnaCAqLwo+ID4gCj4g
PiBTZXJpb3VzbHksIGZvciB0aGF0IG9uZSwgeW91IHNob3VsZCBmaXggdGhlIGNvbXBpbGVyLiBU
aGUgZmFsbCB0aHJvdWdoCj4gCj4gSSdsbCBwYXNzIHlvdXIgZmVlZGJhY2sgb24gdG8gdGhlIEdD
QyBndXlzLgo+IAo+ID4gaXMgbm90IGltcGxpY2l0LCBpdCBpcyBhY3R1YWxseSBxdWl0ZSBleHBs
aWNpdCBhbmQgdGhlIHdhcm5pbmcgaXMgc2ltcGx5Cj4gPiB3cm9uZy4KPiA+IAo+ID4gQWxzbywg
dGhlIGdjYyBkb2N1bWVudGF0aW9uIHNheXMgdGhhdCAtV2ltcGxpY2l0LWZhbGx0aHJvdWdoPTMK
PiA+IHJlY29nbml6ZXMgLyogZmFsbHRocm91Z2ggKi8gYXMgYSBwcm9wZXIgZmFsbCB0aHJvdWdo
IGNvbW1lbnQgKGFuZCBJCj4gPiB0ZXN0ZWQgd2l0aCBnY2MgOC4yKS4KPiA+IAo+IAo+IFllYWgu
IEJ1dCB0aGF0J3Mgbm90IHRoZSByZWxldmFudCBjaGFuZ2UgaW4gdGhpcyBjYXNlLiAgTm90aWNl
IHRoYXQgdGhlCj4gY29tbWVudCB3YXMgbW92ZWQgdG8gdGhlIHZlcnkgYm90dG9tIG9mIHRoZSBw
cmV2aW91cyBjYXNlLgo+IAoKWWVzIGFuZCBpdCBkb2Vzbid0IG1hdHRlciBmb3IgZ2NjLCBJIHRl
c3RlZCB3aXRoIGdjYyA4LjIuCgotLSAKQWxleGFuZHJlIEJlbGxvbmksIEJvb3RsaW4KRW1iZWRk
ZWQgTGludXggYW5kIEtlcm5lbCBlbmdpbmVlcmluZwpodHRwczovL2Jvb3RsaW4uY29tCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2Vy
bmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVs
Cg==
