Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99548C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:50:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 699A82085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RELgJY1b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 699A82085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TY4bWgCz5ebhDaT4toWNpucId6szk+vW3yC0Cqnlf6w=; b=RELgJY1bDtfMej
	ZEHEnIWVMJEv+YhV2hpuSFK3CG8cmnbPJoLnOM77nELTAWGfSQ/BiVwYGso1a8a5qDBpeDBJd9kbM
	ZYk3ykRU2qVexNb++pv2AZvYdwKfQ5IMdbV3dtS1xcqYap3zaNNdwJSp60l9nh9/w8SXqOm0PzJPu
	9Wd65MqV+1AGi8cUL0GtqMSZ3lh9RqwmARH3jfVChqtXSBLZOqfM+tNG2yvuWWRQP4KsAVTt6yEV+
	u7YggsKEMU88FDxXbLLGPr7qkPtKp/kuyhwjO37dd3Hc+DDC236kD8OR21sZdamMiWeW6qYo+afOL
	iXP1PYWmZBwW9pKmXdjg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmLjb-0006wi-I0; Wed, 23 Jan 2019 16:50:39 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmLjX-0006vX-Fc
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 16:50:37 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gmLjR-000789-4F; Wed, 23 Jan 2019 17:50:29 +0100
Message-ID: <1548262227.28802.7.camel@pengutronix.de>
Subject: Re: [PATCH v3 5/5] imx8mq.dtsi: add the sdma nodes
From: Lucas Stach <l.stach@pengutronix.de>
To: "Angus Ainslie (Purism)" <angus@akkea.ca>
Date: Wed, 23 Jan 2019 17:50:27 +0100
In-Reply-To: <20190123152310.11680-6-angus@akkea.ca>
References: <20190120023150.17138-1-angus@akkea.ca>
 <20190123152310.11680-1-angus@akkea.ca>
 <20190123152310.11680-6-angus@akkea.ca>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_085035_674905_BAF5EE71 
X-CRM114-Status: GOOD (  14.31  )
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
Cc: Daniel Baluta <daniel.baluta@gmail.com>, linux-kernel@vger.kernel.org,
 dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, angus.ainslie@puri.sm,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QW0gTWl0dHdvY2gsIGRlbiAyMy4wMS4yMDE5LCAwODoyMyAtMDcwMCBzY2hyaWViIEFuZ3VzIEFp
bnNsaWUgKFB1cmlzbSk6Cj4gQWRkIHRoZSBzZG1hIG5vZGVzIHRvIHRoZSBiYXNlIGRldmljZXRy
ZWUgZm9yIHRoZSBpbXg4bXEKPiAKPiA+IFNpZ25lZC1vZmYtYnk6IEFuZ3VzIEFpbnNsaWUgKFB1
cmlzbSkgPGFuZ3VzQGFra2VhLmNhPgo+IC0tLQo+IMKgYXJjaC9hcm02NC9ib290L2R0cy9mcmVl
c2NhbGUvaW14OG1xLmR0c2kgfCAzMSArKysrKysrKysrKysrKysrKysrKysrKwo+IMKgMSBmaWxl
IGNoYW5nZWQsIDMxIGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9i
b290L2R0cy9mcmVlc2NhbGUvaW14OG1xLmR0c2kgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVz
Y2FsZS9pbXg4bXEuZHRzaQo+IGluZGV4IGMwNDAyMzc1ZTdjMS4uNDM5Nzk5MmZkMDIxIDEwMDY0
NAo+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcS5kdHNpCj4gKysr
IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1xLmR0c2kKPiBAQCAtMzM2LDYg
KzMzNiwxOSBAQAo+ID4gwqAJCQkJY2xvY2tzID0gPCZjbGsgSU1YOE1RX0NMS19XRE9HM19ST09U
PjsKPiA+IMKgCQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7Cj4gPiDCoAkJCX07Cj4gKwo+ID4gPiAr
CQkJc2RtYTI6IHNkbWFAMzAyYzAwMDAgewo+ID4gKwkJCQljb21wYXRpYmxlID0gImZzbCxpbXg4
bXEtc2RtYSIsICJmc2wsaW14N2Qtc2RtYSI7Cj4gPiArCQkJCXJlZyA9IDwweDMwMmMwMDAwIDB4
MTAwMDA+Owo+ID4gKwkJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMTAzIElSUV9UWVBFX0xFVkVM
X0hJR0g+Owo+ID4gKwkJCQljbG9ja3MgPSA8JmNsayBJTVg4TVFfQ0xLX1NETUEyX1JPT1Q+LAo+
ID4gKwkJCQkJPCZjbGsgSU1YOE1RX0NMS19TRE1BMl9ST09UPjsKPiA+ICsJCQkJY2xvY2stbmFt
ZXMgPSAiaXBnIiwgImFoYiI7Cj4gPiArCQkJCSNkbWEtY2VsbHMgPSA8Mz47Cj4gPiArCQkJCWZz
bCxzZG1hLXJhbS1zY3JpcHQtbmFtZSA9ICJpbXgvc2RtYS9zZG1hLWlteDdkLmJpbiI7Cj4gKwkJ
CQlmc2wscmF0aW8tMS0xOwoKUHJvcGVydHkgZG9lcyBub3QgZXhpc3QgYW55bW9yZS4KCj4gKwkJ
CQlzdGF0dXMgPSAiZGlzYWJsZWQiOwoKU29DIHBlcmlwaGVyYWxzIHRoYXQgaGF2ZSBubyBvdXRz
aWRlIGNvbm5lY3Rpb24gYW5kIHRodXMgZG9uJ3QgZGVwZW5kCm9uIGFueSBib2FyZCBsZXZlbCBj
b25maWd1cmF0aW9uIHNob3VsZCBhbHdheXMgYmUgZW5hYmxlZC4gUGxlYXNlIGRyb3AKdGhpcyBz
dGF0dXMgcHJvcGVydHkuCgo+ICsJCQl9Owo+ID4gwqAJCX07Cj4gwqAKPiA+IMKgCQlidXNAMzA0
MDAwMDAgeyAvKiBBSVBTMiAqLwo+IEBAIC0zNzAsNiArMzgzLDggQEAKPiA+IMKgCQkJCWNsb2Nr
cyA9IDwmY2xrIElNWDhNUV9DTEtfVUFSVDNfUk9PVD4sCj4gPiDCoAkJCQnCoMKgwqDCoMKgwqDC
oMKgwqA8JmNsayBJTVg4TVFfQ0xLX1VBUlQzX1JPT1Q+Owo+ID4gwqAJCQkJY2xvY2stbmFtZXMg
PSAiaXBnIiwgInBlciI7Cj4gPiArCQkJCWRtYXMgPSA8JnNkbWExIDI2IDQgMD4sIDwmc2RtYTEg
MjcgNCAwPjsKPiA+ICsJCQkJZG1hLW5hbWVzID0gInJ4IiwgInR4IjsKPiA+IMKgCQkJCXN0YXR1
cyA9ICJkaXNhYmxlZCI7Cj4gPiDCoAkJCX07Cj4gwqAKPiBAQCAtMzgxLDYgKzM5Niw4IEBACj4g
PiDCoAkJCQljbG9ja3MgPSA8JmNsayBJTVg4TVFfQ0xLX1VBUlQyX1JPT1Q+LAo+ID4gwqAJCQkJ
wqDCoMKgwqDCoMKgwqDCoMKgPCZjbGsgSU1YOE1RX0NMS19VQVJUMl9ST09UPjsKPiA+IMKgCQkJ
CWNsb2NrLW5hbWVzID0gImlwZyIsICJwZXIiOwo+ID4gKwkJCQlkbWFzID0gPCZzZG1hMSAyNCA0
IDA+LCA8JnNkbWExIDI1IDQgMD47Cj4gPiArCQkJCWRtYS1uYW1lcyA9ICJyeCIsICJ0eCI7Cj4g
PiDCoAkJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOwo+ID4gwqAJCQl9Owo+IMKgCj4gQEAgLTQzMiw2
ICs0NDksOCBAQAo+ID4gwqAJCQkJY2xvY2tzID0gPCZjbGsgSU1YOE1RX0NMS19VQVJUNF9ST09U
PiwKPiA+IMKgCQkJCcKgwqDCoMKgwqDCoMKgwqDCoDwmY2xrIElNWDhNUV9DTEtfVUFSVDRfUk9P
VD47Cj4gPiDCoAkJCQljbG9jay1uYW1lcyA9ICJpcGciLCAicGVyIjsKPiA+ICsJCQkJZG1hcyA9
IDwmc2RtYTEgMjggNCAwPiwgPCZzZG1hMSAyOSA0IDA+Owo+ID4gKwkJCQlkbWEtbmFtZXMgPSAi
cngiLCAidHgiOwo+ID4gwqAJCQkJc3RhdHVzID0gImRpc2FibGVkIjsKPiA+IMKgCQkJfTsKPiDC
oAo+IEBAIC00NjUsNiArNDg0LDE4IEBACj4gPiDCoAkJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOwo+
ID4gwqAJCQl9Owo+IMKgCj4gPiA+ICsJCQlzZG1hMTogc2RtYUAzMGJkMDAwMCB7Cj4gPiArCQkJ
CWNvbXBhdGlibGUgPSAiZnNsLGlteDhtcS1zZG1hIiwgImZzbCxpbXg3ZC1zZG1hIjsKPiA+ICsJ
CQkJcmVnID0gPDB4MzBiZDAwMDAgMHgxMDAwMD47Cj4gPiArCQkJCWludGVycnVwdHMgPSA8R0lD
X1NQSSAyIElSUV9UWVBFX0xFVkVMX0hJR0g+Owo+ID4gKwkJCQljbG9ja3MgPSA8JmNsayBJTVg4
TVFfQ0xLX1NETUExX1JPT1Q+LAo+ID4gKwkJCQkJPCZjbGsgSU1YOE1RX0NMS19BSEI+Owo+ID4g
KwkJCQljbG9jay1uYW1lcyA9ICJpcGciLCAiYWhiIjsKPiA+ICsJCQkJI2RtYS1jZWxscyA9IDwz
PjsKPiA+ICsJCQkJZnNsLHNkbWEtcmFtLXNjcmlwdC1uYW1lID0gImlteC9zZG1hL3NkbWEtaW14
N2QuYmluIjsKPiArCQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7CgpTYW1lIGNvbW1lbnQgYXMgYWJv
dmUsIHRoaXMgbm9kZSBzaG91bGQgYmUgZW5hYmxlZCBieSBkZWZhdWx0LgoKUmVnYXJkcywKTHVj
YXMKCj4gKwkJCX07Cj4gKwo+ID4gPiDCoAkJCWZlYzE6IGV0aGVybmV0QDMwYmUwMDAwIHsKPiA+
IMKgCQkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDhtcS1mZWMiLCAiZnNsLGlteDZzeC1mZWMiOwo+
ID4gwqAJCQkJcmVnID0gPDB4MzBiZTAwMDAgMHgxMDAwMD47CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlz
dApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
