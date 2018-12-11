Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75331C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:29:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 456C22081F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lwTT6DNh";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="M9CZGhvs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 456C22081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1bbpHsLLem+NC/+C4j0wy9rk0/gXFSvoEZ485wPpERE=; b=lwTT6DNhvzi/cuGm5cCUI9JqP
	RnhZgycwNDtPGuAtgCwYsaDnkwSVASpXRmp26SFd7qtzXV7Wc/+/earAZjSNNU6q8gM7Z3gE9wyDk
	24TOAuXmxW5s36cZ6GjpOc1PS4wxFd652Paj4SA/k+M0kxnVQ6pwzEbHNQQO6cSHE6n1QWV4jQtdi
	eCApWfY6zVlDtkoXxYlISWAYtqsGQ/MA41/oGRw50mPlqRM4yqISqIbiTwgVjukLaHCmjMrlRZEpf
	e+PCH461tYPYW8B9pZGVoGiQxyliIyFYMtBy80VWsMZWGE9FJpD3mspLOZep4cUFHhqOY/C/eCW/z
	paMMl+pLw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWWrJ-0001KL-Pr; Tue, 11 Dec 2018 01:29:13 +0000
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWWrB-0000zb-Ka
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 01:29:11 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c0f12d30000>; Mon, 10 Dec 2018 17:28:51 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Mon, 10 Dec 2018 17:28:54 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Mon, 10 Dec 2018 17:28:54 -0800
Received: from [10.19.108.132] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 11 Dec
 2018 01:28:52 +0000
Subject: Re: [PATCH 01/19] dt-bindings: clock: tegra124-dfll: Update DFLL
 binding for PWM regulator
To: Jon Hunter <jonathanh@nvidia.com>, Thierry Reding
 <thierry.reding@gmail.com>, Peter De Schrijver <pdeschrijver@nvidia.com>
References: <20181204092548.3038-1-josephl@nvidia.com>
 <20181204092548.3038-2-josephl@nvidia.com>
 <af1211f0-dda0-bdde-f320-03e54f82d7e1@nvidia.com>
 <46b5eafa-00a0-1d91-1f4d-97ab119fcf21@nvidia.com>
 <e61b1da8-78cd-c3d4-9878-c25fd9c89ba3@nvidia.com>
 <433ed5cf-70ce-1d03-530f-406b2cb16e07@nvidia.com>
 <c5a7360b-3aed-108b-fd77-921626db6797@nvidia.com>
From: Joseph Lo <josephl@nvidia.com>
Message-ID: <54d4fe64-902a-1da3-88b6-a5911f354bb6@nvidia.com>
Date: Tue, 11 Dec 2018 09:28:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <c5a7360b-3aed-108b-fd77-921626db6797@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1544491731; bh=3hBxWjt3OaqRCGzZJU7OdvD1hD7eZR1ZBtVkEzecb4o=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=M9CZGhvsXh9H8dXW7C8gudUr7A0bO/Auwft2w+QPum4N9qVkxTUOs0Oj8zN4WMwg2
 lkzSf0+mR4l9BkzUzx/WdYBxegqN++vIAwmlYNm557r8EYppic12nROhFG4CfddNqP
 ro7gjokFRotlGiO2oqUmgkqogMtqQXUsq0V8/J0hHIxIuA/UY5ImXA+t+6XpxyubpT
 Ydc57s0f6rBN7uTa0vn7gmxt9oaxfGCmOAtLnQgUcWIOxk5lNM5cS/AXIdLdV+y1cI
 quBXwiqiY2EDuu5BqSw1xHs5WaTESpxSxDYANXR51yGZltWj0i9eJuIMsQ+Ri3Rq8p
 avwMWhS7LnF1g==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_172906_194343_6F5F216F 
X-CRM114-Status: GOOD (  24.82  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

CgpPbiAxMi8xMC8xOCA1OjQ0IFBNLCBKb24gSHVudGVyIHdyb3RlOgo+IAo+IE9uIDEwLzEyLzIw
MTggMDk6MzEsIEpvc2VwaCBMbyB3cm90ZToKPj4gT24gMTIvMTAvMTggNDo1OSBQTSwgSm9uIEh1
bnRlciB3cm90ZToKPj4+Cj4+PiBPbiAxMC8xMi8yMDE4IDA4OjQ5LCBKb3NlcGggTG8gd3JvdGU6
Cj4+Pj4gSGkgSm9uLAo+Pj4+Cj4+Pj4gVGhhbmtzIGZvciByZXZpZXdpbmcgdGhpcyBzZXJpZXMu
Cj4+Pj4KPj4+PiBPbiAxMi83LzE4IDk6NDEgUE0sIEpvbiBIdW50ZXIgd3JvdGU6Cj4+Pj4+Cj4+
Pj4+IE9uIDA0LzEyLzIwMTggMDk6MjUsIEpvc2VwaCBMbyB3cm90ZToKPj4+Pj4+IEZyb206IFBl
dGVyIERlIFNjaHJpanZlciA8cGRlc2NocmlqdmVyQG52aWRpYS5jb20+Cj4+Pj4+Pgo+Pj4+Pj4g
QWRkIG5ldyBwcm9wZXJ0aWVzIHRvIGNvbmZpZ3VyZSB0aGUgREZMTCBQV00gcmVndWxhdG9yIHN1
cHBvcnQuIEFsc28KPj4+Pj4+IGFkZCBhbiBleGFtcGxlIGFuZCBtYWtlIHRoZSBJMkMgY2xvY2sg
b25seSByZXF1aXJlZCB3aGVuIEkyQwo+Pj4+Pj4gc3VwcG9ydCBpcwo+Pj4+Pj4gdXNlZC4KPj4+
Pj4+Cj4+Pj4+PiBDYzogZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcKPj4+Pj4+IFNpZ25lZC1v
ZmYtYnk6IFBldGVyIERlIFNjaHJpanZlciA8cGRlc2NocmlqdmVyQG52aWRpYS5jb20+Cj4+Pj4+
PiBTaWduZWQtb2ZmLWJ5OiBKb3NlcGggTG8gPGpvc2VwaGxAbnZpZGlhLmNvbT4KPj4+Pj4+IC0t
LQo+Pj4+Pj4gIMKgwqAgLi4uL2JpbmRpbmdzL2Nsb2NrL252aWRpYSx0ZWdyYTEyNC1kZmxsLnR4
dMKgwqAgfCA3Mwo+Pj4+Pj4gKysrKysrKysrKysrKysrKysrLQo+Pj4+Pj4gIMKgwqAgMSBmaWxl
IGNoYW5nZWQsIDcxIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4+Pj4+Pgo+Pj4+Pj4g
ZGlmZiAtLWdpdAo+Pj4+Pj4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY2xv
Y2svbnZpZGlhLHRlZ3JhMTI0LWRmbGwudHh0Cj4+Pj4+PiBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9jbG9jay9udmlkaWEsdGVncmExMjQtZGZsbC50eHQKPj4+Pj4+IGluZGV4
IGRmZjIzNmY1MjRhNy4uOGM5NzYwMGQyYmFkIDEwMDY0NAo+Pj4+Pj4gLS0tIGEvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2NrL252aWRpYSx0ZWdyYTEyNC1kZmxsLnR4dAo+
Pj4+Pj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2NrL252aWRp
YSx0ZWdyYTEyNC1kZmxsLnR4dAo+Pj4+Pj4gQEAgLTgsNyArOCw2IEBAIHRoZSBmYXN0IENQVSBj
bHVzdGVyLiBJdCBjb25zaXN0cyBvZiBhIGZyZWUtcnVubmluZwo+Pj4+Pj4gdm9sdGFnZSBjb250
cm9sbGVkCj4+Pj4+PiAgwqDCoCBvc2NpbGxhdG9yIGNvbm5lY3RlZCB0byB0aGUgQ1BVIHZvbHRh
Z2UgcmFpbCAoVkREX0NQVSksIGFuZCBhCj4+Pj4+PiBjbG9zZWQgbG9vcAo+Pj4+Pj4gIMKgwqAg
Y29udHJvbCBtb2R1bGUgdGhhdCB3aWxsIGF1dG9tYXRpY2FsbHkgYWRqdXN0IHRoZSBWRERfQ1BV
Cj4+Pj4+PiB2b2x0YWdlIGJ5Cj4+Pj4+PiAgwqDCoCBjb21tdW5pY2F0aW5nIHdpdGggYW4gb2Zm
LWNoaXAgUE1JQyBlaXRoZXIgdmlhIGFuIEkyQyBidXMgb3IgdmlhCj4+Pj4+PiBQV00gc2lnbmFs
cy4KPj4+Pj4+IC1DdXJyZW50bHkgb25seSB0aGUgSTJDIG1vZGUgaXMgc3VwcG9ydGVkIGJ5IHRo
ZXNlIGJpbmRpbmdzLgo+Pj4+Pj4gIMKgwqAgwqAgUmVxdWlyZWQgcHJvcGVydGllczoKPj4+Pj4+
ICDCoMKgIC0gY29tcGF0aWJsZSA6IHNob3VsZCBiZSAibnZpZGlhLHRlZ3JhMTI0LWRmbGwiCj4+
Pj4+PiBAQCAtNDUsMTAgKzQ0LDI4IEBAIFJlcXVpcmVkIHByb3BlcnRpZXMgZm9yIHRoZSBjb250
cm9sIGxvb3AKPj4+Pj4+IHBhcmFtZXRlcnM6Cj4+Pj4+PiAgwqDCoCBPcHRpb25hbCBwcm9wZXJ0
aWVzIGZvciB0aGUgY29udHJvbCBsb29wIHBhcmFtZXRlcnM6Cj4+Pj4+PiAgwqDCoCAtIG52aWRp
YSxjZy1zY2FsZTogQm9vbGVhbiB2YWx1ZSwgc2VlIHRoZSBmaWVsZAo+Pj4+Pj4gREZMTF9QQVJB
TVNfQ0dfU0NBTEUgaW4gdGhlIFRSTS4KPj4+Pj4+ICDCoMKgICtPcHRpb25hbCBwcm9wZXJ0aWVz
IGZvciBtb2RlIHNlbGVjdGlvbjoKPj4+Pj4+ICstIG52aWRpYSxwd20tdG8tcG1pYzogVXNlIFBX
TSB0byBjb250cm9sIHJlZ3VsYXRvciByYXRoZXIgdGhlbiBJMkMuCj4+Pj4+PiArCj4+Pj4+PiAg
wqDCoCBSZXF1aXJlZCBwcm9wZXJ0aWVzIGZvciBJMkMgbW9kZToKPj4+Pj4+ICDCoMKgIC0gbnZp
ZGlhLGkyYy1mcy1yYXRlOiBJMkMgdHJhbnNmZXIgcmF0ZSwgaWYgdXNpbmcgZnVsbCBzcGVlZCBt
b2RlLgo+Pj4+Pj4gIMKgwqAgLUV4YW1wbGU6Cj4+Pj4+PiArUmVxdWlyZWQgcHJvcGVydGllcyBm
b3IgUFdNIG1vZGU6Cj4+Pj4+PiArLSBudmlkaWEscHdtLXBlcmlvZDogcGVyaW9kIG9mIFBXTSBz
cXVhcmUgd2F2ZSBpbiBtaWNyb3NlY29uZHMuCj4+Pj4+PiArLSBudmlkaWEsaW5pdC11djogUmVn
dWxhdG9yIHZvbHRhZ2UgaW4gbWljcm8gdm9sdHMgd2hlbiBQV00gY29udHJvbAo+Pj4+Pj4gaXMg
ZGlzYWJsZWQuCj4+Pj4+Cj4+Pj4+IE1heWJlIGNvbnNpZGVyICdwd20taW5hY3RpdmUtdm9sdGFn
ZS1taWNyb3ZvbHQnLgo+Pj4+IEFoLCBJIHRoaW5rIEkgbmVlZCB0byByZWZpbmUgdGhlIGRlc2Ny
aXB0aW9uIGhlcmUuIEl0IHNob3VsZCBiZQo+Pj4+IHNvbWV0aGluZyBsaWtlIGJlbG93Lgo+Pj4+
ICDCoMKgLSBudmlkaWEscHdtLWluaXQtbWljcm92b2x0IDogUmVndWxhdG9yIHZvbHRhZ2UgaW4g
bWljcm8gdm9sdHMgd2hlbgo+Pj4+IFBXTQo+Pj4+IGNvbnRyb2wgaXMgaW5pdGlhbGl6ZWQKPj4+
Pgo+Pj4+IFRoaXMgaXMgdGhlIGluaXRpYWwgdm9sdGFnZSB0aGF0IHdoZW4gd2UganVzdCBpbml0
aWFsaXplIHRoZSBERkxMCj4+Pj4gaGFyZHdhcmUgZm9yIFBXTSBvdXRwdXQuIEFuZCBiZWZvcmUg
d2Ugc3dpdGNoIHRoZSBDUFUgY2xvY2sgZnJvbSBQTExYIHRvCj4+Pj4gREZMTCwgd2Ugd2lsbCBl
bmFibGUgREZMTCBoYXJkd2FyZSBpbiBjbG9zZWQgbG9vcCBtb2RlIHdoaWNoIHdpbGwgYXBsbHkK
Pj4+PiB0aGUgRFZGUyB0YWJsZSB0aGF0IHdhcyBjYWxjdWxhdGVkIGZyb20gQ1ZCIHRhYmxlLgo+
Pj4+Cj4+Pj4gVGhlIG9yaWdpbmFsIGRlc2NyaXB0aW9uIG1heWJlIG1ha2UgeW91IHRoaW5rIHRo
YXQgaXQncyB0aGUgd29ya2luZwo+Pj4+IHZvbHRhZ2Ugd2hlbiBpdCdzIHVuZGVyIG9wZW4tbG9v
cCBtb2RlLiBCdXQgaXQncyBub3QuIFNvcnJ5Lgo+Pj4+Cj4+Pj4gV2hlbiB3ZSB3b3JraW5nIG9u
IG9wZW4tbG9vcCBtb2RlIHdoaWNoIHdpbGwgc3dpdGNoIHRvIGxvdyB2b2x0YWdlIHJhbmdlCj4+
Pj4gd2hpY2ggYWxzbyBmb2xsb3dzIHRoZSBEVkZTIHRhYmxlLiBOb3QgdGhpcyBvbmUuCj4+Pgo+
Pj4gT0ssIGJ1dCBJIGFtIHN0aWxsIG5vdCBzdXJlIHdoYXQgdGhpcyB2b2x0YWdlIGlzLiBJIG1l
YW4gdGhhdCBJCj4+PiB1bmRlcnN0YW5kIGl0IGlzIHRoZSBpbml0aWFsIHZvbHRhZ2UsIGJ1dCBo
b3cgZXhhY3RseSBkbyB3ZSBkZWZpbmUgdGhpcwo+Pj4gbnVtYmVyPyBXaGVyZSBkb2VzIGl0IGNv
bWUgZnJvbSwgaG93IGlzIHRoaXMgZGV0ZXJtaW5lZD8KPj4gSUlSQywgdGhpcyBpcyB0aGUgc2Ft
ZSBvdXRwdXQgdm9sdGFnZSB0aGF0IGJvb3Rsb2FkZXIgY29uZmlndXJlZCB3aXRoCj4+IHByb3Bl
ciBQTExYIHJhdGUuIFNvIGJlZm9yZSBERkxMIGhhbmRsaW5nIHRoZSBDUFUgY2xvY2ssIHRoYXQg
aXMgdGhlCj4+IG91dHB1dCB2b2x0YWdlLiBXZSBjb25maWd1cmUgdGhlIHNhbWUgd2hlbiBERkxM
IEhXIGlzIGp1c3QgaW5pdGlhbGl6ZWQuCj4+Cj4+IDEgdm9sdCBoZXJlIGlzIHByZXR0eSBzYWZl
IHdoZW4gQ1BVIGNsb2NrIHN3aXRjaGVkIGZyb20gYm9vdGxvYWRlciB0bwo+PiBrZXJuZWwgYXQg
Ni45MTJNSHpAcGxseC4KPiAKPiBPSywgbm93IEkgdW5kZXJzdGFuZC4gU2VlbXMgYSBsaXR0bGUg
ZnJhZ2lsZSwgYnV0IG1heWJlIHRoZXJlIGlzIG5vCj4gYmV0dGVyIGFsdGVybmF0aXZlIGhlcmUu
Cj4gCj4gUGxlYXNlIGRlc2NyaWJlIHdoYXQgdGhpcyB2b2x0YWdlIGlzIGluIHRoZSBiaW5kaW5n
IGRvYywgc28gaWYgYW55b25lCj4gaGFwcGVuZWQgdG8gbW9kaWZ5IHRoZWlyIGJvb3Rsb2FkZXIg
dG8gcnVuIGF0IGEgZGlmZmVyZW50IHNwZWVkIHRoYXQgaXQKPiBpcyBzdGF0ZWQgdGhhdCB0aGlz
IHZvbHRhZ2Ugc2hvdWxkIGJlIGhpZ2ggZW5vdWdoIHRvIHN1cHBvcnQgaW5pdGlhbAo+IGJvb3Qg
ZnJlcXVlbmN5Lgo+IAo+Pj4KPj4+Pj4KPj4+Pj4+ICstIG52aWRpYSxhbGlnbi1vZmZzZXQtdXY6
IFJlZ3VsYXRvciB2b2x0YWdlIGluIG1pY3JvIHZvbHRzIHdoZW4gUFdNCj4+Pj4+PiBjb250cm9s
IGlzCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZW5hYmxlZCBhbmQgUFdNIG91
dHB1dCBpcyBsb3cuCj4+Pj4+Cj4+Pj4+IFdvdWxkIHRoaXMgYmUgY29uc2lkZXJlZCB0aGUgbWlu
aW11bSBwd20gYWN0aXZlIHZvbHRhZ2U/Cj4+Pj4gVGhpcyB3b3VsZCBiZSB1c2VkIGZvciBtaW5p
bXVtIHZvbHRhZ2UgZm9yIExVVCB0YWJsZSwgd2hpY2ggaXMgdGhlIHRhYmxlCj4+Pj4gdGhhdCBQ
TUlDIGNhbiBvdXRwdXQuIFRoZSByZWFsIG1pbmltdW0gdm9sdGFnZSBpbiBQV00gbW9kZSBzdGls
bCBkZXBlbmRzCj4+Pj4gb24gdGhlIENWQiB0YWJsZS4KPj4+Pgo+Pj4+IFNvIG1heWJlIGNoYW5n
ZSB0aGlzIG9uZSB0byAnbnZpZGlhLHB3bS1vZmZzZXQtdXYnLgo+Pj4KPj4+IFNvIGlzIHRoaXMg
dGhlIG1pbiBzdXBwb3J0ZWQgYnkgdGhlIFBNSUM/IE1heWJlIHRoZSBuYW1lIHNob3VsZCByZWZs
ZWN0Cj4+PiB0aGF0IGJlY2F1c2UgdGhlIGFib3ZlIG5hbWUgZG9lcyBub3QgcmVmbGVjdCB0aGlz
LiBGdXJ0aGVybW9yZSwgaWYgdGhpcwo+Pj4gaXMgYSBtaW4gdGhlbiBtYXliZSB0aGUgbmFtZSBz
aG91bGQgdXNlICdtaW4nIGFzIG9wcG9zZWQgdG8gJ29mZnNldCcuCj4+PiBmb3IgZXhhbXBsZSwg
J252aWRpYSxwd20tcG1pYy1taW4tbWljcm92b2x0cycuCj4+Pgo+Pj4gRG9lcyB0aGlzIG5lZWQg
dG8gYmUgZGVzY3JpYmVkIGluIERULCBjYW4gaXQgbm90IGJlIHF1ZXJpZWQgZnJvbSB0aGUKPj4+
IFBNSUM/Cj4+Pgo+PiBZZXMsIGVpdGhlciB3YXkgbmVlZHMgdG8gZ28gd2l0aCBEVC4gVGhlIHZl
cnkgaW5pdGlhbCBwYXRjaHNldCBmb3IKPj4gREZMTC1QV00gc3VwcG9ydCwgd2hpY2ggaW50cm9k
dWNlZCBhIHJlZHVuZGFudCBwd20tZGZsbCBkcml2ZXIuIEFuZCB3aXRoCj4+IHRoZSBkcml2ZXIs
IHdlIGNhbiBkZXNjcmliZSB0aGUgUFdNIHZkZC1jcHUgcmVndWxhdG9yIGluIERUIHdpdGggdGhl
Cj4+IHZvbHRhZ2UgdGFibGUgdGhhdCB0aGUgUE1JQyBjYW4gb3V0cHV0LiBCdXQgTkFLZWQgYnkg
cmV2aWV3ZXIuCj4+Cj4+IE9rYXksICdudmlkaWEscHdtLXBtaWMtbWluLW1pY3Jvdm9sdHMnIGxv
b2tzIGZpbmUuIFRoYW5rcy4KPj4KPj4gWzFdOiBodHRwczovL3BhdGNod29yay5vemxhYnMub3Jn
L3BhdGNoLzYxMzUyNC8KPiAKPiBUaGllcnJ5LCB3aGF0IGFyZSB5b3VyIHRob3VnaHRzIGhlcmU/
IEkgZ3Vlc3MgeW91IGhhZCBhc2tlZCBpbml0aWFsbHkKPiB3aHkgd2UgbmVlZGVkIGEgcGhhbmRs
ZSB0byB0aGUgUE1JQy4gU2VlbXMgd2UgbmVlZCB0byBjb21wcmVoZW5kIHRoZSBtaW4KPiB2b2x0
YWdlIHN1cHBvcnRlZCBieSB0aGUgUE1JQyBmb3IgY3JlYXRpbmcgdGhlIExVVC4KPiAKCkpvbiwK
Ck5vdGljZSB0aGF0IHRoaXMgaXMgbm90IGEgcmVhbCAiUFdNIiBkcml2ZXIgaXQganVzdCBwcm92
aWRlcyBhbiAKaW50ZXJmYWNlIHRoYXQgbWFrZXMgdXMgY2FuIHByb3ZpZGUgYSBQV00gcmVndWxh
dG9yIG5vZGUgd2l0aCB2b2x0YWdlIAp0YWJsZS4gVGhlbiB5b3UgY2FuIGdldCBMVVQgZnJvbSB0
aGF0LiBCdXQgdGhlIFBXTSBkcml2ZXIgaXRzZWxmIGlzIGEgCmZha2UgcHdtIGRyaXZlciBhcyB0
aGUgREZMTC1QV00gaXMgaGFyZHdhcmUgZHJpdmVuIG5vdCBTVy4KCkFuZCBhcyB5b3Ugc2F3IGlu
IFsxXSwgdGhlIERGTEwgY29udHJvbCBjb2RlIHNob3VsZCByZW1haW4gaW4gREZMTCAKZHJpdmVy
LCBub3QgaW4gdGhlIFBXTSBkcml2ZXIuIFNvIGJhc2ljYWxseSwgSSBzdGlsbCBwcmVmZXIgdGhl
IHdheSB3ZSAKcHJlc2VudGVkIGluIHRoaXMgc2VyaWVzLgoKVGhhbmtzLApKb3NlcGgKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJu
ZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
