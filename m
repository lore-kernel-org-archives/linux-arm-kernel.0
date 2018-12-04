Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AD6C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 01:51:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AC1420850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 01:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZuFR0XUM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AC1420850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ieet+Okddp25R3vAyTycd6u07mfcEW83hiwFgUdPkoY=; b=ZuFR0XUMCJPHEJ2fX7taXHHwZ
	I6Wb7PmtYZo2zAbRDngbwxbikaKVc+8LS8P+VUk8BraNVJNCYaQ+dfX2aeVquFfa3kFbPQrk1DZby
	4KRZDxoEriIpWJjL9IS521IxdaBvJBauefJ55+GHSc6/3b1EGtcuXiBX0EjYy2sQ89mVPRb0sc7ei
	py2CXSZQjv7+SXGJ6vd25k2xbh5CWqWM+/ZJJolXQm506w2n1XBzH7C7BLs+6Q8qy9InWhIpTKZqE
	Yr8X0Ba73AMn63uwVh5naL12y9AMtIXG2KMWJjR9SkaJvYd7vpGWGRBxrmWzpjsInNfsPe4S4FFnx
	jsusjwkew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTzrz-0002yo-Ru; Tue, 04 Dec 2018 01:51:27 +0000
Received: from mail-sz2.amlogic.com ([211.162.65.114])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTzrv-0002xF-C6; Tue, 04 Dec 2018 01:51:25 +0000
Received: from [10.28.18.81] (10.28.18.81) by mail-sz2.amlogic.com
 (10.28.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Tue, 4 Dec 2018
 09:51:28 +0800
Subject: Re: [PATCH 2/2] irqchip/meson-gpio: Add support for Meson-G12A SoC
To: Neil Armstrong <narmstrong@baylibre.com>, Jerome Brunet
 <jbrunet@baylibre.com>, Marc Zyngier <marc.zyngier@arm.com>, Jason Cooper
 <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>, Kevin Hilman
 <khilman@baylibre.com>
References: <20181203061324.36248-1-xingyu.chen@amlogic.com>
 <20181203061324.36248-3-xingyu.chen@amlogic.com>
 <7a2f88d849ada782de6e27676518d0b9897e30e7.camel@baylibre.com>
 <dc42e7df-a3de-7323-177f-56a08564fb60@amlogic.com>
 <4fc0694c-4c00-5abd-5336-ef85ad36d9b5@baylibre.com>
From: Xingyu Chen <xingyu.chen@amlogic.com>
Message-ID: <47b58f29-7424-63f4-44fe-0f99a4756862@amlogic.com>
Date: Tue, 4 Dec 2018 09:51:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <4fc0694c-4c00-5abd-5336-ef85ad36d9b5@baylibre.com>
Content-Language: en-GB
X-Originating-IP: [10.28.18.81]
X-ClientProxiedBy: mail-sz2.amlogic.com (10.28.11.6) To mail-sz2.amlogic.com
 (10.28.11.6)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_175123_412973_8E2A649A 
X-CRM114-Status: GOOD (  16.26  )
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
Cc: Rob Herring <robh@kernel.org>, Jianxin Pan <jianxin.pan@amlogic.com>,
 linux-kernel@vger.kernel.org, Carlo Caione <carlo@caione.org>,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Heiner Kallweit <hkallweit1@gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

CgpPbiAyMDE4LzEyLzMgMTg6MDYsIE5laWwgQXJtc3Ryb25nIHdyb3RlOgo+IE9uIDAzLzEyLzIw
MTggMTA6MjgsIFhpbmd5dSBDaGVuIHdyb3RlOgo+Pgo+Pgo+PiBPbiAyMDE4LzEyLzMgMTc6MTks
IEplcm9tZSBCcnVuZXQgd3JvdGU6Cj4+PiBPbiBNb24sIDIwMTgtMTItMDMgYXQgMTQ6MTMgKzA4
MDAsIFhpbmd5dSBDaGVuIHdyb3RlOgo+Pj4+IFRoZSBNZXNvbi1HMTJBIFNvQyB1c2VzIHRoZSBz
YW1lIEdQSU8gaW50ZXJydXB0IGNvbnRyb2xsZXIgSVAgYmxvY2sgYXMgdGhlCj4+Pj4gb3RoZXIg
TWVzb24gU29DcywgQSB0b3RsZSBvZiAxMDAgcGlucyBjYW4gYmUgc3BpZWQgb24sIHdoaWNoIGlz
IHRoZSBzdW0gb2Y6Cj4+Pj4KPj4+PiAtIDIyMzoxMDAgdW5kZWZpbmVkIChubyBpbnRlcnJ1cHQp
Cj4+Pj4gLSA5OTo5N8KgwqAgMyBwaW5zIG9uIGJhbmsgR1BJT0UKPj4+PiAtIDk2Ojc3wqDCoCAy
MCBwaW5zIG9uIGJhbmsgR1BJT1gKPj4+PiAtIDc2OjYxwqDCoCAxNiBwaW5zIG9uIGJhbmsgR1BJ
T0EKPj4+PiAtIDYwOjUzwqDCoCA4IHBpbnMgb24gYmFuayBHUElPQwo+Pj4+IC0gNTI6MzfCoMKg
IDE2IHBpbnMgb24gYmFuayBCT09UCj4+Pj4gLSAzNjoyOMKgwqAgOSBwaW5zIG9uIGJhbmsgR1BJ
T0gKPj4+PiAtIDI3OjEywqDCoCAxNiBwaW5zIG9uIGJhbmsgR1BJT1oKPj4+PiAtIDExOjDCoMKg
wqAgMTIgcGlucyBpbiB0aGUgQU8gZG9tYWluCj4+Pj4KPj4+PiBTaWduZWQtb2ZmLWJ5OiBYaW5n
eXUgQ2hlbiA8eGluZ3l1LmNoZW5AYW1sb2dpYy5jb20+Cj4+Pj4gU2lnbmVkLW9mZi1ieTogSmlh
bnhpbiBQYW4gPGppYW54aW4ucGFuQGFtbG9naWMuY29tPgo+Pj4+IC0tLQo+Pj4+ICDCoCBkcml2
ZXJzL2lycWNoaXAvaXJxLW1lc29uLWdwaW8uYyB8IDUgKysrKysKPj4+PiAgwqAgMSBmaWxlIGNo
YW5nZWQsIDUgaW5zZXJ0aW9ucygrKQo+Pj4+Cj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaXJx
Y2hpcC9pcnEtbWVzb24tZ3Bpby5jIGIvZHJpdmVycy9pcnFjaGlwL2lycS1tZXNvbi0KPj4+PiBn
cGlvLmMKPj4+PiBpbmRleCA3YjUzMWZkMDc1YjguLjk3MWU4ZGVhMDY5YSAxMDA2NDQKPj4+PiAt
LS0gYS9kcml2ZXJzL2lycWNoaXAvaXJxLW1lc29uLWdwaW8uYwo+Pj4+ICsrKyBiL2RyaXZlcnMv
aXJxY2hpcC9pcnEtbWVzb24tZ3Bpby5jCj4+Pj4gQEAgLTY3LDEyICs2NywxNyBAQCBzdGF0aWMg
Y29uc3Qgc3RydWN0IG1lc29uX2dwaW9faXJxX3BhcmFtcyBheGdfcGFyYW1zID0gewo+Pj4+ICDC
oMKgwqDCoMKgIC5ucl9od2lycSA9IDEwMCwKPj4+PiAgwqAgfTsKPj4+PiAgwqAgK3N0YXRpYyBj
b25zdCBzdHJ1Y3QgbWVzb25fZ3Bpb19pcnFfcGFyYW1zIGcxMmFfcGFyYW1zID0gewo+Pj4+ICvC
oMKgwqAgLm5yX2h3aXJxID0gMTAwLAo+Pj4+ICt9Owo+Pj4+ICsKPj4+Cj4+PiBTYW1lIGNvbW1l
bnQgYXMgb24gaTJjLCB0aGUgZzEyIHNlZW1zIGNvbXBhdGlibGUgd2l0aCB0aGUgYXhnLgo+Pj4g
SXMgdGhpcyBwYXRjaHNldCBwYXRjaHNldCByZWFsbHkgbmVjZXNzYXJ5ID8KPj4+Cj4+IEFsdGhv
dWdoIHRoZSB0b3RhbCBudW1iZXIgb2YgcGlucyBpcyB0aGUgc2FtZSBhcyB0aGUgTWVzb24tQVhH
IFNvQywgdGhlIGdwaW8gYmFua3MgYW5kIGlycSBudW1iZXJzIGFyZSBkaWZmZXJlbnQuIFRvIGF2
b2lkIGNvbmZ1c2lvbiBvbiB1c2UsIGkgdGhpbmsgdGhlIG5ldyBjb21wYXRpYmxlIHN0cmluZyBp
cyBuZWVkZWQuCj4gCj4gT0sgZm9yIHRoZSBuZXcgY29tcGF0aWJsZSwgYnV0IHlvdSBjYW4gcmUt
dXNlIHRoZSBzYW1lIHN0cnVjdCBsaWtlIGZvciBpMmMuCj4gCj4gTmVpbAo+IApUaGFua3MgZm9y
IHlvdXIgY29tbWVudCwgSSB3aWxsIGZpeCBpdCBpbiB0aGUgbmV4dCB2ZXJzaW9uLgoKPj4+PiAg
wqAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgbWVzb25faXJxX2dwaW9fbWF0Y2hl
c1tdID0gewo+Pj4+ICDCoMKgwqDCoMKgIHsgLmNvbXBhdGlibGUgPSAiYW1sb2dpYyxtZXNvbjgt
Z3Bpby1pbnRjIiwgLmRhdGEgPSAmbWVzb244X3BhcmFtcyB9LAo+Pj4+ICDCoMKgwqDCoMKgIHsg
LmNvbXBhdGlibGUgPSAiYW1sb2dpYyxtZXNvbjhiLWdwaW8taW50YyIsIC5kYXRhID0gJm1lc29u
OGJfcGFyYW1zCj4+Pj4gfSwKPj4+PiAgwqDCoMKgwqDCoCB7IC5jb21wYXRpYmxlID0gImFtbG9n
aWMsbWVzb24tZ3hiYi1ncGlvLWludGMiLCAuZGF0YSA9ICZneGJiX3BhcmFtcwo+Pj4+IH0sCj4+
Pj4gIMKgwqDCoMKgwqAgeyAuY29tcGF0aWJsZSA9ICJhbWxvZ2ljLG1lc29uLWd4bC1ncGlvLWlu
dGMiLCAuZGF0YSA9ICZneGxfcGFyYW1zIH0sCj4+Pj4gIMKgwqDCoMKgwqAgeyAuY29tcGF0aWJs
ZSA9ICJhbWxvZ2ljLG1lc29uLWF4Zy1ncGlvLWludGMiLCAuZGF0YSA9ICZheGdfcGFyYW1zIH0s
Cj4+Pj4gK8KgwqDCoCB7IC5jb21wYXRpYmxlID0gImFtbG9naWMsbWVzb24tZzEyYS1ncGlvLWlu
dGMiLCAuZGF0YSA9ICZnMTJhX3BhcmFtcwo+Pj4+IH0sCj4+Pj4gIMKgwqDCoMKgwqAgeyB9Cj4+
Pj4gIMKgIH07Cj4+Pj4gICAgCj4+Pgo+Pj4KPj4+IC4KPj4+Cj4+Cj4+IF9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4+IGxpbnV4LWFtbG9naWMgbWFpbGlu
ZyBsaXN0Cj4+IGxpbnV4LWFtbG9naWNAbGlzdHMuaW5mcmFkZWFkLm9yZwo+PiBodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFtbG9naWMKPiAKPiAuCj4g
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1h
cm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0t
a2VybmVsCg==
