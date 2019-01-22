Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E8AC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:48:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2724D21019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SPTlq+9S";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="O2N0aNf5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UTO6FxKs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2724D21019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+6joawM6nAgos7ynNgCUA4oAsyIvMKocaULjKCcTZlI=; b=SPTlq+9SyxB23SFZEztPvhDlj
	jh49om18Mp4U0J7MDx7ESvwlZBnzYeYXfQ0eoDkzxYiGqyan396wY4tEz39b8TUxAKioFGWfuBr0R
	q1TMaCOTFt4GymBnwR+FghSOQLACJPDhwAos908By6i9TEp/jT8yVA52noBs2nyomsS/0MiRnaXLN
	MKuh7NPUC2wgk0mPoWG3qItP9T5mnd276rCoLGcQgOwnB7bCrGLBBaNBa4CwEIK9f9S8OVoCOK3WH
	ptdG6yFweGCfSb2qTw/6NkE9C+7VN51yk+IBbhhlc2UeC07eP0IM4oaaDjVFXr5/uVvenq9lyXKQ1
	aeVc+4D1w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glzEG-0006Ru-20; Tue, 22 Jan 2019 16:48:48 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glzEC-0006RU-FF
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 16:48:45 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id AC61360795; Tue, 22 Jan 2019 16:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548175723;
 bh=eP2k8C/TWcMco/1C7Pz9d07P0ZKYfLgyo4TtCUaWb3o=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=O2N0aNf59MRngS49WBCvadWzxu+57ZmDEQOx4wXf8ttQel1I08KMEOS8lk5AAXjxN
 /9SgML3St6z0f9Z5JDDvjR+/cGJjUjv7SPvzgPoK0NaAUXmCvami6DLo+A/ZTUYJRa
 UyNY+Enh4vnTHMYeh1mTq8sqQmIdwD4I0CCuFOEk=
Received: from [192.168.1.100] (unknown [157.49.207.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 158736024C;
 Tue, 22 Jan 2019 16:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548175722;
 bh=eP2k8C/TWcMco/1C7Pz9d07P0ZKYfLgyo4TtCUaWb3o=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=UTO6FxKssWDy7V5uPfYO6e0XTr3b8t3R3PB7G38CYMIW5+nzFFD2X0juqhfRgpCQm
 Dg3fZH01y2hmywiut0kmLGh8WO8y/osiWx+sNjZ/8OeVi/QsQ0co4DS2HccCpe4T1h
 +hbWeCf+kwIlyKsBHFmP+ynGnFdgLvKrcZxlyv9o=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 158736024C
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none
 smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCHv4 1/4] arm64: dts: qcom: sdm845: Add Coresight support
To: Suzuki K Poulose <suzuki.poulose@arm.com>, robh+dt@kernel.org,
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
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <3906faf1-abbd-9c28-ad55-ed3800f06352@codeaurora.org>
Date: Tue, 22 Jan 2019 22:18:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <91a90daa-9e14-2d2e-e633-2ddfdc0955bf@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_084844_547462_5857F01D 
X-CRM114-Status: GOOD (  24.71  )
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

SGkgU3V6dWtpLAoKT24gMS8yMi8yMDE5IDk6MzggUE0sIFN1enVraSBLIFBvdWxvc2Ugd3JvdGU6
Cj4gCj4gQnkgaW5jb25zaXN0ZW50LCBJIG1lYW50IHRoZSByZWdpc3RlcnMgcHJvdmlkZXMgdmFs
dWVzIHdoaWNoIGFyZSBub3QKPiB0aGUgc2FtZSBvbiB0d28gZGlmZmVyZW50IENQVXMgb2YgdGhl
ICpzYW1lIHR5cGUqLiBBbmQgaXQgaXMgZXhwZWN0ZWQKPiB0aGF0IHR3byBkaWZmZXJlbnQgQ1BV
L0VUTSBpbXBsZW1lbnRhdGlvbnMgd2lsbCBoYXZlIGRpZmZlcmVudCBQSURzLgo+IAoKU0RNODQ1
IGhhcyA0IEtyeW8gMzg1IEdvbGQgKEFSTSBBNzUpICsgNCBLcnlvIDM4NSBTaWx2ZXIgKEFSTSBB
NTUpLApzbyB0aGUgUElEIHZhbHVlcyBzaG91bGQgYmUgc2FtZSBmb3IgNCBFVE1zIGF0bGVhc3Qu
IEJ1dCBoZXJlIG9uZQpwaWQgdmFsdWUoMDAxYmI4MDMpIGlzIHNhbWUgZm9yIDYgRVRNcyBhbmQg
b3RoZXIgb25lIGZvciAyCkVUTXMoMDAxYmI4MDIpIHdoaWNoIHNlZW1zIG9kZCBhbmQgaGVuY2Ug
dGhlIGRvdWJ0IGlmIHRoZXNlIHBpZHMKYXJlIGV2ZW4gdmFsaWQgb25lcy4KCj4+Cj4+IEJlbG93
IGFyZSB0aGUgUElEcyByZWFkIGZvciBTRE04NDU6Cj4+Cj4+IFvCoMKgwqAgNS45OTY0NDhdIHJl
c25hbWU9ZXRtQDcwNDAwMDAgcGlkPTAwMWJiODAzCj4+IFvCoMKgwqAgNi4wNTI4OTFdIHJlc25h
bWU9ZXRtQDcxNDAwMDAgcGlkPTAwMWJiODAzCj4+Cj4+IDxzbmlwPiAuLiAoU2FtZSBwaWQ9MDAx
YmI4MDMgZm9yIGV0bUA3MjQwMDAwIHRvIGV0bUA3NTQwMDAwIGJ1dCBkaWZmZXJzCj4+IGZvciBv
dGhlciAyIGNwdXMgYXMgc2hvd24gYmVsb3cpCj4+Cj4+IFvCoMKgwqAgNi4yNjY2ODddIHJlc25h
bWU9ZXRtQDc2NDAwMDAgcGlkPTAwMWJiODAyCj4+IFvCoMKgwqAgNi4zMjkxNzFdIHJlc25hbWU9
ZXRtQDc3NDAwMDAgcGlkPTAwMWJiODAyCj4+Cj4+IFRoaXMgaXMgdGhlIGNhc2UgZm9yIE1TTTg5
OTYgYWxzbyBhcyBzaG93biBiZWxvdyB3aGVyZSBQSUQKPj4gdmFsdWUgaXMgbm90IGNvcnJlY3Qg
YW5kIGhhcyB0byBiZSBoYXJkY29kZWQuCj4gCj4gVGhleSBkaWZmZXIgYmVjYXVzZSB0aGV5IGFy
ZSB0d28gZGlmZmVyZW50IHR5cGVzIG9mIENQVSBjb3JlcyAoYW5kIHRodXMgCj4gZGlmZmVyZW50
IEVUTSBQSURzKS4gV2hhdCBkb2VzIHRoZSBSZWdpc3RlciBkZXNjcmlwdGlvbnMgc2F5IGZvcgo+
IHRoZSBDb3JlcyA/Cj4gCj4gVG8gbWUgaXQgbG9va3MgbGlrZSB0aGVyZSBhcmUgdHdvIGRpZmZl
cmVudCB0eXBlcyBvZiBRdWFsY29tbQo+IENvcmVzIHdpdGggdGhlaXIgcmVzcGVjdGl2ZSBFVE1z
IHdoaWNoIGFyZSBtaXNzaW5nIGluIHRoZSBFVE00eAo+IGRyaXZlciBhbmQgd2UgYXJlIHRyeWlu
ZyB0byAibWFrZSB0aGUgRVRNIiB3b3JrIGJ5IGZha2luZyBpdCBhcwo+IHNvbWV0aGluZyBlbHNl
LCB3aGljaCBpcyBub3QgbmljZS4gSSB3b3VsZCByYXRoZXIgcHJlZmVyCj4gdG8gYWRkIHRoZSBh
cHByb3ByaWF0ZSBtYXNrcyBhbmQgdGhlIGV4cGVjdGVkIHZhbHVlIGZvciB0aGVzZQo+IHR3byBk
aWZmZXJlbnQgRVRNIGltcGxlbWVudGF0aW9ucyBhbmQgYmUgZG9uZSB3aXRoIGl0LCBpbnN0ZWFk
Cj4gb2YgZmFraW5nIGl0IGluIGFsbCB0aGUgRFRzIHdoZXJlIHRoZXNlIGNvcmVzIGFwcGVhci4K
PiAKCkVUTTR4IGRyaXZlciBkb2VzIG5vdCBoYXZlIGVudHJpZXMgZm9yIEE1NSBhbmQgQTc1LiBD
b3VsZCB5b3UgcGxlYXNlCmxldCBtZSBrbm93IHRoZSBQSURzIGZvciB0aGVzZSBDUFVzIHNvIHRo
YXQgd2UgY2FuIGNvbXBhcmU/Cgo+Pgo+PiBGb3IgTVNNODk5NjoKPj4KPj4gcmVzbmFtZT1ldG1A
M2I0MDAwMCBwaWQ9MTAyZjAyMDUKPiAKPiBJIGRvbid0IGtub3cgd2hhdCBDUFVzIHRoZSBNU004
OTk2IGhhdmUuIElmIHRoZXkgZG9uJ3QgaGF2ZSBBNTMsIHlvdQo+IG11c3QgYWRkIHRoZSBhY3R1
YWwgUElEcyB0byB0aGUgdGFibGUgb25jZSBhbmQgZm9yIGFsbC4KPiAKCkJ1dCBhZ2FpbiwgdGhp
cyBQSUQgaXMgc29tZSBpbnZhbGlkIHZhbHVlLiBBbmQgZG9lcyBub3QgY29ycmVzcG9uZAp0byBh
bnkgb2YgdGhlIEFSTSBDUFUgY29yZXMgYW5kIHdvdWxkIGJlIE1TTTg5OTYgc3BlY2lmaWMuCk1T
TTg5OTYgaGFzIDIrMiBLcnlvIGNvcmVzIHdoaWNoIGFyZSBub3QgQVJNIGRlcml2YXRpdmUgYXMg
U0RNODQ1CmlmIEkgYW0gcmlnaHQuCgo+Pgo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBldG1ANzA0MDAw
MCB7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29tcGF0aWJsZSA9ICJhcm0sY29yZXNp
Z2h0LWV0bTR4IiwgImFybSxwcmltZWNlbGwiOwo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGFybSxwcmltZWNlbGwtcGVyaXBoaWQgPSA8MHgwMDBiYjk1ZD4gPiArICAgICAgICAgICAgCj4+
Pj4gcmVnID0gPDAgMHgwNzA0MDAwMCAwIDB4MTAwMD47Cj4+Pj4gKwo+Pj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGNwdSA9IDwmQ1BVMD47Cj4+Pj4gKwo+Pj4KPj4+IFlvdSBzZWVtIHRvIGJl
IHNwZWNpZnlpbmcgdGhlIFBJRCBvZiBBNTMgRVRNIGFsbCBvdmVyLCB3aGlsZSBhdCBsZWFzdAo+
Pj4gb25lIG9mIHlvdXIgY29yZXMgaXMgRVRNdjQuMiAoZnJvbSB0aGUgb3RoZXIgcGF0Y2gpIGFu
ZCBBNTMgaXMgbm90Cj4+PiBFVE12NC4yLiBBcyBhYm92ZSwgaXQgd291bGQgYmUgZ29vZCB0byBh
ZGQgdGhlIFBJRCB0byB0aGUgdGFibGUuCj4+Pgo+Pgo+PiBBcyBleHBsYWluZWQgaW4gYWJvdmUg
Y29tbWVudCwgUElEIHZhbHVlcyByZWFkIGFyZSBub3QgY29ycmVjdC4gUGxlYXNlIAo+PiBsZXQg
bWUga25vdyBpZiBJIGFtIG5vdCBjbGVhci4KPiAKPiBUaGVyZSBpcyBubyBtZWFzdXJlIGZvciAi
Y29ycmVjdG5lc3MiIGhlcmUuIElmIHRoZSBFVE0gZXhwb3NlcyBkaWZmZXJlbnQKPiBQSUQgdGhh
biB3aGF0IHlvdSBleHBlY3QgZnJvbSB0aGUgVFJNLCB0aGVuIHdlIGNvdWxkIHRoaW5rIG9mIG92
ZXJyaWRpbmcKPiBpdC4gT3RoZXJ3aXNlIHBsZWFzZSBhZGQgdGhlIFBJRHMgdG8gdGhlIHRhYmxl
Lgo+IAoKVGhpcyBpcyBleGFjdGx5IHRoZSBjYXNlLCBFVE0gUElEIHJlZ2lzdGVycyBhcmUgZXhw
b3Npbmcgc29tZSBpbnZhbGlkCnZhbHVlIGFuZCBoZW5jZSB3ZSBvdmVycmlkZSBpbiBEVC4KClRo
YW5rcywKU2FpCgotLSAKUVVBTENPTU0gSU5ESUEsIG9uIGJlaGFsZiBvZiBRdWFsY29tbSBJbm5v
dmF0aW9uIENlbnRlciwgSW5jLiBpcyBhIG1lbWJlcgpvZiBDb2RlIEF1cm9yYSBGb3J1bSwgaG9z
dGVkIGJ5IFRoZSBMaW51eCBGb3VuZGF0aW9uCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
