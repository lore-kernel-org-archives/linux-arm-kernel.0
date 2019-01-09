Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBCBC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 08:25:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B64D6214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 08:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U5rpomMT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B64D6214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=KARO-electronics.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7p+9ebYfvCRKOESaT9wouPbYGydUEDpJfvziALwRVk8=; b=U5rpomMTwC2xtP
	L8yswZ7Wyg0OtjARQ/lRXSZ3zV3pv3nE8M2tWQpIu151xEiK2kAT75DmWcLPKNoVwLjbmKg5oAxnh
	cNYIk+WurQRcUNCY1IX6Zfu3sWHsZtSVQdZwLX6rrAM8IXnZQb/6djJEBV7zem6hupFnSQ0zDzmWF
	j/UiSqyr/hcX2Zb4UoReFAwhePbafNmfWts7+znUGCvKyrkX7hq4NBmJ2jOpj7u9E9HcpL+7xxAH3
	cN4ChkZjbWzuyKWjmW5PlplGK2V9MnMWy4E3e4H7bipAlhrzxjR/CvIEBL2FlXwQO6hJZPlbas8ef
	NAdxWKxodpvhxWmMwxGw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gh9BL-0007CB-I1; Wed, 09 Jan 2019 08:25:47 +0000
Received: from smtprelay05.ispgateway.de ([80.67.31.97])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gh9BH-0007BY-AL
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 08:25:45 +0000
Received: from [89.1.81.74] (helo=karo-electronics.de)
 by smtprelay05.ispgateway.de with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <LW@KARO-electronics.de>)
 id 1gh9B6-0000m3-R8; Wed, 09 Jan 2019 09:25:32 +0100
Date: Wed, 9 Jan 2019 09:25:31 +0100
From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>
Subject: Re: Handle pwm with sysfs with recent kernel
Message-ID: <20190109092531.71cf52c8@karo-electronics.de>
In-Reply-To: <20190108222102.hwv5oekspifhj7bh@pengutronix.de>
References: <20190108100739.GA9046@arthur-bzh>
 <20190108222102.hwv5oekspifhj7bh@pengutronix.de>
Organization: Ka-Ro electronics GmbH
MIME-Version: 1.0
X-Df-Sender: bHdAa2Fyby1lbGVjdHJvbmljcy5kZQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_002543_360892_75FD2188 
X-CRM114-Status: GOOD (  16.21  )
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
Cc: linux-pwm@vger.kernel.org, Arthur LAMBERT <lambertarthur22@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGksCgpPbiBUdWUsIDggSmFuIDIwMTkgMjM6MjE6MDIgKzAxMDAgVXdlIEtsZWluZS1Lw7ZuaWcg
d3JvdGU6Cj4gW0NjOiArPSBsaW51eC1wd20gbGlzdF0KPiAKPiBIZWxsbyBBcnRodXIsCj4gCj4g
T24gVHVlLCBKYW4gMDgsIDIwMTkgYXQgMTE6MDc6MzlBTSArMDEwMCwgQXJ0aHVyIExBTUJFUlQg
d3JvdGU6Cj4gPiBJIGFtIHRyeWluZyB0byB1cGRhdGUgbXkga2VybmVsIGJzcCBmcm9tIHY0LjEu
WCB0byB2NC4xOS44IGJ1dCBJIGhhdmUgc29tZSByZWdyZXNzaW9ucwo+ID4gd2hlbiBJIHRyeSB0
byB1c2UgcHdtIHRocm91Z2ggc3lzZnMgZnJvbSB1c2Vyc3BhY2UuIEkgaGF2ZSB0aHJlZSBwd20g
ZGVjbGFyZWQgYXMKPiA+IGZvbGxvdyBpbiBteSBkZXZpY2UgdHJlZSA6Cj4gPiAKPiA+IAlsZWRz
IHsKPiA+IAkgICAgIGNvbXBhdGlibGUgPSAicHdtLWxlZHMiOwo+ID4gCSAgICAgbGVkcmVkIHsK
PiA+IAkJcHdtcyA9IDwmcHdtMT47Cj4gPiAJCWxhYmVsID0gInJlZCI7Cj4gPiAJCWxpbnV4LGRl
ZmF1bHQtdHJpZ2dlciA9ICJub25lIjsKPiA+IAkJZGVmYXVsdC1zdGF0ZSA9ICJvbiI7Cj4gPiAJ
ICAgICB9Owo+ID4gCj4gPiAJICAgICBsZWRibHVlIHsKPiA+IAkgICAgIAlwd21zID0gPCZwd201
PjsKPiA+IAkJbGFiZWwgPSAiYmx1ZSI7Cj4gPiAJCWxpbnV4LGRlZmF1bHQtdHJpZ2dlciA9ICJu
b25lIjsKPiA+IAkJZGVmYXVsdC1zdGF0ZSA9ICJvbiI7Cj4gPiAJICAgICB9Owo+ID4gCj4gPiAJ
ICAgICBsZWRncmVlbiB7Cj4gPiAJICAgICAJcHdtcyA9IDwmcHdtNj47Cj4gPiAJCWxhYmVsID0g
ImdyZWVuIjsKPiA+IAkJbGludXgsZGVmYXVsdC10cmlnZ2VyID0gIm5vbmUiOwo+ID4gCQlkZWZh
dWx0LXN0YXRlID0gIm9uIjsKPiA+IAkgICAgIH07Cj4gPiAJfTsKPiA+IAo+ID4gRmlyc3QgSSBo
YXZlIGFuIGlzc3VlIHdpdGggZHVwbGljYXRlIG5hbWUgOgo+ID4gc3lzZnM6IGNhbm5vdCBjcmVh
dGUgZHVwbGljYXRlIGZpbGVuYW1lICcvY2xhc3MvcHdtL3B3bTAnCj4gPiBDUFU6IDAgUElEOiA2
NTMgQ29tbTogWFhYWAo+ID4gSGFyZHdhcmUgbmFtZTogRnJlZXNjYWxlIGkuTVg2IFVsdHJhbGl0
ZSAoRGV2aWNlIFRyZWUpCj4gPiBbPDgwMTBkZGE4Pl0gKHVud2luZF9iYWNrdHJhY2UpIGZyb20g
Wzw4MDEwYjQ2OD5dIChzaG93X3N0YWNrKzB4MTAvMHgxNCkKPiA+IFs8ODAxMGI0Njg+XSAoc2hv
d19zdGFjaykgZnJvbSBbPDgwMjVlZjBjPl0gKHN5c2ZzX3dhcm5fZHVwKzB4NTgvMHg2NCkKPiA+
IFs8ODAyNWVmMGM+XSAoc3lzZnNfd2Fybl9kdXApIGZyb20gWzw4MDI1ZjIwMD5dIChzeXNmc19k
b19jcmVhdGVfbGlua19zZCsweGQ0LzB4ZDgpCj4gPiBbPDgwMjVmMjAwPl0gKHN5c2ZzX2RvX2Ny
ZWF0ZV9saW5rX3NkKSBmcm9tIFs8ODA0NThkNmM+XSAoZGV2aWNlX2FkZCsweDFlYy8weDVkNCkK
PiA+IFs8ODA0NThkNmM+XSAoZGV2aWNlX2FkZCkgZnJvbSBbPDgwNDBiNWE4Pl0gKGV4cG9ydF9z
dG9yZSsweGZjLzB4MTdjKQo+ID4gWzw4MDQwYjVhOD5dIChleHBvcnRfc3RvcmUpIGZyb20gWzw4
MDQ1NjkwND5dIChkZXZfYXR0cl9zdG9yZSsweDE4LzB4MjQpCj4gPiBbPDgwNDU2OTA0Pl0gKGRl
dl9hdHRyX3N0b3JlKSBmcm9tIFs8ODAyNWU2MDQ+XSAoc3lzZnNfa2Zfd3JpdGUrMHg0NC8weDQ4
KQo+ID4gWzw4MDI1ZTYwND5dIChzeXNmc19rZl93cml0ZSkgZnJvbSBbPDgwMjVkY2IwPl0gKGtl
cm5mc19mb3Bfd3JpdGUrMHhlOC8weDFkMCkKPiA+IFs8ODAyNWRjYjA+XSAoa2VybmZzX2ZvcF93
cml0ZSkgZnJvbSBbPDgwMWVhYWY4Pl0gKF9fdmZzX3dyaXRlKzB4MjgvMHgxNDQpCj4gPiBbPDgw
MWVhYWY4Pl0gKF9fdmZzX3dyaXRlKSBmcm9tIFs8ODAxZWFkODg+XSAodmZzX3dyaXRlKzB4YTQv
MHgxNjQpCj4gPiBbPDgwMWVhZDg4Pl0gKHZmc193cml0ZSkgZnJvbSBbPDgwMWVhZjU0Pl0gKGtz
eXNfd3JpdGUrMHg0MC8weDk0KQo+ID4gWzw4MDFlYWY1ND5dIChrc3lzX3dyaXRlKSBmcm9tIFs8
ODAxMDEwMDA+XSAocmV0X2Zhc3Rfc3lzY2FsbCsweDAKPiA+IAo+ID4gSSB3YXMgYWJsZSB0byBm
aXggaXQgYnkgcmV2ZXJ0IGEgcGF0Y2ggOiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Bh
dGNoLzk5NzE4MjEvCj4gPiBJdCBpcyBub3JtYWwgdGhhdCB0aGlzIHJldmVydCBwYXRjaCBpcyBu
b3QgY3VycmVudGx5IGFwcGx5IG9uIGxhc3QgNC4xOS5YIHRhZyAobGFzdCBvbmUKPiA+IHNlZW1z
IHRvIGJlIDQuMTkuMTMpCj4gPiAKPiA+IFRoZW4gSSBoYXZlIGFub3RoZXIgaXNzdWUgd2hlbiBJ
IHRyeSB0byBlbmFibGUgbXkgcHdtIDoKPiA+IAo+ID4gIyBscyAvc3lzL2NsYXNzL3B3bS8KPiA+
IHB3bWNoaXAwICBwd21jaGlwMiAgcHdtY2hpcDQgIHB3bWNoaXA2Cj4gPiBwd21jaGlwMSAgcHdt
Y2hpcDMgIHB3bWNoaXA1ICBwd21jaGlwNwo+ID4gIyBlY2hvIDAgPiAvc3lzL2NsYXNzL3B3bS9w
d21jaGlwMC9leHBvcnQKPiA+ICMgZWNobyAxID4gL3N5cy9jbGFzcy9wd20vcHdtY2hpcDAvcHdt
MC9lbmFibGUKPiA+IC1zaDogd3JpdGUgZXJyb3I6IEludmFsaWQgYXJndW1lbnQgIAo+IAo+IEp1
c3QgYSBndWVzczogZGlkIHlvdSBjaGVjayB0aGF0IC9zeXMvY2xhc3MvcHdtL3B3bWNoaXAwL3B3
bTAvZW5hYmxlCj4gYWN0dWFsbHkgZXhpc3RzPwo+IApJZiBub3QsIHRoZSBlcnJvciBtZXNzYWdl
IHdvdWxkIGJlICdObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5JyByYXRoZXIKdGhhbiAiSW52YWxp
ZCBhcmd1bWVudCIuCgo+ID4gSXMgdGhlcmUgYSBuZXcgd2F5IHRvIGhhbmRsZSBwd20gaW4gcmVj
ZW50IGtlcm5lbCA/IE15IG9sZCBwcm9jZXNzIGlzCj4gPiBub3cgZGVwcmVjYXRlZCBvciBzb21l
dGhpbmcgPyAgCj4gCj4gTm90IHN1cmUgd2hhdCB5b3Ugd2FudCB0byBhY2hpdmUgYW5kIGlmIHB3
bWNoaXAwL3B3bTAgaXMgb25lIG9mIHRoZSBwd21zCj4gdXNlZCBpbiB5b3VyIGR0cyBzbmlwcGVk
IGFib3ZlLiBJZiB0aGUgcHdtIGlzIGluIHVzZSwgZG9uJ3QgZXhwZWN0IGl0IHRvCj4gYmUgY29u
dHJvbGxhYmxlIHZpYSBzeXNmcy4KPiAKSWYgaXQgd2VyZSBpbiB1c2UsIGhlIHNob3VsZCBnZXQg
YSAnRGV2aWNlIG9yIHJlc291cmNlIGJ1c3knIGVycm9yIHdoZW4KdHJ5aW5nIHRvIGV4cG9ydCBp
dC4KCgpMb3RoYXIgV2HDn21hbm4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
