Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8EEC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:12:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C300E20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m5la1Z6M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C300E20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=f7aLzkp30e8hDXpTzjoSHVSZIEfSSjae5aC3bVHEXcE=; b=m5la1Z6MjqiWGo
	rLsH99ECLAinFekT1za6/6mqduOBktB1mBlrH+M3h9dUAbbhHST+hGEJwY+X7TQ0D96sEuuk58I7+
	dgWppFl+oBCHfmqldOnszQL6+HdzQSUVodNXL5NGe/IDqJp6gOZ98jHZrw2UrHi2ugJ7iK2QE9TF/
	pWl7u11+QOFbHGtA7fr2WLZ1ZblIBQU/z4CCOClxxIE1yChtzax/kExJ0/j7dSrc3dlrmEjxzCvjK
	YwLTNOWwx+FNNnsx50MBtgAkIpXWGOY1f7utst/LX9BXCL06KoZ1/Szgd4qSq/4OOjSQp2Ka4YcLe
	fXph94BMarWW0d9tet8A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUrZz-000504-Gm; Thu, 06 Dec 2018 11:12:27 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUrZv-0004yY-SQ
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 11:12:25 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gUrZd-0003iR-4q; Thu, 06 Dec 2018 12:12:05 +0100
Message-ID: <1544094724.3709.60.camel@pengutronix.de>
Subject: Re: [PATCH 3/5] irqchip/irq-imx-gpcv2: Make use of BIT() macro
From: Lucas Stach <l.stach@pengutronix.de>
To: Andrey Smirnov <andrew.smirnov@gmail.com>, Marc Zyngier
 <marc.zyngier@arm.com>
Date: Thu, 06 Dec 2018 12:12:04 +0100
In-Reply-To: <20181206073125.7255-4-andrew.smirnov@gmail.com>
References: <20181206073125.7255-1-andrew.smirnov@gmail.com>
 <20181206073125.7255-4-andrew.smirnov@gmail.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_031224_070705_B925AD88 
X-CRM114-Status: GOOD (  12.60  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>,
 Jason Cooper <jason@lakedaemon.net>, linux-kernel@vger.kernel.org,
 linux-imx@nxp.com, Thomas Gleixner <tglx@linutronix.de>,
 Leonard Crestez <leonard.crestez@nxp.com>, cphealy@gmail.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QW0gTWl0dHdvY2gsIGRlbiAwNS4xMi4yMDE4LCAyMzozMSAtMDgwMCBzY2hyaWViIEFuZHJleSBT
bWlybm92Ogo+IENvbnZlcnQgYWxsIGluc3RhbmNlcyBvZiAxIDw8IHggdG8gQklUKHgpIGZvciBj
b25zaXN0ZW5jeSB3aXRoIG90aGVyCj4ga2VybmVsIGNvZGUuCj4gCj4gQ2M6IFRob21hcyBHbGVp
eG5lciA8dGdseEBsaW51dHJvbml4LmRlPgo+IENjOiBKYXNvbiBDb29wZXIgPGphc29uQGxha2Vk
YWVtb24ubmV0Pgo+IENjOiBNYXJjIFp5bmdpZXIgPG1hcmMuenluZ2llckBhcm0uY29tPgo+IENj
OiBjcGhlYWx5QGdtYWlsLmNvbQo+IENjOiBsLnN0YWNoQHBlbmd1dHJvbml4LmRlCj4gQ2M6IExl
b25hcmQgQ3Jlc3RleiA8bGVvbmFyZC5jcmVzdGV6QG54cC5jb20+Cj4gQ2M6ICJBLnMuIERvbmci
IDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4KPiBDYzogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBu
eHAuY29tPgo+IENjOiBsaW51eC1pbXhAbnhwLmNvbQo+IENjOiBsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmcKPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZwo+IFNp
Z25lZC1vZmYtYnk6IEFuZHJleSBTbWlybm92IDxhbmRyZXcuc21pcm5vdkBnbWFpbC5jb20+CgpS
ZXZpZXdlZC1ieTogTHVjYXMgU3RhY2ggPGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU+Cgo+IC0tLQo+
IMKgZHJpdmVycy9pcnFjaGlwL2lycS1pbXgtZ3BjdjIuYyB8IDYgKysrLS0tCj4gwqAxIGZpbGUg
Y2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2lycWNoaXAvaXJxLWlteC1ncGN2Mi5jIGIvZHJpdmVycy9pcnFjaGlwL2lycS0K
PiBpbXgtZ3BjdjIuYwo+IGluZGV4IGIyNjJiYThiMjY1Mi4uMDc3ZDU2YjMxODNhIDEwMDY0NAo+
IC0tLSBhL2RyaXZlcnMvaXJxY2hpcC9pcnEtaW14LWdwY3YyLmMKPiArKysgYi9kcml2ZXJzL2ly
cWNoaXAvaXJxLWlteC1ncGN2Mi5jCj4gQEAgLTc4LDcgKzc4LDcgQEAgc3RhdGljIGludCBpbXhf
Z3BjdjJfaXJxX3NldF93YWtlKHN0cnVjdCBpcnFfZGF0YQo+ICpkLCB1bnNpZ25lZCBpbnQgb24p
Cj4gwqAJdTMyIG1hc2ssIHZhbDsKPiDCoAo+IMKgCXJhd19zcGluX2xvY2tfaXJxc2F2ZSgmY2Qt
PnJsb2NrLCBmbGFncyk7Cj4gLQltYXNrID0gMSA8PCBkLT5od2lycSAlIDMyOwo+ICsJbWFzayA9
IEJJVChkLT5od2lycSAlIDMyKTsKPiDCoAl2YWwgPSBjZC0+d2FrZXVwX3NvdXJjZXNbaWR4XTsK
PiDCoAo+IMKgCWNkLT53YWtldXBfc291cmNlc1tpZHhdID0gb24gPyAodmFsICYgfm1hc2spIDog
KHZhbCB8IG1hc2spOwo+IEBAIC0xMDEsNyArMTAxLDcgQEAgc3RhdGljIHZvaWQgaW14X2dwY3Yy
X2lycV91bm1hc2soc3RydWN0IGlycV9kYXRhCj4gKmQpCj4gwqAJcmF3X3NwaW5fbG9jaygmY2Qt
PnJsb2NrKTsKPiDCoAlyZWcgPSBncGN2Ml9pZHhfdG9fcmVnKGNkLCBkLT5od2lycSAvIDMyKTsK
PiDCoAl2YWwgPSByZWFkbF9yZWxheGVkKHJlZyk7Cj4gLQl2YWwgJj0gfigxIDw8IGQtPmh3aXJx
ICUgMzIpOwo+ICsJdmFsICY9IH5CSVQoZC0+aHdpcnEgJSAzMik7Cj4gwqAJd3JpdGVsX3JlbGF4
ZWQodmFsLCByZWcpOwo+IMKgCXJhd19zcGluX3VubG9jaygmY2QtPnJsb2NrKTsKPiDCoAo+IEBA
IC0xMTcsNyArMTE3LDcgQEAgc3RhdGljIHZvaWQgaW14X2dwY3YyX2lycV9tYXNrKHN0cnVjdCBp
cnFfZGF0YQo+ICpkKQo+IMKgCXJhd19zcGluX2xvY2soJmNkLT5ybG9jayk7Cj4gwqAJcmVnID0g
Z3BjdjJfaWR4X3RvX3JlZyhjZCwgZC0+aHdpcnEgLyAzMik7Cj4gwqAJdmFsID0gcmVhZGxfcmVs
YXhlZChyZWcpOwo+IC0JdmFsIHw9IDEgPDwgKGQtPmh3aXJxICUgMzIpOwo+ICsJdmFsIHw9IEJJ
VChkLT5od2lycSAlIDMyKTsKPiDCoAl3cml0ZWxfcmVsYXhlZCh2YWwsIHJlZyk7Cj4gwqAJcmF3
X3NwaW5fdW5sb2NrKCZjZC0+cmxvY2spOwo+IMKgCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
