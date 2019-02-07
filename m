Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B334EC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:28:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82FE3218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NdFsj+rT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82FE3218D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Lo58KIwaAnf2H9iBKQ7CoE3AnOc4x3dfCOZ5HHVsWeY=; b=NdFsj+rTdM0pLA
	K4V0Jtc2oj8kLy71lO2pENLa4x5HMc9GiiNdHx8LYTIbSzzb3/8OHKGV1B2HrzBEGPx6f7dYMd6vg
	suONZdR6cmVnTvy/J06cYX3TUTl4mfnUx3gc1iND9IA12LLhtgrWz7alDXERu6feNuTASWLEKTBDJ
	swCNdHfub4NzctQbyB7v6GHXmbFqsDQ4GHIdemeFwwPzwDMmAhxLJ57uU/NNH8P93HsPbHA4aCDty
	DLhkAKgZYHyj8AAvOPeUrtw9TKbQYfC0+BX+bNv4+7fqI2WrUzz7KgKmXE0vH9VOz5cC/G3N/694y
	/gwleNMHZDlT44A+mNug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grkf0-0002dE-AB; Thu, 07 Feb 2019 14:28:14 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grkeq-0002Qw-SR
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 14:28:09 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1grkei-0007al-Q9; Thu, 07 Feb 2019 15:27:56 +0100
Message-ID: <1549549676.2544.79.camel@pengutronix.de>
Subject: Re: [RFC 4/5] arm64: dts: Add nodes for PCIe IP blocks
From: Lucas Stach <l.stach@pengutronix.de>
To: Andrey Smirnov <andrew.smirnov@gmail.com>, Shawn Guo <shawnguo@kernel.org>
Date: Thu, 07 Feb 2019 15:27:56 +0100
In-Reply-To: <20190131204333.31846-5-andrew.smirnov@gmail.com>
References: <20190131204333.31846-1-andrew.smirnov@gmail.com>
 <20190131204333.31846-5-andrew.smirnov@gmail.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_062805_623214_69A8ACCA 
X-CRM114-Status: GOOD (  15.32  )
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
 linux-kernel@vger.kernel.org, linux-imx@nxp.com,
 Fabio Estevam <fabio.estevam@nxp.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, Chris Healy <cphealy@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QW0gRG9ubmVyc3RhZywgZGVuIDMxLjAxLjIwMTksIDEyOjQzIC0wODAwIHNjaHJpZWIgQW5kcmV5
IFNtaXJub3Y6Cj4gQWRkIG5vZGVzIGZvciB0d28gUENJZSBjb250cm9sbGVycyBmb3VuZCBvbiBp
Lk1YOE1RLgo+IAo+ID4gU2lnbmVkLW9mZi1ieTogQW5kcmV5IFNtaXJub3YgPGFuZHJldy5zbWly
bm92QGdtYWlsLmNvbT4KPiA+IENjOiBTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+Cj4g
PiBDYzogRmFiaW8gRXN0ZXZhbSA8ZmFiaW8uZXN0ZXZhbUBueHAuY29tPgo+ID4gQ2M6IENocmlz
IEhlYWx5IDxjcGhlYWx5QGdtYWlsLmNvbT4KPiA+IENjOiBMdWNhcyBTdGFjaCA8bC5zdGFjaEBw
ZW5ndXRyb25peC5kZT4KPiA+IENjOiBMZW9uYXJkIENyZXN0ZXogPGxlb25hcmQuY3Jlc3RlekBu
eHAuY29tPgo+ID4gQ2M6ICJBLnMuIERvbmciIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4KPiA+IENj
OiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+Cj4gQ2M6IGxpbnV4LWlteEBueHAu
Y29tCj4gQ2M6IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwo+IENjOiBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnCj4gLS0tCj4gwqBhcmNoL2FybTY0L2Jvb3QvZHRzL2Zy
ZWVzY2FsZS9pbXg4bXEuZHRzaSB8IDY4ICsrKysrKysrKysrKysrKysrKysrKysrCj4gwqAxIGZp
bGUgY2hhbmdlZCwgNjggaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0
L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXEuZHRzaSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJl
ZXNjYWxlL2lteDhtcS5kdHNpCj4gaW5kZXggODliYWJjNTMxMzgwLi5kMjBlNWM3ZTIxYTMgMTAw
NjQ0Cj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1xLmR0c2kKPiAr
KysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXEuZHRzaQo+IEBAIC02LDYg
KzYsNyBAQAo+IMKgCj4gwqAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvY2xvY2svaW14OG1xLWNsb2Nr
Lmg+Cj4gwqAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvcG93ZXIvaW14OG1xLXBvd2VyLmg+Cj4gKyNp
bmNsdWRlIDxkdC1iaW5kaW5ncy9yZXNldC9pbXg4bXEtcmVzZXQuaD4KPiDCoCNpbmNsdWRlIDxk
dC1iaW5kaW5ncy9ncGlvL2dwaW8uaD4KPiDCoCNpbmNsdWRlIDxkdC1iaW5kaW5ncy9pbnRlcnJ1
cHQtY29udHJvbGxlci9hcm0tZ2ljLmg+Cj4gwqAjaW5jbHVkZSAiaW14OG1xLXBpbmZ1bmMuaCIK
PiBAQCAtNTM5LDYgKzU0MCw3MyBAQAo+IMKgCQkJfTsKPiDCoAkKPiAJfTsKPiDCoAo+ICsJCXBj
aWUwOiBwY2llQDMzODAwMDAwIHsKPiArCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14OG1xLXBjaWUi
Owo+ICsJCQlyZWcgPSA8MHgzMzgwMDAwMCAweDQwMDAwMD4sCj4gKwkJCcKgwqDCoMKgwqDCoDww
eDFmZjAwMDAwIDB4ODAwMDA+Owo+ICsJCQlyZWctbmFtZXMgPSAiZGJpIiwgImNvbmZpZyI7Cj4g
KwkJCSNhZGRyZXNzLWNlbGxzID0gPDM+Owo+ICsJCQkjc2l6ZS1jZWxscyA9IDwyPjsKPiArCQkJ
ZGV2aWNlX3R5cGUgPSAicGNpIjsKPiArCQkJYnVzLXJhbmdlID0gPDB4MDAgMHhmZj47Cj4gKwkJ
CXJhbmdlcyA9IDwweDgxMDAwMDAwIDAgMHgwMDAwMDAwMCAweDFmZjgwMDAwIDAgMHgwMDAxMDAw
MCAvKiBkb3duc3RyZWFtIEkvTyA2NEtCICovCj4gKwkJCcKgwqDCoMKgwqDCoMKgwqDCoMKgMHg4
MjAwMDAwMCAwIDB4MTgwMDAwMDAgMHgxODAwMDAwMCAwIDB4MDdmMDAwMDA+OyAvKiBub24tcHJl
ZmV0Y2hhYmxlIG1lbW9yeSAqLwo+ICsJCQludW0tbGFuZXMgPSA8MT47Cj4gKwkJCWludGVycnVw
dHMgPSA8R0lDX1NQSSAxMjIgSVJRX1RZUEVfTEVWRUxfSElHSD4sCj4gKwkJCcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgPEdJQ19TUEkgMTI3IElSUV9UWVBFX0xFVkVMX0hJR0g+OyAvKiBlRE1B
ICovCgpJIGRvbid0IHRoaW5rIHRoaXMgSVJRIGlzIGRvY3VtZW50ZWQgaW4gYW55IGJpbmRpbmcg
eWV0LgoKPiArCQkJaW50ZXJydXB0LW5hbWVzID0gIm1zaSI7Cj4gKwkJCSNpbnRlcnJ1cHQtY2Vs
bHMgPSA8MT47Cj4gKwkJCWludGVycnVwdC1tYXAtbWFzayA9IDwwIDAgMCAweDc+Owo+ICsJCQlp
bnRlcnJ1cHQtbWFwID0gPDAgMCAwIDEgJmdpYyBHSUNfU1BJIDEyNSBJUlFfVFlQRV9MRVZFTF9I
SUdIPiwKPiArCQkJwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqA8MCAwIDAgMiAmZ2lj
IEdJQ19TUEkgMTI0IElSUV9UWVBFX0xFVkVMX0hJR0g+LAo+ICsJCQnCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoDwwIDAgMCAzICZnaWMgR0lDX1NQSSAxMjMgSVJRX1RZUEVfTEVWRUxf
SElHSD4sCj4gKwkJCcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgPDAgMCAwIDQgJmdp
YyBHSUNfU1BJIDEyMiBJUlFfVFlQRV9MRVZFTF9ISUdIPjsKPiArCQkJY2xvY2tzID0gPCZjbGsg
SU1YOE1RX0NMS19QQ0lFMV9ST09UPiwKPiArCQkJwqDCoMKgwqDCoMKgwqDCoMKgPCZjbGsgSU1Y
OE1RX0NMS19QQ0lFMV9BVVg+LAoKVGhpcyBpcyBub3QgdGhlIFBDSWUgYnVzIGNsb2NrLiBUaGUg
YnVzIGNsb2NrIGlzIHdoYXRldmVyIGRyaXZlcyB0aGUKcmVmIGNsb2NrIG9mIHRoZSBleHRlcm5h
bCBidXMuIFNvIG9uIHRoZSBpLk1YOE0tRVZLIHRoaXMgd291bGQgYmUgdGhlCmZpeGVkIGNsb2Nr
IGdlbmVyYXRlZCBieSBVMTMwMi4KClRoZSByaWdodCB0aGluZyB0byBwcm9wZXJseSBkZXNjcmli
ZSB0aGUgSFcgaXMgdG8gZXh0ZW5kIHRoZSBQQ0llCmRyaXZlciB0byBsb29rIGZvciB0aGUgYXV4
IGNsb2NrIG9uIGkuTVg4TSwganVzdCBsaWtlIHdlIGRvIHdpdGggdGhlCmF4aV9pbmJvdW5kX2Ns
ayBvbiBpLk1YNlNYLgoKUmVnYXJkcywKTHVjYXMKCj4gKwkJCcKgwqDCoMKgwqDCoMKgwqDCoDwm
Y2xrIElNWDhNUV9DTEtfUENJRTFfUEhZPjsKPiArCQkJY2xvY2stbmFtZXMgPSAicGNpZSIsICJw
Y2llX2J1cyIsICJwY2llX3BoeSI7Cj4gKwkJCWZzbCxtYXgtbGluay1zcGVlZCA9IDwyPjsKPiAr
CQkJcG93ZXItZG9tYWlucyA9IDwmcGdjX3BjaWU+Owo+ICsJCQlyZXNldHMgPSA8JnNyYyBJTVg4
TVFfUkVTRVRfUENJRVBIWT4sCj4gKwkJCcKgwqDCoMKgwqDCoMKgwqDCoDwmc3JjIElNWDhNUV9S
RVNFVF9QQ0lFX0NUUkxfQVBQU19FTj4sCj4gKwkJCcKgwqDCoMKgwqDCoMKgwqDCoDwmc3JjIElN
WDhNUV9SRVNFVF9QQ0lFX0NUUkxfQVBQU19UVVJOT0ZGPjsKPiArCQkJcmVzZXQtbmFtZXMgPSAi
cGNpZXBoeSIsICJhcHBzIiwgInR1cm5vZmYiOwo+ICsJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOwo+
ICsJCX07Cj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1hcm0ta2VybmVsCg==
