Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F353DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:06:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C070F20855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CI5lb+7E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C070F20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MxlAtXsc3Ac2H5J4hGEiP+YOqv5Db8JwDVbc0+UigDE=; b=CI5lb+7Epcmv5m
	qSL+nZqpgup39fAYGzMagd9kpDdPXRXD+dmle7IyEz3yPVDBZnIZ1WOjpIwFjjbVM2Y1uwFShXViF
	9pAVjgQZhLa5uk4+EiPHD5TxJLnZrAVlH4HrXlj510DmislGBG5uOkeyP9XGSTIpIibNpBauy1X58
	Ckk7KrxLCXS3x+By6f/AlRQvrqmTv0USMIiR+bbIQoK/ZezHY8RJ6nKihYgYBATK/8eunBDt9PAPM
	Fc4nvhyLoAobAqilcLSNlrtEPIAiDz2ryVixm8OhsXlcQ2BRwXh53aXlgXkWuWzG1/Zp7R561MMSx
	tGA7SBYBlvaRJ9U6z0Cg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwmBM-0000RG-Kz; Thu, 21 Feb 2019 11:06:24 +0000
Received: from relay2-d.mail.gandi.net ([217.70.183.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwmBI-0000QJ-TU; Thu, 21 Feb 2019 11:06:22 +0000
X-Originating-IP: 90.88.23.190
Received: from xps13 (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr
 [90.88.23.190]) (Authenticated sender: miquel.raynal@bootlin.com)
 by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id C73844000A;
 Thu, 21 Feb 2019 11:06:11 +0000 (UTC)
Date: Thu, 21 Feb 2019 12:06:10 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [RFC PATCH 02/27] mtd: nand: Compile in the NAND core by default
Message-ID: <20190221120610.5abb49ae@xps13>
In-Reply-To: <20190221115554.315fbd9b@kernel.org>
References: <20190221100216.25255-1-miquel.raynal@bootlin.com>
 <20190221100216.25255-3-miquel.raynal@bootlin.com>
 <20190221115554.315fbd9b@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_030621_107463_3C1383B1 
X-CRM114-Status: GOOD (  16.98  )
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
Cc: Mason Yang <masonccyang@mxic.com.tw>, Vignesh R <vigneshr@ti.com>,
 Tudor Ambarus <Tudor.Ambarus@microchip.com>, Julien Su <juliensu@mxic.com.tw>,
 Richard Weinberger <richard@nod.at>,
 Schrempf Frieder <frieder.schrempf@kontron.de>,
 Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgQm9yaXMsCgpCb3JpcyBCcmV6aWxsb24gPGJicmV6aWxsb25Aa2VybmVsLm9yZz4gd3JvdGUg
b24gVGh1LCAyMSBGZWIgMjAxOQoxMTo1NTo1NCArMDEwMDoKCj4gT24gVGh1LCAyMSBGZWIgMjAx
OSAxMTowMTo1MSArMDEwMAo+IE1pcXVlbCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5j
b20+IHdyb3RlOgo+IAo+ID4gRm9yY2UgdGhlIE5BTkQgY29yZSBiZSBjb21waWxlZC1pbiB3aGVu
IHVzaW5nIGFueSBraW5kIG9mIE5BTkQuICAKPiAKPiBXaHk/CgpCZWNhdXNlIGFsbCB0aGUgbG9n
aWMgdGhhdCBjb21lcyBsYXRlciBpbiB0aGUgc2VyaWVzIHJlbGllcyBvbiB0aGlzCmNoYW5nZS4g
SSBuZWVkIHRoZSBOQU5EIGNvcmUgdG8gYmUgY29tcGlsZWQtaW4sIGFzIHdlbGwgdGhlIEVDQyBl
bmdpbmUKY29yZSwgYXMgd2VsbCBhcyBldmVyeXRoaW5nIHRoYXQgaXMgc2hhcmVkIGJldHdlZW4g
cmF3IE5BTkQgYW5kClNQSS1OQU5EIHdoaWNoIEkgbW92ZSBpbiB0aGUgTkFORCBjb3JlLgoKPiAK
PiA+IAo+ID4gQWxzbyByZW1vdmUgdGhlIHJlZHVuZGFudCBkZXBlbmRlbmNpZXMgb24gTVREIHdo
aWNoIGlzIGVuZm9yY2VkIGJ5IHRoZQo+ID4gZ2FtZSBvZiB0aGUgaWYvZW5kaWYgYmxvY3MuCj4g
PiAKPiA+IFNpZ25lZC1vZmYtYnk6IE1pcXVlbCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxp
bi5jb20+Cj4gPiAtLS0KPiA+ICBkcml2ZXJzL210ZC9uYW5kL0tjb25maWcgICAgICAgICB8IDEy
ICsrKysrKysrKystLQo+ID4gIGRyaXZlcnMvbXRkL25hbmQvb25lbmFuZC9LY29uZmlnIHwgIDEg
LQo+ID4gIGRyaXZlcnMvbXRkL25hbmQvcmF3L0tjb25maWcgICAgIHwgIDEgLQo+ID4gIGRyaXZl
cnMvbXRkL25hbmQvc3BpL0tjb25maWcgICAgIHwgIDEgLQo+ID4gIDQgZmlsZXMgY2hhbmdlZCwg
MTAgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbXRkL25hbmQvS2NvbmZpZyBiL2RyaXZlcnMvbXRkL25hbmQvS2NvbmZpZwo+ID4gaW5k
ZXggNDk1NzUxZWQzZmQ3Li5lOGQyNmE3MTU5MjIgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL210
ZC9uYW5kL0tjb25maWcKPiA+ICsrKyBiL2RyaXZlcnMvbXRkL25hbmQvS2NvbmZpZwo+ID4gQEAg
LTEsNiArMSwxNCBAQAo+ID4gLWNvbmZpZyBNVERfTkFORF9DT1JFCj4gPiAtCXRyaXN0YXRlCj4g
PiArbWVudWNvbmZpZyBNVERfTkFORF9DT1JFCj4gPiArCXRyaXN0YXRlICJOQU5EIiAgCj4gCj4g
RGVmaW5pdGVseSBub3Qgc29tZXRoaW5nIHdlIHdhbnQgdG8gZXhwb3NlIGluIG1lbnVjb25maWcu
CgpJIGNvbnNpZGVyZWQgdGhlIE5BTkQgY29yZSBhcyBlc3NlbnRpYWwgd2hlbiB1c2luZyByYXcg
TkFORCBhbmQKU1BJLU5BTkQuIEhlbmNlLCB0dXJuaW5nIGl0IGludG8gYSBtZW51Y29uZmlnIG9w
dGlvbiBtYWtlIHRoZSB3aG9sZQpOQU5EIHN1YnN5c3RlbSBhdmFpbGFibGUgKG9yIG5vdCkgYW5k
IHdpbGwgYXBwZWFyIGluIGEgZGlmZmVyZW50CiJtZW51Y29uZmlnIHBhZ2UiLCB3aGljaCByZWFs
bHkgZW5oYW5jZXMgdGhlIHJlYWRhYmlsaXR5LgoKPiAKPiA+ICsJZGVmYXVsdCB5ICAKPiAKPiBJ
IGRvbid0IHNlZSB3aGF0J3MgdGhlIHByb2JsZW0gd2l0aCBsZXR0aW5nIFNQSU5BTkQsIFJBV05B
TkQgYW5kCj4gT05FTkFORCBzZWxlY3QgdGhpcyBvcHRpb25zIGlmIHRoZXkgYWN0dWFsbHkgbmVl
ZCBpdC4KClNlZSB0aGUgcmVhc29uIGFib3ZlLCBoZW5jZSBoYXZpbmcgaXQgImRlZmF1bHQgeSIg
aXMgbmVlZGVkIHRvIGRvIG5vdApicmVhayBleGlzdGluZyBkZWZjb25maWdzLgoKClRoYW5rcywK
TWlxdcOobAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtYXJtLWtlcm5lbAo=
