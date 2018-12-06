Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491DDC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:42:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1376E20892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c+hzJBXK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1376E20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zGjmXc0VFDzVugaxB4S+L4MyMFJ3JoXgeu/awudUBjM=; b=c+hzJBXKAIEKNZ
	/Vji/ri0jQvnHTiYK36q+26aTzshSvwsoPK48sfpJlaorLeKu1YW6DaLabj+uBioAZb1UKpP3/AxN
	Z3uVbSoY/aNrRkQYBcAiAA+qpSHjJw1mH+8P3etu/DvirIfzNNC8RVWJQ5k3L7L8lCgBdYuaH4rly
	9+JjQjZPC7PDbA1SMnIlwuE2ieRalBxg+vB8iOTG7OKSn7Z6MZG5laU6bG4BVqHE6d5nSrhMoHB22
	O5823mMEllQ8CYjoyOJW0Ji6jcufrSneutYZ1OWtYUKW5KIBnbf6OHWbavXdaqViP+BIFMlSS0yDC
	PHxxmL3hWdRGjj6jcMWg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUqAk-00074i-P9; Thu, 06 Dec 2018 09:42:18 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUqAb-0006lP-H8
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 09:42:16 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gUqAL-0001Hd-My; Thu, 06 Dec 2018 10:41:53 +0100
Message-ID: <1544089313.3709.54.camel@pengutronix.de>
Subject: Re: [PATCH v2 2/3] PCI: imx: No-op imx6_pcie_reset_phy() on i.MX7D
From: Lucas Stach <l.stach@pengutronix.de>
To: Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pci@vger.kernel.org
Date: Thu, 06 Dec 2018 10:41:53 +0100
In-Reply-To: <20181206073545.10967-3-andrew.smirnov@gmail.com>
References: <20181206073545.10967-1-andrew.smirnov@gmail.com>
 <20181206073545.10967-3-andrew.smirnov@gmail.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_014210_247327_CB18CD17 
X-CRM114-Status: GOOD (  13.04  )
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
 linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>,
 linux-imx@nxp.com, bhelgaas@google.com,
 Leonard Crestez <leonard.crestez@nxp.com>, cphealy@gmail.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QW0gTWl0dHdvY2gsIGRlbiAwNS4xMi4yMDE4LCAyMzozNSAtMDgwMCBzY2hyaWViIEFuZHJleSBT
bWlybm92Ogo+IFBDSUUgUEhZIElQIGJsb2NrIG9uIGkuTVg3RCBkaWZmZXJzIGZyb20gdGhlIG9u
ZSB1c2VkIG9uIGkuTVg2IGZhbWlseSwKPiBzbyBub25lIG9mIHRoZSBjb2RlIGluIGN1cnJlbnQg
aW1wbGVtZW50YXRpb24gb2YgaW14Nl9wY2llX3Jlc2V0X3BoeSgpCj4gaXMgYXBwbGljYWJsZS4K
PiAKPiBDYzogYmhlbGdhYXNAZ29vZ2xlLmNvbQo+ID4gQ2M6IEZhYmlvIEVzdGV2YW0gPGZhYmlv
LmVzdGV2YW1AbnhwLmNvbT4KPiBDYzogY3BoZWFseUBnbWFpbC5jb20KPiBDYzogbC5zdGFjaEBw
ZW5ndXRyb25peC5kZQo+ID4gQ2M6IExlb25hcmQgQ3Jlc3RleiA8bGVvbmFyZC5jcmVzdGV6QG54
cC5jb20+Cj4gPiBDYzogIkEucy4gRG9uZyIgPGFpc2hlbmcuZG9uZ0BueHAuY29tPgo+ID4gQ2M6
IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4KPiBDYzogbGludXgtaW14QG54cC5j
b20KPiBDYzogbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCj4gQ2M6IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcKPiBDYzogbGludXgtcGNpQHZnZXIua2VybmVsLm9yZwo+
ID4gVGVzdGVkLWJ5OiBUcmVudCBQaWVwaG8gPHRwaWVwaG9AaW1waW5qLmNvbT4KPiBTaWduZWQt
b2ZmLWJ5OiBBbmRyZXkgU21pcm5vdiA8YW5kcmV3LnNtaXJub3ZAZ21haWwuY29tPgoKUmV2aWV3
ZWQtYnk6IEx1Y2FzIFN0YWNoIDxsLnN0YWNoQHBlbmd1dHJvbml4LmRlPgoKPiAtLS0KPiDCoGRy
aXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMgfCAzICsrKwo+IMKgMSBmaWxlIGNo
YW5nZWQsIDMgaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250
cm9sbGVyL2R3Yy9wY2ktaW14Ni5jIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlt
eDYuYwo+IGluZGV4IGMxNDBmNzk4NzU5OC4uM2MzMDAyODYxZDI1IDEwMDY0NAo+IC0tLSBhL2Ry
aXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMKPiArKysgYi9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jCj4gQEAgLTI0NSw2ICsyNDUsOSBAQCBzdGF0aWMgdm9p
ZCBpbXg2X3BjaWVfcmVzZXRfcGh5KHN0cnVjdCBpbXg2X3BjaWUgKmlteDZfcGNpZSkKPiDCoHsK
PiA+IMKgCXUzMiB0bXA7Cj4gwqAKPiA+ICsJaWYgKGlteDZfcGNpZS0+dmFyaWFudCA9PSBJTVg3
RCkKPiA+ICsJCXJldHVybjsKPiArCj4gPiDCoAlwY2llX3BoeV9yZWFkKGlteDZfcGNpZSwgUEhZ
X1JYX09WUkRfSU5fTE8sICZ0bXApOwo+ID4gwqAJdG1wIHw9IChQSFlfUlhfT1ZSRF9JTl9MT19S
WF9EQVRBX0VOIHwKPiA+IMKgCQlQSFlfUlhfT1ZSRF9JTl9MT19SWF9QTExfRU4pOwoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5l
bCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
