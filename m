Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F02C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:32:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3D7A2081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jK4giv7e";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XHs8ksmt";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Xgz2uXXc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3D7A2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=op++ftafvD5xwQA9uT4625Dx9p6I7dpdT3gEu2DaLgo=; b=jK4giv7eR6c8HNyjM2WxzhC14
	kWBbgbdDAlP6ZYB0mHfFN7QBUulfNR1HpIkzc2pSvup4SqnoBU1f7vAA+GflUfofRRdcTzD8la9O+
	qZJYXnv3evfzzClQ8kvzcR0BQi25V7y1WrxGQSxWzfLD2M/768Pe6014fJgISQ54T7KYBSyvgmuSn
	S+bdu3j9cNeSxm5u3SXrgASE9jxCW3cxoBAk/VUPQiTPIMP0SCULSth3A7aNJchAEo6qTzY7rfDKE
	6Cp+qhmNuKw6H8P7sQzgX+UeDU/bMcJlTjEczOrIIaOnmpa7V8fZRjk+iAKd0/XEUS65ZU+9wgxLq
	QDUC//f7Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUEYO-0006Es-5A; Tue, 04 Dec 2018 17:32:12 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUEYK-0006Dw-3G
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 17:32:09 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id B6746609F3; Tue,  4 Dec 2018 17:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1543944717;
 bh=HLDLeLWXAjPOIzWj/16/cd68sKDZ8TZ1IYnvbAtzAtU=;
 h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
 b=XHs8ksmttBzQXjSbs7kRqLCcIQr4OJ4R+X9h+NBHVt6fnwF4e66ImB8mAYSEgI/Wq
 34xeVkbnjAO1qu5TI0e7HiemviDu2KKSX2XyD/stDSsxgzHTAcHfFi9b4Mv2kJJl/E
 HX5czeYq1d3lFg11sF/IamFQRwgy2/2ANvQYA8BM=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: jhugo@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 4E182602F4;
 Tue,  4 Dec 2018 17:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1543944715;
 bh=HLDLeLWXAjPOIzWj/16/cd68sKDZ8TZ1IYnvbAtzAtU=;
 h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
 b=Xgz2uXXcAZL/KS0I3Q91t+RrBBb69/OForKFtNmVr3qpHsOUPEgMKScBqZXBus9ZJ
 4wfh4abckTUXdGdfuZLm5Fd/gExfL1LucFjvPR1rv+5XJx5Jzz6F5vKn4e/5najxhk
 gNan5U3VMOMvrYNGKj6j58GwGhoIz3Kw8lwhc0cw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4E182602F4
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: WIP: UFS on apq8098
From: Jeffrey Hugo <jhugo@codeaurora.org>
To: Marc Gonzalez <marc.w.gonzalez@free.fr>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Nicolas Dechesne <nicolas.dechesne@linaro.org>,
 Niklas Cassel <niklas.cassel@linaro.org>, Andy Gross <andy.gross@linaro.org>
References: <ab9c8bec-35be-9e01-a567-bc2e4b2bef87@free.fr>
 <2b186a33-aea2-629c-6fbf-aefe16ff7b0a@free.fr>
 <bc40674c-9be7-3e5e-9409-42aa8bb0b376@free.fr>
 <ec633e12-b6c1-5de9-690c-a58b8ecdb2b8@free.fr>
 <48b1a7ce-afb7-18d3-6855-69196972d640@codeaurora.org>
 <a4c0c2e1-09d8-c48f-d434-6147c047c3a8@free.fr>
 <d99567c7-9c1c-6d7e-6dd1-2930b82db7d8@codeaurora.org>
 <0c189977-62dd-3539-3b5c-233773682e69@free.fr>
 <1dbb2f0b-0ad1-e622-a9c4-9ff7284dbee7@codeaurora.org>
Message-ID: <7a7ccedd-c6b2-6789-c76e-ad2ddcd53e2a@codeaurora.org>
Date: Tue, 4 Dec 2018 10:31:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <1dbb2f0b-0ad1-e622-a9c4-9ff7284dbee7@codeaurora.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_093208_180706_1EDE7A3D 
X-CRM114-Status: GOOD (  12.58  )
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

T24gMTIvNC8yMDE4IDEwOjIxIEFNLCBKZWZmcmV5IEh1Z28gd3JvdGU6Cj4gT24gMTIvNC8yMDE4
IDEwOjExIEFNLCBNYXJjIEdvbnphbGV6IHdyb3RlOgo+PiBPbiAwNC8xMi8yMDE4IDE4OjA1LCBK
ZWZmcmV5IEh1Z28gd3JvdGU6Cj4+Cj4+PiBtb3VudCAtdCBkZWJ1Z2ZzIG5vbmUgL3N5cy9rZXJu
ZWwvZGVidWcKPj4KPj4gRG9oIQo+Pgo+PiAjIGNhdCAvc3lzL2tlcm5lbC9kZWJ1Zy9jbGsvY2xr
X3N1bW1hcnkKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVuYWJsZcKgIHByZXBhcmUgIAo+PiBwcm90ZWN0wqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
ZHV0eQo+PiDCoMKgwqAgY2xvY2vCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBjb3VudMKgwqDCoCBjb3VudMKgwqDCoCBjb3VudCAgICAgICAgCj4+IHJh
dGXCoMKgIGFjY3VyYWN5IHBoYXNlwqAgY3ljbGUKPj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tIAo+Pgo+PiDCoCBnY2NfdXNiX3BoeV9jZmdfYWhiMnBoeV9jbGvCoMKgwqDC
oMKgwqDCoMKgwqAgMMKgwqDCoMKgwqDCoMKgIDDCoMKgwqDCoMKgwqDCoCAwICAgICAgICAgICAK
Pj4gMMKgwqDCoMKgwqDCoMKgwqDCoCAwwqDCoMKgwqAgMMKgIDUwMDAwCj4+IMKgIGdjY191c2Iz
X3BoeV9waXBlX2Nsa8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAwwqDCoMKgwqDCoMKg
wqAgMMKgwqDCoMKgwqDCoMKgIDAgICAgICAgICAgIAo+PiAwwqDCoMKgwqDCoMKgwqDCoMKgIDDC
oMKgwqDCoCAwwqAgNTAwMDAKPj4gwqAgZ2NjX3VzYjMwX3NsZWVwX2Nsa8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgMMKgwqDCoMKgwqDCoMKgIDDCoMKgwqDCoMKgwqDCoCAwICAg
ICAgICAgICAKPj4gMMKgwqDCoMKgwqDCoMKgwqDCoCAwwqDCoMKgwqAgMMKgIDUwMDAwCj4+IMKg
IGdjY191ZnNfdW5pcHJvX2NvcmVfY2xrwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMMKgwqDC
oMKgwqDCoMKgIDDCoMKgwqDCoMKgwqDCoCAwICAgICAgICAgICAKPj4gMMKgwqDCoMKgwqDCoMKg
wqDCoCAwwqDCoMKgwqAgMMKgIDUwMDAwCj4gCj4gWWVhaCwgdGhpcyBjbG9jayBoYXMgbm8gcGFy
ZW50LCBhbmQgaXMgb25lIG9mIHRoZSBvbmVzIHRoYXQgaXMgYSBkZWx0YSAKPiBmcm9tIHRoZSBk
b3duc3RlYW0gcGVyIHlvdXIgbG9ncy4KCiBGcm9tIHdoYXQgSSBjYW4gdGVsbCBmcm9tIHRoZSBk
b2N1bWVudGF0aW9uLCB0aGlzIGlzIHNvdXJjZWQgZnJvbSAKdWZzX3VuaXByb19jb3JlX2Nsa19z
cmMsIHdoaWNoIGlzIGludHVybiBzb3VyY2VkIGZyb20gZ3BsbDBfb3V0X21haW4uIApJJ20gZ3Vl
c3NpbmcgZ2NjLW1zbTg5OTguYyBuZWVkcyB0byBiZSB1cGRhdGVkIHRvIHJlZmxlY3QgdGhpcy4g
IEl0IAp3b3VsZCBhbHNvIGJlIGdvb2QgdG8gY2hlY2sgdGhpcyBhZ2FpbnN0IHRoZSBkb3duc3Ry
ZWFtIGtlcm5lbC4KCkxldCBtZSBrbm93IGlmIHlvdSB3YW50IG1lIHRvIGhhdmUgYSBsb29rIGF0
IGFueSBvdGhlciBzcGVjaWZpYyBjbG9ja3MuCgotLSAKSmVmZnJleSBIdWdvClF1YWxjb21tIERh
dGFjZW50ZXIgVGVjaG5vbG9naWVzIGFzIGFuIGFmZmlsaWF0ZSBvZiBRdWFsY29tbSAKVGVjaG5v
bG9naWVzLCBJbmMuClF1YWxjb21tIFRlY2hub2xvZ2llcywgSW5jLiBpcyBhIG1lbWJlciBvZiB0
aGUKQ29kZSBBdXJvcmEgRm9ydW0sIGEgTGludXggRm91bmRhdGlvbiBDb2xsYWJvcmF0aXZlIFBy
b2plY3QuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
aW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC1hcm0ta2VybmVsCg==
