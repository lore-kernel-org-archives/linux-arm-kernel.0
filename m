Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFFCC67872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:08:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5CF120851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VA3v9QAB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KIlquCrz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5CF120851
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=g7LwgeK+c4ZKOm1b1aB+WMPlU4mPkg9LlFlyujl83LY=; b=VA3v9QABRRbh70txIwkfZXTUm
	BMy+GlvygzaTQ1Dt+kzccd5L8cjB/g20MvXAFz5ghWr9zbyPA8GjrxIvifgPQ8Xc+aAW2rhID/RUi
	OgQPcPRkB9Aap/Dq6PY2T1UmPwBP7CnFpc2cmXwcJyaueNfXs0D3qTwi+TPBPxoq4NfPrbtDxNud9
	ZpG3pyi5Y3DEAc6pfwB6ykK1ZQVMZWBcsDXQJQMF+PrygT8DnLXRTZ9T7+3c44+3ZX32+i5VRMZK1
	rsNmkpMjNwGyUB4wn8ThlvEYKHNKllJodRNc9YYG7DAkyFkeoVcsDeLlTSjSOyDsPQGmEvgtVTCnw
	qCPsO1Jhg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXSbY-0005xQ-6n; Thu, 13 Dec 2018 15:08:48 +0000
Received: from fllv0015.ext.ti.com ([198.47.19.141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXSbS-0005wc-Vi
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 15:08:45 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBDF8UEp019441;
 Thu, 13 Dec 2018 09:08:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1544713710;
 bh=wzMrdHvbCJrnm+2/hnMVe6XOvQgONtk9n1EhxmTwBnw=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=KIlquCrzD6PeiTfzB4zpU5LitxvfWeMpeYzQVNJnRiFeYjYUCEGcamwkgxRTqL5n8
 QXnhf5dlEta+MD5AfC+YdVdzCXvmcMku4VczK03qrIZMB6Fj4b+57vLlB7Wrs5OhJH
 pwVgbztgSDV3Hx4GwW2Oyq21a8MilFScOp/pyaB4=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBDF8UNI066008
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 13 Dec 2018 09:08:30 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 13
 Dec 2018 09:08:29 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 13 Dec 2018 09:08:29 -0600
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBDF8Rvo017277;
 Thu, 13 Dec 2018 09:08:27 -0600
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-am654: Add McSPI DT nodes
To: Vignesh R <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
References: <20181209102222.7624-1-vigneshr@ti.com>
 <20181209102222.7624-2-vigneshr@ti.com>
 <7b718f70-bb74-0530-9566-d621371c3d13@ti.com>
 <3420b087-673b-b5be-ed5a-bf8d95ecc4dc@ti.com>
From: Tero Kristo <t-kristo@ti.com>
Message-ID: <723772e0-162b-edfb-75ab-0461925a9930@ti.com>
Date: Thu, 13 Dec 2018 17:08:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <3420b087-673b-b5be-ed5a-bf8d95ecc4dc@ti.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_070843_099018_32F74AB2 
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
Cc: devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMTMvMTIvMjAxOCAxNzowMywgVmlnbmVzaCBSIHdyb3RlOgo+IAo+IAo+IE9uIDEzLURlYy0x
OCA4OjI5IFBNLCBUZXJvIEtyaXN0byB3cm90ZToKPj4gT24gMDkvMTIvMjAxOCAxMjoyMiwgVmln
bmVzaCBSIHdyb3RlOgo+Pj4gVGhlcmUgYXJlIDMgaW5zdGFuY2VzIG9mIE1jU1BJIGluIE1DVSBk
b21haW4gYW5kIDQgaW5zdGFuY2VzIGluIE1haW4KPj4+IGRvbWFpbi4KPj4+IEFkZCBEVCBub2Rl
cyBmb3IgYWxsIE1jU1BJIGluc3RhbmNlcyBwcmVzZW50IG9uIEFNNjU0IFNvQy4KPj4+Cj4+PiBT
aWduZWQtb2ZmLWJ5OiBWaWduZXNoIFIgPHZpZ25lc2hyQHRpLmNvbT4KPj4+IC0tLQo+Pj4gIMKg
IGFyY2gvYXJtNjQvYm9vdC9kdHMvdGkvazMtYW02NS1tYWluLmR0c2kgfCA1MiArKysrKysrKysr
KysrKysrKysrKysrKysKPj4+ICDCoCBhcmNoL2FybTY0L2Jvb3QvZHRzL3RpL2szLWFtNjUtbWN1
LmR0c2nCoCB8IDMwICsrKysrKysrKysrKysrCj4+PiAgwqAgMiBmaWxlcyBjaGFuZ2VkLCA4MiBp
bnNlcnRpb25zKCspCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvdGkv
azMtYW02NS1tYWluLmR0c2kKPj4+IGIvYXJjaC9hcm02NC9ib290L2R0cy90aS9rMy1hbTY1LW1h
aW4uZHRzaQo+Pj4gaW5kZXggMGEwYThmYzVkZjY0Li42YzcxZTY3Yjg5ODggMTAwNjQ0Cj4+PiAt
LS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL3RpL2szLWFtNjUtbWFpbi5kdHNpCj4+PiArKysgYi9h
cmNoL2FybTY0L2Jvb3QvZHRzL3RpL2szLWFtNjUtbWFpbi5kdHNpCj4+PiBAQCAtMTM4LDQgKzEz
OCw1NiBAQAo+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoCBjbG9ja3MgPSA8JmszX2Nsa3MgMzkgMD47
Cj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgIGNsb2NrLW5hbWVzID0gImZjayI7Cj4+PiAgwqDCoMKg
wqDCoCB9Owo+Pj4gKwo+Pj4gK8KgwqDCoCBtYWluX3NwaTA6IHNwaUAyMTAwMDAwIHsKPj4+ICvC
oMKgwqDCoMKgwqDCoCBjb21wYXRpYmxlID0gInRpLGFtNjU0LW1jc3BpIiwidGksb21hcDQtbWNz
cGkiOwo+Pgo+PiBXQVJOSU5HOiBEVCBjb21wYXRpYmxlIHN0cmluZyAidGksYW02NTQtbWNzcGki
IGFwcGVhcnMgdW4tZG9jdW1lbnRlZCAtLQo+PiBjaGVjayAuLi8uLi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvCj4+ICM2MzogRklMRTogYXJjaC9hcm02NC9ib290L2R0cy90aS9r
My1hbTY1LW1haW4uZHRzaToxNDM6Cj4+ICvCoMKgwqDCoMKgwqDCoCBjb21wYXRpYmxlID0gInRp
LGFtNjU0LW1jc3BpIiwidGksb21hcDQtbWNzcGkiOwo+Pgo+PiBTYW1lIGZvciB0aGUgcmVzdCBv
ZiB0aGUgbm9kZXMuCj4+Cj4+IERpZCB5b3UgZm9yZ2V0IGRvY3VtZW50YXRpb24gcGFydD8KPj4K
PiAKPiBEb2N1bWVudGF0aW9uIHBhdGNoIGFzIGJlZW4gYWNjZXB0ZWQgaW50byBTUEkgdHJlZSBh
bmQgcGFydCBvZiBsaW51eC1uZXh0Ogo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9s
aW51eC9rZXJuZWwvZ2l0L25leHQvbGludXgtbmV4dC5naXQvY29tbWl0Lz9pZD1hYmM2MWY0N2E3
MGY3YzgzMzFmMDBlZmYxY2NiNjU1N2E5ZDRjMjI0CgpPayB0aGFua3MgZm9yIHRoZSBpbmZvLgoK
LVRlcm8KCj4gCj4gUmVnYXJkcwo+IFZpZ25lc2gKPiAKPj4gLVRlcm8KPj4KPj4+ICvCoMKgwqDC
oMKgwqDCoCByZWcgPSA8MHgwIDB4MjEwMDAwMCAweDAgMHg0MDA+Owo+Pj4gK8KgwqDCoMKgwqDC
oMKgIGludGVycnVwdHMgPSA8R0lDX1NQSSAxODQgSVJRX1RZUEVfTEVWRUxfSElHSD47Cj4+PiAr
wqDCoMKgwqDCoMKgwqAgY2xvY2tzID0gPCZrM19jbGtzIDEzNyAxPjsKPj4+ICvCoMKgwqDCoMKg
wqDCoCBwb3dlci1kb21haW5zID0gPCZrM19wZHMgMTM3PjsKPj4+ICvCoMKgwqDCoMKgwqDCoCAj
YWRkcmVzcy1jZWxscyA9IDwxPjsKPj4+ICvCoMKgwqDCoMKgwqDCoCAjc2l6ZS1jZWxscyA9IDww
PjsKPj4+ICvCoMKgwqAgfTsKPj4+ICsKPj4+ICvCoMKgwqAgbWFpbl9zcGkxOiBzcGlAMjExMDAw
MCB7Cj4+PiArwqDCoMKgwqDCoMKgwqAgY29tcGF0aWJsZSA9ICJ0aSxhbTY1NC1tY3NwaSIsInRp
LG9tYXA0LW1jc3BpIjsKPj4+ICvCoMKgwqDCoMKgwqDCoCByZWcgPSA8MHgwIDB4MjExMDAwMCAw
eDAgMHg0MDA+Owo+Pj4gK8KgwqDCoMKgwqDCoMKgIGludGVycnVwdHMgPSA8R0lDX1NQSSAxODUg
SVJRX1RZUEVfTEVWRUxfSElHSD47Cj4+PiArwqDCoMKgwqDCoMKgwqAgY2xvY2tzID0gPCZrM19j
bGtzIDEzOCAxPjsKPj4+ICvCoMKgwqDCoMKgwqDCoCBwb3dlci1kb21haW5zID0gPCZrM19wZHMg
MTM4PjsKPj4+ICvCoMKgwqDCoMKgwqDCoCAjYWRkcmVzcy1jZWxscyA9IDwxPjsKPj4+ICvCoMKg
wqDCoMKgwqDCoCAjc2l6ZS1jZWxscyA9IDwwPjsKPj4+ICvCoMKgwqDCoMKgwqDCoCBhc3NpZ25l
ZC1jbG9ja3MgPSA8JmszX2Nsa3MgMTM3IDE+Owo+Pj4gK8KgwqDCoMKgwqDCoMKgIGFzc2lnbmVk
LWNsb2NrLXJhdGVzID0gPDQ4MDAwMDAwPjsKPj4+ICvCoMKgwqAgfTsKPj4+ICsKPj4+ICvCoMKg
wqAgbWFpbl9zcGkyOiBzcGlAMjEyMDAwMCB7Cj4+PiArwqDCoMKgwqDCoMKgwqAgY29tcGF0aWJs
ZSA9ICJ0aSxhbTY1NC1tY3NwaSIsInRpLG9tYXA0LW1jc3BpIjsKPj4+ICvCoMKgwqDCoMKgwqDC
oCByZWcgPSA8MHgwIDB4MjEyMDAwMCAweDAgMHg0MDA+Owo+Pj4gK8KgwqDCoMKgwqDCoMKgIGlu
dGVycnVwdHMgPSA8R0lDX1NQSSAxODYgSVJRX1RZUEVfTEVWRUxfSElHSD47Cj4+PiArwqDCoMKg
wqDCoMKgwqAgY2xvY2tzID0gPCZrM19jbGtzIDEzOSAxPjsKPj4+ICvCoMKgwqDCoMKgwqDCoCBw
b3dlci1kb21haW5zID0gPCZrM19wZHMgMTM5PjsKPj4+ICvCoMKgwqDCoMKgwqDCoCAjYWRkcmVz
cy1jZWxscyA9IDwxPjsKPj4+ICvCoMKgwqDCoMKgwqDCoCAjc2l6ZS1jZWxscyA9IDwwPjsKPj4+
ICvCoMKgwqAgfTsKPj4+ICsKPj4+ICvCoMKgwqAgbWFpbl9zcGkzOiBzcGlAMjEzMDAwMCB7Cj4+
PiArwqDCoMKgwqDCoMKgwqAgY29tcGF0aWJsZSA9ICJ0aSxhbTY1NC1tY3NwaSIsInRpLG9tYXA0
LW1jc3BpIjsKPj4+ICvCoMKgwqDCoMKgwqDCoCByZWcgPSA8MHgwIDB4MjEzMDAwMCAweDAgMHg0
MDA+Owo+Pj4gK8KgwqDCoMKgwqDCoMKgIGludGVycnVwdHMgPSA8R0lDX1NQSSAxODcgSVJRX1RZ
UEVfTEVWRUxfSElHSD47Cj4+PiArwqDCoMKgwqDCoMKgwqAgY2xvY2tzID0gPCZrM19jbGtzIDE0
MCAxPjsKPj4+ICvCoMKgwqDCoMKgwqDCoCBwb3dlci1kb21haW5zID0gPCZrM19wZHMgMTQwPjsK
Pj4+ICvCoMKgwqDCoMKgwqDCoCAjYWRkcmVzcy1jZWxscyA9IDwxPjsKPj4+ICvCoMKgwqDCoMKg
wqDCoCAjc2l6ZS1jZWxscyA9IDwwPjsKPj4+ICvCoMKgwqAgfTsKPj4+ICsKPj4+ICvCoMKgwqAg
bWFpbl9zcGk0OiBzcGlAMjE0MDAwMCB7Cj4+PiArwqDCoMKgwqDCoMKgwqAgY29tcGF0aWJsZSA9
ICJ0aSxhbTY1NC1tY3NwaSIsInRpLG9tYXA0LW1jc3BpIjsKPj4+ICvCoMKgwqDCoMKgwqDCoCBy
ZWcgPSA8MHgwIDB4MjE0MDAwMCAweDAgMHg0MDA+Owo+Pj4gK8KgwqDCoMKgwqDCoMKgIGludGVy
cnVwdHMgPSA8R0lDX1NQSSAxODggSVJRX1RZUEVfTEVWRUxfSElHSD47Cj4+PiArwqDCoMKgwqDC
oMKgwqAgY2xvY2tzID0gPCZrM19jbGtzIDE0MSAxPjsKPj4+ICvCoMKgwqDCoMKgwqDCoCBwb3dl
ci1kb21haW5zID0gPCZrM19wZHMgMTQxPjsKPj4+ICvCoMKgwqDCoMKgwqDCoCAjYWRkcmVzcy1j
ZWxscyA9IDwxPjsKPj4+ICvCoMKgwqDCoMKgwqDCoCAjc2l6ZS1jZWxscyA9IDwwPjsKPj4+ICvC
oMKgwqAgfTsKPj4+ICDCoCB9Owo+Pj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMv
dGkvazMtYW02NS1tY3UuZHRzaQo+Pj4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL3RpL2szLWFtNjUt
bWN1LmR0c2kKPj4+IGluZGV4IDFmZDAyNzc0OGUxZi4uMWFlYWU1MmZiMjM5IDEwMDY0NAo+Pj4g
LS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy90aS9rMy1hbTY1LW1jdS5kdHNpCj4+PiArKysgYi9h
cmNoL2FybTY0L2Jvb3QvZHRzL3RpL2szLWFtNjUtbWN1LmR0c2kKPj4+IEBAIC0yNiw0ICsyNiwz
NCBAQAo+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoCBjbG9ja3MgPSA8JmszX2Nsa3MgMTE0IDE+Owo+
Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoCBwb3dlci1kb21haW5zID0gPCZrM19wZHMgMTE0PjsKPj4+
ICDCoMKgwqDCoMKgIH07Cj4+PiArCj4+PiArwqDCoMKgIG1jdV9zcGkwOiBzcGlANDAzMDAwMDAg
ewo+Pj4gK8KgwqDCoMKgwqDCoMKgIGNvbXBhdGlibGUgPSAidGksYW02NTQtbWNzcGkiLCJ0aSxv
bWFwNC1tY3NwaSI7Cj4+PiArwqDCoMKgwqDCoMKgwqAgcmVnID0gPDB4MCAweDQwMzAwMDAwIDB4
MCAweDQwMD47Cj4+PiArwqDCoMKgwqDCoMKgwqAgaW50ZXJydXB0cyA9IDxHSUNfU1BJIDU2MCBJ
UlFfVFlQRV9MRVZFTF9ISUdIPjsKPj4+ICvCoMKgwqDCoMKgwqDCoCBjbG9ja3MgPSA8JmszX2Ns
a3MgMTQyIDE+Owo+Pj4gK8KgwqDCoMKgwqDCoMKgIHBvd2VyLWRvbWFpbnMgPSA8JmszX3BkcyAx
NDI+Owo+Pj4gK8KgwqDCoMKgwqDCoMKgICNhZGRyZXNzLWNlbGxzID0gPDE+Owo+Pj4gK8KgwqDC
oMKgwqDCoMKgICNzaXplLWNlbGxzID0gPDA+Owo+Pj4gK8KgwqDCoCB9Owo+Pj4gKwo+Pj4gK8Kg
wqDCoCBtY3Vfc3BpMTogc3BpQDQwMzEwMDAwIHsKPj4+ICvCoMKgwqDCoMKgwqDCoCBjb21wYXRp
YmxlID0gInRpLGFtNjU0LW1jc3BpIiwidGksb21hcDQtbWNzcGkiOwo+Pj4gK8KgwqDCoMKgwqDC
oMKgIHJlZyA9IDwweDAgMHg0MDMxMDAwMCAweDAgMHg0MDA+Owo+Pj4gK8KgwqDCoMKgwqDCoMKg
IGludGVycnVwdHMgPSA8R0lDX1NQSSA1NjEgSVJRX1RZUEVfTEVWRUxfSElHSD47Cj4+PiArwqDC
oMKgwqDCoMKgwqAgY2xvY2tzID0gPCZrM19jbGtzIDE0MyAxPjsKPj4+ICvCoMKgwqDCoMKgwqDC
oCBwb3dlci1kb21haW5zID0gPCZrM19wZHMgMTQzPjsKPj4+ICvCoMKgwqDCoMKgwqDCoCAjYWRk
cmVzcy1jZWxscyA9IDwxPjsKPj4+ICvCoMKgwqDCoMKgwqDCoCAjc2l6ZS1jZWxscyA9IDwwPjsK
Pj4+ICvCoMKgwqAgfTsKPj4+ICsKPj4+ICvCoMKgwqAgbWN1X3NwaTI6IHNwaUA0MDMyMDAwMCB7
Cj4+PiArwqDCoMKgwqDCoMKgwqAgY29tcGF0aWJsZSA9ICJ0aSxhbTY1NC1tY3NwaSIsInRpLG9t
YXA0LW1jc3BpIjsKPj4+ICvCoMKgwqDCoMKgwqDCoCByZWcgPSA8MHgwIDB4NDAzMjAwMDAgMHgw
IDB4NDAwPjsKPj4+ICvCoMKgwqDCoMKgwqDCoCBpbnRlcnJ1cHRzID0gPEdJQ19TUEkgNTYyIElS
UV9UWVBFX0xFVkVMX0hJR0g+Owo+Pj4gK8KgwqDCoMKgwqDCoMKgIGNsb2NrcyA9IDwmazNfY2xr
cyAxNDQgMT47Cj4+PiArwqDCoMKgwqDCoMKgwqAgcG93ZXItZG9tYWlucyA9IDwmazNfcGRzIDE0
ND47Cj4+PiArwqDCoMKgwqDCoMKgwqAgI2FkZHJlc3MtY2VsbHMgPSA8MT47Cj4+PiArwqDCoMKg
wqDCoMKgwqAgI3NpemUtY2VsbHMgPSA8MD47Cj4+PiArwqDCoMKgIH07Cj4+PiAgwqAgfTsKPj4+
Cj4+Cj4+IC0tIAoKLS0KVGV4YXMgSW5zdHJ1bWVudHMgRmlubGFuZCBPeSwgUG9ya2thbGFua2F0
dSAyMiwgMDAxODAgSGVsc2lua2kuIFktdHVubnVzL0J1c2luZXNzIElEOiAwNjE1NTIxLTQuIEtv
dGlwYWlra2EvRG9taWNpbGU6IEhlbHNpbmtpCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
