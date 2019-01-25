Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272CBC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:02:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E292F218D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eG39WXYq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="NHU5D041"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E292F218D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=q/GWrgueSQT8/8qHgy7UOdeWzVcY2iLmXAoqJkvY710=; b=eG39WXYqWwCiG7
	qpXFar2OAm7gbBdNzV/EdW7r3hFy0zzQQ+7IRxwSUSpNII+/5YVwlzGRR1SPCrYwOjM89Jo/z8KL9
	Akt9Bvcea8T3rHnu9CFInA7p/2yPk74dyUNCgZ1EWZKXzEswgDyWhw5mfA4hJgofbnmfC8q/nAfdN
	7mWXAIh54hWGBD5y1Pc5cbewGzu9mW99JXgNfkrmPGL7PzQMtHeCv/9tGxK83BgwpASgA+nQxMOlp
	2ROs44HNK1YQdFeKf9lph/EeL+x3TwKBnqvGI5C79FhmGxpmFQQjFfT2ID2QFIJ67R1R8w+/Um+vN
	HCREGBLnUNphz9S87CwA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn0BL-0006gv-TH; Fri, 25 Jan 2019 12:01:59 +0000
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn0BI-0006gY-8j
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 12:01:57 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c4afa990000>; Fri, 25 Jan 2019 04:01:30 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Fri, 25 Jan 2019 04:01:55 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Fri, 25 Jan 2019 04:01:55 -0800
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 25 Jan
 2019 12:01:53 +0000
Subject: Re: [PATCH 1/6] dt-bindings: timer: add Tegra210 timer
To: Joseph Lo <josephl@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>
References: <20190107032810.13522-1-josephl@nvidia.com>
 <20190107032810.13522-2-josephl@nvidia.com>
 <a5fec080-d388-5362-7f44-b50f7d7e1adf@nvidia.com>
 <285bd3f7-e1c0-0767-6381-4b1d748bd6db@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <381f94c0-6c19-0f5b-df06-91353455a4c0@nvidia.com>
Date: Fri, 25 Jan 2019 12:01:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <285bd3f7-e1c0-0767-6381-4b1d748bd6db@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1548417690; bh=t07DzrGW7WngQL4dRC+GUQ+u3s6LC+S0x/oywjBdt2g=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=NHU5D041YOkVhripbHyYQHmRGwKz5SuiIbN8KbI3l2EmeQr/GAfSNcDMZu4q+vknw
 GeheiRCiAs1XzsIDLa1zKkAYSI+7cP/K4siFG6IFN2x30c4jf4yuJ8HsqSmAfwCfEf
 lR2/6cVXXtO9KIkxvA1V7nYma90vw6hADx2fDmQBfxiLof/VOqQxu/9B2qXodJrYRR
 HyBXHuK2q1UJQkOpmtovxB9rxPsnO/WIpZMu0HngjY/3xAxAyx/Oc4+03rKilPI0Qb
 MYLyr/KHbiF1ASIFHeS11LrJZS3Dr1bQM0Y9eiUQASPoP7k0IKFxaGTUfRZssqmAfM
 N04l/6KPZLURA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_040156_325892_D43AB70C 
X-CRM114-Status: GOOD (  16.38  )
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

Ck9uIDI1LzAxLzIwMTkgMDM6MjMsIEpvc2VwaCBMbyB3cm90ZToKPiBIaSBKb24sCj4gCj4gVGhh
bmtzIGZvciByZXZpZXdpbmcuCj4gCj4gT24gMS8yNC8xOSA2OjMwIFBNLCBKb24gSHVudGVyIHdy
b3RlOgo+Pgo+PiBPbiAwNy8wMS8yMDE5IDAzOjI4LCBKb3NlcGggTG8gd3JvdGU6Cj4+PiBUaGUg
VGVncmEyMTAgdGltZXIgcHJvdmlkZXMgZm91cnRlZW4gMjktYml0IHRpbWVyIGNvdW50ZXJzIGFu
ZCBvbmUKPj4+IDMyLWJpdAo+Pj4gdGltZXN0YW1wIGNvdW50ZXIuIFRoZSBUTVJzIHJ1biBhdCBl
aXRoZXIgYSBmaXhlZCAxIE1IeiBjbG9jayByYXRlCj4+PiBkZXJpdmVkCj4+PiBmcm9tIHRoZSBv
c2NpbGxhdG9yIGNsb2NrIChUTVIwLVRNUjkpIG9yIGRpcmVjdGx5IGF0IHRoZSBvc2NpbGxhdG9y
Cj4+PiBjbG9jawo+Pj4gKFRNUjEwLVRNUjEzKS4gRWFjaCBUTVIgY2FuIGJlIHByb2dyYW1tZWQg
dG8gZ2VuZXJhdGUgb25lLXNob3QgcGVyaW9kaWMsCj4+PiBvciB3YXRjaGRvZyBpbnRlcnJ1cHRz
Lgo+Pj4KPj4+IENjOiBEYW5pZWwgTGV6Y2FubyA8ZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZz4K
Pj4+IENjOiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4KPj4+IENjOiBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnCj4+PiBDYzogZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5v
cmcKPj4+IFNpZ25lZC1vZmYtYnk6IEpvc2VwaCBMbyA8am9zZXBobEBudmlkaWEuY29tPgo+Pj4g
LS0tCj4+PiDCoCAuLi4vYmluZGluZ3MvdGltZXIvbnZpZGlhLHRlZ3JhMjEwLXRpbWVyLnR4dMKg
IHwgMjUgKysrKysrKysrKysrKysrKysrKwo+Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDI1IGluc2Vy
dGlvbnMoKykKPj4+IMKgIGNyZWF0ZSBtb2RlIDEwMDY0NAo+Pj4gRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3RpbWVyL252aWRpYSx0ZWdyYTIxMC10aW1lci50eHQKPj4+Cj4+PiBk
aWZmIC0tZ2l0Cj4+PiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy90aW1lci9u
dmlkaWEsdGVncmEyMTAtdGltZXIudHh0Cj4+PiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy90aW1lci9udmlkaWEsdGVncmEyMTAtdGltZXIudHh0Cj4+PiBuZXcgZmlsZSBtb2Rl
IDEwMDY0NAo+Pj4gaW5kZXggMDAwMDAwMDAwMDAwLi5iYTUxMTIyMGE2NjkKPj4+IC0tLSAvZGV2
L251bGwKPj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy90aW1lci9u
dmlkaWEsdGVncmEyMTAtdGltZXIudHh0Cj4+PiBAQCAtMCwwICsxLDI1IEBACj4+PiArTlZJRElB
IFRlZ3JhMjEwIHRpbWVyCj4+PiArCj4+PiArVGhlIFRlZ3JhMjEwIHRpbWVyIHByb3ZpZGVzIGZv
dXJ0ZWVuIDI5LWJpdCB0aW1lciBjb3VudGVycyBhbmQgb25lCj4+PiAzMi1iaXQKPj4+ICt0aW1l
c3RhbXAgY291bnRlci4gVGhlIFRNUnMgcnVuIGF0IGVpdGhlciBhIGZpeGVkIDEgTUh6IGNsb2Nr
IHJhdGUKPj4+IGRlcml2ZWQKPj4+ICtmcm9tIHRoZSBvc2NpbGxhdG9yIGNsb2NrIChUTVIwLVRN
UjkpIG9yIGRpcmVjdGx5IGF0IHRoZSBvc2NpbGxhdG9yCj4+PiBjbG9jawo+Pj4gKyhUTVIxMC1U
TVIxMykuIEVhY2ggVE1SIGNhbiBiZSBwcm9ncmFtbWVkIHRvIGdlbmVyYXRlIG9uZS1zaG90LAo+
Pj4gcGVyaW9kaWMsCj4+PiArb3Igd2F0Y2hkb2cgaW50ZXJydXB0cy4KPj4+ICsKPj4+ICtSZXF1
aXJlZCBwcm9wZXJ0aWVzOgo+Pj4gKy0gY29tcGF0aWJsZSA6ICJudmlkaWEsdGVncmEyMTAtdGlt
ZXIiLgo+Pj4gKy0gcmVnIDogU3BlY2lmaWVzIGJhc2UgcGh5c2ljYWwgYWRkcmVzcyBhbmQgc2l6
ZSBvZiB0aGUgcmVnaXN0ZXJzLgo+Pj4gKy0gaW50ZXJydXB0cyA6IEEgbGlzdCBvZiA0IGludGVy
cnVwdHM7IG9uZSBwZXIgZWFjaCBvZiBUTVIxMCB0aHJvdWdoCj4+PiBUTVIxMy4KPj4KPj4gV2h5
IGRvIHdlIG9ubHkgYWRkIHRoZSBpbnRlcnJ1cHRzIGZvciBUTVIxMCAtIFRNUjEzPyBXaGF0IGFi
b3V0IHRoZQo+PiBvdGhlcnM/Cj4+Cj4gCj4gVGhlIG90aGVycyAoVE1SMC1UTVI5KSBhcmUgb2Nj
dXBpZWQgZm9yIG90aGVyIHVzYWdlcy4gVE1SNSBpcyBvY2N1cGllZAo+IGZvciB0aGUgd2F0Y2hk
b2cgdGltZXIgaW4gdGhlIHVwc3RyZWFtIGtlcm5lbC4gQW5kIG90aGVycyAoc3RpbGwgaW4KPiBU
TVIwLVRNUjkpIGFyZSBvY2N1cGllZCBmb3IgZGlmZmVyZW50IHVzYWdlcyBpbiBvdXIgZG93bnN0
cmVhbSBrZXJuZWwuCgpXaGVyZSBpcyBUTVI1IHJlc2VydmVkIGZvciB0aGUgd2F0Y2hkb2c/IEkg
ZG9uJ3Qgc2VlIHRoaXM/Cgo+IEFuZCBub3RpY2UgdGhhdCBvbmx5IFRNUjEwLVRNUjEzIGFyZSBy
dW5uaW5nIGF0IHRoZSBvc2NpbGxhdG9yIGNsb2NrCj4gKGNsa19tKS4gV2l0aCB0aGUgVGVncmEy
MTAgdGltZXIgZHJpdmVyLCB3ZSBpbnRyb2R1Y2UgaW4gdGhpcyBzZXJpZXMsCj4gd2hpY2ggb25s
eSByZXBsYWNlIHRoZSBjbG9jayBldmVudCBkZXZpY2UgZnVuY3Rpb24gdGhhdCB3YXMgb3JpZ2lu
YWxseQo+IG93bmVkIGJ5IHRoZSBhcmNoIHRpbWVyIChhcm12OCB0aW1lcikgYW5kIGl0IGFsc28g
cnVubmluZyBhdCB0aGUKPiBvc2NpbGxhdG9yIGNsb2NrLiBUaGUgc2NoZWRfdGltZXIgc3RpbGwg
b3ducyBieSB0aGUgYXJjaCB0aW1lci4gU28gdGhlCj4gdGltZXIgcmVzb2x1dGlvbiB3aWxsIGJl
IHRoZSBzYW1lLiBUaGF0J3Mgd2h5IHdlIGNob29zZSBUTVIxMC1UTVIxMyBhcwo+IHRoZSB0aW1l
ciBmb3IgVGVncmEyMTAuCgpUaGF0IG1heWJlIGZpbmUsIGJ1dCBEVCBzaG91bGQgZGVzY3JpYmUg
dGhlIGhhcmR3YXJlIGFuZCBzbyBJIGRvbid0IHNlZQp3aHkgd2Ugd291bGQgbm90IGxpc3QgYWxs
IHRoZSBpbnRlcnJ1cHRzLiBXZSBjYW4gc3RpbGwgb25seSB1c2UgVE1SMTAtMTMKaW4gdGhlIGRy
aXZlci4KCkNoZWVycwpKb24KCi0tIApudnB1YmxpYwoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
