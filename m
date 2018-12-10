Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508FAC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:51:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DE8820851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CLvl/1R1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DE8820851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4bdmcUbx28IA4bYH+cVA69BCY8WBQGxDHowD1oSX3oI=; b=CLvl/1R1tDu6aV
	QZ8uaESdqqmNyA9OMW9h+d56DtgLs54yho+PYyDWatZw76cVtBKD+HbfTpI1bkJA6AlNbL/T/30KE
	9Wt6W+JHjBXSYBncQCmJuqhsqSw5AYMP32HdtJb69/4IHHMMbdTGmOA0qDwNPCOFYQApQhBQqIRRQ
	6Jih1xHlkXFAmHG1k9RsP3YsWtRy7v+Ds4HFn/wG9bRTTQ31lKhA6UobBwl9ZoTl3PjG6MvLMQKJD
	fFeFeQlPpONaJHiqWPFtuqqoBP9zrXKQEdo+ZjdR61rg8jIWAZZiAlkO5qIJUqgfVm/Qk68RQUUvw
	Fh/raLdmhJfIQ1GJBKTA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWMu0-0002Gr-PN; Mon, 10 Dec 2018 14:51:20 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWMtr-0002EE-H9; Mon, 10 Dec 2018 14:51:17 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 5EF5820CEB; Mon, 10 Dec 2018 15:50:58 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr
 [90.88.21.44])
 by mail.bootlin.com (Postfix) with ESMTPSA id E516320CE8;
 Mon, 10 Dec 2018 15:50:57 +0100 (CET)
Date: Mon, 10 Dec 2018 15:50:57 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Liang Yang <liang.yang@amlogic.com>
Subject: Re: [PATCH v7 2/2] mtd: rawnand: meson: add support for Amlogic
 NAND flash controller
Message-ID: <20181210155057.38788656@xps13>
In-Reply-To: <79a797c2-f37f-7f7c-e907-2d3c2283ec2d@amlogic.com>
References: <1542386439-30166-1-git-send-email-jianxin.pan@amlogic.com>
 <1542386439-30166-3-git-send-email-jianxin.pan@amlogic.com>
 <20181207102456.1dc67e07@xps13>
 <823825a3-86fb-9a20-ae29-85cc52d44093@amlogic.com>
 <20181210123809.5ade45c4@bbrezillon>
 <79a797c2-f37f-7f7c-e907-2d3c2283ec2d@amlogic.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_065111_698733_A59C1AF6 
X-CRM114-Status: GOOD (  15.36  )
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

SGkgTGlhbmcsCgpMaWFuZyBZYW5nIDxsaWFuZy55YW5nQGFtbG9naWMuY29tPiB3cm90ZSBvbiBN
b24sIDEwIERlYyAyMDE4IDIwOjEyOjM5CiswODAwOgoKPiBPbiAyMDE4LzEyLzEwIDE5OjM4LCBC
b3JpcyBCcmV6aWxsb24gd3JvdGU6Cj4gPiBPbiBNb24sIDEwIERlYyAyMDE4IDE5OjIzOjQ2ICsw
ODAwCj4gPiBMaWFuZyBZYW5nIDxsaWFuZy55YW5nQGFtbG9naWMuY29tPiB3cm90ZToKPiA+ICAg
Cj4gPj4+PiArCQkJbXRkLT5lY2Nfc3RhdHMuZmFpbGVkKys7Cj4gPj4+PiArCQkJY29udGludWU7
Cj4gPj4+PiArCQl9Cj4gPj4+PiArCQltdGQtPmVjY19zdGF0cy5jb3JyZWN0ZWQgKz0gRUNDX0VS
Ul9DTlQoKmluZm8pOwo+ID4+Pj4gKwkJYml0ZmxpcHMgPSBtYXhfdCh1MzIsIGJpdGZsaXBzLCBF
Q0NfRVJSX0NOVCgqaW5mbykpOwo+ID4+Pj4gKwl9ICAKPiA+Pj4KPiA+Pj4gQXJlIHlvdSBzdXJl
IHlvdSBoYW5kbGUgY29ycmVjdGx5IGVtcHR5IHBhZ2VzIHdpdGggYmY/ICAKPiA+Pj4gICAgPj4g
aWYgc2NyYW1ibGUgaXMgZW5hYmxlLCBpIHdvdWxkIHNheSB5ZXMgaGVyZS4gIAo+ID4+IHdoZW4g
c2NyYW1ibGUgaXMgZGlzYWJsZWQsIGkgYW0gY29uc2lkZXJpbmcgaG93IHRvIHVzZSB0aGUgaGVs
cGVyCj4gPj4gbmFuZF9jaGVja19lcmFzZWRfZWNjX2NodW5rLCBidXQgaXQgc2VlbXMgdGhhdCBp
IGNhbid0IGdldCB0aGUgZWNjCj4gPj4gYnl0ZXMgd2hpY2ggaXMgY2FjdWxhdGVkIGJ5IGVjYyBl
bmdpbmUuYnkgdGhlIHdheSwgbmZjIGRtYSBkb2Vzbid0IHNlbmQKPiA+PiBvdXQgdGhlIGVjYyBw
YXJpdHkgYnl0ZXMuICAKPiA+IAo+ID4gRXZlbiBpZiB0aGUgRUNDIGVuZ2luZSBpcyBkaXNhYmxl
ZD8KPiA+ICAgCj4gTm8uCj4gV2hlbiBFQ0MgZW5naW5lIGlzIGRpc2FibGVkLCBpdCBjYW4gcmVh
ZCB0aGUgZWNjIHBhcml0eSBieXRlcyA7IGJ1dCB0aGVyZSBpcyBhbm90aGVyIHByb2JsZW0gdGhh
dCBpIG5lZWQgdG8gY29uc2lkZXIgaG93IGNvZGUgc3RydWN0IGxvb2tzIGJldHRlciB3aGVuIHJl
YWRpbmcgZXJyb3Igd2l0aCBlY2Mgb3BlbmVkIGFuZCB0aGVuIHRyeSB0byByYXcgcmVhZC4KPiBJ
cyB0aGVyZSBhIGdvb2QgaWRlYT8KCldoZW4gcmVhZGluZyB3aXRoIEVDQyBlbmFibGVkLCBpbiBj
YXNlIG9mIHVuY29ycmVjdGFibGUgZXJyb3IgeW91Cm11c3QgcmUtcmVhZCB3aXRob3V0IEVDQywg
dGhlbiBjaGVjayBpZiB0aGUgcGFnZSBpcyBlbXB0eSBvciBub3Qgd2l0aAp0aGUgY29yZSBoZWxw
ZXJzIChuYW5kX2NoZWNrX2VyYXNlZF8qKCkpLgoKSXMgdGhpcyB3aGF0IHlvdSBtZWFudD8KClRo
YW5rcywKTWlxdcOobAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtYXJtLWtlcm5lbAo=
