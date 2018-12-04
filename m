Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3E1C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:21:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 475812081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K1DjA/V2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 475812081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wyXwO6v7horsY7ik+7ee9x9mzySVWBa/48KAtJU3vUE=; b=K1DjA/V2DvhnHM
	arTZERq71mOMGPVAdR+BS9X2VV/sbVgNDzByz1QzXQDLQ8oEuwxqoz9o+095Jl3dXlo0cXbC11PNR
	g/k/cgLk8qf83FTEykwQrH4cdh3vWI8QYDcPe8O2tvyNN+YP9pRO5CdEkbL9TY4w9YybL8pFOtz23
	/aWSEB8taeGAAYrR1FqRCfehez3Fu5SjIQxFQVDAalgYhKAOVGwIpqxGfFqT9iZBMWyly4J6Lsj97
	vXDak744uKBEjqlHDs2NBxRgCI+lC86svOrROSL3iflMr91WWY1Wewbkg6n10yfRpE1RnwQhBxviI
	zdRkZn/JkqNnU0l79KiA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUDSL-0004yt-5h; Tue, 04 Dec 2018 16:21:53 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUDSF-0004fZ-Ku
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 16:21:50 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id E08F520784; Tue,  4 Dec 2018 17:21:34 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
 by mail.bootlin.com (Postfix) with ESMTPSA id A817B20743;
 Tue,  4 Dec 2018 17:21:24 +0100 (CET)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH] Revert "arm64: dts: marvell: add CPU Idle power state
 support on Armada 7K/8K"
References: <3ece60154be74bd6534387db8da578194f823b43.1543938362.git.baruch@tkos.co.il>
Date: Tue, 04 Dec 2018 17:21:25 +0100
In-Reply-To: <3ece60154be74bd6534387db8da578194f823b43.1543938362.git.baruch@tkos.co.il>
 (Baruch Siach's message of "Tue, 4 Dec 2018 17:46:02 +0200")
Message-ID: <87o9a1w9dm.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_082147_954631_91F8DB75 
X-CRM114-Status: GOOD (  14.83  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 Sergey Matyukevich <geomatsi@gmail.com>, linux-pm@vger.kernel.org,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, orenbh <orenbh@marvell.com>,
 Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgQmFydWNoIGFuZCBTZXJnZXksCiAKIE9uIG1hci4sIGTDqWMuIDA0IDIwMTgsIEJhcnVjaCBT
aWFjaCA8YmFydWNoQHRrb3MuY28uaWw+IHdyb3RlOgoKPiBUaGlzIHJldmVydHMgY29tbWl0IDhl
ZDQ2MzY4Nzc2YjNiYzkzZDc0YzFmOGYyYmZiOWZkOGE5YWQ4MDUuCj4KPiBUaGlzIGNvbW1pdCBi
cmVha3MgYm9vdCBvbiBBcm1hZGEgOEsgYmFzZWQgc3lzdGVtcy4gUmV2ZXJ0aW5nIGl0IG1ha2Vz
Cj4gYWZmZWN0ZWQgc3lzdGVtcyBib290IGFnYWluLgo+Cj4gUmVwb3J0ZWQtYnk6IFNlcmdleSBN
YXR5dWtldmljaCA8Z2VvbWF0c2lAZ21haWwuY29tPgo+IFNpZ25lZC1vZmYtYnk6IEJhcnVjaCBT
aWFjaCA8YmFydWNoQHRrb3MuY28uaWw+CgpJIHdvdWxkIGxpa2UgdG8ga25vdyBtb3JlIGFib3V0
IGl0IGJlY2F1c2Ugb24gdGhlIE1jQmluIEkgdXNlIHRoZXJlIGlzCm5vIGlzc3VlIHdpdGggNC4y
MC1yYzEuCgpEbyB5b3Ugb2JzZXJ2ZSB0aGlzIGlzc3VlIHdpdGggdGhlIGFybTY0IGRlZmNvbmZp
ZyBvciBkbyB5b3UgaGF2ZSBzb21lCnNwZWNpZmljIGNvbmZpZ3VyYXRpb24gb3B0aW9uPwoKVGhh
bmtzLAoKR3JlZ29yeQoKCgo+IC0tLQo+ICAuLi4vYm9vdC9kdHMvbWFydmVsbC9hcm1hZGEtYXA4
MDYtcXVhZC5kdHNpICAgfCAgNCAtLS0KPiAgYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2Fy
bWFkYS1hcDgwNi5kdHNpIHwgMjcgLS0tLS0tLS0tLS0tLS0tLS0tLQo+ICAyIGZpbGVzIGNoYW5n
ZWQsIDMxIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMv
bWFydmVsbC9hcm1hZGEtYXA4MDYtcXVhZC5kdHNpIGIvYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2
ZWxsL2FybWFkYS1hcDgwNi1xdWFkLmR0c2kKPiBpbmRleCA2NDYzMmM4NzM4ODguLjAxZWE2NjJh
ZmJhOCAxMDA2NDQKPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvYXJtYWRhLWFw
ODA2LXF1YWQuZHRzaQo+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9hcm1hZGEt
YXA4MDYtcXVhZC5kdHNpCj4gQEAgLTIwLDI4ICsyMCwyNCBAQAo+ICAJCQljb21wYXRpYmxlID0g
ImFybSxjb3J0ZXgtYTcyIiwgImFybSxhcm12OCI7Cj4gIAkJCXJlZyA9IDwweDAwMD47Cj4gIAkJ
CWVuYWJsZS1tZXRob2QgPSAicHNjaSI7Cj4gLQkJCWNwdS1pZGxlLXN0YXRlcyA9IDwmQ1BVX1NM
RUVQXzA+Owo+ICAJCX07Cj4gIAkJY3B1MTogY3B1QDEgewo+ICAJCQlkZXZpY2VfdHlwZSA9ICJj
cHUiOwo+ICAJCQljb21wYXRpYmxlID0gImFybSxjb3J0ZXgtYTcyIiwgImFybSxhcm12OCI7Cj4g
IAkJCXJlZyA9IDwweDAwMT47Cj4gIAkJCWVuYWJsZS1tZXRob2QgPSAicHNjaSI7Cj4gLQkJCWNw
dS1pZGxlLXN0YXRlcyA9IDwmQ1BVX1NMRUVQXzA+Owo+ICAJCX07Cj4gIAkJY3B1MjogY3B1QDEw
MCB7Cj4gIAkJCWRldmljZV90eXBlID0gImNwdSI7Cj4gIAkJCWNvbXBhdGlibGUgPSAiYXJtLGNv
cnRleC1hNzIiLCAiYXJtLGFybXY4IjsKPiAgCQkJcmVnID0gPDB4MTAwPjsKPiAgCQkJZW5hYmxl
LW1ldGhvZCA9ICJwc2NpIjsKPiAtCQkJY3B1LWlkbGUtc3RhdGVzID0gPCZDUFVfU0xFRVBfMD47
Cj4gIAkJfTsKPiAgCQljcHUzOiBjcHVAMTAxIHsKPiAgCQkJZGV2aWNlX3R5cGUgPSAiY3B1IjsK
PiAgCQkJY29tcGF0aWJsZSA9ICJhcm0sY29ydGV4LWE3MiIsICJhcm0sYXJtdjgiOwo+ICAJCQly
ZWcgPSA8MHgxMDE+Owo+ICAJCQllbmFibGUtbWV0aG9kID0gInBzY2kiOwo+IC0JCQljcHUtaWRs
ZS1zdGF0ZXMgPSA8JkNQVV9TTEVFUF8wPjsKPiAgCQl9Owo+ICAJfTsKPiAgfTsKPiBkaWZmIC0t
Z2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2FybWFkYS1hcDgwNi5kdHNpIGIvYXJj
aC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2FybWFkYS1hcDgwNi5kdHNpCj4gaW5kZXggMDczNjEw
YWMwYTUzLi43ZDk0YzFmYTU5MmEgMTAwNjQ0Cj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9t
YXJ2ZWxsL2FybWFkYS1hcDgwNi5kdHNpCj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2
ZWxsL2FybWFkYS1hcDgwNi5kdHNpCj4gQEAgLTI4LDMzICsyOCw2IEBACj4gIAkJbWV0aG9kID0g
InNtYyI7Cj4gIAl9Owo+ICAKPiAtCWNwdXMgewo+IC0JCSNhZGRyZXNzLWNlbGxzID0gPDE+Owo+
IC0JCSNzaXplLWNlbGxzID0gPDA+Owo+IC0KPiAtCQlpZGxlX3N0YXRlcyB7Cj4gLQkJCWVudHJ5
X21ldGhvZCA9ICJhcm0scGNzaSI7Cj4gLQo+IC0JCQlDUFVfU0xFRVBfMDogY3B1LXNsZWVwLTAg
ewo+IC0JCQkJY29tcGF0aWJsZSA9ICJhcm0saWRsZS1zdGF0ZSI7Cj4gLQkJCQlsb2NhbC10aW1l
ci1zdG9wOwo+IC0JCQkJYXJtLHBzY2ktc3VzcGVuZC1wYXJhbSA9IDwweDAwMTAwMDA+Owo+IC0J
CQkJZW50cnktbGF0ZW5jeS11cyA9IDw4MD47Cj4gLQkJCQlleGl0LWxhdGVuY3ktdXMgID0gPDE2
MD47Cj4gLQkJCQltaW4tcmVzaWRlbmN5LXVzID0gPDMyMD47Cj4gLQkJCX07Cj4gLQo+IC0JCQlD
TFVTVEVSX1NMRUVQXzA6IGNsdXN0ZXItc2xlZXAtMCB7Cj4gLQkJCQljb21wYXRpYmxlID0gImFy
bSxpZGxlLXN0YXRlIjsKPiAtCQkJCWxvY2FsLXRpbWVyLXN0b3A7Cj4gLQkJCQlhcm0scHNjaS1z
dXNwZW5kLXBhcmFtID0gPDB4MTAxMDAwMD47Cj4gLQkJCQllbnRyeS1sYXRlbmN5LXVzID0gPDUw
MD47Cj4gLQkJCQlleGl0LWxhdGVuY3ktdXMgPSA8MTAwMD47Cj4gLQkJCQltaW4tcmVzaWRlbmN5
LXVzID0gPDI1MDA+Owo+IC0JCQl9Owo+IC0JCX07Cj4gLQl9Owo+IC0KPiAgCWFwODA2IHsKPiAg
CQkjYWRkcmVzcy1jZWxscyA9IDwyPjsKPiAgCQkjc2l6ZS1jZWxscyA9IDwyPjsKPiAtLSAKPiAy
LjE5LjIKPgo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KPiBsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdAo+IGxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZwo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtYXJtLWtlcm5lbAoKLS0gCkdyZWdvcnkgQ2xlbWVudCwgQm9vdGxpbgpFbWJl
ZGRlZCBMaW51eCBhbmQgS2VybmVsIGVuZ2luZWVyaW5nCmh0dHA6Ly9ib290bGluLmNvbQoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtl
cm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5l
bAo=
