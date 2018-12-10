Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C47EC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:59:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E11C22082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A4xi/4cp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="HinvS8Ml"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E11C22082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YGAvIr9b7NxmaTdJDTe+dtcqxic3irJLm1yEPkXykwQ=; b=A4xi/4cpfBYwDv
	up2vMwilyiCxRHxJK3q2S8kgWHNbRz8YBomZ2D2THsDdzqGP0BUVfeH9kZPdCb9E0hBMvQ7mmw4wV
	GQ+0HEVHF/3Y2Gu+GJWPQxgD9M3H/AsuYkQ2fcWk2dKp2jfIjJSyFZoGnBhS95FKTk5DGOp2qvfRX
	xb67Up31JbOvlEo+ZXrfgIiS7aenT7MmrchEPvYjM76zU0N1Ac+7/8GNtsw8sa5UuxFJhs/QUKtuG
	orhRGsMAgr3l/GVUejs47NCOinTDLua4V4wIr3+CboQD6JkdwzaYq6juPHmmdiNmRyb/qEwnhCXWn
	5AxFAY1fvYEa86XMi4Ag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWHPk-0003n8-1R; Mon, 10 Dec 2018 08:59:44 +0000
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWHPQ-0003WO-Jv
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 08:59:32 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c0e2ae00002>; Mon, 10 Dec 2018 00:59:12 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Mon, 10 Dec 2018 00:59:14 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Mon, 10 Dec 2018 00:59:14 -0800
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 10 Dec
 2018 08:59:12 +0000
Subject: Re: [PATCH 01/19] dt-bindings: clock: tegra124-dfll: Update DFLL
 binding for PWM regulator
To: Joseph Lo <josephl@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, 
 Peter De Schrijver <pdeschrijver@nvidia.com>
References: <20181204092548.3038-1-josephl@nvidia.com>
 <20181204092548.3038-2-josephl@nvidia.com>
 <af1211f0-dda0-bdde-f320-03e54f82d7e1@nvidia.com>
 <46b5eafa-00a0-1d91-1f4d-97ab119fcf21@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <e61b1da8-78cd-c3d4-9878-c25fd9c89ba3@nvidia.com>
Date: Mon, 10 Dec 2018 08:59:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <46b5eafa-00a0-1d91-1f4d-97ab119fcf21@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1544432352; bh=5yAzpD8l7HUY63K5eJLdZc5G6VTUM2U5k9OxSRtIbBQ=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=HinvS8MldIvsvVP/k6adWpf7VwRrtiw/u3RKpI7h8t4W6BQXIqZiaHVQM/4atTy3k
 e3On5MpVB2M/CdklRBct1kXuYDskqjWt5TLw1ON1BPB0rYjIrBqmk9N9XpAe+TdkZZ
 1PkaEuvYFVFxgWuyY8IpDlOEWyKlb9vN6tZ9Wjml4vASQgAs/bFjCXhlhCrD5VdWx9
 JqZStRVAo+SdddkHUxzCArJByvt97QHI4+PLNnp8NiVkXNQgQGSIYt6FrHqPLGszhw
 Wktd5vkOKrjsy1eru7kKMEy0WhfXMkWM1/uLFhyxSBa2iUPEZaahORPVeulYpzP8PK
 5XWwZ7MvZOxlQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_005925_212459_67F1CC67 
X-CRM114-Status: GOOD (  22.13  )
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
Cc: linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Ck9uIDEwLzEyLzIwMTggMDg6NDksIEpvc2VwaCBMbyB3cm90ZToKPiBIaSBKb24sCj4gCj4gVGhh
bmtzIGZvciByZXZpZXdpbmcgdGhpcyBzZXJpZXMuCj4gCj4gT24gMTIvNy8xOCA5OjQxIFBNLCBK
b24gSHVudGVyIHdyb3RlOgo+Pgo+PiBPbiAwNC8xMi8yMDE4IDA5OjI1LCBKb3NlcGggTG8gd3Jv
dGU6Cj4+PiBGcm9tOiBQZXRlciBEZSBTY2hyaWp2ZXIgPHBkZXNjaHJpanZlckBudmlkaWEuY29t
Pgo+Pj4KPj4+IEFkZCBuZXcgcHJvcGVydGllcyB0byBjb25maWd1cmUgdGhlIERGTEwgUFdNIHJl
Z3VsYXRvciBzdXBwb3J0LiBBbHNvCj4+PiBhZGQgYW4gZXhhbXBsZSBhbmQgbWFrZSB0aGUgSTJD
IGNsb2NrIG9ubHkgcmVxdWlyZWQgd2hlbiBJMkMgc3VwcG9ydCBpcwo+Pj4gdXNlZC4KPj4+Cj4+
PiBDYzogZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcKPj4+IFNpZ25lZC1vZmYtYnk6IFBldGVy
IERlIFNjaHJpanZlciA8cGRlc2NocmlqdmVyQG52aWRpYS5jb20+Cj4+PiBTaWduZWQtb2ZmLWJ5
OiBKb3NlcGggTG8gPGpvc2VwaGxAbnZpZGlhLmNvbT4KPj4+IC0tLQo+Pj4gwqAgLi4uL2JpbmRp
bmdzL2Nsb2NrL252aWRpYSx0ZWdyYTEyNC1kZmxsLnR4dMKgwqAgfCA3MyArKysrKysrKysrKysr
KysrKystCj4+PiDCoCAxIGZpbGUgY2hhbmdlZCwgNzEgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0Cj4+PiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9jbG9jay9udmlkaWEsdGVncmExMjQtZGZsbC50eHQKPj4+IGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2NrL252aWRpYSx0ZWdyYTEyNC1kZmxsLnR4dAo+Pj4g
aW5kZXggZGZmMjM2ZjUyNGE3Li44Yzk3NjAwZDJiYWQgMTAwNjQ0Cj4+PiAtLS0gYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY2xvY2svbnZpZGlhLHRlZ3JhMTI0LWRmbGwudHh0
Cj4+PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY2xvY2svbnZpZGlh
LHRlZ3JhMTI0LWRmbGwudHh0Cj4+PiBAQCAtOCw3ICs4LDYgQEAgdGhlIGZhc3QgQ1BVIGNsdXN0
ZXIuIEl0IGNvbnNpc3RzIG9mIGEgZnJlZS1ydW5uaW5nCj4+PiB2b2x0YWdlIGNvbnRyb2xsZWQK
Pj4+IMKgIG9zY2lsbGF0b3IgY29ubmVjdGVkIHRvIHRoZSBDUFUgdm9sdGFnZSByYWlsIChWRERf
Q1BVKSwgYW5kIGEKPj4+IGNsb3NlZCBsb29wCj4+PiDCoCBjb250cm9sIG1vZHVsZSB0aGF0IHdp
bGwgYXV0b21hdGljYWxseSBhZGp1c3QgdGhlIFZERF9DUFUgdm9sdGFnZSBieQo+Pj4gwqAgY29t
bXVuaWNhdGluZyB3aXRoIGFuIG9mZi1jaGlwIFBNSUMgZWl0aGVyIHZpYSBhbiBJMkMgYnVzIG9y
IHZpYQo+Pj4gUFdNIHNpZ25hbHMuCj4+PiAtQ3VycmVudGx5IG9ubHkgdGhlIEkyQyBtb2RlIGlz
IHN1cHBvcnRlZCBieSB0aGVzZSBiaW5kaW5ncy4KPj4+IMKgIMKgIFJlcXVpcmVkIHByb3BlcnRp
ZXM6Cj4+PiDCoCAtIGNvbXBhdGlibGUgOiBzaG91bGQgYmUgIm52aWRpYSx0ZWdyYTEyNC1kZmxs
Igo+Pj4gQEAgLTQ1LDEwICs0NCwyOCBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzIGZvciB0aGUgY29u
dHJvbCBsb29wIHBhcmFtZXRlcnM6Cj4+PiDCoCBPcHRpb25hbCBwcm9wZXJ0aWVzIGZvciB0aGUg
Y29udHJvbCBsb29wIHBhcmFtZXRlcnM6Cj4+PiDCoCAtIG52aWRpYSxjZy1zY2FsZTogQm9vbGVh
biB2YWx1ZSwgc2VlIHRoZSBmaWVsZAo+Pj4gREZMTF9QQVJBTVNfQ0dfU0NBTEUgaW4gdGhlIFRS
TS4KPj4+IMKgICtPcHRpb25hbCBwcm9wZXJ0aWVzIGZvciBtb2RlIHNlbGVjdGlvbjoKPj4+ICst
IG52aWRpYSxwd20tdG8tcG1pYzogVXNlIFBXTSB0byBjb250cm9sIHJlZ3VsYXRvciByYXRoZXIg
dGhlbiBJMkMuCj4+PiArCj4+PiDCoCBSZXF1aXJlZCBwcm9wZXJ0aWVzIGZvciBJMkMgbW9kZToK
Pj4+IMKgIC0gbnZpZGlhLGkyYy1mcy1yYXRlOiBJMkMgdHJhbnNmZXIgcmF0ZSwgaWYgdXNpbmcg
ZnVsbCBzcGVlZCBtb2RlLgo+Pj4gwqAgLUV4YW1wbGU6Cj4+PiArUmVxdWlyZWQgcHJvcGVydGll
cyBmb3IgUFdNIG1vZGU6Cj4+PiArLSBudmlkaWEscHdtLXBlcmlvZDogcGVyaW9kIG9mIFBXTSBz
cXVhcmUgd2F2ZSBpbiBtaWNyb3NlY29uZHMuCj4+PiArLSBudmlkaWEsaW5pdC11djogUmVndWxh
dG9yIHZvbHRhZ2UgaW4gbWljcm8gdm9sdHMgd2hlbiBQV00gY29udHJvbAo+Pj4gaXMgZGlzYWJs
ZWQuCj4+Cj4+IE1heWJlIGNvbnNpZGVyICdwd20taW5hY3RpdmUtdm9sdGFnZS1taWNyb3ZvbHQn
Lgo+IEFoLCBJIHRoaW5rIEkgbmVlZCB0byByZWZpbmUgdGhlIGRlc2NyaXB0aW9uIGhlcmUuIEl0
IHNob3VsZCBiZQo+IHNvbWV0aGluZyBsaWtlIGJlbG93Lgo+IMKgLSBudmlkaWEscHdtLWluaXQt
bWljcm92b2x0IDogUmVndWxhdG9yIHZvbHRhZ2UgaW4gbWljcm8gdm9sdHMgd2hlbiBQV00KPiBj
b250cm9sIGlzIGluaXRpYWxpemVkCj4gCj4gVGhpcyBpcyB0aGUgaW5pdGlhbCB2b2x0YWdlIHRo
YXQgd2hlbiB3ZSBqdXN0IGluaXRpYWxpemUgdGhlIERGTEwKPiBoYXJkd2FyZSBmb3IgUFdNIG91
dHB1dC4gQW5kIGJlZm9yZSB3ZSBzd2l0Y2ggdGhlIENQVSBjbG9jayBmcm9tIFBMTFggdG8KPiBE
RkxMLCB3ZSB3aWxsIGVuYWJsZSBERkxMIGhhcmR3YXJlIGluIGNsb3NlZCBsb29wIG1vZGUgd2hp
Y2ggd2lsbCBhcGxseQo+IHRoZSBEVkZTIHRhYmxlIHRoYXQgd2FzIGNhbGN1bGF0ZWQgZnJvbSBD
VkIgdGFibGUuCj4gCj4gVGhlIG9yaWdpbmFsIGRlc2NyaXB0aW9uIG1heWJlIG1ha2UgeW91IHRo
aW5rIHRoYXQgaXQncyB0aGUgd29ya2luZwo+IHZvbHRhZ2Ugd2hlbiBpdCdzIHVuZGVyIG9wZW4t
bG9vcCBtb2RlLiBCdXQgaXQncyBub3QuIFNvcnJ5Lgo+IAo+IFdoZW4gd2Ugd29ya2luZyBvbiBv
cGVuLWxvb3AgbW9kZSB3aGljaCB3aWxsIHN3aXRjaCB0byBsb3cgdm9sdGFnZSByYW5nZQo+IHdo
aWNoIGFsc28gZm9sbG93cyB0aGUgRFZGUyB0YWJsZS4gTm90IHRoaXMgb25lLgoKT0ssIGJ1dCBJ
IGFtIHN0aWxsIG5vdCBzdXJlIHdoYXQgdGhpcyB2b2x0YWdlIGlzLiBJIG1lYW4gdGhhdCBJCnVu
ZGVyc3RhbmQgaXQgaXMgdGhlIGluaXRpYWwgdm9sdGFnZSwgYnV0IGhvdyBleGFjdGx5IGRvIHdl
IGRlZmluZSB0aGlzCm51bWJlcj8gV2hlcmUgZG9lcyBpdCBjb21lIGZyb20sIGhvdyBpcyB0aGlz
IGRldGVybWluZWQ/Cgo+Pgo+Pj4gKy0gbnZpZGlhLGFsaWduLW9mZnNldC11djogUmVndWxhdG9y
IHZvbHRhZ2UgaW4gbWljcm8gdm9sdHMgd2hlbiBQV00KPj4+IGNvbnRyb2wgaXMKPj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlbmFibGVkIGFuZCBQV00gb3V0cHV0IGlzIGxvdy4KPj4K
Pj4gV291bGQgdGhpcyBiZSBjb25zaWRlcmVkIHRoZSBtaW5pbXVtIHB3bSBhY3RpdmUgdm9sdGFn
ZT8KPiBUaGlzIHdvdWxkIGJlIHVzZWQgZm9yIG1pbmltdW0gdm9sdGFnZSBmb3IgTFVUIHRhYmxl
LCB3aGljaCBpcyB0aGUgdGFibGUKPiB0aGF0IFBNSUMgY2FuIG91dHB1dC4gVGhlIHJlYWwgbWlu
aW11bSB2b2x0YWdlIGluIFBXTSBtb2RlIHN0aWxsIGRlcGVuZHMKPiBvbiB0aGUgQ1ZCIHRhYmxl
Lgo+IAo+IFNvIG1heWJlIGNoYW5nZSB0aGlzIG9uZSB0byAnbnZpZGlhLHB3bS1vZmZzZXQtdXYn
LgoKU28gaXMgdGhpcyB0aGUgbWluIHN1cHBvcnRlZCBieSB0aGUgUE1JQz8gTWF5YmUgdGhlIG5h
bWUgc2hvdWxkIHJlZmxlY3QKdGhhdCBiZWNhdXNlIHRoZSBhYm92ZSBuYW1lIGRvZXMgbm90IHJl
ZmxlY3QgdGhpcy4gRnVydGhlcm1vcmUsIGlmIHRoaXMKaXMgYSBtaW4gdGhlbiBtYXliZSB0aGUg
bmFtZSBzaG91bGQgdXNlICdtaW4nIGFzIG9wcG9zZWQgdG8gJ29mZnNldCcuCmZvciBleGFtcGxl
LCAnbnZpZGlhLHB3bS1wbWljLW1pbi1taWNyb3ZvbHRzJy4KCkRvZXMgdGhpcyBuZWVkIHRvIGJl
IGRlc2NyaWJlZCBpbiBEVCwgY2FuIGl0IG5vdCBiZSBxdWVyaWVkIGZyb20gdGhlIFBNSUM/CgpD
aGVlcnMKSm9uCgotLSAKbnZwdWJsaWMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
