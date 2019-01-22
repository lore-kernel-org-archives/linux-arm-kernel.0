Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C442C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:03:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BE0820879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b1RU759R";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AT9LbDgN";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OoJvQnwP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BE0820879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PyZ2FD9QVQ8FEgQdLTMLe/mNSooyeYDkKkoiccrJ+vk=; b=b1RU759RdtUSbuqj3T+gzQNOk
	PJBKVov+o01mKSf76myOJx+mwHsdQsIkyAs250BN1/gBq6Al9TAp3kmIbEakwgB8Mrocl3OHi24i2
	05InCaqx/lEV98SXGNZrMjEHTC148uad0/nQ1mhJBODAhX7Lhw76bkNJ8IN91A5b8bWhiqQGFZr7w
	cCSpz0hxJX7J8xjFZLUs34M5C38a9g+BbJ3dRM1cmfzj0xrHRcesNTpzZJ8t+24gqb9SczCs1Tjlb
	nUOqeY/7tnRTEyWTeghGSsmTkBzOMtvSJVNQkVYUcKhub9YIH10VI5AQ8+NTY6Rx2D8xIYcLd2wAo
	EdqI+AzUg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glxZz-00037Q-QV; Tue, 22 Jan 2019 15:03:07 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glxZw-00036q-01
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 15:03:05 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 71A766044E; Tue, 22 Jan 2019 15:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548169381;
 bh=6pR4WJEX9BrwhrjL8sF/7l6ind7XQnrqoNa0E6QRTgs=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=AT9LbDgNy92/MdUH9cS6pNida/us1FGZcsyiBTSnBa5PmaZ9WVlTGXkSb5vVbw7k4
 MM1N+yJDQta21jc0EK/bzEAylq2DJ6mkKNmL+a6HMWMdrfXYHYbnO9/jH2iUKBvOHm
 T3CFZsS2XnpC/3OCS+sFueEQIXWfC1vCpAUVVedU=
Received: from [192.168.1.100] (unknown [157.49.207.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 656FA6044E;
 Tue, 22 Jan 2019 15:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548169380;
 bh=6pR4WJEX9BrwhrjL8sF/7l6ind7XQnrqoNa0E6QRTgs=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=OoJvQnwPOCRW+AYRzCS10erMp1zqlgtu0wE7+N6EWQETZyPjlLHbOV4pQ8EKvPq0m
 VyUPbNbJdg4cLSx+GcJlXWvrf/WzJEa5zPE5Zrq/8mEWpqzk6jELf7KuUHf+pkAAd0
 pXX7wBRClhNRlH9MAM+KCxWyzDrXZLhtsNCk5eWg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 656FA6044E
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
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <75ed74af-6946-b86d-092e-42dc16e55308@codeaurora.org>
Date: Tue, 22 Jan 2019 20:32:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1bd39862-0725-70ce-6535-fdb59569f683@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_070304_082446_9718F0A3 
X-CRM114-Status: GOOD (  21.27  )
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

SGkgU3V6dWtpLAoKVGhhbmtzIGZvciBsb29raW5nIGludG8gdGhpcy4gUGxlYXNlIGZpbmQgbXkg
cmVzcG9uc2UgaW5saW5lLgoKT24gMS8yMi8yMDE5IDc6MzAgUE0sIFN1enVraSBLIFBvdWxvc2Ug
d3JvdGU6Cj4gSGkgU2FpLAo+IAo+IE9uIDAxLzIyLzIwMTkgMDE6MzcgUE0sIFNhaSBQcmFrYXNo
IFJhbmphbiB3cm90ZToKPj4gQWRkIGNvcmVzaWdodCBjb21wb25lbnRzIGZvdW5kIG9uIFF1YWxj
b21tIFNETTg0NSBTb0MuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IFNhaSBQcmFrYXNoIFJhbmphbiA8
c2FpcHJha2FzaC5yYW5qYW5AY29kZWF1cm9yYS5vcmc+Cj4+Cj4gCj4gU29ycnksIGJ1dCBJIGhh
ZG4ndCBub3RpY2VkIHRoZSBQSUQgb3ZlcnJpZGUgc3RyaW5ncyBiZWxvdy4gUGxlYXNlCj4gZmlu
ZCB0aGUgcXVlc3Rpb24uCj4KWy4uXQoKPj4gK8KgwqDCoMKgwqDCoMKgIC8qCj4+ICvCoMKgwqDC
oMKgwqDCoMKgICogT24gUUNPTSBTRE04NDUsIHdlIGJ5cGFzcyB0aGUgbm9ybWFsIEFNQkEgYnVz
IGRpc2NvdmVyeQo+PiArwqDCoMKgwqDCoMKgwqDCoCAqIG1ldGhvZCBieSBmb3JjaW5nIHRoZSBw
ZXJpcGhlcmFsIElEIGJlY2F1c2Ugb2YgdGhlIHdyb25nCj4+ICvCoMKgwqDCoMKgwqDCoMKgICog
dmFsdWUgcmVhZCBmcm9tIEVUTSBQSUQgcmVnaXN0ZXJzLgo+PiArwqDCoMKgwqDCoMKgwqDCoCAq
Lwo+IAo+IFdoYXQgaXMgdGhlIHZhbHVlIHJlYWQgYmFjayBmcm9tIHRoZSBFVE0gUElEeCByZWdp
c3RlcnMgPyBEbyB0aGV5Cj4gcHJvdmlkZSBpbmNvbnNpc3RlbnQgb3IgaW5jb21wYXRpYmxlIHZh
bHVlIHcuci50IHRoZSBFVE0vQ29yZXNpZ2h0Cj4gYXJjaGl0ZWN0dXJlID8gSWYgaXQgaXMgYW4g
dW5zdXBwb3J0ZWQgQ1BVIHdpdGggcHJvcGVyIHZhbHVlcywKPiB5b3UgbXVzdCBhZGQgdGhlbSB0
byB0aGUgdGFibGUgaW4gZXRtNHggZHJpdmVyLgo+IAoKVGhlIHZhbHVlcyByZWFkIGZyb20gRVRN
IFBJRHggcmVnaXN0ZXJzIGFyZSBhY3R1YWxseSBpbmNvbnNpc3RlbnQKYW5kIGlzIGRpZmZlcmVu
dCBmb3Igc29tZSBFVE1zLgoKQmVsb3cgYXJlIHRoZSBQSURzIHJlYWQgZm9yIFNETTg0NToKClsg
ICAgNS45OTY0NDhdIHJlc25hbWU9ZXRtQDcwNDAwMDAgcGlkPTAwMWJiODAzClsgICAgNi4wNTI4
OTFdIHJlc25hbWU9ZXRtQDcxNDAwMDAgcGlkPTAwMWJiODAzCgo8c25pcD4gLi4gKFNhbWUgcGlk
PTAwMWJiODAzIGZvciBldG1ANzI0MDAwMCB0byBldG1ANzU0MDAwMCBidXQgZGlmZmVycwpmb3Ig
b3RoZXIgMiBjcHVzIGFzIHNob3duIGJlbG93KQoKWyAgICA2LjI2NjY4N10gcmVzbmFtZT1ldG1A
NzY0MDAwMCBwaWQ9MDAxYmI4MDIKWyAgICA2LjMyOTE3MV0gcmVzbmFtZT1ldG1ANzc0MDAwMCBw
aWQ9MDAxYmI4MDIKClRoaXMgaXMgdGhlIGNhc2UgZm9yIE1TTTg5OTYgYWxzbyBhcyBzaG93biBi
ZWxvdyB3aGVyZSBQSUQKdmFsdWUgaXMgbm90IGNvcnJlY3QgYW5kIGhhcyB0byBiZSBoYXJkY29k
ZWQuCgpGb3IgTVNNODk5NjoKCnJlc25hbWU9ZXRtQDNiNDAwMDAgcGlkPTEwMmYwMjA1Cgo+PiAr
wqDCoMKgwqDCoMKgwqAgZXRtQDcwNDAwMDAgewo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBj
b21wYXRpYmxlID0gImFybSxjb3Jlc2lnaHQtZXRtNHgiLCAiYXJtLHByaW1lY2VsbCI7Cj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFybSxwcmltZWNlbGwtcGVyaXBoaWQgPSA8MHgwMDBiYjk1
ZD4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZWcgCj4+ID0gPDAgMHgwNzA0MDAwMCAwIDB4
MTAwMD47Cj4+ICsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY3B1ID0gPCZDUFUwPjsKPj4g
Kwo+IAo+IFlvdSBzZWVtIHRvIGJlIHNwZWNpZnlpbmcgdGhlIFBJRCBvZiBBNTMgRVRNIGFsbCBv
dmVyLCB3aGlsZSBhdCBsZWFzdAo+IG9uZSBvZiB5b3VyIGNvcmVzIGlzIEVUTXY0LjIgKGZyb20g
dGhlIG90aGVyIHBhdGNoKSBhbmQgQTUzIGlzIG5vdAo+IEVUTXY0LjIuIEFzIGFib3ZlLCBpdCB3
b3VsZCBiZSBnb29kIHRvIGFkZCB0aGUgUElEIHRvIHRoZSB0YWJsZS4KPiAKCkFzIGV4cGxhaW5l
ZCBpbiBhYm92ZSBjb21tZW50LCBQSUQgdmFsdWVzIHJlYWQgYXJlIG5vdCBjb3JyZWN0LiBQbGVh
c2UgCmxldCBtZSBrbm93IGlmIEkgYW0gbm90IGNsZWFyLgoKVGhhbmtzLApTYWkKCi0tIApRVUFM
Q09NTSBJTkRJQSwgb24gYmVoYWxmIG9mIFF1YWxjb21tIElubm92YXRpb24gQ2VudGVyLCBJbmMu
IGlzIGEgbWVtYmVyCm9mIENvZGUgQXVyb3JhIEZvcnVtLCBob3N0ZWQgYnkgVGhlIExpbnV4IEZv
dW5kYXRpb24KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LWFybS1rZXJuZWwK
