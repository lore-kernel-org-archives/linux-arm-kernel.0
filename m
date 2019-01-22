Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E95C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:10:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F23121726
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lY1DbVge"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F23121726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=YP+l3iH1lq2pcxb7ENcNaJZVQ3v5a/MtgBzrSUJoaVg=; b=lY1DbVgeSB7UDIoL2wFCiqDO1
	one0gk13BfWFf840ouhXg86nlfwNM5KXoS7KfXSqNplE2miUpS6/p71ryPENxp7Xf7yCYIkhtknNL
	tCaMAuu4dRHBYNtOIffcz7cgihfA2fDwpf0F0pQd5J4WNWR5OiMSSdKOU9zFH8UVO8UruBOPnj9QK
	QT8mnnW/kFp4276+blIvKRP46ExBzYBqx64uPZpytdb+2ntSYi28deSSS/teI44ab5Zn3heq+fSGC
	t1FDjfCCctqywuVnxyIENAXGPN/P6PSq5kpk7T5dKYGfmTy2rApc6wIReoUn5+SOlDgjyw1jZPTWj
	Gv4qx1KkA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gm2Nj-0005iF-AV; Tue, 22 Jan 2019 20:10:47 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gm2Ng-0005hr-3A
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 20:10:45 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6DA6EBD;
 Tue, 22 Jan 2019 12:10:41 -0800 (PST)
Received: from [10.37.10.44] (unknown [10.37.10.44])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9BA943F589;
 Tue, 22 Jan 2019 12:10:37 -0800 (PST)
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
 <91a90daa-9e14-2d2e-e633-2ddfdc0955bf@arm.com>
 <3906faf1-abbd-9c28-ad55-ed3800f06352@codeaurora.org>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <c03b63bf-aca8-ea46-70ad-ee4558f0319e@arm.com>
Date: Tue, 22 Jan 2019 20:12:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <3906faf1-abbd-9c28-ad55-ed3800f06352@codeaurora.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_121044_151876_65397922 
X-CRM114-Status: GOOD (  25.18  )
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
Cc: rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org, john.horley@arm.com,
 linux-kernel@vger.kernel.org, sibis@codeaurora.org,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgU2FpLAoKT24gMDEvMjIvMjAxOSAwNDo0OCBQTSwgU2FpIFByYWthc2ggUmFuamFuIHdyb3Rl
Ogo+IEhpIFN1enVraSwKPiAKPiBPbiAxLzIyLzIwMTkgOTozOCBQTSwgU3V6dWtpIEsgUG91bG9z
ZSB3cm90ZToKPj4KPj4gQnkgaW5jb25zaXN0ZW50LCBJIG1lYW50IHRoZSByZWdpc3RlcnMgcHJv
dmlkZXMgdmFsdWVzIHdoaWNoIGFyZSBub3QKPj4gdGhlIHNhbWUgb24gdHdvIGRpZmZlcmVudCBD
UFVzIG9mIHRoZSAqc2FtZSB0eXBlKi4gQW5kIGl0IGlzIGV4cGVjdGVkCj4+IHRoYXQgdHdvIGRp
ZmZlcmVudCBDUFUvRVRNIGltcGxlbWVudGF0aW9ucyB3aWxsIGhhdmUgZGlmZmVyZW50IFBJRHMu
Cj4+Cj4gCj4gU0RNODQ1IGhhcyA0IEtyeW8gMzg1IEdvbGQgKEFSTSBBNzUpICsgNCBLcnlvIDM4
NSBTaWx2ZXIgKEFSTSBBNTUpLAo+IHNvIHRoZSBQSUQgdmFsdWVzIHNob3VsZCBiZSBzYW1lIGZv
ciA0IEVUTXMgYXRsZWFzdC4gQnV0IGhlcmUgb25lCj4gcGlkIHZhbHVlKDAwMWJiODAzKSBpcyBz
YW1lIGZvciA2IEVUTXMgYW5kIG90aGVyIG9uZSBmb3IgMgo+IEVUTXMoMDAxYmI4MDIpIHdoaWNo
IHNlZW1zIG9kZCBhbmQgaGVuY2UgdGhlIGRvdWJ0IGlmIHRoZXNlIHBpZHMKPiBhcmUgZXZlbiB2
YWxpZCBvbmVzLgoKSGF2ZSB5b3UgY2hlY2tlZCBvdGhlciBTb0NzIHdpdGggQTU1IGZvciB0aGUg
RVRNIFBJRCA/IFRoZSBkcml2ZXJzCnVzdWFsbHkgb25seSBjYXJlIGFib3V0IFBJRDBbNy0wXSwg
UElEMVs3LTBdLCBQSUQyWzMtMF0gYW5kIGlnbm9yZXMKdGhlIG90aGVyIGZpZWxkcyB0aGF0IG1h
eSBjaGFuZ2Ugb3ZlciByZXZpc2lvbnMgb2YgdGhlIGNvcmUuIFNvLCBpbiB5b3VyCmNhc2UgdGhl
IEVUTSBJRCBjb3VsZCBiZSB0cmVhdGVkIGFzIDB4YmI4MDIgYW5kIDB4YmI4MDMuCgo+IAo+Pj4K
Pj4+IEJlbG93IGFyZSB0aGUgUElEcyByZWFkIGZvciBTRE04NDU6Cj4+Pgo+Pj4gW8KgwqDCoCA1
Ljk5NjQ0OF0gcmVzbmFtZT1ldG1ANzA0MDAwMCBwaWQ9MDAxYmI4MDMKPj4+IFvCoMKgwqAgNi4w
NTI4OTFdIHJlc25hbWU9ZXRtQDcxNDAwMDAgcGlkPTAwMWJiODAzCj4+Pgo+Pj4gPHNuaXA+IC4u
IChTYW1lIHBpZD0wMDFiYjgwMyBmb3IgZXRtQDcyNDAwMDAgdG8gZXRtQDc1NDAwMDAgYnV0IGRp
ZmZlcnMKPj4+IGZvciBvdGhlciAyIGNwdXMgYXMgc2hvd24gYmVsb3cpCgpTbyB0aGF0cyA0IENQ
VXMgd2l0aCAweDFiYjgwMy4KCj4+Pgo+Pj4gW8KgwqDCoCA2LjI2NjY4N10gcmVzbmFtZT1ldG1A
NzY0MDAwMCBwaWQ9MDAxYmI4MDIKPj4+IFvCoMKgwqAgNi4zMjkxNzFdIHJlc25hbWU9ZXRtQDc3
NDAwMDAgcGlkPTAwMWJiODAyCj4+PgoKCj4+PiBUaGlzIGlzIHRoZSBjYXNlIGZvciBNU004OTk2
IGFsc28gYXMgc2hvd24gYmVsb3cgd2hlcmUgUElECj4+PiB2YWx1ZSBpcyBub3QgY29ycmVjdCBh
bmQgaGFzIHRvIGJlIGhhcmRjb2RlZC4KPj4KPj4gVGhleSBkaWZmZXIgYmVjYXVzZSB0aGV5IGFy
ZSB0d28gZGlmZmVyZW50IHR5cGVzIG9mIENQVSBjb3JlcyAoYW5kIAo+PiB0aHVzIGRpZmZlcmVu
dCBFVE0gUElEcykuIFdoYXQgZG9lcyB0aGUgUmVnaXN0ZXIgZGVzY3JpcHRpb25zIHNheSBmb3IK
Pj4gdGhlIENvcmVzID8KPj4KPj4gVG8gbWUgaXQgbG9va3MgbGlrZSB0aGVyZSBhcmUgdHdvIGRp
ZmZlcmVudCB0eXBlcyBvZiBRdWFsY29tbQo+PiBDb3JlcyB3aXRoIHRoZWlyIHJlc3BlY3RpdmUg
RVRNcyB3aGljaCBhcmUgbWlzc2luZyBpbiB0aGUgRVRNNHgKPj4gZHJpdmVyIGFuZCB3ZSBhcmUg
dHJ5aW5nIHRvICJtYWtlIHRoZSBFVE0iIHdvcmsgYnkgZmFraW5nIGl0IGFzCj4+IHNvbWV0aGlu
ZyBlbHNlLCB3aGljaCBpcyBub3QgbmljZS4gSSB3b3VsZCByYXRoZXIgcHJlZmVyCj4+IHRvIGFk
ZCB0aGUgYXBwcm9wcmlhdGUgbWFza3MgYW5kIHRoZSBleHBlY3RlZCB2YWx1ZSBmb3IgdGhlc2UK
Pj4gdHdvIGRpZmZlcmVudCBFVE0gaW1wbGVtZW50YXRpb25zIGFuZCBiZSBkb25lIHdpdGggaXQs
IGluc3RlYWQKPj4gb2YgZmFraW5nIGl0IGluIGFsbCB0aGUgRFRzIHdoZXJlIHRoZXNlIGNvcmVz
IGFwcGVhci4KPj4KPiAKPiBFVE00eCBkcml2ZXIgZG9lcyBub3QgaGF2ZSBlbnRyaWVzIGZvciBB
NTUgYW5kIEE3NS4gQ291bGQgeW91IHBsZWFzZQo+IGxldCBtZSBrbm93IHRoZSBQSURzIGZvciB0
aGVzZSBDUFVzIHNvIHRoYXQgd2UgY2FuIGNvbXBhcmU/CgpGV0lXLCBoZXJlIGlzIHRoZSBQSUQg
bGlzdDoKCkE3NTogMHhCX0JEXzBBCkE1NTogMHhCX0JEXzA1CgpCdHcsIEkgYW0gbm90IHN1cmUg
aWYgdGhlIEVUTSBoYXMgYmVlbiBjaGFuZ2VkL3R1bmVkIGZvciB0aGUgQ29yZXMgaW4KU0RNODQ1
LiBQbGVhc2UgY291bGQgeW91IGdldCB0aGlzIGNsYXJpZmllZCBpbnRlcm5hbGx5IHdpdGhpbiB5
b3VyCm9yZ2FuaXNhdGlvbiA/Cgo+IAo+Pj4KPj4+IEZvciBNU004OTk2Ogo+Pj4KPj4+IHJlc25h
bWU9ZXRtQDNiNDAwMDAgcGlkPTEwMmYwMjA1Cj4+Cj4+IEkgZG9uJ3Qga25vdyB3aGF0IENQVXMg
dGhlIE1TTTg5OTYgaGF2ZS4gSWYgdGhleSBkb24ndCBoYXZlIEE1MywgeW91Cj4+IG11c3QgYWRk
IHRoZSBhY3R1YWwgUElEcyB0byB0aGUgdGFibGUgb25jZSBhbmQgZm9yIGFsbC4KPj4KPiAKPiBC
dXQgYWdhaW4sIHRoaXMgUElEIGlzIHNvbWUgaW52YWxpZCB2YWx1ZS4gQW5kIGRvZXMgbm90IGNv
cnJlc3BvbmQKPiB0byBhbnkgb2YgdGhlIEFSTSBDUFUgY29yZXMgYW5kIHdvdWxkIGJlIE1TTTg5
OTYgc3BlY2lmaWMuCj4gTVNNODk5NiBoYXMgMisyIEtyeW8gY29yZXMgd2hpY2ggYXJlIG5vdCBB
Uk0gZGVyaXZhdGl2ZSBhcyBTRE04NDUKPiBpZiBJIGFtIHJpZ2h0LgoKQXMgbG9uZyBhcyB0aGUg
SkVQMTA2IGNvZGluZyBzdGFuZGFyZCBpcyBmb2xsb3dlZCBhbmQgaXMgaW5kaWNhdGVkIGluCnRo
ZSBhcHByb3ByaWF0ZSBmaWVsZHMgKFBJRFIyWzNdKSwgd2Ugc2hvdWxkIGJlIGZpbmUuIEluIHRo
ZSBjYXNlIGFib3ZlOgpQSUQgb2YgdGhlIEVUTSBpcyAweGYwMjA1LCBpbXBsaWVzIEpFUDEwNiBj
b2RlWzY6MF0gb2YgdGhlIGRlc2lnbmVyIGlzIAoweDcwIGFuZCBFVE0gcGFydCBudW1iZXIgaXMg
OiAweDIwNSwgd2hpY2ggbWFrZXMgc2Vuc2UgdG8gbWUuCgo+IAo+Pj4KPj4+Pj4gK8KgwqDCoMKg
wqDCoMKgIGV0bUA3MDQwMDAwIHsKPj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29tcGF0
aWJsZSA9ICJhcm0sY29yZXNpZ2h0LWV0bTR4IiwgImFybSxwcmltZWNlbGwiOwo+Pj4+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBhcm0scHJpbWVjZWxsLXBlcmlwaGlkID0gPDB4MDAwYmI5NWQ+
ID4gKyByZWcgPSA8MCAKPj4+Pj4gMHgwNzA0MDAwMCAwIDB4MTAwMD47Cj4+Pj4+ICsKPj4+Pj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY3B1ID0gPCZDUFUwPjsKPj4+Pj4gKwo+Pj4+Cj4+Pj4g
WW91IHNlZW0gdG8gYmUgc3BlY2lmeWluZyB0aGUgUElEIG9mIEE1MyBFVE0gYWxsIG92ZXIsIHdo
aWxlIGF0IGxlYXN0Cj4+Pj4gb25lIG9mIHlvdXIgY29yZXMgaXMgRVRNdjQuMiAoZnJvbSB0aGUg
b3RoZXIgcGF0Y2gpIGFuZCBBNTMgaXMgbm90Cj4+Pj4gRVRNdjQuMi4gQXMgYWJvdmUsIGl0IHdv
dWxkIGJlIGdvb2QgdG8gYWRkIHRoZSBQSUQgdG8gdGhlIHRhYmxlLgo+Pj4+Cj4+Pgo+Pj4gQXMg
ZXhwbGFpbmVkIGluIGFib3ZlIGNvbW1lbnQsIFBJRCB2YWx1ZXMgcmVhZCBhcmUgbm90IGNvcnJl
Y3QuIAo+Pj4gUGxlYXNlIGxldCBtZSBrbm93IGlmIEkgYW0gbm90IGNsZWFyLgo+Pgo+PiBUaGVy
ZSBpcyBubyBtZWFzdXJlIGZvciAiY29ycmVjdG5lc3MiIGhlcmUuIElmIHRoZSBFVE0gZXhwb3Nl
cyBkaWZmZXJlbnQKPj4gUElEIHRoYW4gd2hhdCB5b3UgZXhwZWN0IGZyb20gdGhlIFRSTSwgdGhl
biB3ZSBjb3VsZCB0aGluayBvZiBvdmVycmlkaW5nCj4+IGl0LiBPdGhlcndpc2UgcGxlYXNlIGFk
ZCB0aGUgUElEcyB0byB0aGUgdGFibGUuCj4+Cj4gCj4gVGhpcyBpcyBleGFjdGx5IHRoZSBjYXNl
LCBFVE0gUElEIHJlZ2lzdGVycyBhcmUgZXhwb3Npbmcgc29tZSBpbnZhbGlkCj4gdmFsdWUgYW5k
IGhlbmNlIHdlIG92ZXJyaWRlIGluIERULgoKSXQgd291bGQgYmUgZ29vZCB0byBoYXZlIHRoaXMg
Y2xhcmlmaWVkLiBJIHdpbGwgY2hlY2sgd2l0aCB0aGUgaW50ZXJuYWwKdGVhbXMgaGVyZSBmb3Ig
YW55IGRldGFpbHMuCgpUaGFua3MKU3V6dWtpCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
