Return-Path: <SRS0=Q9BQ=QJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F13DC282DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 16:05:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EAEB20857
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 16:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="olo9xR1t";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="AwDeX8U0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EAEB20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=yxGI+FDW9XCRCASBuTFlxu6eXsEEfKNyCiRThjFIXfU=; b=olo9xR1tsbg+/R22cAuA+P1OE
	B8+I1J9TW9zOLwXMjlpHus1KqaeMZENx4amnBXbGKNIopPc6YcHweZay/ze6rK1oLHG1qKgvWXGPf
	4QscrhEljxT5N0dtfnLhEVKUy3qyz8f//vLgXpt6iVv/azNRq4/XE2fdDZEpYqINFHxE6M0k2d7Qa
	VFGCqqAmptQvOUx+CLovP+YJenEFnrgYMKKZ2IpnVRagRLCLU9vPb3hneLq3NiIdPbbzF5996DQr8
	WOtrPvAQaA0aGgr/NxDJ1hNbOiFcHYvl29DNqiwaa5qpzkdVWkdTo9Br3qsC/g5H1SRHPj9zuccew
	qVVK6OG6g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpxmm-0001fz-UG; Sat, 02 Feb 2019 16:04:52 +0000
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpxmk-0001fd-7a
 for linux-arm-kernel@lists.infradead.org; Sat, 02 Feb 2019 16:04:51 +0000
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c55bf830000>; Sat, 02 Feb 2019 08:04:19 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Sat, 02 Feb 2019 08:04:48 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Sat, 02 Feb 2019 08:04:48 -0800
Received: from [10.19.108.132] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 2 Feb
 2019 16:04:46 +0000
Subject: Re: [PATCH V5 2/7] clocksource: tegra: add Tegra210 timer support
To: Dmitry Osipenko <digetx@gmail.com>, Jon Hunter <jonathanh@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>
References: <20190201033621.16814-1-josephl@nvidia.com>
 <20190201033621.16814-3-josephl@nvidia.com>
 <9370a0e4-2c76-6e9e-9219-121f92cdb14a@gmail.com>
 <46a1a62f-29b1-caac-ba68-e1394a76b3af@gmail.com>
 <85988378-0c88-6b71-00df-0700a7b4cdf7@nvidia.com>
 <4c89fd38-eacd-4643-52d3-da4760ecb4c5@nvidia.com>
 <57549882-4d0a-64ac-da04-7e790ac2d80e@gmail.com>
 <9437d5b5-5af0-9393-169c-2ebaf384c75c@nvidia.com>
 <3d173ddf-46d2-165c-7886-cea685a0737d@gmail.com>
From: Joseph Lo <josephl@nvidia.com>
Message-ID: <e2bcf87a-1cf4-c149-9b72-10fe46052f9e@nvidia.com>
Date: Sun, 3 Feb 2019 00:04:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <3d173ddf-46d2-165c-7886-cea685a0737d@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1549123459; bh=Wgrp3zwbX7fCu/fjyxmLXE0T0P95Qlrfo03Klo+AyrM=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=AwDeX8U0LMOdD0kdz3X6imrlfNfkKkVYxFHOEFQQGbZ3lNAy8nos6N86m+c+znP0m
 vxN1jC+a3GrR3f1V3Bj4OuQWgdSEqXyEc9buutHJE2FMR9RDgvSHRzb09pwCfkqrvj
 IOuTrHtlgjfLCbIvxEw7JSM31H3KUVfOB/n7LWU0doOaY4AmqQ/wlsvb/JdXU11gcR
 N+QDVOo8oZzQBgQqx0tBAdvo1QEgQwZl1+P4g2nIpbaY5bvP/zdEJYtigvOmG2P9XW
 460allxHl+9Wzy3RwwgHXxA1qlIj7sWiC9BVrkF4QLy3UothrTe7+WX1v7BZcDlJ6u
 yEViMxb8L+L0Q==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190202_080450_292344_D6073C77 
X-CRM114-Status: GOOD (  14.21  )
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
Cc: linux-tegra@vger.kernel.org, Thierry Reding <treding@nvidia.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMi8yLzE5IDk6MzAgUE0sIERtaXRyeSBPc2lwZW5rbyB3cm90ZToKPiAwMS4wMi4yMDE5IDE4
OjM3LCBKb3NlcGggTG8g0L/QuNGI0LXRgjoKPj4gT24gMi8xLzE5IDExOjEzIFBNLCBEbWl0cnkg
T3NpcGVua28gd3JvdGU6Cj4+PiAwMS4wMi4yMDE5IDE3OjEzLCBKb3NlcGggTG8g0L/QuNGI0LXR
gjoKPj4+PiBPbiAyLzEvMTkgOTo1NCBQTSwgSm9uIEh1bnRlciB3cm90ZToKPj4+Pj4KPj4+Pj4g
T24gMDEvMDIvMjAxOSAxMzoxMSwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+Pj4+Pj4gMDEuMDIu
MjAxOSAxNjowNiwgRG1pdHJ5IE9zaXBlbmtvINC/0LjRiNC10YI6Cj4+Pj4+Pj4gMDEuMDIuMjAx
OSA2OjM2LCBKb3NlcGggTG8g0L/QuNGI0LXRgjoKPj4+Pj4+Pj4gQWRkIHN1cHBvcnQgZm9yIHRo
ZSBUZWdyYTIxMCB0aW1lciB0aGF0IHJ1bnMgYXQgb3NjaWxsYXRvciBjbG9jawo+Pj4+Pj4+PiAo
VE1SMTAtVE1SMTMpLiBXZSBuZWVkIHRoZXNlIHRpbWVycyB0byB3b3JrIGFzIGNsb2NrIGV2ZW50
IGRldmljZSBhbmQgdG8KPj4+Pj4+Pj4gcmVwbGFjZSB0aGUgQVJNdjggYXJjaGl0ZWN0ZWQgdGlt
ZXIgZHVlIHRvIGl0IGNhbid0IHN1cnZpdmUgYWNyb3NzIHRoZQo+Pj4+Pj4+PiBwb3dlciBjeWNs
ZSBvZiB0aGUgQ1BVIGNvcmUgb3IgQ1BVUE9SRVNFVCBzaWduYWwuIFNvIGl0IGNhbid0IGJlIGEg
d2FrZS11cAo+Pj4+Pj4+PiBzb3VyY2Ugd2hlbiBDUFUgc3VzcGVuZHMgaW4gcG93ZXIgZG93biBz
dGF0ZS4KPj4+Pj4+Pj4KPj4+Pj4+Pj4gQWxzbyBjb252ZXJ0IHRoZSBvcmlnaW5hbCBkcml2ZXIg
dG8gdXNlIHRpbWVyLW9mIEFQSS4KPj4+Pj4+Pj4KPj4+Pj4+Pj4gQ2M6IERhbmllbCBMZXpjYW5v
IDxkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnPgo+Pj4+Pj4+PiBDYzogVGhvbWFzIEdsZWl4bmVy
IDx0Z2x4QGxpbnV0cm9uaXguZGU+Cj4+Pj4+Pj4+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnCj4+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEpvc2VwaCBMbyA8am9zZXBobEBudmlkaWEu
Y29tPgo+Pj4+Pj4+PiBBY2tlZC1ieTogVGhpZXJyeSBSZWRpbmcgPHRyZWRpbmdAbnZpZGlhLmNv
bT4KPj4+Pj4+Pj4gLS0tCj4+IHNuaXAuCj4+Pj4+Pj4+ICt9Cj4+Pj4+Pj4+ICtUSU1FUl9PRl9E
RUNMQVJFKHRlZ3JhMjEwX3RpbWVyLCAibnZpZGlhLHRlZ3JhMjEwLXRpbWVyIiwgdGVncmEyMTBf
dGltZXJfaW5pdCk7Cj4+Pj4+Pj4+ICsjZWxzZSAvKiBDT05GSUdfQVJNICovCj4+Pj4+Pj4+ICtz
dGF0aWMgaW50IF9faW5pdCB0ZWdyYTIwX2luaXRfdGltZXIoc3RydWN0IGRldmljZV9ub2RlICpu
cCkKPj4+Pj4+Pj4gK3sKPj4+Pj4+PiBXaGF0IGFib3V0IFQxMzI/IElzbid0IGl0IEFSTTY0IHdo
aWNoIHVzZXMgdGVncmEyMC10aW1lciBJUD8gQXQgbGVhc3QgVDEzMiBEVCBzdWdnZXN0cyBzbyBh
bmQgc2VlbXMgdGhpcyBjaGFuZ2Ugd2lsbCBicmVhayBpdC4KPj4+Pj4+Pgo+Pj4+Pj4+IFtzbmlw
XQo+Pj4+Pj4+Cj4+Pj4+Pgo+Pj4+Pj4gQWgsIG5vdGljZWQgdGhlICJkZXBlbmRzIG9uIEFSTSIg
aW4gS2NvbmZpZy4uIFNlZW1zIG9rYXkgdGhlbi4KPj4+Pj4+Cj4+Pj4+Cj4+Pj4+Cj4+Pj4+IFRo
aXMgaXMgYSBnb29kIHBvaW50LCBiZWNhdXNlIGV2ZW4gdGhvdWdoIHdlIGhhZCAnZGVwZW5kcyBv
biBBUk0nLCB0aGlzCj4+Pj4+IHN0aWxsIG1lYW5zIHRoYXQgdGhlIFRlZ3JhMTMyIERUIGlzIGlu
Y29ycmVjdC4KPj4+Pj4KPj4+Pj4gSm9zZXBoLCBjYW4geW91IHRha2UgYSBxdWljayBsb29rIGF0
IFRlZ3JhMTMyPwo+Pj4+Cj4+Pj4gSGkgSm9uIGFuZCBEbWl0cnksCj4+Pj4KPj4+PiBObyB3b3Jy
eSBhYm91dCBUMTMyLCBUMTMyIHVzZXMgYXJjaCB0aW1lciAodjcpLiBUaGUgdGVncmEyMCB0aW1l
ciBkcml2ZXIgaGFzIG5ldmVyIGJlZW4gdXNlZC4gV2Ugc2hvdWxkIGZpeCB0aGUgZHRzaSBmaWxl
IGxhdGVyLgo+Pj4KPj4+IEhpIEpvc2VwaCwKPj4+Cj4+PiBTbyBpcyBUMTMyIEhXIGFjdHVhbGx5
IGluY29tcGF0aWJsZSB3aXRoIHRoZSB0ZWdyYTIwLXRpbWVyPyBJZiBpdCdzIGNvbXBhdGlibGUs
IHRoZW4gSSB0aGluayB0aGUgZHJpdmVyJ3MgY29kZSBzaG91bGQgYmUgbWFkZSBtb3JlIHVuaXZl
cnNhbCB0byBzdXBwb3J0IFQxMzIuCj4+Pgo+Pgo+PiAgRnJvbSBIVyBwb2ludCBvZiB2aWV3LCB0
aGUgVElNRVIxIH4gVElNRVI0IGlzIGNvbXBhdGlibGUgd2l0aCAibnZpZGlhLHRlZ3JhMjAtdGlt
ZXIiLiBCdXQgVGVncmExMzIgYWN0dWFsbHkgaGFzIDEwIHRpbWVycyB3aGljaCBhcmUgZXhhY3Rs
eSB0aGUgc2FtZSBhcyBUZWdyYTMwLiBTbyBpdCBzaG91bGQgYmFja3dhcmQgY29tcGF0aWJsZSB3
aXRoICJudmlkaWEsdGVncmEzMC10aW1lciIsIHdoaWNoIGlzIHRlZ3JhX3dkdCBkcml2ZXIgbm93
LiBBbmQgVGVncmExMzIgc2hvdWxkIG5ldmVyIHVzZSB0aGlzIGRyaXZlci4KPiAKPiBUaGVuIHNo
b3VsZG4ndCBkZXZpY2UgdHJlZSBsb29rIGxpa2UgdGhpcz8gV2h5IFRNUjctVE1SMCBhcmUgbm90
IGRlZmluZWQgdGhlcmU/ClllYWgsIHRoZXkgbmVlZCB0byByZXZpc2l0IGFuZCBmaXguCj4gCj4g
CXRpbWVyQDYwMDA1MDAwIHsKPiAJCWNvbXBhdGlibGUgPSAibnZpZGlhLHRlZ3JhMTI0LXRpbWVy
IiwgIm52aWRpYSx0ZWdyYTMwLXRpbWVyIiwgIm52aWRpYSx0ZWdyYTIwLXRpbWVyIjsKPiAJCXJl
ZyA9IDwweDAgMHg2MDAwNTAwMCAweDAgMHg0MDA+Owo+IAkJaW50ZXJydXB0cyA9IDxHSUNfU1BJ
IDAgSVJRX1RZUEVfTEVWRUxfSElHSD4sCj4gCQkJICAgICA8R0lDX1NQSSAxIElSUV9UWVBFX0xF
VkVMX0hJR0g+LAo+IAkJCSAgICAgPEdJQ19TUEkgNDEgSVJRX1RZUEVfTEVWRUxfSElHSD4sCj4g
CQkJICAgICA8R0lDX1NQSSA0MiBJUlFfVFlQRV9MRVZFTF9ISUdIPiwKPiAJCQkgICAgIDxHSUNf
U1BJIDEyMSBJUlFfVFlQRV9MRVZFTF9ISUdIPiwKPiAJCQkgICAgIDxHSUNfU1BJIDE1MiBJUlFf
VFlQRV9MRVZFTF9ISUdIPjsKPiAJCQkgICAgIDxHSUNfU1BJIDE1MyBJUlFfVFlQRV9MRVZFTF9I
SUdIPjsKPiAJCQkgICAgIDxHSUNfU1BJIDE1NCBJUlFfVFlQRV9MRVZFTF9ISUdIPjsKPiAJCQkg
ICAgIDxHSUNfU1BJIDE1NSBJUlFfVFlQRV9MRVZFTF9ISUdIPjsKPiAJCQkgICAgIDxHSUNfU1BJ
IDE1NiBJUlFfVFlQRV9MRVZFTF9ISUdIPjsKPiAJCWNsb2NrcyA9IDwmdGVncmFfY2FyIFRFR1JB
MTI0X0NMS19USU1FUj47Cj4gCQljbG9jay1uYW1lcyA9ICJ0aW1lciI7Cj4gCX07Cj4gCj4gVE1S
IDAsNiw3LDgsOSBzaG91bGQgZGVmaW5lIGEgc2hhcmVkIGludGVycnVwdCBhcyB3ZWxsLCBidXQg
c2VlbXMgdGhlIHNoYXJlZCBpbnRlcnJ1cHQgcHJvdmlkZXIgaXMgbm90IHN1cHBvcnRlZCBpbiB1
cHN0cmVhbS4KPiAKPiBBbHNvIG5vdGUgdGhhdCBzZWVtcyBUMTI0LzEzMiBkZXZpY2UgdHJlZSBo
YXMgYSB0eXBvIChJJ20gbG9va2luZyBhdCBUSzEgVFJNKSwgVE1SNiBJUlEgaXMgMTUyIGFuZCBu
b3QgMTIyLgo+IAo+IEFuZCBUMzAgZGV2aWNlIHRyZWUgbG9va3MgaW5jb3JyZWN0LCBUUk0gc2F5
cyB0aGF0IFRNUjEtVE1SNSBoYXZlIGEgImRlZGljYXRlZCBpbnRlcnJ1cHQgYml0IiwgYnV0IG5v
dCBUTVI2Lgo+IApZZWFoLCBub3RpY2VkIHRoYXQgYXMgd2VsbC4gQmVjYXVzZSB0aGUgd2R0IGRy
aXZlciBkb2Vzbid0IG5lZWQgSVJRIApzdXBwb3J0IGFuZCB0aGV5IChUZWdyYTExNC8xMjQvMTMy
KSB1c2UgYXJjaCB0aW1lci4gU28gZXZlcnl0aGluZyBqdXN0IAp3b3JrcyBmaW5lLgoKVGhhbmtz
LApKb3NlcGgKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LWFybS1rZXJuZWwK
