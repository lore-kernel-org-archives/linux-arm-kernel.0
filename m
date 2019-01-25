Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224EEC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:06:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5137218D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qu0zvdgp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="m4Ye+8NM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5137218D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:From:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JtB0vUNjsNMwXRtqV2OH8SXO7IYTiRNvc3DoU55gKrs=; b=qu0zvdgp6Z3lSk
	n8iAV0wtBkpnpitQ1q3Ug0Nt0G7RNMRPM4cN2WheIy6USTCBc3PDM9//GzfZCpcHOSp00xuUnWDhS
	rPW0YScxMIaE/7Z4JhgZ9XXkpn45sDHF7YoUmOi9/inpYcFePmFSUl3WhiRETydj0PtRdHqG8xQF5
	SUb+XEd4PdICLqhfZ5vBQTC5P00brGxqIW73vm7XETNU7ynd/28m8W9tQTZBm+rDopnViAMwOnkUo
	wRydvxTYC1qzTN7T6xF2aI1n6ARRin0ymyNp/7S0tLHkZ3TPPMOMBnzpYL0S13U5d2jxACfR5+dfZ
	tNKH5xnmQdyMWQWlabcw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn0G7-00020d-2X; Fri, 25 Jan 2019 12:06:55 +0000
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn0G3-000204-5i
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 12:06:52 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c4afbc10002>; Fri, 25 Jan 2019 04:06:25 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Fri, 25 Jan 2019 04:06:50 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Fri, 25 Jan 2019 04:06:50 -0800
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 25 Jan
 2019 12:06:48 +0000
Subject: Re: [PATCH 1/6] dt-bindings: timer: add Tegra210 timer
From: Jon Hunter <jonathanh@nvidia.com>
To: Joseph Lo <josephl@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>
References: <20190107032810.13522-1-josephl@nvidia.com>
 <20190107032810.13522-2-josephl@nvidia.com>
 <a5fec080-d388-5362-7f44-b50f7d7e1adf@nvidia.com>
 <285bd3f7-e1c0-0767-6381-4b1d748bd6db@nvidia.com>
 <381f94c0-6c19-0f5b-df06-91353455a4c0@nvidia.com>
Message-ID: <709e24fa-02e1-96ea-2b20-acf150caff00@nvidia.com>
Date: Fri, 25 Jan 2019 12:06:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <381f94c0-6c19-0f5b-df06-91353455a4c0@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1548417985; bh=52DdgeQgGbRQd70/mlPU5RXi/79u+o+2v3jVDcM9BgY=;
 h=X-PGP-Universal:Subject:From:To:CC:References:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=m4Ye+8NMkqSLhS5/KxFM7SBEYqyiWBqAZb+3coUEbF8JAsV6SakU6K4Q1V00I60xM
 0BNaWEjLfKf25MLfX23QhREbXFWLRF3DgHNCR1MNNnGo4A4zj4vr6BdqJ8LtaUHqbX
 E91NNE/ILifqJY9XtLj4Ekx5PC2j2oYYgXlBoOkG3OoEhI/NS+UeTljtn+IzAFnEI2
 HRUxhpIOQlyWlS0mnFobhs94e87kilRsp9AKFxzKA2AA6oylIVwwPLLpeLwazIxa/Q
 WqgY7QKQOuhNtR6bnlCGYPkGfxP3OHHCBCDGpXLrWmS4/w3Gr0YsRYyWmCnvirrJgD
 Kseuf97osfG9Q==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_040651_223411_C3AA3BA8 
X-CRM114-Status: GOOD (  11.48  )
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
Cc: devicetree@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Ck9uIDI1LzAxLzIwMTkgMTI6MDEsIEpvbiBIdW50ZXIgd3JvdGU6Cj4gCj4gT24gMjUvMDEvMjAx
OSAwMzoyMywgSm9zZXBoIExvIHdyb3RlOgo+PiBIaSBKb24sCj4+Cj4+IFRoYW5rcyBmb3IgcmV2
aWV3aW5nLgo+Pgo+PiBPbiAxLzI0LzE5IDY6MzAgUE0sIEpvbiBIdW50ZXIgd3JvdGU6Cj4+Pgo+
Pj4gT24gMDcvMDEvMjAxOSAwMzoyOCwgSm9zZXBoIExvIHdyb3RlOgo+Pj4+IFRoZSBUZWdyYTIx
MCB0aW1lciBwcm92aWRlcyBmb3VydGVlbiAyOS1iaXQgdGltZXIgY291bnRlcnMgYW5kIG9uZQo+
Pj4+IDMyLWJpdAo+Pj4+IHRpbWVzdGFtcCBjb3VudGVyLiBUaGUgVE1ScyBydW4gYXQgZWl0aGVy
IGEgZml4ZWQgMSBNSHogY2xvY2sgcmF0ZQo+Pj4+IGRlcml2ZWQKPj4+PiBmcm9tIHRoZSBvc2Np
bGxhdG9yIGNsb2NrIChUTVIwLVRNUjkpIG9yIGRpcmVjdGx5IGF0IHRoZSBvc2NpbGxhdG9yCj4+
Pj4gY2xvY2sKPj4+PiAoVE1SMTAtVE1SMTMpLiBFYWNoIFRNUiBjYW4gYmUgcHJvZ3JhbW1lZCB0
byBnZW5lcmF0ZSBvbmUtc2hvdCBwZXJpb2RpYywKPj4+PiBvciB3YXRjaGRvZyBpbnRlcnJ1cHRz
Lgo+Pj4+Cj4+Pj4gQ2M6IERhbmllbCBMZXpjYW5vIDxkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3Jn
Pgo+Pj4+IENjOiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4KPj4+PiBDYzog
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZwo+Pj4+IENjOiBkZXZpY2V0cmVlQHZnZXIua2Vy
bmVsLm9yZwo+Pj4+IFNpZ25lZC1vZmYtYnk6IEpvc2VwaCBMbyA8am9zZXBobEBudmlkaWEuY29t
Pgo+Pj4+IC0tLQo+Pj4+IMKgIC4uLi9iaW5kaW5ncy90aW1lci9udmlkaWEsdGVncmEyMTAtdGlt
ZXIudHh0wqAgfCAyNSArKysrKysrKysrKysrKysrKysrCj4+Pj4gwqAgMSBmaWxlIGNoYW5nZWQs
IDI1IGluc2VydGlvbnMoKykKPj4+PiDCoCBjcmVhdGUgbW9kZSAxMDA2NDQKPj4+PiBEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdGltZXIvbnZpZGlhLHRlZ3JhMjEwLXRpbWVyLnR4
dAo+Pj4+Cj4+Pj4gZGlmZiAtLWdpdAo+Pj4+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3RpbWVyL252aWRpYSx0ZWdyYTIxMC10aW1lci50eHQKPj4+PiBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy90aW1lci9udmlkaWEsdGVncmEyMTAtdGltZXIudHh0Cj4+
Pj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPj4+PiBpbmRleCAwMDAwMDAwMDAwMDAuLmJhNTExMjIw
YTY2OQo+Pj4+IC0tLSAvZGV2L251bGwKPj4+PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvdGltZXIvbnZpZGlhLHRlZ3JhMjEwLXRpbWVyLnR4dAo+Pj4+IEBAIC0wLDAg
KzEsMjUgQEAKPj4+PiArTlZJRElBIFRlZ3JhMjEwIHRpbWVyCj4+Pj4gKwo+Pj4+ICtUaGUgVGVn
cmEyMTAgdGltZXIgcHJvdmlkZXMgZm91cnRlZW4gMjktYml0IHRpbWVyIGNvdW50ZXJzIGFuZCBv
bmUKPj4+PiAzMi1iaXQKPj4+PiArdGltZXN0YW1wIGNvdW50ZXIuIFRoZSBUTVJzIHJ1biBhdCBl
aXRoZXIgYSBmaXhlZCAxIE1IeiBjbG9jayByYXRlCj4+Pj4gZGVyaXZlZAo+Pj4+ICtmcm9tIHRo
ZSBvc2NpbGxhdG9yIGNsb2NrIChUTVIwLVRNUjkpIG9yIGRpcmVjdGx5IGF0IHRoZSBvc2NpbGxh
dG9yCj4+Pj4gY2xvY2sKPj4+PiArKFRNUjEwLVRNUjEzKS4gRWFjaCBUTVIgY2FuIGJlIHByb2dy
YW1tZWQgdG8gZ2VuZXJhdGUgb25lLXNob3QsCj4+Pj4gcGVyaW9kaWMsCj4+Pj4gK29yIHdhdGNo
ZG9nIGludGVycnVwdHMuCj4+Pj4gKwo+Pj4+ICtSZXF1aXJlZCBwcm9wZXJ0aWVzOgo+Pj4+ICst
IGNvbXBhdGlibGUgOiAibnZpZGlhLHRlZ3JhMjEwLXRpbWVyIi4KPj4+PiArLSByZWcgOiBTcGVj
aWZpZXMgYmFzZSBwaHlzaWNhbCBhZGRyZXNzIGFuZCBzaXplIG9mIHRoZSByZWdpc3RlcnMuCj4+
Pj4gKy0gaW50ZXJydXB0cyA6IEEgbGlzdCBvZiA0IGludGVycnVwdHM7IG9uZSBwZXIgZWFjaCBv
ZiBUTVIxMCB0aHJvdWdoCj4+Pj4gVE1SMTMuCj4+Pgo+Pj4gV2h5IGRvIHdlIG9ubHkgYWRkIHRo
ZSBpbnRlcnJ1cHRzIGZvciBUTVIxMCAtIFRNUjEzPyBXaGF0IGFib3V0IHRoZQo+Pj4gb3RoZXJz
Pwo+Pj4KPj4KPj4gVGhlIG90aGVycyAoVE1SMC1UTVI5KSBhcmUgb2NjdXBpZWQgZm9yIG90aGVy
IHVzYWdlcy4gVE1SNSBpcyBvY2N1cGllZAo+PiBmb3IgdGhlIHdhdGNoZG9nIHRpbWVyIGluIHRo
ZSB1cHN0cmVhbSBrZXJuZWwuIEFuZCBvdGhlcnMgKHN0aWxsIGluCj4+IFRNUjAtVE1SOSkgYXJl
IG9jY3VwaWVkIGZvciBkaWZmZXJlbnQgdXNhZ2VzIGluIG91ciBkb3duc3RyZWFtIGtlcm5lbC4K
PiAKPiBXaGVyZSBpcyBUTVI1IHJlc2VydmVkIGZvciB0aGUgd2F0Y2hkb2c/IEkgZG9uJ3Qgc2Vl
IHRoaXM/CgpJIHNlZSBpdCBub3csIGl0IGlzIGhhcmQtY29kZWQgaW4gdGhlIGRyaXZlci4gSSB3
YXMgbG9va2luZyBhdCBhcm02NCB0bwpzZWUgd2hlcmUgaXQgaXMgdXNlZC4KCkNoZWVycwpKb24K
Ci0tIApudnB1YmxpYwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtYXJtLWtlcm5lbAo=
