Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6A3C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:44:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 135D72082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tQ/IJ1pc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="qMnm35st"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 135D72082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=60ma5A1hPj87q8xDLUWiQEpppEZLW5IPKMys8bHILGw=; b=tQ/IJ1pc8Nyz7V
	je1SY7+y1Txh9/e+c/IL+9ejdaJOE8LlIZuMX0lvLeuQ+CQgt2b0qAIXhPfIOy88HZ4u4JCW2aRzc
	e/FWlucGV+pa78dtynmA863mxWIy6n0u9QYwMelVtlxZI/xsCQPDt1JJIkNMCU0edjNjkHCbPALtM
	IdmL7DbhzjvzzzsbrRZo8B5HqFLAYVW0FKfcKP21/1pAnpcoWJi3NOYwWTn/RR9/OqDUa/+VJpdON
	wAPISu3nC0OJ8VdOmYvlbcYBvj40bhn4FJ/jruN9DoAhF+8rn6s9ZE0ve4i7tiB78v0UAzIBV79Nb
	XWdPjv4jc8O2LOrb2ZUg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWI7U-0007sE-6N; Mon, 10 Dec 2018 09:44:56 +0000
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWI7Q-0007rL-7Y
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 09:44:54 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c0e35870000>; Mon, 10 Dec 2018 01:44:39 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Mon, 10 Dec 2018 01:44:41 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Mon, 10 Dec 2018 01:44:41 -0800
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 10 Dec
 2018 09:44:38 +0000
Subject: Re: [PATCH 01/19] dt-bindings: clock: tegra124-dfll: Update DFLL
 binding for PWM regulator
To: Joseph Lo <josephl@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, 
 Peter De Schrijver <pdeschrijver@nvidia.com>
References: <20181204092548.3038-1-josephl@nvidia.com>
 <20181204092548.3038-2-josephl@nvidia.com>
 <af1211f0-dda0-bdde-f320-03e54f82d7e1@nvidia.com>
 <46b5eafa-00a0-1d91-1f4d-97ab119fcf21@nvidia.com>
 <e61b1da8-78cd-c3d4-9878-c25fd9c89ba3@nvidia.com>
 <433ed5cf-70ce-1d03-530f-406b2cb16e07@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <c5a7360b-3aed-108b-fd77-921626db6797@nvidia.com>
Date: Mon, 10 Dec 2018 09:44:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <433ed5cf-70ce-1d03-530f-406b2cb16e07@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1544435080; bh=i0A/2LHJBvYMdPMOPocQ4kchixi+FvVzyDIPng+bPs4=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=qMnm35stuQQpDqWR0p6QIV2eU4uCAUcInK5mdON18S82kZ1WLtJ72S63FSYMJgVrv
 Pbw5oNN3UCSc3J+DS10DIYGX8izax0lJB4InolWgJc02+UegEPSpVEJXJvjykFhoVv
 A9uhw4MGMvtUhZr9JDdoZ1T+4BGfnvN3RnXx2b5DeieAtBfN3rxHHiKjRYejA/z7VH
 CJjBO/yjM5e3Jsm2KWlbXhKwE18GVTjBlPVQodDo/5z2NPGiMMTKhme5Z4/qaspF/N
 s1t/hLtOiWNQ85PgSnsEg9leTC/Ll+WUIa0y4ZIXjhnybqPLvO6gqKKC1lR0ifV4tX
 bR8tIjobQLkZg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_014452_279309_C0586264 
X-CRM114-Status: GOOD (  23.40  )
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

Ck9uIDEwLzEyLzIwMTggMDk6MzEsIEpvc2VwaCBMbyB3cm90ZToKPiBPbiAxMi8xMC8xOCA0OjU5
IFBNLCBKb24gSHVudGVyIHdyb3RlOgo+Pgo+PiBPbiAxMC8xMi8yMDE4IDA4OjQ5LCBKb3NlcGgg
TG8gd3JvdGU6Cj4+PiBIaSBKb24sCj4+Pgo+Pj4gVGhhbmtzIGZvciByZXZpZXdpbmcgdGhpcyBz
ZXJpZXMuCj4+Pgo+Pj4gT24gMTIvNy8xOCA5OjQxIFBNLCBKb24gSHVudGVyIHdyb3RlOgo+Pj4+
Cj4+Pj4gT24gMDQvMTIvMjAxOCAwOToyNSwgSm9zZXBoIExvIHdyb3RlOgo+Pj4+PiBGcm9tOiBQ
ZXRlciBEZSBTY2hyaWp2ZXIgPHBkZXNjaHJpanZlckBudmlkaWEuY29tPgo+Pj4+Pgo+Pj4+PiBB
ZGQgbmV3IHByb3BlcnRpZXMgdG8gY29uZmlndXJlIHRoZSBERkxMIFBXTSByZWd1bGF0b3Igc3Vw
cG9ydC4gQWxzbwo+Pj4+PiBhZGQgYW4gZXhhbXBsZSBhbmQgbWFrZSB0aGUgSTJDIGNsb2NrIG9u
bHkgcmVxdWlyZWQgd2hlbiBJMkMKPj4+Pj4gc3VwcG9ydCBpcwo+Pj4+PiB1c2VkLgo+Pj4+Pgo+
Pj4+PiBDYzogZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcKPj4+Pj4gU2lnbmVkLW9mZi1ieTog
UGV0ZXIgRGUgU2NocmlqdmVyIDxwZGVzY2hyaWp2ZXJAbnZpZGlhLmNvbT4KPj4+Pj4gU2lnbmVk
LW9mZi1ieTogSm9zZXBoIExvIDxqb3NlcGhsQG52aWRpYS5jb20+Cj4+Pj4+IC0tLQo+Pj4+PiDC
oMKgIC4uLi9iaW5kaW5ncy9jbG9jay9udmlkaWEsdGVncmExMjQtZGZsbC50eHTCoMKgIHwgNzMK
Pj4+Pj4gKysrKysrKysrKysrKysrKysrLQo+Pj4+PiDCoMKgIDEgZmlsZSBjaGFuZ2VkLCA3MSBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Pj4+Pgo+Pj4+PiBkaWZmIC0tZ2l0Cj4+Pj4+
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2NrL252aWRpYSx0ZWdyYTEy
NC1kZmxsLnR4dAo+Pj4+PiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9j
ay9udmlkaWEsdGVncmExMjQtZGZsbC50eHQKPj4+Pj4gaW5kZXggZGZmMjM2ZjUyNGE3Li44Yzk3
NjAwZDJiYWQgMTAwNjQ0Cj4+Pj4+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9jbG9jay9udmlkaWEsdGVncmExMjQtZGZsbC50eHQKPj4+Pj4gKysrIGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2NrL252aWRpYSx0ZWdyYTEyNC1kZmxsLnR4dAo+
Pj4+PiBAQCAtOCw3ICs4LDYgQEAgdGhlIGZhc3QgQ1BVIGNsdXN0ZXIuIEl0IGNvbnNpc3RzIG9m
IGEgZnJlZS1ydW5uaW5nCj4+Pj4+IHZvbHRhZ2UgY29udHJvbGxlZAo+Pj4+PiDCoMKgIG9zY2ls
bGF0b3IgY29ubmVjdGVkIHRvIHRoZSBDUFUgdm9sdGFnZSByYWlsIChWRERfQ1BVKSwgYW5kIGEK
Pj4+Pj4gY2xvc2VkIGxvb3AKPj4+Pj4gwqDCoCBjb250cm9sIG1vZHVsZSB0aGF0IHdpbGwgYXV0
b21hdGljYWxseSBhZGp1c3QgdGhlIFZERF9DUFUKPj4+Pj4gdm9sdGFnZSBieQo+Pj4+PiDCoMKg
IGNvbW11bmljYXRpbmcgd2l0aCBhbiBvZmYtY2hpcCBQTUlDIGVpdGhlciB2aWEgYW4gSTJDIGJ1
cyBvciB2aWEKPj4+Pj4gUFdNIHNpZ25hbHMuCj4+Pj4+IC1DdXJyZW50bHkgb25seSB0aGUgSTJD
IG1vZGUgaXMgc3VwcG9ydGVkIGJ5IHRoZXNlIGJpbmRpbmdzLgo+Pj4+PiDCoMKgIMKgIFJlcXVp
cmVkIHByb3BlcnRpZXM6Cj4+Pj4+IMKgwqAgLSBjb21wYXRpYmxlIDogc2hvdWxkIGJlICJudmlk
aWEsdGVncmExMjQtZGZsbCIKPj4+Pj4gQEAgLTQ1LDEwICs0NCwyOCBAQCBSZXF1aXJlZCBwcm9w
ZXJ0aWVzIGZvciB0aGUgY29udHJvbCBsb29wCj4+Pj4+IHBhcmFtZXRlcnM6Cj4+Pj4+IMKgwqAg
T3B0aW9uYWwgcHJvcGVydGllcyBmb3IgdGhlIGNvbnRyb2wgbG9vcCBwYXJhbWV0ZXJzOgo+Pj4+
PiDCoMKgIC0gbnZpZGlhLGNnLXNjYWxlOiBCb29sZWFuIHZhbHVlLCBzZWUgdGhlIGZpZWxkCj4+
Pj4+IERGTExfUEFSQU1TX0NHX1NDQUxFIGluIHRoZSBUUk0uCj4+Pj4+IMKgwqAgK09wdGlvbmFs
IHByb3BlcnRpZXMgZm9yIG1vZGUgc2VsZWN0aW9uOgo+Pj4+PiArLSBudmlkaWEscHdtLXRvLXBt
aWM6IFVzZSBQV00gdG8gY29udHJvbCByZWd1bGF0b3IgcmF0aGVyIHRoZW4gSTJDLgo+Pj4+PiAr
Cj4+Pj4+IMKgwqAgUmVxdWlyZWQgcHJvcGVydGllcyBmb3IgSTJDIG1vZGU6Cj4+Pj4+IMKgwqAg
LSBudmlkaWEsaTJjLWZzLXJhdGU6IEkyQyB0cmFuc2ZlciByYXRlLCBpZiB1c2luZyBmdWxsIHNw
ZWVkIG1vZGUuCj4+Pj4+IMKgwqAgLUV4YW1wbGU6Cj4+Pj4+ICtSZXF1aXJlZCBwcm9wZXJ0aWVz
IGZvciBQV00gbW9kZToKPj4+Pj4gKy0gbnZpZGlhLHB3bS1wZXJpb2Q6IHBlcmlvZCBvZiBQV00g
c3F1YXJlIHdhdmUgaW4gbWljcm9zZWNvbmRzLgo+Pj4+PiArLSBudmlkaWEsaW5pdC11djogUmVn
dWxhdG9yIHZvbHRhZ2UgaW4gbWljcm8gdm9sdHMgd2hlbiBQV00gY29udHJvbAo+Pj4+PiBpcyBk
aXNhYmxlZC4KPj4+Pgo+Pj4+IE1heWJlIGNvbnNpZGVyICdwd20taW5hY3RpdmUtdm9sdGFnZS1t
aWNyb3ZvbHQnLgo+Pj4gQWgsIEkgdGhpbmsgSSBuZWVkIHRvIHJlZmluZSB0aGUgZGVzY3JpcHRp
b24gaGVyZS4gSXQgc2hvdWxkIGJlCj4+PiBzb21ldGhpbmcgbGlrZSBiZWxvdy4KPj4+IMKgwqAt
IG52aWRpYSxwd20taW5pdC1taWNyb3ZvbHQgOiBSZWd1bGF0b3Igdm9sdGFnZSBpbiBtaWNybyB2
b2x0cyB3aGVuCj4+PiBQV00KPj4+IGNvbnRyb2wgaXMgaW5pdGlhbGl6ZWQKPj4+Cj4+PiBUaGlz
IGlzIHRoZSBpbml0aWFsIHZvbHRhZ2UgdGhhdCB3aGVuIHdlIGp1c3QgaW5pdGlhbGl6ZSB0aGUg
REZMTAo+Pj4gaGFyZHdhcmUgZm9yIFBXTSBvdXRwdXQuIEFuZCBiZWZvcmUgd2Ugc3dpdGNoIHRo
ZSBDUFUgY2xvY2sgZnJvbSBQTExYIHRvCj4+PiBERkxMLCB3ZSB3aWxsIGVuYWJsZSBERkxMIGhh
cmR3YXJlIGluIGNsb3NlZCBsb29wIG1vZGUgd2hpY2ggd2lsbCBhcGxseQo+Pj4gdGhlIERWRlMg
dGFibGUgdGhhdCB3YXMgY2FsY3VsYXRlZCBmcm9tIENWQiB0YWJsZS4KPj4+Cj4+PiBUaGUgb3Jp
Z2luYWwgZGVzY3JpcHRpb24gbWF5YmUgbWFrZSB5b3UgdGhpbmsgdGhhdCBpdCdzIHRoZSB3b3Jr
aW5nCj4+PiB2b2x0YWdlIHdoZW4gaXQncyB1bmRlciBvcGVuLWxvb3AgbW9kZS4gQnV0IGl0J3Mg
bm90LiBTb3JyeS4KPj4+Cj4+PiBXaGVuIHdlIHdvcmtpbmcgb24gb3Blbi1sb29wIG1vZGUgd2hp
Y2ggd2lsbCBzd2l0Y2ggdG8gbG93IHZvbHRhZ2UgcmFuZ2UKPj4+IHdoaWNoIGFsc28gZm9sbG93
cyB0aGUgRFZGUyB0YWJsZS4gTm90IHRoaXMgb25lLgo+Pgo+PiBPSywgYnV0IEkgYW0gc3RpbGwg
bm90IHN1cmUgd2hhdCB0aGlzIHZvbHRhZ2UgaXMuIEkgbWVhbiB0aGF0IEkKPj4gdW5kZXJzdGFu
ZCBpdCBpcyB0aGUgaW5pdGlhbCB2b2x0YWdlLCBidXQgaG93IGV4YWN0bHkgZG8gd2UgZGVmaW5l
IHRoaXMKPj4gbnVtYmVyPyBXaGVyZSBkb2VzIGl0IGNvbWUgZnJvbSwgaG93IGlzIHRoaXMgZGV0
ZXJtaW5lZD8KPiBJSVJDLCB0aGlzIGlzIHRoZSBzYW1lIG91dHB1dCB2b2x0YWdlIHRoYXQgYm9v
dGxvYWRlciBjb25maWd1cmVkIHdpdGgKPiBwcm9wZXIgUExMWCByYXRlLiBTbyBiZWZvcmUgREZM
TCBoYW5kbGluZyB0aGUgQ1BVIGNsb2NrLCB0aGF0IGlzIHRoZQo+IG91dHB1dCB2b2x0YWdlLiBX
ZSBjb25maWd1cmUgdGhlIHNhbWUgd2hlbiBERkxMIEhXIGlzIGp1c3QgaW5pdGlhbGl6ZWQuCj4g
Cj4gMSB2b2x0IGhlcmUgaXMgcHJldHR5IHNhZmUgd2hlbiBDUFUgY2xvY2sgc3dpdGNoZWQgZnJv
bSBib290bG9hZGVyIHRvCj4ga2VybmVsIGF0IDYuOTEyTUh6QHBsbHguCgpPSywgbm93IEkgdW5k
ZXJzdGFuZC4gU2VlbXMgYSBsaXR0bGUgZnJhZ2lsZSwgYnV0IG1heWJlIHRoZXJlIGlzIG5vCmJl
dHRlciBhbHRlcm5hdGl2ZSBoZXJlLgoKUGxlYXNlIGRlc2NyaWJlIHdoYXQgdGhpcyB2b2x0YWdl
IGlzIGluIHRoZSBiaW5kaW5nIGRvYywgc28gaWYgYW55b25lCmhhcHBlbmVkIHRvIG1vZGlmeSB0
aGVpciBib290bG9hZGVyIHRvIHJ1biBhdCBhIGRpZmZlcmVudCBzcGVlZCB0aGF0IGl0CmlzIHN0
YXRlZCB0aGF0IHRoaXMgdm9sdGFnZSBzaG91bGQgYmUgaGlnaCBlbm91Z2ggdG8gc3VwcG9ydCBp
bml0aWFsCmJvb3QgZnJlcXVlbmN5LgoKPj4KPj4+Pgo+Pj4+PiArLSBudmlkaWEsYWxpZ24tb2Zm
c2V0LXV2OiBSZWd1bGF0b3Igdm9sdGFnZSBpbiBtaWNybyB2b2x0cyB3aGVuIFBXTQo+Pj4+PiBj
b250cm9sIGlzCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlbmFibGVkIGFuZCBQ
V00gb3V0cHV0IGlzIGxvdy4KPj4+Pgo+Pj4+IFdvdWxkIHRoaXMgYmUgY29uc2lkZXJlZCB0aGUg
bWluaW11bSBwd20gYWN0aXZlIHZvbHRhZ2U/Cj4+PiBUaGlzIHdvdWxkIGJlIHVzZWQgZm9yIG1p
bmltdW0gdm9sdGFnZSBmb3IgTFVUIHRhYmxlLCB3aGljaCBpcyB0aGUgdGFibGUKPj4+IHRoYXQg
UE1JQyBjYW4gb3V0cHV0LiBUaGUgcmVhbCBtaW5pbXVtIHZvbHRhZ2UgaW4gUFdNIG1vZGUgc3Rp
bGwgZGVwZW5kcwo+Pj4gb24gdGhlIENWQiB0YWJsZS4KPj4+Cj4+PiBTbyBtYXliZSBjaGFuZ2Ug
dGhpcyBvbmUgdG8gJ252aWRpYSxwd20tb2Zmc2V0LXV2Jy4KPj4KPj4gU28gaXMgdGhpcyB0aGUg
bWluIHN1cHBvcnRlZCBieSB0aGUgUE1JQz8gTWF5YmUgdGhlIG5hbWUgc2hvdWxkIHJlZmxlY3QK
Pj4gdGhhdCBiZWNhdXNlIHRoZSBhYm92ZSBuYW1lIGRvZXMgbm90IHJlZmxlY3QgdGhpcy4gRnVy
dGhlcm1vcmUsIGlmIHRoaXMKPj4gaXMgYSBtaW4gdGhlbiBtYXliZSB0aGUgbmFtZSBzaG91bGQg
dXNlICdtaW4nIGFzIG9wcG9zZWQgdG8gJ29mZnNldCcuCj4+IGZvciBleGFtcGxlLCAnbnZpZGlh
LHB3bS1wbWljLW1pbi1taWNyb3ZvbHRzJy4KPj4KPj4gRG9lcyB0aGlzIG5lZWQgdG8gYmUgZGVz
Y3JpYmVkIGluIERULCBjYW4gaXQgbm90IGJlIHF1ZXJpZWQgZnJvbSB0aGUKPj4gUE1JQz8KPj4K
PiBZZXMsIGVpdGhlciB3YXkgbmVlZHMgdG8gZ28gd2l0aCBEVC4gVGhlIHZlcnkgaW5pdGlhbCBw
YXRjaHNldCBmb3IKPiBERkxMLVBXTSBzdXBwb3J0LCB3aGljaCBpbnRyb2R1Y2VkIGEgcmVkdW5k
YW50IHB3bS1kZmxsIGRyaXZlci4gQW5kIHdpdGgKPiB0aGUgZHJpdmVyLCB3ZSBjYW4gZGVzY3Jp
YmUgdGhlIFBXTSB2ZGQtY3B1IHJlZ3VsYXRvciBpbiBEVCB3aXRoIHRoZQo+IHZvbHRhZ2UgdGFi
bGUgdGhhdCB0aGUgUE1JQyBjYW4gb3V0cHV0LiBCdXQgTkFLZWQgYnkgcmV2aWV3ZXIuCj4gCj4g
T2theSwgJ252aWRpYSxwd20tcG1pYy1taW4tbWljcm92b2x0cycgbG9va3MgZmluZS4gVGhhbmtz
Lgo+IAo+IFsxXTogaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wYXRjaC82MTM1MjQvCgpU
aGllcnJ5LCB3aGF0IGFyZSB5b3VyIHRob3VnaHRzIGhlcmU/IEkgZ3Vlc3MgeW91IGhhZCBhc2tl
ZCBpbml0aWFsbHkKd2h5IHdlIG5lZWRlZCBhIHBoYW5kbGUgdG8gdGhlIFBNSUMuIFNlZW1zIHdl
IG5lZWQgdG8gY29tcHJlaGVuZCB0aGUgbWluCnZvbHRhZ2Ugc3VwcG9ydGVkIGJ5IHRoZSBQTUlD
IGZvciBjcmVhdGluZyB0aGUgTFVULgoKQ2hlZXJzCkpvbgoKLS0gCm52cHVibGljCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVs
IG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
