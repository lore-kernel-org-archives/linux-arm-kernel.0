Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA82C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:07:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F38920823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SNgmoICQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F38920823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xUM+yVASxFoxqzajnnqqzrcU+I0HCT3Ko5T/UsEVsws=; b=SNgmoICQxfNcvd/e607Wip+si
	100nRntiSQ8/w0l8gIb3ferlbpwduhgCatnSbwLR3DNtpNyVCgJA5xD+xKMhah8NkV8KkEY4kMoOF
	cNUYi2MnKStOjSwWEMXxvaLf+JePxBOQkxH3X4MeSwAVoT4XD8NuYR60wFp3Po8hcjZ0QzTNLQ6vq
	ucbf0e+0rhWd86ACwW+uG/DdUqMy5oQvVb2wyaL07y4kxIfD0t4cQA53zd5D4BC4S1FF/VsveuCbB
	R14w/UlqIQ6dkQjRhFCMH4tGz1DWUEGbYp0sFkI+vUeNIY/xRJ4pPJDUwSPurx9TVaq7qLmLKc5lN
	GQ8kE+Kew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glyZn-00023Y-5V; Tue, 22 Jan 2019 16:06:59 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glyZj-00022m-LL
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 16:06:57 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68A60A78;
 Tue, 22 Jan 2019 08:06:54 -0800 (PST)
Received: from [10.37.10.44] (unknown [10.37.10.44])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F4503F589;
 Tue, 22 Jan 2019 08:06:50 -0800 (PST)
Subject: Re: [PATCHv4 1/4] arm64: dts: qcom: sdm845: Add Coresight support
To: saiprakash.ranjan@codeaurora.org, robh+dt@kernel.org,
 mathieu.poirier@linaro.org, leo.yan@linaro.org,
 alexander.shishkin@linux.intel.com, andy.gross@linaro.org,
 david.brown@linaro.org, vivek.gautam@codeaurora.org, dianders@chromium.org,
 sboyd@kernel.org, bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
 mark.rutland@arm.com
References: <cover.1548133311.git.saiprakash.ranjan@codeaurora.org>
 <ad16cfb9b6f5efb85149458d5f5a1abf43fa027c.1548133311.git.saiprakash.ranjan@codeaurora.org>
 <1bd39862-0725-70ce-6535-fdb59569f683@arm.com>
 <75ed74af-6946-b86d-092e-42dc16e55308@codeaurora.org>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <91a90daa-9e14-2d2e-e633-2ddfdc0955bf@arm.com>
Date: Tue, 22 Jan 2019 16:08:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <75ed74af-6946-b86d-092e-42dc16e55308@codeaurora.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_080655_713338_F15C17C4 
X-CRM114-Status: GOOD (  24.81  )
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
Cc: linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org, sibis@codeaurora.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgU2FpLAoKT24gMDEvMjIvMjAxOSAwMzowMiBQTSwgU2FpIFByYWthc2ggUmFuamFuIHdyb3Rl
Ogo+IEhpIFN1enVraSwKPiAKPiBUaGFua3MgZm9yIGxvb2tpbmcgaW50byB0aGlzLiBQbGVhc2Ug
ZmluZCBteSByZXNwb25zZSBpbmxpbmUuCj4gCj4gT24gMS8yMi8yMDE5IDc6MzAgUE0sIFN1enVr
aSBLIFBvdWxvc2Ugd3JvdGU6Cj4+IEhpIFNhaSwKPj4KPj4gT24gMDEvMjIvMjAxOSAwMTozNyBQ
TSwgU2FpIFByYWthc2ggUmFuamFuIHdyb3RlOgo+Pj4gQWRkIGNvcmVzaWdodCBjb21wb25lbnRz
IGZvdW5kIG9uIFF1YWxjb21tIFNETTg0NSBTb0MuCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogU2Fp
IFByYWthc2ggUmFuamFuIDxzYWlwcmFrYXNoLnJhbmphbkBjb2RlYXVyb3JhLm9yZz4KPj4+Cj4+
Cj4+IFNvcnJ5LCBidXQgSSBoYWRuJ3Qgbm90aWNlZCB0aGUgUElEIG92ZXJyaWRlIHN0cmluZ3Mg
YmVsb3cuIFBsZWFzZQo+PiBmaW5kIHRoZSBxdWVzdGlvbi4KPj4KPiBbLi5dCj4gCj4+PiArwqDC
oMKgwqDCoMKgwqAgLyoKPj4+ICvCoMKgwqDCoMKgwqDCoMKgICogT24gUUNPTSBTRE04NDUsIHdl
IGJ5cGFzcyB0aGUgbm9ybWFsIEFNQkEgYnVzIGRpc2NvdmVyeQo+Pj4gK8KgwqDCoMKgwqDCoMKg
wqAgKiBtZXRob2QgYnkgZm9yY2luZyB0aGUgcGVyaXBoZXJhbCBJRCBiZWNhdXNlIG9mIHRoZSB3
cm9uZwo+Pj4gK8KgwqDCoMKgwqDCoMKgwqAgKiB2YWx1ZSByZWFkIGZyb20gRVRNIFBJRCByZWdp
c3RlcnMuCj4+PiArwqDCoMKgwqDCoMKgwqDCoCAqLwo+Pgo+PiBXaGF0IGlzIHRoZSB2YWx1ZSBy
ZWFkIGJhY2sgZnJvbSB0aGUgRVRNIFBJRHggcmVnaXN0ZXJzID8gRG8gdGhleQo+PiBwcm92aWRl
IGluY29uc2lzdGVudCBvciBpbmNvbXBhdGlibGUgdmFsdWUgdy5yLnQgdGhlIEVUTS9Db3Jlc2ln
aHQKPj4gYXJjaGl0ZWN0dXJlID8gSWYgaXQgaXMgYW4gdW5zdXBwb3J0ZWQgQ1BVIHdpdGggcHJv
cGVyIHZhbHVlcywKPj4geW91IG11c3QgYWRkIHRoZW0gdG8gdGhlIHRhYmxlIGluIGV0bTR4IGRy
aXZlci4KPj4KPiAKPiBUaGUgdmFsdWVzIHJlYWQgZnJvbSBFVE0gUElEeCByZWdpc3RlcnMgYXJl
IGFjdHVhbGx5IGluY29uc2lzdGVudAo+IGFuZCBpcyBkaWZmZXJlbnQgZm9yIHNvbWUgRVRNcy4K
CkJ5IGluY29uc2lzdGVudCwgSSBtZWFudCB0aGUgcmVnaXN0ZXJzIHByb3ZpZGVzIHZhbHVlcyB3
aGljaCBhcmUgbm90CnRoZSBzYW1lIG9uIHR3byBkaWZmZXJlbnQgQ1BVcyBvZiB0aGUgKnNhbWUg
dHlwZSouIEFuZCBpdCBpcyBleHBlY3RlZAp0aGF0IHR3byBkaWZmZXJlbnQgQ1BVL0VUTSBpbXBs
ZW1lbnRhdGlvbnMgd2lsbCBoYXZlIGRpZmZlcmVudCBQSURzLgoKPiAKPiBCZWxvdyBhcmUgdGhl
IFBJRHMgcmVhZCBmb3IgU0RNODQ1Ogo+IAo+IFvCoMKgwqAgNS45OTY0NDhdIHJlc25hbWU9ZXRt
QDcwNDAwMDAgcGlkPTAwMWJiODAzCj4gW8KgwqDCoCA2LjA1Mjg5MV0gcmVzbmFtZT1ldG1ANzE0
MDAwMCBwaWQ9MDAxYmI4MDMKPiAKPiA8c25pcD4gLi4gKFNhbWUgcGlkPTAwMWJiODAzIGZvciBl
dG1ANzI0MDAwMCB0byBldG1ANzU0MDAwMCBidXQgZGlmZmVycwo+IGZvciBvdGhlciAyIGNwdXMg
YXMgc2hvd24gYmVsb3cpCj4gCj4gW8KgwqDCoCA2LjI2NjY4N10gcmVzbmFtZT1ldG1ANzY0MDAw
MCBwaWQ9MDAxYmI4MDIKPiBbwqDCoMKgIDYuMzI5MTcxXSByZXNuYW1lPWV0bUA3NzQwMDAwIHBp
ZD0wMDFiYjgwMgo+IAo+IFRoaXMgaXMgdGhlIGNhc2UgZm9yIE1TTTg5OTYgYWxzbyBhcyBzaG93
biBiZWxvdyB3aGVyZSBQSUQKPiB2YWx1ZSBpcyBub3QgY29ycmVjdCBhbmQgaGFzIHRvIGJlIGhh
cmRjb2RlZC4KClRoZXkgZGlmZmVyIGJlY2F1c2UgdGhleSBhcmUgdHdvIGRpZmZlcmVudCB0eXBl
cyBvZiBDUFUgY29yZXMgKGFuZCB0aHVzIApkaWZmZXJlbnQgRVRNIFBJRHMpLiBXaGF0IGRvZXMg
dGhlIFJlZ2lzdGVyIGRlc2NyaXB0aW9ucyBzYXkgZm9yCnRoZSBDb3JlcyA/CgpUbyBtZSBpdCBs
b29rcyBsaWtlIHRoZXJlIGFyZSB0d28gZGlmZmVyZW50IHR5cGVzIG9mIFF1YWxjb21tCkNvcmVz
IHdpdGggdGhlaXIgcmVzcGVjdGl2ZSBFVE1zIHdoaWNoIGFyZSBtaXNzaW5nIGluIHRoZSBFVE00
eApkcml2ZXIgYW5kIHdlIGFyZSB0cnlpbmcgdG8gIm1ha2UgdGhlIEVUTSIgd29yayBieSBmYWtp
bmcgaXQgYXMKc29tZXRoaW5nIGVsc2UsIHdoaWNoIGlzIG5vdCBuaWNlLiBJIHdvdWxkIHJhdGhl
ciBwcmVmZXIKdG8gYWRkIHRoZSBhcHByb3ByaWF0ZSBtYXNrcyBhbmQgdGhlIGV4cGVjdGVkIHZh
bHVlIGZvciB0aGVzZQp0d28gZGlmZmVyZW50IEVUTSBpbXBsZW1lbnRhdGlvbnMgYW5kIGJlIGRv
bmUgd2l0aCBpdCwgaW5zdGVhZApvZiBmYWtpbmcgaXQgaW4gYWxsIHRoZSBEVHMgd2hlcmUgdGhl
c2UgY29yZXMgYXBwZWFyLgoKPiAKPiBGb3IgTVNNODk5NjoKPiAKPiByZXNuYW1lPWV0bUAzYjQw
MDAwIHBpZD0xMDJmMDIwNQoKSSBkb24ndCBrbm93IHdoYXQgQ1BVcyB0aGUgTVNNODk5NiBoYXZl
LiBJZiB0aGV5IGRvbid0IGhhdmUgQTUzLCB5b3UKbXVzdCBhZGQgdGhlIGFjdHVhbCBQSURzIHRv
IHRoZSB0YWJsZSBvbmNlIGFuZCBmb3IgYWxsLgoKPiAKPj4+ICvCoMKgwqDCoMKgwqDCoCBldG1A
NzA0MDAwMCB7Cj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb21wYXRpYmxlID0gImFybSxj
b3Jlc2lnaHQtZXRtNHgiLCAiYXJtLHByaW1lY2VsbCI7Cj4+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBhcm0scHJpbWVjZWxsLXBlcmlwaGlkID0gPDB4MDAwYmI5NWQ+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgcmVnIAo+Pj4gPSA8MCAweDA3MDQwMDAwIDAgMHgxMDAwPjsKPj4+ICsKPj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNwdSA9IDwmQ1BVMD47Cj4+PiArCj4+Cj4+IFlvdSBz
ZWVtIHRvIGJlIHNwZWNpZnlpbmcgdGhlIFBJRCBvZiBBNTMgRVRNIGFsbCBvdmVyLCB3aGlsZSBh
dCBsZWFzdAo+PiBvbmUgb2YgeW91ciBjb3JlcyBpcyBFVE12NC4yIChmcm9tIHRoZSBvdGhlciBw
YXRjaCkgYW5kIEE1MyBpcyBub3QKPj4gRVRNdjQuMi4gQXMgYWJvdmUsIGl0IHdvdWxkIGJlIGdv
b2QgdG8gYWRkIHRoZSBQSUQgdG8gdGhlIHRhYmxlLgo+Pgo+IAo+IEFzIGV4cGxhaW5lZCBpbiBh
Ym92ZSBjb21tZW50LCBQSUQgdmFsdWVzIHJlYWQgYXJlIG5vdCBjb3JyZWN0LiBQbGVhc2UgCj4g
bGV0IG1lIGtub3cgaWYgSSBhbSBub3QgY2xlYXIuCgpUaGVyZSBpcyBubyBtZWFzdXJlIGZvciAi
Y29ycmVjdG5lc3MiIGhlcmUuIElmIHRoZSBFVE0gZXhwb3NlcyBkaWZmZXJlbnQKUElEIHRoYW4g
d2hhdCB5b3UgZXhwZWN0IGZyb20gdGhlIFRSTSwgdGhlbiB3ZSBjb3VsZCB0aGluayBvZiBvdmVy
cmlkaW5nCml0LiBPdGhlcndpc2UgcGxlYXNlIGFkZCB0aGUgUElEcyB0byB0aGUgdGFibGUuCgpD
aGVlcnMKU3V6dWtpCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1hcm0ta2VybmVsCg==
