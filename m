Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405DCC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:55:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BF6620849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Kc/Rmfn5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BF6620849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Rc387JGbMwwou9xOcBcGYR0hCBcx0BO76o51NbsFI+0=; b=Kc/Rmfn5VJCypT
	/+2Epu56wh5nB5+o5X0CRT7C5jI1Qfp5UFK5GFeDpfKrWS4A5BvcbsDbRQwzPAxX6dPjQL1FVC6ZR
	ESwIJ9cR3N/47tyCCgUKQ8dVT1dWY7KkABhYPhc1Ehm5AzbZqBCYts8Tv5teBsD0rNoE9r+J6735r
	q2tcCbT+5R0udzmXCU/FIK8HB3FMerUR+B2EWgHLSfOOmhcO8A6LDZZ/9jBrRLei+t9AvSkuxCswW
	LUztxp92mB8J+Mom9HKgw2z9/uUtP2Zt89W2fbOFBBVX1WTUroChCj+I+QkPJyQn5zxrGI4MTeQgY
	isVDiwo3mzAR3ojtLa+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWcsu-000744-8E; Tue, 11 Dec 2018 07:55:16 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWcso-0005nh-Kv; Tue, 11 Dec 2018 07:55:12 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 4425C20723; Tue, 11 Dec 2018 08:54:56 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr
 [90.88.21.44])
 by mail.bootlin.com (Postfix) with ESMTPSA id BF08E20701;
 Tue, 11 Dec 2018 08:54:45 +0100 (CET)
Date: Tue, 11 Dec 2018 08:54:45 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Liang Yang <liang.yang@amlogic.com>
Subject: Re: [PATCH v7 2/2] mtd: rawnand: meson: add support for Amlogic
 NAND flash controller
Message-ID: <20181211085445.68e57e0e@xps13>
In-Reply-To: <d60bac6f-732d-0ddc-2644-17f650dfa885@amlogic.com>
References: <1542386439-30166-1-git-send-email-jianxin.pan@amlogic.com>
 <1542386439-30166-3-git-send-email-jianxin.pan@amlogic.com>
 <20181207102456.1dc67e07@xps13>
 <823825a3-86fb-9a20-ae29-85cc52d44093@amlogic.com>
 <20181210123809.5ade45c4@bbrezillon>
 <79a797c2-f37f-7f7c-e907-2d3c2283ec2d@amlogic.com>
 <20181210155057.38788656@xps13>
 <d60bac6f-732d-0ddc-2644-17f650dfa885@amlogic.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_235510_962724_3860451B 
X-CRM114-Status: GOOD (  17.67  )
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
Cc: Rob Herring <robh@kernel.org>, Hanjie Lin <hanjie.lin@amlogic.com>,
 Victor Wan <victor.wan@amlogic.com>, Jianxin Pan <jianxin.pan@amlogic.com>,
 Marek Vasut <marek.vasut@gmail.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Richard Weinberger <richard@nod.at>, Neil Armstrong <narmstrong@baylibre.com>,
 Yixun Lan <yixun.lan@amlogic.com>, linux-kernel@vger.kernel.org,
 Boris Brezillon <boris.brezillon@bootlin.com>, Jian Hu <jian.hu@amlogic.com>,
 linux-mtd@lists.infradead.org, Kevin Hilman <khilman@baylibre.com>,
 Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org,
 Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgTGlhbmcsCgpMaWFuZyBZYW5nIDxsaWFuZy55YW5nQGFtbG9naWMuY29tPiB3cm90ZSBvbiBU
dWUsIDExIERlYyAyMDE4IDA5OjU2OjI1CiswODAwOgoKPiBIaSBNaXF1ZWwsCj4gCj4gT24gMjAx
OC8xMi8xMCAyMjo1MCwgTWlxdWVsIFJheW5hbCB3cm90ZToKPiA+IEhpIExpYW5nLAo+ID4gCj4g
PiBMaWFuZyBZYW5nIDxsaWFuZy55YW5nQGFtbG9naWMuY29tPiB3cm90ZSBvbiBNb24sIDEwIERl
YyAyMDE4IDIwOjEyOjM5Cj4gPiArMDgwMDoKPiA+ICAgCj4gPj4gT24gMjAxOC8xMi8xMCAxOToz
OCwgQm9yaXMgQnJlemlsbG9uIHdyb3RlOiAgCj4gPj4+IE9uIE1vbiwgMTAgRGVjIDIwMTggMTk6
MjM6NDYgKzA4MDAKPiA+Pj4gTGlhbmcgWWFuZyA8bGlhbmcueWFuZ0BhbWxvZ2ljLmNvbT4gd3Jv
dGU6ICAKPiA+Pj4gICAgPj4+Pj4+ICsJCQltdGQtPmVjY19zdGF0cy5mYWlsZWQrKzsgIAo+ID4+
Pj4+PiArCQkJY29udGludWU7Cj4gPj4+Pj4+ICsJCX0KPiA+Pj4+Pj4gKwkJbXRkLT5lY2Nfc3Rh
dHMuY29ycmVjdGVkICs9IEVDQ19FUlJfQ05UKCppbmZvKTsKPiA+Pj4+Pj4gKwkJYml0ZmxpcHMg
PSBtYXhfdCh1MzIsIGJpdGZsaXBzLCBFQ0NfRVJSX0NOVCgqaW5mbykpOwo+ID4+Pj4+PiArCX0g
IAo+ID4+Pj4+Cj4gPj4+Pj4gQXJlIHlvdSBzdXJlIHlvdSBoYW5kbGUgY29ycmVjdGx5IGVtcHR5
IHBhZ2VzIHdpdGggYmY/ICAKPiA+Pj4+PiAgICAgPj4gaWYgc2NyYW1ibGUgaXMgZW5hYmxlLCBp
IHdvdWxkIHNheSB5ZXMgaGVyZS4gIAo+ID4+Pj4gd2hlbiBzY3JhbWJsZSBpcyBkaXNhYmxlZCwg
aSBhbSBjb25zaWRlcmluZyBob3cgdG8gdXNlIHRoZSBoZWxwZXIKPiA+Pj4+IG5hbmRfY2hlY2tf
ZXJhc2VkX2VjY19jaHVuaywgYnV0IGl0IHNlZW1zIHRoYXQgaSBjYW4ndCBnZXQgdGhlIGVjYwo+
ID4+Pj4gYnl0ZXMgd2hpY2ggaXMgY2FjdWxhdGVkIGJ5IGVjYyBlbmdpbmUuYnkgdGhlIHdheSwg
bmZjIGRtYSBkb2Vzbid0IHNlbmQKPiA+Pj4+IG91dCB0aGUgZWNjIHBhcml0eSBieXRlcy4gIAo+
ID4+Pgo+ID4+PiBFdmVuIGlmIHRoZSBFQ0MgZW5naW5lIGlzIGRpc2FibGVkPyAgCj4gPj4+ICAg
ID4+IE5vLiAgCj4gPj4gV2hlbiBFQ0MgZW5naW5lIGlzIGRpc2FibGVkLCBpdCBjYW4gcmVhZCB0
aGUgZWNjIHBhcml0eSBieXRlcyA7IGJ1dCB0aGVyZSBpcyBhbm90aGVyIHByb2JsZW0gdGhhdCBp
IG5lZWQgdG8gY29uc2lkZXIgaG93IGNvZGUgc3RydWN0IGxvb2tzIGJldHRlciB3aGVuIHJlYWRp
bmcgZXJyb3Igd2l0aCBlY2Mgb3BlbmVkIGFuZCB0aGVuIHRyeSB0byByYXcgcmVhZC4KPiA+PiBJ
cyB0aGVyZSBhIGdvb2QgaWRlYT8gIAo+ID4gCj4gPiBXaGVuIHJlYWRpbmcgd2l0aCBFQ0MgZW5h
YmxlZCwgaW4gY2FzZSBvZiB1bmNvcnJlY3RhYmxlIGVycm9yIHlvdQo+ID4gbXVzdCByZS1yZWFk
IHdpdGhvdXQgRUNDLCB0aGVuIGNoZWNrIGlmIHRoZSBwYWdlIGlzIGVtcHR5IG9yIG5vdCB3aXRo
Cj4gPiB0aGUgY29yZSBoZWxwZXJzIChuYW5kX2NoZWNrX2VyYXNlZF8qKCkpLgo+ID4gCj4gPiBJ
cyB0aGlzIHdoYXQgeW91IG1lYW50Pwo+ID4gICAKPiB5ZXMuIHdoZW4gdW5jb3JyZWN0YWJsZSBF
Q0MgZXJyb3IsIGkgbmVlZCBmaXJzdGx5IHJlYWQgb3V0IHRoZSBFQ0MgYnl0ZXMgd2l0aG91dCBF
Q0MgZW5naW5lIGFuZCB0aGVuIHVzZSB0aGUgaGVscGVyIG5hbmRfY2hlY2tfZXJhc2VkX2VjY19j
aHVuayB0byBjaGVjayBpZiBibGFuayBwYWdlLgo+IE9mIGNvdXJzZSwgdGhlIHByZWNvbmRpdGlv
biBpcyB3aXRob3V0IHNjcmFtYmxlciwgb3IgdGhlIGJsYW5kIHBhZ2UgY2FuIGJlIGRldGVjdGVk
IGJ5IG1lc29uIE5GQy4KCkEgc3VwcG9zZSB5b3UgbWVhbnQgImJsYW5rIHBhZ2UiPyBJZiB5ZXMs
IHRoZW4geW91IGRvbid0IG5lZWQgdGhlCmhlbHBlciB0byBjaGVjayBmb3Igb25seS0weEZGIHBh
Z2VzLiBJZiB0aGUgY29udHJvbGxlciB0ZWxscyB5b3UgaWYgdGhlCnBhZ2Ugd2FzIGJsYW5rLCB0
aGVuIGp1c3QgY2hlY2sgZm9yIHRoYXQgYml0LgoKClRoYW5rcywKTWlxdcOobAoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBt
YWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
