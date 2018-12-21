Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BDDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:59:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7B84218E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O72qQoxO";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jfbY+aso";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="o/iZX2iW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7B84218E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cKhrQBNrLE9tlOFyIDZQ4W+JC7DBE6VSwoTzd8vwUW8=; b=O72qQoxOeqYc8w4MvA42prGyr
	DRKoVdR+/ijHzNXIKMtBPj67gPKBNDK9dpjYL4c8cGQB9hNAot23Nsryd5kqExDpo0pC12yYZsKeP
	t2Lwf33EEKldShf+OiH5rv9jVDQnB7bQG0/5JnQtl9BIBD4q+2tYgAvI4GeMavrqBI9b+arqUz/0X
	9xSOaycnED9J7+Orw/G/UaOLpJ14kZOyE1TED1cGNPdREiZPsmXzbduT/V8lLKEx9CGSJJGd4/MaM
	nzAzdBkITlQztq/3/DQ5t0LaWvIEKK1qkxBw8OJhL6/q4pvYrqdqbQhoSPXSeoLNwP57TO0b7E7I1
	kT67x6eeg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaP4x-0000m3-Vi; Fri, 21 Dec 2018 17:59:19 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaP4u-0000l0-EO
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 17:59:18 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 3167E60767; Fri, 21 Dec 2018 17:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1545415145;
 bh=ToaKA+6kwMe5bmJIcLqmQ8j2a69VMR6t5WiM4eu5240=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=jfbY+asoa/TUnvisqGz8uojFkSdYCe4tn0sELFNH8WmrPK4RP/36Oad+6ujBS7YF/
 Mog1ouxrDN67IJ5IgFqmNPiHrzAExrPSzZL+fjwrpBrlm991pSVM++xiDJANsfb1iT
 s73SNvHKKmaK8lAz1ahCxzwqUlwkgGKqacFkxC2w=
Received: from [192.168.225.247] (unknown [49.32.116.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: tdas@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 74724606CF;
 Fri, 21 Dec 2018 17:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1545415143;
 bh=ToaKA+6kwMe5bmJIcLqmQ8j2a69VMR6t5WiM4eu5240=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=o/iZX2iWacHywN+CVwHpV3qK4M02LmP9sUwTINPTn+7g7wZ4v1k6QSxEDj0o39C56
 76IkKiXK8V/Oe371klqyc91BTYPGTURQzeIOMxskE6yGEhuQKovh4WGF5h2N45l/PH
 ywD4bEIOBFtO0fi/4cjob7yQHHHmgGJzCzTZ2riM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 74724606CF
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH 01/13] clk: qcom: gcc: limit GPLL0_AO_OUT operating
 frequency
To: Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>, robh+dt@kernel.org,
 mark.rutland@arm.com, andy.gross@linaro.org, david.brown@linaro.org,
 sboyd@kernel.org, will.deacon@arm.com, mturquette@baylibre.com,
 jassisinghbrar@gmail.com
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <e97d9050-effc-56d7-0f9b-768df90dd73a@codeaurora.org>
 <6814777f-1e5f-bd99-db63-a0050dcdd930@linaro.org>
From: Taniya Das <tdas@codeaurora.org>
Message-ID: <874ce15d-67f5-8e55-8b62-73071fe6ae06@codeaurora.org>
Date: Fri, 21 Dec 2018 23:28:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <6814777f-1e5f-bd99-db63-a0050dcdd930@linaro.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_095916_521541_212784DC 
X-CRM114-Status: GOOD (  23.23  )
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
Cc: devicetree@vger.kernel.org, heiko@sntech.de, arnd@arndb.de, olof@lixom.net,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, bjorn.andersson@linaro.org,
 enric.balletbo@collabora.com, vkoul@kernel.org, sibis@codeaurora.org,
 niklas.cassel@linaro.org, horms+renesas@verge.net.au, georgi.djakov@linaro.org,
 linux-arm-kernel@lists.infradead.org, jagan@amarulasolutions.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGVsbG8sCgpPbiAxMi8yMS8yMDE4IDY6MDYgUE0sIEpvcmdlIFJhbWlyZXogd3JvdGU6Cj4gT24g
MTIvMjEvMTggMTI6MTksIFRhbml5YSBEYXMgd3JvdGU6Cj4+Cj4+Cj4+IE9uIDEyLzE3LzIwMTgg
MzoxNiBQTSwgSm9yZ2UgUmFtaXJlei1PcnRpeiB3cm90ZToKPj4+IExpbWl0IHRoZSBHUExMMF9B
T19PVVRfTUFJTiBvcGVyYXRpbmcgZnJlcXVlbmN5IGFzIHBlciBpdHMgaGFyZHdhcmUKPj4+IHNw
ZWNpZmljYXRpb25zLgo+Pj4KPj4+IENvLWRldmVsb3BlZC1ieTogTmlrbGFzIENhc3NlbCA8bmlr
bGFzLmNhc3NlbEBsaW5hcm8ub3JnPgo+Pj4gU2lnbmVkLW9mZi1ieTogTmlrbGFzIENhc3NlbCA8
bmlrbGFzLmNhc3NlbEBsaW5hcm8ub3JnPgo+Pj4gU2lnbmVkLW9mZi1ieTogSm9yZ2UgUmFtaXJl
ei1PcnRpeiA8am9yZ2UucmFtaXJlei1vcnRpekBsaW5hcm8ub3JnPgo+Pj4gLS0tCj4+PiDCoCBk
cml2ZXJzL2Nsay9xY29tL2djYy1xY3M0MDQuYyB8IDYgKysrKysrCj4+PiDCoCAxIGZpbGUgY2hh
bmdlZCwgNiBpbnNlcnRpb25zKCspCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL3Fj
b20vZ2NjLXFjczQwNC5jIAo+Pj4gYi9kcml2ZXJzL2Nsay9xY29tL2djYy1xY3M0MDQuYwo+Pj4g
aW5kZXggNjRkYTAzMi4uODMzNDM2YSAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvY2xrL3Fjb20v
Z2NjLXFjczQwNC5jCj4+PiArKysgYi9kcml2ZXJzL2Nsay9xY29tL2djYy1xY3M0MDQuYwo+Pj4g
QEAgLTMwNCwxMCArMzA0LDE2IEBAIHN0YXRpYyBzdHJ1Y3QgY2xrX2FscGhhX3BsbCBncGxsMF9v
dXRfbWFpbiA9IHsKPj4+IMKgwqDCoMKgwqAgfSwKPj4+IMKgIH07Cj4+PiDCoCArc3RhdGljIGNv
bnN0IHN0cnVjdCBwbGxfdmNvIGdwbGwwX2FvX291dF92Y29bXSA9IHsKPj4+ICvCoMKgwqAgeyA4
MDAwMDAwMDAsIDgwMDAwMDAwMCwgMCB9LAo+Pj4gK307Cj4+PiArCj4+PiDCoCBzdGF0aWMgc3Ry
dWN0IGNsa19hbHBoYV9wbGwgZ3BsbDBfYW9fb3V0X21haW4gPSB7Cj4+PiDCoMKgwqDCoMKgIC5v
ZmZzZXQgPSAweDIxMDAwLAo+Pj4gwqDCoMKgwqDCoCAucmVncyA9IGNsa19hbHBoYV9wbGxfcmVn
c1tDTEtfQUxQSEFfUExMX1RZUEVfREVGQVVMVF0sCj4+PiDCoMKgwqDCoMKgIC5mbGFncyA9IFNV
UFBPUlRTX0ZTTV9NT0RFLAo+Pj4gK8KgwqDCoCAudmNvX3RhYmxlID0gZ3BsbDBfYW9fb3V0X3Zj
bywKPj4+ICvCoMKgwqAgLm51bV92Y28gPSBBUlJBWV9TSVpFKGdwbGwwX2FvX291dF92Y28pLAo+
Pgo+PiBDb3VsZCB5b3UgcGxlYXNlIGhlbHAgYXMgdG8gd2h5IHRoaXMgaXMgcmVxdWlyZWQ/IFRo
aXMgaXMgYSBmaXhlZCBQTEwgCj4+IGFuZCB3ZSBkbyBub3QgcmVxdWlyZSBhIFZDTyB0YWJsZSBm
b3IgaXQuCj4gCj4gSGkgVGFuaXlhLAo+IAo+IHRoaXMgcGF0Y2ggLSB0aGUgYWRkaXRpb25hbCBp
bmZvcm1hdGlvbiB0aGF0IGl0IHByb3ZpZGVzIGFib3V0IHRoZSAKPiBoYXJkd2FyZSAtIGhlbHBz
IHRvIHNlbGVjdCB0aGUgcmlnaHQgcGFyZW50IGNsb2NrIGZvciBhIGdpdmVuIGZyZXF1ZW5jeS4K
PiAKPiBPbiB0aGUgcWNzNDA0IHRoaXMgY2xvY2sgaXMgb25lIG9mIHRoZSB0d28gcGFyZW50IGNs
b2NrcyBvZiB0aGUgYXBjcyAKPiBjbG9jayBjb250cm9sbGVyICh0aGUgb3RoZXIgb25lIGJlaW5n
IHRoZSBoaWdoIGZyZXF1ZW5jeSBwbGwpCj4gV2hlbiBjcHVmcmVxIHNldHMgYSB0YXJnZXQgZnJl
cXVlbmN5LCB0aGVyZSBpcyBhbiBpdGVyYXRpb24gdGhyb3VnaCB0aGUgCj4gbGlzdCBvZiBwYXJl
bnRzIHRvIHNlbGVjdCB0aGUgb25lIHRoYXQgZGVsaXZlcnMgdGhlIGJlc3QgbWF0Y2guCj4gCj4g
V2hlbiBhdHRlbXB0aW5nIHRvIHNldCB0aGUgY2xvY2sgZm9yIGFuIGFscGhhX3BsbCwgdGhlIG9w
ZXJhdGlvbiBkb2VzIGEgCj4gc2FuaXR5IGNoZWNrIHRvIHZhbGlkYXRlIHRoYXQgdGhlIHJlcXVl
c3RlZCBmcmVxdWVuY3kgaXMgaW4gZmFjdCAKPiByZWFjaGFibGUgdXNpbmcgdGhlIHZjbyByYW5n
ZTogdHJ5aW5nIHRvIHNldCBhIHZhbHVlIHRoYXQgaXMgbm90IGluIAo+IHJhbmdlIHdpbGwgZmFp
bC4KPiAKPiBUaGlzIHBhdGNoIG1ha2VzIHN1cmUgdGhhdCBpdHMgcmFuZ2UgaXMgZXhwbGljaXRs
eSBkZWZpbmVkLgo+IAo+IEl0IGFsc28gaGVscHMgbWFraW5nIHN1cmUgdGhlcmUgYXJlIG5vIHJv
dW5kaW5nIGlzc3VlcyB3aGVuIHNldHRpbmcgaXRzIAo+IHZhbHVlOiB3aXRob3V0IGl0IHRoZSBj
bG9jayB3YXMgYmVpbmcgcmVhZCBhdCA3OTlNSHoKPiAKPiAKCklmIHRoZSBQTEwgaXMgYmVpbmcg
cmVhZCBhcyA3OTlNSHogaXQgd291bGQgYmVjYXVzZSBub3QgYWxsIHRoZSA0MCBiaXRzIApvZiB0
aGUgQUxQSEFfVkFMIGJlaW5nIHByb2dyYW1tZWQgYnkgdGhlIGJvb3Rsb2FkZXJzKHdoaWNoIGFy
ZSB0aGUgCm9yaWdpbmFsIG93bmVycyBvZiB0aGlzIFBMTCkuIFNvIHdlIHNob3VsZCBnbyB3aXRo
IHRoZSB3YXkgdGhleSBhcmUgCmJlaW5nIHNldCBieSBib290bG9hZGVycyBhbmQgcmVhZCBieSBI
TE9TIGRyaXZlci4KCkFuZCBhIFZDTyByYW5nZSB5b3UgaGF2ZSBjb25zaWRlcmVkIGlzIHdyb25n
IGZyb20gYSBQTEwgcGVyc3BlY3RpdmUuIEFzIAp0aGVzZSBhcmUgZml4ZWQgUExMcyBhbmQgVkNP
IHJhbmdlIHJlYWxseSBkb2VzIG5vdCBtYXR0ZXIgaGVyZSwgc28gCnBsZWFzZSBkcm9wIHRoaXMg
Y2hhbmdlLgoKPj4KPj4+IMKgwqDCoMKgwqAgLmNsa3IgPSB7Cj4+PiDCoMKgwqDCoMKgwqDCoMKg
wqAgLmVuYWJsZV9yZWcgPSAweDQ1MDAwLAo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIC5lbmFibGVf
bWFzayA9IEJJVCgwKSwKPj4+Cj4+Cj4gCgotLSAKUVVBTENPTU0gSU5ESUEsIG9uIGJlaGFsZiBv
ZiBRdWFsY29tbSBJbm5vdmF0aW9uIENlbnRlciwgSW5jLiBpcyBhIG1lbWJlcgpvZiBDb2RlIEF1
cm9yYSBGb3J1bSwgaG9zdGVkIGJ5IFRoZSBMaW51eCBGb3VuZGF0aW9uLgoKLS0KCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwg
bWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
