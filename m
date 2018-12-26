Return-Path: <SRS0=N/t3=PD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B696DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 10:39:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D1D921720
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 10:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qA6kjs7D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D1D921720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=magewell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=w5y4yz9CACiI4f5kJkUqlS7R3t0+hpMqoM47vGY5joc=; b=qA6kjs7DusRWjd
	3bTaK6Hgex5pS0/Um5gs08fYxYsxQ6Im9pYObezMHKvQCXzRqGT6l1nFpiQLUUHOwGcQoFUlNQPco
	ubJgK72P2ydzJnqABuvQchEEVWLueoC8t7HaTII7ykf0nY4JGz1kGw3tw9X5siiN5xoubyV30X12B
	q0OenuEsFXjCKLcU18P+Okdjal55TKpVxHPO3tjHXzdG6ew2I1HwnBQcw8VJcOgJ4G9KI/X10KCAD
	7f2bZbm0Y/5cXH8KbXHhFdeIuXt0DYW/G1OTLbHtV16cJqi/03Oe/1TZ1B3TJAtUfS6my9+HYasxg
	07Sg4eGyMstKXeypKgPQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gc6ai-0000bk-CL; Wed, 26 Dec 2018 10:39:08 +0000
Received: from out20-1.mail.aliyun.com ([115.124.20.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gc6ae-0000Np-A9
 for linux-arm-kernel@lists.infradead.org; Wed, 26 Dec 2018 10:39:06 +0000
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.08374568|-1; CH=green;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03294; MF=yong.deng@magewell.com; NM=1; PH=DS;
 RN=24; RT=24; SR=0; TI=SMTPD_---.DdCL9.._1545820694; 
Received: from John(mailfrom:yong.deng@magewell.com
 fp:SMTPD_---.DdCL9.._1545820694)
 by smtp.aliyun-inc.com(10.147.42.22); Wed, 26 Dec 2018 18:38:15 +0800
Date: Wed, 26 Dec 2018 18:38:15 +0800
From: Yong <yong.deng@magewell.com>
To: megous@megous.com
Subject: Re: [linux-sunxi] [PATCH v12 0/2] Initial Allwinner V3s CSI Support
Message-Id: <20181226183815.81443b67313823e4fd7788eb@magewell.com>
In-Reply-To: <20181226102936.2xxu7lii4kcg7656@core.my.home>
References: <1540886988-27696-1-git-send-email-yong.deng@magewell.com>
 <20181226102936.2xxu7lii4kcg7656@core.my.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181226_023904_529614_F5C53314 
X-CRM114-Status: GOOD (  14.86  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Neil Armstrong <narmstrong@baylibre.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 =?UTF-8?B?J09uZMWZZWo=?= Jirman' via linux-sunxi
 <linux-sunxi@googlegroups.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Chen-Yu Tsai <wens@csie.org>, Hans Verkuil <hans.verkuil@cisco.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>,
 Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Todor Tomov <todor.tomov@linaro.org>, Jacopo Mondi <jacopo+renesas@jmondi.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGksCgpPbiBXZWQsIDI2IERlYyAyMDE4IDExOjI5OjM2ICswMTAwCidPbmTFmWVqIEppcm1hbicg
dmlhIGxpbnV4LXN1bnhpIDxsaW51eC1zdW54aUBnb29nbGVncm91cHMuY29tPiB3cm90ZToKCj4g
SGVsbG8sCj4gCj4gT24gVHVlLCBPY3QgMzAsIDIwMTggYXQgMDQ6MDk6NDhQTSArMDgwMCwgWW9u
ZyBEZW5nIHdyb3RlOgo+ID4gSSBjYW4ndCBtYWtlIHY0bDItY29tcGxpYW5jZSBhbHdheXMgaGFw
cHkuCj4gPiBUaGUgVjNzIENTSSBzdXBwb3J0IG1hbnkgcGl4Zm9ybWF0cy4gQnV0IHRoZXkgYXJl
IG5vdCBhbHdheXMgYXZhaWxhYmxlLgo+ID4gSXQncyBkZXBlbmRlbnQgb24gdGhlIGlucHV0IGJ1
cyBmb3JtYXQgKE1FRElBX0JVU19GTVRfKikuIAo+ID4gRXhhbXBsZToKPiA+IFY0TDJfUElYX0ZN
VF9TQkdHUjg6IE1FRElBX0JVU19GTVRfU0JHR1I4XzFYOAo+ID4gVjRMMl9QSVhfRk1UX1lVWVY6
IE1FRElBX0JVU19GTVRfWVVZVjhfMlg4Cj4gPiBCdXQgSSBjYW4ndCBnZXQgdGhlIHN1YmRldidz
IGZvcm1hdCBjb2RlIGJlZm9yZSBzdGFydGluZyBzdHJlYW0gYXMgdGhlCj4gPiBzdWJkZXYgbWF5
IGNoYW5nZSBpdC4gU28gSSBjYW4ndCBrbm93IHdoaWNoIHBpeGZvcm1hdHMgYXJlIGF2YWlsYWJs
ZS4KPiA+IFNvIEkgZXhwb3J0cyBhbGwgdGhlIHBpeGZvcm1hdHMgc3VwcG9ydGVkIGJ5IFNvQy4K
PiA+IFRoZSByZXN1bHQgaXMgdGhlIGFwcCAodjRsMi1jb21wbGlhbmNlKSBpcyBsaWtlbHkgdG8g
ZmFpbCBvbiBzdHJlYW1vbi4KPiA+IAo+ID4gVGhpcyBwYXRjaHNldCBhZGQgaW5pdGlhbCBzdXBw
b3J0IGZvciBBbGx3aW5uZXIgVjNzIENTSS4KPiAKPiBJJ3ZlIHRlc3RlZCB5b3VyIHBhdGNoZXMg
b24gQTgzVCBhbmQgQ1NJIHdvcmtzIG9uIHRoYXQgU29DIHRvby4gSSdsbCBzZW5kCj4gRFRTIHBh
dGNoZXMgbGF0ZXIuCj4gCj4gT25lIHRoaW5nIEkgbm90aWNlZCBpcyB0aGF0LCB3aGVuIHlvdSBj
YXQgdGhlIHJlZ21hcCByZWdpc3RlcnMgZmlsZSBpbiBkZWJ1Z2ZzCj4gd2hpbGUgc3RyZWFtaW5n
LCB0aGUga2VybmVsIGxvY2tzIHVwIGhhcmQuIEkgd2FzIG5vdCBhYmxlIHRvIGV4dHJhY3QgYW55
IGxvZ3MuCgpNYXkgYmUgc29tZSByZWdpc3RlcnMgY2FuJ3QgYmUgcmVhZCB3aGVuIHN0cmVhbWlu
ZyA/IExpa2UgcmVhZC1jbGVhciByZWdzID8KT3IgbXVsdGkgQ1BVIGNvcmUgYWNjZXNzIHJlZ3Mg
YXQgdGhlIHNhbWUgdGltZSBtYXkgY2F1c2UgdGhlIGJ1cyBsb2NrIHVwPwoKVGhhbmtzLApZb25n
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1h
cm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0t
a2VybmVsCg==
