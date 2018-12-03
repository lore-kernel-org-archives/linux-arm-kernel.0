Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F27FC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:03:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71D2620672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LYz4cf0b";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nKuuYVGG";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nKuuYVGG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71D2620672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2UkCsNfPm49uMh4e7z7LllSnzQ6VKxTW+cy12rLPQdI=; b=LYz4cf0b26AVfv0cDTgpleCQk
	qViQGHzu6t+yhdlFe1XcnhTz4vm1NnlzkNhD3NoghQsP3BRJE9iOSOIpl0A/ZeErXGSNhDOvGUeYJ
	BRXVU5Z4QL6UaBCr/VnE5V+yUkcs5JmHDY8tFZFl4vaVL8WNp7unfO0PoSTVh88uJkuGVDvnAb3e7
	ZqmKsVFI4au2Y76eRM+7Dz1L9lMNNtvciNhuZULokBjwzs4sIyyuNAhtN5T3vBO/Km3Otrq1uqwks
	W6MU1CO6RK3wWGbV8rd7oSrv4+vzQTP5XaCVTThYYspyhul36ZaOkHrlW4WxsyyGOxe0GugljWvOo
	ix6F7H2yw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTqh1-000189-Vn; Mon, 03 Dec 2018 16:03:31 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTqgu-0000rK-06
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 16:03:30 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 85C4D60913; Mon,  3 Dec 2018 16:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1543852993;
 bh=bi35WE7Ij0TTjAgl+5Y+AtXTe0Sl3hRjTHFOUx8P3V4=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=nKuuYVGGFbRjrZLWRu1BG/SXD1aAbw4PnStWa3ASeXq1X0Yr2F4x14+hq6A+GTKVj
 NAgTam2JWo1VFl6On5LgVoek+B6+H62KXqhThh0PAY7XHA3715s8QQkq5GKKuDoTdX
 MOoKnZBAagdeKzgmi4BA9V45Q8n0H9BZk4wdWurM=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: jhugo@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 5810B6021A;
 Mon,  3 Dec 2018 16:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1543852993;
 bh=bi35WE7Ij0TTjAgl+5Y+AtXTe0Sl3hRjTHFOUx8P3V4=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=nKuuYVGGFbRjrZLWRu1BG/SXD1aAbw4PnStWa3ASeXq1X0Yr2F4x14+hq6A+GTKVj
 NAgTam2JWo1VFl6On5LgVoek+B6+H62KXqhThh0PAY7XHA3715s8QQkq5GKKuDoTdX
 MOoKnZBAagdeKzgmi4BA9V45Q8n0H9BZk4wdWurM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5810B6021A
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: WIP: UFS on apq8098
To: Marc Gonzalez <marc.w.gonzalez@free.fr>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Nicolas Dechesne <nicolas.dechesne@linaro.org>,
 Niklas Cassel <niklas.cassel@linaro.org>, Andy Gross
 <andy.gross@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>
References: <ab9c8bec-35be-9e01-a567-bc2e4b2bef87@free.fr>
 <de223e7a-3b60-0566-997f-b607bbc15007@codeaurora.org>
 <7d588806-5699-2d87-e95e-f1388de01a74@codeaurora.org>
 <8b697e3b-6cb5-41ea-cd56-94c54082c58b@free.fr>
From: Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <e1b8ed92-c310-97ed-c1bd-5b90af76b3a0@codeaurora.org>
Date: Mon, 3 Dec 2018 09:03:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <8b697e3b-6cb5-41ea-cd56-94c54082c58b@free.fr>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_080324_072775_396B6C27 
X-CRM114-Status: GOOD (  12.88  )
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
Cc: MSM <linux-arm-msm@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMTIvMy8yMDE4IDg6NTMgQU0sIE1hcmMgR29uemFsZXogd3JvdGU6Cj4gT24gMDMvMTIvMjAx
OCAxNjo0NywgSmVmZnJleSBIdWdvIHdyb3RlOgo+IAo+PiBPbiAxMi8zLzIwMTggODoyNyBBTSwg
SmVmZnJleSBIdWdvIHdyb3RlOgo+Pgo+Pj4gT24gMTIvMy8yMDE4IDg6MTggQU0sIE1hcmMgR29u
emFsZXogd3JvdGU6Cj4+Pgo+Pj4+ICvCoMKgwqDCoMKgwqDCoCB1ZnNwaHk6IHBoeUAxZGE3MDAw
IHsKPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb21wYXRpYmxlID0gInFjb20sc2RtODQ1
LXFtcC11ZnMtcGh5IjsKPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZWcgPSA8MHgxZGE3
MDAwIDB4MThjPjsKPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAjYWRkcmVzcy1jZWxscyA9
IDwxPjsKPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAjc2l6ZS1jZWxscyA9IDwxPjsKPj4+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByYW5nZXM7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgY2xvY2stbmFtZXMgPQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
InJlZl9jbGtfc3JjIiwKPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJyZWZf
Y2xrIiwKPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJyZWZfYXV4X2NsayI7
Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2xvY2tzID0KPj4+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIDwmcnBtY2MgMD4sCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCA8JmdjYyBHQ0NfVUZTX0NMS1JFRl9DTEs+LAo+Pgo+PiBBbHNvLCAiR0NDX1VG
U19DTEtSRUZfQ0xLIiBpcyBub3QgZGVmaW5lZCBpbgo+PiBpbmNsdWRlL2R0LWJpbmRpbmdzL2Ns
b2NrL3Fjb20sZ2NjLW1zbTg5OTguaCB3aGljaCBpcyBwcm9iYWJseSB0aGUgY2F1c2UKPj4gb2Yg
eW91ciAtMiBlcnJvciBsaXN0ZWQgYWJvdmUuCj4gCj4gSWYgaXQgd2VyZSB1bmRlZmluZWQsIGR0
YyB3b3VsZCBoYXZlIGtpY2tlZCBtZSBpbiB0aGUgbmFkcyA6LSkKPiAKPiAkIGdpdCBncmVwIEdD
Q19VRlNfQ0xLUkVGX0NMSyBpbmNsdWRlCj4gaW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9jay9xY29t
LGdjYy1tc204OTk2Lmg6I2RlZmluZSBHQ0NfVUZTX0NMS1JFRl9DTEsgICAgICAgIDIxNQo+IGlu
Y2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svcWNvbSxnY2MtbXNtODk5OC5oOiNkZWZpbmUgR0NDX1VG
U19DTEtSRUZfQ0xLICAgICAgICAxNjgKCk5vdCBwcmVzZW50IGluIHY0LjIwLXJjNSBub3IgbGlu
dXgtbmV4dC4gIERpZCB5b3UgYWRkIHRoaXMgeW91cnNlbGY/ICBJZiAKc28sIGRpZCB5b3UgYWxz
byB1cGRhdGUgdGhlIGRyaXZlcj8KCj4gaW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9jay9xY29tLGdj
Yy1zZG02NjAuaDojZGVmaW5lIEdDQ19VRlNfQ0xLUkVGX0NMSyAgICAgICAgICA4MQo+IAo+IERv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvcWNvbS1xbXAtcGh5LnR4dCBzcGVs
bHMgaXQgb3V0Ogo+IEZvciAicWNvbSxzZG04NDUtcW1wLXVmcy1waHkiLCBjbG9jay1uYW1lcyBt
dXN0IGNvbnRhaW4gInJlZiIsICJyZWZfYXV4Ii4KCgotLSAKSmVmZnJleSBIdWdvClF1YWxjb21t
IERhdGFjZW50ZXIgVGVjaG5vbG9naWVzIGFzIGFuIGFmZmlsaWF0ZSBvZiBRdWFsY29tbSAKVGVj
aG5vbG9naWVzLCBJbmMuClF1YWxjb21tIFRlY2hub2xvZ2llcywgSW5jLiBpcyBhIG1lbWJlciBv
ZiB0aGUKQ29kZSBBdXJvcmEgRm9ydW0sIGEgTGludXggRm91bmRhdGlvbiBDb2xsYWJvcmF0aXZl
IFByb2plY3QuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1hcm0ta2VybmVsCg==
