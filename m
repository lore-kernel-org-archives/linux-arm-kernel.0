Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4904EC10F04
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:26:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 190CB222DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X56wCj8a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 190CB222DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Yt/Ak9j1+/RfyzyYa4tP/ssaBai5Rjt7HxopB5iBI+4=; b=X56wCj8aNOyAd2
	rsUFKnXQVwud113KDx6eNY04B3SS7pk1QDjLgj0DQ0KtEQporEU3myOJ32Ek474AahARzXihptuTa
	gvOYefKCDXhYvFjUdDmSpiV6ZUaU0x25iCY6jYsv3uEwivcLTURi3u8DSInIlgVgwqIMRftXiRXeY
	8Ppzw1bCbPI0MUxOUvlZ36NYdnfnmuJJvlM+x04GWS1GZ9IHDHWbgXkEepcMwh7AFbCBSCP1VfNH7
	tMU10/JFXCBUvnIG8neJUHyyQr2eUxBptSqQ7KY0Zd7AljjjbdWCE3IRgQXkPmEHExTgD0vTDOYKd
	gEJnIkHFHnEZHHjrtdXQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guKmW-0002go-JQ; Thu, 14 Feb 2019 17:26:40 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guKmR-0002aB-Qn
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 17:26:39 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1guKmI-0007L2-HG; Thu, 14 Feb 2019 18:26:26 +0100
Message-ID: <1550165185.2546.48.camel@pengutronix.de>
Subject: Re: [RFC 5/5] arm64: dts: imx8mq: Add the opp table and the
 cpu-supply nodes
From: Lucas Stach <l.stach@pengutronix.de>
To: Abel Vesa <abel.vesa@nxp.com>
Date: Thu, 14 Feb 2019 18:26:25 +0100
In-Reply-To: <20190214171806.kufhw7ouguxt5jhq@fsr-ub1664-175>
References: <1550084693-9797-1-git-send-email-abel.vesa@nxp.com>
 <1550084693-9797-6-git-send-email-abel.vesa@nxp.com>
 <1550159428.2546.40.camel@pengutronix.de>
 <20190214171806.kufhw7ouguxt5jhq@fsr-ub1664-175>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_092636_076325_037CE88D 
X-CRM114-Status: GOOD (  19.05  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
 Anson Huang <anson.huang@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Mike Turquette <mturquette@baylibre.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, Sascha Hauer <kernel@pengutronix.de>,
 Angus Ainslie <angus.ainslie@puri.sm>, Shawn Guo <shawnguo@kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QW0gRG9ubmVyc3RhZywgZGVuIDE0LjAyLjIwMTksIDE3OjE4ICswMDAwIHNjaHJpZWIgQWJlbCBW
ZXNhOgo+IE9uIDE5LTAyLTE0IDE2OjUwOjI4LCBMdWNhcyBTdGFjaCB3cm90ZToKPiA+IEhpIEFi
ZWwKPiA+IAo+ID4gQW0gTWl0dHdvY2gsIGRlbiAxMy4wMi4yMDE5LCAxOTowNSArMDAwMCBzY2hy
aWViIEFiZWwgVmVzYToKPiA+ID4gQWRkIHRoZSBvcHAgdGFibGUgY29udGFpbmluZyBvbmx5IG5v
biBvdmVyIGRyaXZlIG9wcHMuCj4gPiA+IEFsc28gYWRkIHRoZSBjcHUtc3VwcGx5IG5vZGVzIGZv
ciB0aGUgQTUzIGNvcmVzIGluIHRoZSBFVksgYm9hcmQuCj4gPiA+IAo+ID4gPiBTaWduZWQtb2Zm
LWJ5OiBBYmVsIFZlc2EgPGFiZWwudmVzYUBueHAuY29tPgo+ID4gPiAtLS0KPiA+ID4gwqBhcmNo
L2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXEtZXZrLmR0cyB8IDE3Cj4gPiA+ICsrKysr
KysrKysrKysrKysrCj4gPiA+IMKgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1x
LmR0c2nCoMKgwqDCoHwgMjMKPiA+ID4gKysrKysrKysrKysrKysrKysrKysrKysKPiA+ID4gwqAy
IGZpbGVzIGNoYW5nZWQsIDQwIGluc2VydGlvbnMoKykKPiA+ID4gCj4gPiA+IGRpZmYgLS1naXQg
YS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXEtZXZrLmR0cwo+ID4gPiBiL2Fy
Y2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcS1ldmsuZHRzCj4gPiA+IGluZGV4IDU0
NzM3YmYuLjExNDM1OWUgMTAwNjQ0Cj4gPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJl
ZXNjYWxlL2lteDhtcS1ldmsuZHRzCj4gPiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJl
ZXNjYWxlL2lteDhtcS1ldmsuZHRzCj4gPiA+IEBAIC0zMSw2ICszMSwyMyBAQAo+ID4gPiDCoAkJ
Z3BpbyA9IDwmZ3BpbzIgMTkgR1BJT19BQ1RJVkVfSElHSD47Cj4gPiA+IMKgCQllbmFibGUtYWN0
aXZlLWhpZ2g7Cj4gPiA+IMKgCX07Cj4gPiA+ICsKPiA+ID4gK307Cj4gPiA+ICsKPiA+ID4gKyZB
NTNfMCB7Cj4gPiA+ICsJY3B1LXN1cHBseSA9IDwmc3cxYV9yZWc+Owo+ID4gPiArfTsKPiA+ID4g
Kwo+ID4gPiArJkE1M18xIHsKPiA+ID4gKwljcHUtc3VwcGx5ID0gPCZzdzFhX3JlZz47Cj4gPiA+
ICt9Owo+ID4gPiArCj4gPiA+ICsmQTUzXzIgewo+ID4gPiArCWNwdS1zdXBwbHkgPSA8JnN3MWFf
cmVnPjsKPiA+ID4gK307Cj4gPiA+ICsKPiA+ID4gKyZBNTNfMyB7Cj4gPiA+ICsJY3B1LXN1cHBs
eSA9IDwmc3cxYV9yZWc+Owo+ID4gPiDCoH07Cj4gPiAKPiA+IFRoaXMgc2hvdWxkIGJlIGEgc2Vw
YXJhdGUgcGF0Y2guCj4gPiAKPiAKPiBPSywgd2lsbCBzZW5kIGFzIHNlcGFyYXRlIHBhdGNoZXMg
aW4gdGhlIG5leHQgdmVyc2lvbi4KPiAKPiA+IEFuZCBBRkFJQ1MgdGhpcyBpcyB3cm9uZywgc3cx
YSBvbiB0aGUgTVg4TS1FVksgaXMgdGhlIEdQVSBzdXBwbHksCj4gPiB0aGUKPiA+IENQVSBpcyBz
dXBwbGllZCBieSBhIGRlZGljYXRlZCBzd2l0Y2hlciB0aGF0IGlzIGNvbnRyb2xsZWQgdmlhIGEK
PiA+IEdQSU8uCj4gPiAKPiAKPiBIbW0sIEkgdGhpbmsgeW91J3JlIHJpZ2h0LiBBdCBsZWFzdCB0
aGlzIGlzIHdoYXQgdGhlIGZvbGxvd2luZwo+IGRvY3VtZW50IHNheXMuCj4gCj4gaHR0cHM6Ly93
d3cubW91c2VyLmNvbS9kcy8yLzMwMi9JTVg4TURRTFFFVktIVUctMTI4MDMzMy5wZGYKPiAKPiBT
byBJIGd1ZXNzIHRoaXMgbWVhbnMgdGhlcmUgd2lsbCBub3QgYmUgYW55IGNwdS1zdXBwbHkgcHJv
cGVydGllcy7CoAoKVGhlcmUgaXMgYSB2YXJpYWJsZSB2b2x0YWdlIENQVSBzdXBwbHksIGJ1dCB5
b3UgbmVlZCB0byBtb2RlbCBpdCBhcyBhCmdwaW8tcmVndWxhdG9yIGluIHRoZSBEVCwgaXQncyBu
b3QgcGFydCBvZiB0aGUgUE1JQyBwcm92aWRlZCByYWlscy4KClJlZ2FyZHMsCkx1Y2FzCgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtl
cm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5l
bAo=
