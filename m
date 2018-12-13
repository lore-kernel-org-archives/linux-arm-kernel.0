Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A897C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:03:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28D432086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MNgmh+QR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cTZ0BKGC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28D432086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=68WnnS4tKX/DV7O+PgeoyyYhqPO+NLWhDdmvYk0d5dI=; b=MNgmh+QRULHhd/
	D6BL9Nd70mVjRsXtarmIMFToWNOszEskhh7IkGu5YuIDhgkiPIg1s82v99gEFnykIFUaN563bx23c
	6r99de/I8M2iMZKBh6Zg17S5G+WLOylCqxo3Z2DrG/84OgGF7F3ojoZHRFzhmXFrnm4qctNcC8h4n
	AjZipGn/R2ArcvGbwVrEvpMFZjXPo4o/sIoto+AO2o2GR7kMjw3iU2xzCp/f28NIHCv7rOsGH4lYB
	IAvcUBrrivnZCodTRXbmdQV2eRe1WB3Le9xreSybUs6m7ZbfLBPi6VvMcjVoHEAEyfXrZg6Vcf1WO
	eQITVXyYERoX/0BcYigw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXSWf-0003fx-S5; Thu, 13 Dec 2018 15:03:45 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXSWc-0003Z2-1X
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 15:03:43 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBDF3UsW063140;
 Thu, 13 Dec 2018 09:03:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1544713410;
 bh=npFLMbs/heeWjxAC1mb4ywqeKRVF6Spk1cVhLIfZH70=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=cTZ0BKGCUzMBjYDMZeF/YUyn4UZPNAlrtfKH8skAyWK3D20gIgAYpQoylB2HpS8Ef
 Uo617Xtd3cl+0GbaafPyvSMXZFAkUFhItkyGnh0Ii9Ez3LAXBRDZNe7cgETDI0181P
 YDGcuhYSsZAuwbgJxxrS+NMh17dwWNN1ljPcbCF4=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBDF3TsY075861
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 13 Dec 2018 09:03:30 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 13
 Dec 2018 09:03:29 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 13 Dec 2018 09:03:29 -0600
Received: from [172.22.216.26] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBDF3QuD010889;
 Thu, 13 Dec 2018 09:03:27 -0600
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-am654: Add McSPI DT nodes
To: Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
References: <20181209102222.7624-1-vigneshr@ti.com>
 <20181209102222.7624-2-vigneshr@ti.com>
 <7b718f70-bb74-0530-9566-d621371c3d13@ti.com>
From: Vignesh R <vigneshr@ti.com>
Message-ID: <3420b087-673b-b5be-ed5a-bf8d95ecc4dc@ti.com>
Date: Thu, 13 Dec 2018 20:33:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <7b718f70-bb74-0530-9566-d621371c3d13@ti.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_070342_187619_AFCF2A07 
X-CRM114-Status: GOOD (  16.64  )
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
Cc: devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

CgpPbiAxMy1EZWMtMTggODoyOSBQTSwgVGVybyBLcmlzdG8gd3JvdGU6Cj4gT24gMDkvMTIvMjAx
OCAxMjoyMiwgVmlnbmVzaCBSIHdyb3RlOgo+PiBUaGVyZSBhcmUgMyBpbnN0YW5jZXMgb2YgTWNT
UEkgaW4gTUNVIGRvbWFpbiBhbmQgNCBpbnN0YW5jZXMgaW4gTWFpbgo+PiBkb21haW4uCj4+IEFk
ZCBEVCBub2RlcyBmb3IgYWxsIE1jU1BJIGluc3RhbmNlcyBwcmVzZW50IG9uIEFNNjU0IFNvQy4K
Pj4KPj4gU2lnbmVkLW9mZi1ieTogVmlnbmVzaCBSIDx2aWduZXNockB0aS5jb20+Cj4+IC0tLQo+
PiDCoCBhcmNoL2FybTY0L2Jvb3QvZHRzL3RpL2szLWFtNjUtbWFpbi5kdHNpIHwgNTIgKysrKysr
KysrKysrKysrKysrKysrKysrCj4+IMKgIGFyY2gvYXJtNjQvYm9vdC9kdHMvdGkvazMtYW02NS1t
Y3UuZHRzacKgIHwgMzAgKysrKysrKysrKysrKysKPj4gwqAgMiBmaWxlcyBjaGFuZ2VkLCA4MiBp
bnNlcnRpb25zKCspCj4+Cj4+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL3RpL2sz
LWFtNjUtbWFpbi5kdHNpCj4+IGIvYXJjaC9hcm02NC9ib290L2R0cy90aS9rMy1hbTY1LW1haW4u
ZHRzaQo+PiBpbmRleCAwYTBhOGZjNWRmNjQuLjZjNzFlNjdiODk4OCAxMDA2NDQKPj4gLS0tIGEv
YXJjaC9hcm02NC9ib290L2R0cy90aS9rMy1hbTY1LW1haW4uZHRzaQo+PiArKysgYi9hcmNoL2Fy
bTY0L2Jvb3QvZHRzL3RpL2szLWFtNjUtbWFpbi5kdHNpCj4+IEBAIC0xMzgsNCArMTM4LDU2IEBA
Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBjbG9ja3MgPSA8JmszX2Nsa3MgMzkgMD47Cj4+IMKgwqDC
oMKgwqDCoMKgwqDCoCBjbG9jay1uYW1lcyA9ICJmY2siOwo+PiDCoMKgwqDCoMKgIH07Cj4+ICsK
Pj4gK8KgwqDCoCBtYWluX3NwaTA6IHNwaUAyMTAwMDAwIHsKPj4gK8KgwqDCoMKgwqDCoMKgIGNv
bXBhdGlibGUgPSAidGksYW02NTQtbWNzcGkiLCJ0aSxvbWFwNC1tY3NwaSI7Cj4gCj4gV0FSTklO
RzogRFQgY29tcGF0aWJsZSBzdHJpbmcgInRpLGFtNjU0LW1jc3BpIiBhcHBlYXJzIHVuLWRvY3Vt
ZW50ZWQgLS0KPiBjaGVjayAuLi8uLi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
Cj4gIzYzOiBGSUxFOiBhcmNoL2FybTY0L2Jvb3QvZHRzL3RpL2szLWFtNjUtbWFpbi5kdHNpOjE0
MzoKPiArwqDCoMKgwqDCoMKgwqAgY29tcGF0aWJsZSA9ICJ0aSxhbTY1NC1tY3NwaSIsInRpLG9t
YXA0LW1jc3BpIjsKPiAKPiBTYW1lIGZvciB0aGUgcmVzdCBvZiB0aGUgbm9kZXMuCj4gCj4gRGlk
IHlvdSBmb3JnZXQgZG9jdW1lbnRhdGlvbiBwYXJ0Pwo+IAoKRG9jdW1lbnRhdGlvbiBwYXRjaCBh
cyBiZWVuIGFjY2VwdGVkIGludG8gU1BJIHRyZWUgYW5kIHBhcnQgb2YgbGludXgtbmV4dDogCmh0
dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L25leHQvbGludXgt
bmV4dC5naXQvY29tbWl0Lz9pZD1hYmM2MWY0N2E3MGY3YzgzMzFmMDBlZmYxY2NiNjU1N2E5ZDRj
MjI0CgpSZWdhcmRzClZpZ25lc2gKCj4gLVRlcm8KPiAKPj4gK8KgwqDCoMKgwqDCoMKgIHJlZyA9
IDwweDAgMHgyMTAwMDAwIDB4MCAweDQwMD47Cj4+ICvCoMKgwqDCoMKgwqDCoCBpbnRlcnJ1cHRz
ID0gPEdJQ19TUEkgMTg0IElSUV9UWVBFX0xFVkVMX0hJR0g+Owo+PiArwqDCoMKgwqDCoMKgwqAg
Y2xvY2tzID0gPCZrM19jbGtzIDEzNyAxPjsKPj4gK8KgwqDCoMKgwqDCoMKgIHBvd2VyLWRvbWFp
bnMgPSA8JmszX3BkcyAxMzc+Owo+PiArwqDCoMKgwqDCoMKgwqAgI2FkZHJlc3MtY2VsbHMgPSA8
MT47Cj4+ICvCoMKgwqDCoMKgwqDCoCAjc2l6ZS1jZWxscyA9IDwwPjsKPj4gK8KgwqDCoCB9Owo+
PiArCj4+ICvCoMKgwqAgbWFpbl9zcGkxOiBzcGlAMjExMDAwMCB7Cj4+ICvCoMKgwqDCoMKgwqDC
oCBjb21wYXRpYmxlID0gInRpLGFtNjU0LW1jc3BpIiwidGksb21hcDQtbWNzcGkiOwo+PiArwqDC
oMKgwqDCoMKgwqAgcmVnID0gPDB4MCAweDIxMTAwMDAgMHgwIDB4NDAwPjsKPj4gK8KgwqDCoMKg
wqDCoMKgIGludGVycnVwdHMgPSA8R0lDX1NQSSAxODUgSVJRX1RZUEVfTEVWRUxfSElHSD47Cj4+
ICvCoMKgwqDCoMKgwqDCoCBjbG9ja3MgPSA8JmszX2Nsa3MgMTM4IDE+Owo+PiArwqDCoMKgwqDC
oMKgwqAgcG93ZXItZG9tYWlucyA9IDwmazNfcGRzIDEzOD47Cj4+ICvCoMKgwqDCoMKgwqDCoCAj
YWRkcmVzcy1jZWxscyA9IDwxPjsKPj4gK8KgwqDCoMKgwqDCoMKgICNzaXplLWNlbGxzID0gPDA+
Owo+PiArwqDCoMKgwqDCoMKgwqAgYXNzaWduZWQtY2xvY2tzID0gPCZrM19jbGtzIDEzNyAxPjsK
Pj4gK8KgwqDCoMKgwqDCoMKgIGFzc2lnbmVkLWNsb2NrLXJhdGVzID0gPDQ4MDAwMDAwPjsKPj4g
K8KgwqDCoCB9Owo+PiArCj4+ICvCoMKgwqAgbWFpbl9zcGkyOiBzcGlAMjEyMDAwMCB7Cj4+ICvC
oMKgwqDCoMKgwqDCoCBjb21wYXRpYmxlID0gInRpLGFtNjU0LW1jc3BpIiwidGksb21hcDQtbWNz
cGkiOwo+PiArwqDCoMKgwqDCoMKgwqAgcmVnID0gPDB4MCAweDIxMjAwMDAgMHgwIDB4NDAwPjsK
Pj4gK8KgwqDCoMKgwqDCoMKgIGludGVycnVwdHMgPSA8R0lDX1NQSSAxODYgSVJRX1RZUEVfTEVW
RUxfSElHSD47Cj4+ICvCoMKgwqDCoMKgwqDCoCBjbG9ja3MgPSA8JmszX2Nsa3MgMTM5IDE+Owo+
PiArwqDCoMKgwqDCoMKgwqAgcG93ZXItZG9tYWlucyA9IDwmazNfcGRzIDEzOT47Cj4+ICvCoMKg
wqDCoMKgwqDCoCAjYWRkcmVzcy1jZWxscyA9IDwxPjsKPj4gK8KgwqDCoMKgwqDCoMKgICNzaXpl
LWNlbGxzID0gPDA+Owo+PiArwqDCoMKgIH07Cj4+ICsKPj4gK8KgwqDCoCBtYWluX3NwaTM6IHNw
aUAyMTMwMDAwIHsKPj4gK8KgwqDCoMKgwqDCoMKgIGNvbXBhdGlibGUgPSAidGksYW02NTQtbWNz
cGkiLCJ0aSxvbWFwNC1tY3NwaSI7Cj4+ICvCoMKgwqDCoMKgwqDCoCByZWcgPSA8MHgwIDB4MjEz
MDAwMCAweDAgMHg0MDA+Owo+PiArwqDCoMKgwqDCoMKgwqAgaW50ZXJydXB0cyA9IDxHSUNfU1BJ
IDE4NyBJUlFfVFlQRV9MRVZFTF9ISUdIPjsKPj4gK8KgwqDCoMKgwqDCoMKgIGNsb2NrcyA9IDwm
azNfY2xrcyAxNDAgMT47Cj4+ICvCoMKgwqDCoMKgwqDCoCBwb3dlci1kb21haW5zID0gPCZrM19w
ZHMgMTQwPjsKPj4gK8KgwqDCoMKgwqDCoMKgICNhZGRyZXNzLWNlbGxzID0gPDE+Owo+PiArwqDC
oMKgwqDCoMKgwqAgI3NpemUtY2VsbHMgPSA8MD47Cj4+ICvCoMKgwqAgfTsKPj4gKwo+PiArwqDC
oMKgIG1haW5fc3BpNDogc3BpQDIxNDAwMDAgewo+PiArwqDCoMKgwqDCoMKgwqAgY29tcGF0aWJs
ZSA9ICJ0aSxhbTY1NC1tY3NwaSIsInRpLG9tYXA0LW1jc3BpIjsKPj4gK8KgwqDCoMKgwqDCoMKg
IHJlZyA9IDwweDAgMHgyMTQwMDAwIDB4MCAweDQwMD47Cj4+ICvCoMKgwqDCoMKgwqDCoCBpbnRl
cnJ1cHRzID0gPEdJQ19TUEkgMTg4IElSUV9UWVBFX0xFVkVMX0hJR0g+Owo+PiArwqDCoMKgwqDC
oMKgwqAgY2xvY2tzID0gPCZrM19jbGtzIDE0MSAxPjsKPj4gK8KgwqDCoMKgwqDCoMKgIHBvd2Vy
LWRvbWFpbnMgPSA8JmszX3BkcyAxNDE+Owo+PiArwqDCoMKgwqDCoMKgwqAgI2FkZHJlc3MtY2Vs
bHMgPSA8MT47Cj4+ICvCoMKgwqDCoMKgwqDCoCAjc2l6ZS1jZWxscyA9IDwwPjsKPj4gK8KgwqDC
oCB9Owo+PiDCoCB9Owo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy90aS9rMy1h
bTY1LW1jdS5kdHNpCj4+IGIvYXJjaC9hcm02NC9ib290L2R0cy90aS9rMy1hbTY1LW1jdS5kdHNp
Cj4+IGluZGV4IDFmZDAyNzc0OGUxZi4uMWFlYWU1MmZiMjM5IDEwMDY0NAo+PiAtLS0gYS9hcmNo
L2FybTY0L2Jvb3QvZHRzL3RpL2szLWFtNjUtbWN1LmR0c2kKPj4gKysrIGIvYXJjaC9hcm02NC9i
b290L2R0cy90aS9rMy1hbTY1LW1jdS5kdHNpCj4+IEBAIC0yNiw0ICsyNiwzNCBAQAo+PiDCoMKg
wqDCoMKgwqDCoMKgwqAgY2xvY2tzID0gPCZrM19jbGtzIDExNCAxPjsKPj4gwqDCoMKgwqDCoMKg
wqDCoMKgIHBvd2VyLWRvbWFpbnMgPSA8JmszX3BkcyAxMTQ+Owo+PiDCoMKgwqDCoMKgIH07Cj4+
ICsKPj4gK8KgwqDCoCBtY3Vfc3BpMDogc3BpQDQwMzAwMDAwIHsKPj4gK8KgwqDCoMKgwqDCoMKg
IGNvbXBhdGlibGUgPSAidGksYW02NTQtbWNzcGkiLCJ0aSxvbWFwNC1tY3NwaSI7Cj4+ICvCoMKg
wqDCoMKgwqDCoCByZWcgPSA8MHgwIDB4NDAzMDAwMDAgMHgwIDB4NDAwPjsKPj4gK8KgwqDCoMKg
wqDCoMKgIGludGVycnVwdHMgPSA8R0lDX1NQSSA1NjAgSVJRX1RZUEVfTEVWRUxfSElHSD47Cj4+
ICvCoMKgwqDCoMKgwqDCoCBjbG9ja3MgPSA8JmszX2Nsa3MgMTQyIDE+Owo+PiArwqDCoMKgwqDC
oMKgwqAgcG93ZXItZG9tYWlucyA9IDwmazNfcGRzIDE0Mj47Cj4+ICvCoMKgwqDCoMKgwqDCoCAj
YWRkcmVzcy1jZWxscyA9IDwxPjsKPj4gK8KgwqDCoMKgwqDCoMKgICNzaXplLWNlbGxzID0gPDA+
Owo+PiArwqDCoMKgIH07Cj4+ICsKPj4gK8KgwqDCoCBtY3Vfc3BpMTogc3BpQDQwMzEwMDAwIHsK
Pj4gK8KgwqDCoMKgwqDCoMKgIGNvbXBhdGlibGUgPSAidGksYW02NTQtbWNzcGkiLCJ0aSxvbWFw
NC1tY3NwaSI7Cj4+ICvCoMKgwqDCoMKgwqDCoCByZWcgPSA8MHgwIDB4NDAzMTAwMDAgMHgwIDB4
NDAwPjsKPj4gK8KgwqDCoMKgwqDCoMKgIGludGVycnVwdHMgPSA8R0lDX1NQSSA1NjEgSVJRX1RZ
UEVfTEVWRUxfSElHSD47Cj4+ICvCoMKgwqDCoMKgwqDCoCBjbG9ja3MgPSA8JmszX2Nsa3MgMTQz
IDE+Owo+PiArwqDCoMKgwqDCoMKgwqAgcG93ZXItZG9tYWlucyA9IDwmazNfcGRzIDE0Mz47Cj4+
ICvCoMKgwqDCoMKgwqDCoCAjYWRkcmVzcy1jZWxscyA9IDwxPjsKPj4gK8KgwqDCoMKgwqDCoMKg
ICNzaXplLWNlbGxzID0gPDA+Owo+PiArwqDCoMKgIH07Cj4+ICsKPj4gK8KgwqDCoCBtY3Vfc3Bp
Mjogc3BpQDQwMzIwMDAwIHsKPj4gK8KgwqDCoMKgwqDCoMKgIGNvbXBhdGlibGUgPSAidGksYW02
NTQtbWNzcGkiLCJ0aSxvbWFwNC1tY3NwaSI7Cj4+ICvCoMKgwqDCoMKgwqDCoCByZWcgPSA8MHgw
IDB4NDAzMjAwMDAgMHgwIDB4NDAwPjsKPj4gK8KgwqDCoMKgwqDCoMKgIGludGVycnVwdHMgPSA8
R0lDX1NQSSA1NjIgSVJRX1RZUEVfTEVWRUxfSElHSD47Cj4+ICvCoMKgwqDCoMKgwqDCoCBjbG9j
a3MgPSA8JmszX2Nsa3MgMTQ0IDE+Owo+PiArwqDCoMKgwqDCoMKgwqAgcG93ZXItZG9tYWlucyA9
IDwmazNfcGRzIDE0ND47Cj4+ICvCoMKgwqDCoMKgwqDCoCAjYWRkcmVzcy1jZWxscyA9IDwxPjsK
Pj4gK8KgwqDCoMKgwqDCoMKgICNzaXplLWNlbGxzID0gPDA+Owo+PiArwqDCoMKgIH07Cj4+IMKg
IH07Cj4+Cj4gCj4gLS0gCj4gVGV4YXMgSW5zdHJ1bWVudHMgRmlubGFuZCBPeSwgUG9ya2thbGFu
a2F0dSAyMiwgMDAxODAgSGVsc2lua2kuCj4gWS10dW5udXMvQnVzaW5lc3MgSUQ6IDA2MTU1MjEt
NC4gS290aXBhaWtrYS9Eb21pY2lsZTogSGVsc2lua2kKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0Cmxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
