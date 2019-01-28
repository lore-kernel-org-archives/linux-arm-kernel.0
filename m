Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD0FC282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 03:09:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BE1420C01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 03:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E/xcwoe7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="E52NWDOP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BE1420C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XTUGj4SKxu1CxQwRruRqh4RMXR0S4NiOkunR9aj8jXU=; b=E/xcwoe7Vn/rLWcK75qyscE73
	C6iFr/0cAxJU5dOI/J4nXAnHnyExpyV52kUpW40mmRea93qukV/8CEF8mOj+WJ5Yjz2EncU+NUgLT
	sr00FyRQ3EnlYW5D7v5fBedkjBpX7A4cev57gdFQhPskLV76qoZRGhwFcDhxZ175dOQxJrnSvdTLf
	vsylrCsTbcryZ7ibtQuXXpHnN06embHa+HHOneaQQZiGO9iTCFkEKVJQ7nElMGInfUyyTuWNgvpNt
	aWnwmBourUDxBaDI4nR90eSE+LSxjHHUgUvSKuLgdzCkvih4VRA5NiY5/qsbqyzOEG/Mo/FzfgWtG
	KKoucWW3w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnxIl-0005fP-Lu; Mon, 28 Jan 2019 03:09:35 +0000
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnxIi-0005ew-9c
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 03:09:33 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c4e72420000>; Sun, 27 Jan 2019 19:08:50 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Sun, 27 Jan 2019 19:09:29 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Sun, 27 Jan 2019 19:09:29 -0800
Received: from [10.19.108.132] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 28 Jan
 2019 03:09:27 +0000
Subject: Re: [PATCH 1/6] dt-bindings: timer: add Tegra210 timer
To: Jon Hunter <jonathanh@nvidia.com>, Thierry Reding
 <thierry.reding@gmail.com>
References: <20190107032810.13522-1-josephl@nvidia.com>
 <20190107032810.13522-2-josephl@nvidia.com>
 <a5fec080-d388-5362-7f44-b50f7d7e1adf@nvidia.com>
 <285bd3f7-e1c0-0767-6381-4b1d748bd6db@nvidia.com>
 <381f94c0-6c19-0f5b-df06-91353455a4c0@nvidia.com>
From: Joseph Lo <josephl@nvidia.com>
Message-ID: <1d12f949-1a06-fd17-141d-bd04b72cda3c@nvidia.com>
Date: Mon, 28 Jan 2019 11:09:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <381f94c0-6c19-0f5b-df06-91353455a4c0@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1548644931; bh=ZpPo5gbRAe48ZjcdhkboWEuEFJTYCJUjMv/y/WLFfpE=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=E52NWDOPYlxWKd0RzsNEJnWbGEX10ni54N5WeTTPhmMtxPM068iVIdTEfrQ3bgJG/
 R7Nu89/oesTY3SRLm9uk2nPRXy9PKuyua7mTtrNPeCwj4PgBz2MPBddRuK8dn8UsXU
 y8pNZAAFu6Nc+AQs2nmbe/hezI95zZzb2IswoCKStWnCLS8XX7927U53HG9Dw/q0kI
 og1e3SOoVKmRvBfE2zmKfcaTkC7sXzVPw6UorPSDA7FAVm6Uk8yB9qifBEXXlOcNBG
 wltdX9Zm+4Y2bXD4tQQUH96J8oNbvLn3QpdnHT5wY/JCyvdea6f2LgJ4VR5HX+sVPi
 t8LzUpb0JV6gg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190127_190932_350547_20341B9F 
X-CRM114-Status: GOOD (  11.63  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMS8yNS8xOSA4OjAxIFBNLCBKb24gSHVudGVyIHdyb3RlOgo+IAo+IE9uIDI1LzAxLzIwMTkg
MDM6MjMsIEpvc2VwaCBMbyB3cm90ZToKPj4gSGkgSm9uLAo+Pgo+PiBUaGFua3MgZm9yIHJldmll
d2luZy4KPj4KPj4gT24gMS8yNC8xOSA2OjMwIFBNLCBKb24gSHVudGVyIHdyb3RlOgo+Pj4KPj4+
IE9uIDA3LzAxLzIwMTkgMDM6MjgsIEpvc2VwaCBMbyB3cm90ZToKPj4+PiBUaGUgVGVncmEyMTAg
dGltZXIgcHJvdmlkZXMgZm91cnRlZW4gMjktYml0IHRpbWVyIGNvdW50ZXJzIGFuZCBvbmUKPj4+
PiAzMi1iaXQKPj4+PiB0aW1lc3RhbXAgY291bnRlci4gVGhlIFRNUnMgcnVuIGF0IGVpdGhlciBh
IGZpeGVkIDEgTUh6IGNsb2NrIHJhdGUKPj4+PiBkZXJpdmVkCj4+Pj4gZnJvbSB0aGUgb3NjaWxs
YXRvciBjbG9jayAoVE1SMC1UTVI5KSBvciBkaXJlY3RseSBhdCB0aGUgb3NjaWxsYXRvcgo+Pj4+
IGNsb2NrCj4+Pj4gKFRNUjEwLVRNUjEzKS4gRWFjaCBUTVIgY2FuIGJlIHByb2dyYW1tZWQgdG8g
Z2VuZXJhdGUgb25lLXNob3QgcGVyaW9kaWMsCj4+Pj4gb3Igd2F0Y2hkb2cgaW50ZXJydXB0cy4K
Pj4+Pgo+Pj4+IENjOiBEYW5pZWwgTGV6Y2FubyA8ZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZz4K
Pj4+PiBDYzogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+Cj4+Pj4gQ2M6IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcKPj4+PiBDYzogZGV2aWNldHJlZUB2Z2VyLmtlcm5l
bC5vcmcKPj4+PiBTaWduZWQtb2ZmLWJ5OiBKb3NlcGggTG8gPGpvc2VwaGxAbnZpZGlhLmNvbT4K
Pj4+PiAtLS0KPj4+PiAgwqAgLi4uL2JpbmRpbmdzL3RpbWVyL252aWRpYSx0ZWdyYTIxMC10aW1l
ci50eHTCoCB8IDI1ICsrKysrKysrKysrKysrKysrKysKPj4+PiAgwqAgMSBmaWxlIGNoYW5nZWQs
IDI1IGluc2VydGlvbnMoKykKPj4+PiAgwqAgY3JlYXRlIG1vZGUgMTAwNjQ0Cj4+Pj4gRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3RpbWVyL252aWRpYSx0ZWdyYTIxMC10aW1lci50
eHQKPj4+Pgo+Pj4+IGRpZmYgLS1naXQKPj4+PiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy90aW1lci9udmlkaWEsdGVncmEyMTAtdGltZXIudHh0Cj4+Pj4gYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdGltZXIvbnZpZGlhLHRlZ3JhMjEwLXRpbWVyLnR4dAo+
Pj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4+Pj4gaW5kZXggMDAwMDAwMDAwMDAwLi5iYTUxMTIy
MGE2NjkKPj4+PiAtLS0gL2Rldi9udWxsCj4+Pj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3RpbWVyL252aWRpYSx0ZWdyYTIxMC10aW1lci50eHQKPj4+PiBAQCAtMCww
ICsxLDI1IEBACj4+Pj4gK05WSURJQSBUZWdyYTIxMCB0aW1lcgo+Pj4+ICsKPj4+PiArVGhlIFRl
Z3JhMjEwIHRpbWVyIHByb3ZpZGVzIGZvdXJ0ZWVuIDI5LWJpdCB0aW1lciBjb3VudGVycyBhbmQg
b25lCj4+Pj4gMzItYml0Cj4+Pj4gK3RpbWVzdGFtcCBjb3VudGVyLiBUaGUgVE1ScyBydW4gYXQg
ZWl0aGVyIGEgZml4ZWQgMSBNSHogY2xvY2sgcmF0ZQo+Pj4+IGRlcml2ZWQKPj4+PiArZnJvbSB0
aGUgb3NjaWxsYXRvciBjbG9jayAoVE1SMC1UTVI5KSBvciBkaXJlY3RseSBhdCB0aGUgb3NjaWxs
YXRvcgo+Pj4+IGNsb2NrCj4+Pj4gKyhUTVIxMC1UTVIxMykuIEVhY2ggVE1SIGNhbiBiZSBwcm9n
cmFtbWVkIHRvIGdlbmVyYXRlIG9uZS1zaG90LAo+Pj4+IHBlcmlvZGljLAo+Pj4+ICtvciB3YXRj
aGRvZyBpbnRlcnJ1cHRzLgo+Pj4+ICsKPj4+PiArUmVxdWlyZWQgcHJvcGVydGllczoKPj4+PiAr
LSBjb21wYXRpYmxlIDogIm52aWRpYSx0ZWdyYTIxMC10aW1lciIuCj4+Pj4gKy0gcmVnIDogU3Bl
Y2lmaWVzIGJhc2UgcGh5c2ljYWwgYWRkcmVzcyBhbmQgc2l6ZSBvZiB0aGUgcmVnaXN0ZXJzLgo+
Pj4+ICstIGludGVycnVwdHMgOiBBIGxpc3Qgb2YgNCBpbnRlcnJ1cHRzOyBvbmUgcGVyIGVhY2gg
b2YgVE1SMTAgdGhyb3VnaAo+Pj4+IFRNUjEzLgo+Pj4KW3NuaXBdCj4+IEFuZCBub3RpY2UgdGhh
dCBvbmx5IFRNUjEwLVRNUjEzIGFyZSBydW5uaW5nIGF0IHRoZSBvc2NpbGxhdG9yIGNsb2NrCj4+
IChjbGtfbSkuIFdpdGggdGhlIFRlZ3JhMjEwIHRpbWVyIGRyaXZlciwgd2UgaW50cm9kdWNlIGlu
IHRoaXMgc2VyaWVzLAo+PiB3aGljaCBvbmx5IHJlcGxhY2UgdGhlIGNsb2NrIGV2ZW50IGRldmlj
ZSBmdW5jdGlvbiB0aGF0IHdhcyBvcmlnaW5hbGx5Cj4+IG93bmVkIGJ5IHRoZSBhcmNoIHRpbWVy
IChhcm12OCB0aW1lcikgYW5kIGl0IGFsc28gcnVubmluZyBhdCB0aGUKPj4gb3NjaWxsYXRvciBj
bG9jay4gVGhlIHNjaGVkX3RpbWVyIHN0aWxsIG93bnMgYnkgdGhlIGFyY2ggdGltZXIuIFNvIHRo
ZQo+PiB0aW1lciByZXNvbHV0aW9uIHdpbGwgYmUgdGhlIHNhbWUuIFRoYXQncyB3aHkgd2UgY2hv
b3NlIFRNUjEwLVRNUjEzIGFzCj4+IHRoZSB0aW1lciBmb3IgVGVncmEyMTAuCj4gCj4gVGhhdCBt
YXliZSBmaW5lLCBidXQgRFQgc2hvdWxkIGRlc2NyaWJlIHRoZSBoYXJkd2FyZSBhbmQgc28gSSBk
b24ndCBzZWUKPiB3aHkgd2Ugd291bGQgbm90IGxpc3QgYWxsIHRoZSBpbnRlcnJ1cHRzLiBXZSBj
YW4gc3RpbGwgb25seSB1c2UgVE1SMTAtMTMKPiBpbiB0aGUgZHJpdmVyLgo+IAoKT2theSwgd2ls
bCBsaXN0IGFsbCB0aGUgaW50ZXJydXB0cyBmb3IgZWFjaCB0aW1lciBjaGFubmVsLgoKVGhhbmtz
LApKb3NlcGgKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LWFybS1rZXJuZWwK
