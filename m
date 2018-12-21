Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B99FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 12:37:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D142D21908
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 12:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TvYNobyi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VBD9sojf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D142D21908
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=m9nXrh5Bk8H8r17y2brXcO0SLXYB8VroX0MPyrjAqKU=; b=TvYNobyidqGQK018j35NYtzMm
	oKNhKS0VFx50ITVoZDQuRzbWS/j7YY3gJu9M73XV+lBdamsX+VgL84I2AH0qNzUZxwTQ1+rH2qbJZ
	jKayah5bg7rKWYb4mFOgaylT6Gug4uL8PtZLJYZkvol8Flm2i/8GBvzqd45Ax4iNyLNyV5PnKUYxl
	T+E+02e/VjuK5wSatZosLOdUw9t/NBvbhUxT1AGwgUB0nDhNAnZpZYz0sz4q0F2mnEJ5Uuztuh7JO
	j3C+iKkjx4r4zEEb+P+2IJSg7eIyR2mPC1zbiyAPGbAuOz0np9SbQfGVYU7bWx3VY00WZmGPg/wsl
	w81rQv0nQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaK35-0001XB-6s; Fri, 21 Dec 2018 12:37:03 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaK31-0001WD-Qi
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 12:37:01 +0000
Received: by mail-wm1-x343.google.com with SMTP id n190so5188347wmd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 21 Dec 2018 04:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=TBeYpA+ZER3k/7FfAniVy3+DDhg63t94WdSvWr+H9BM=;
 b=VBD9sojfwuff9TQd3cCRJZqV+/JLU472daO5wi/nmLsk1/qtxnXGa8nL1C3xrgIvf4
 CokE6JYhoN1NMDqHXEx7CVSq3NztiYyoxzw+aWqpZqllRjqFVhTpMHUL6OSDBWzPfk1q
 7OREXHISVJkfJsapbuZWmv3G7kxXFqt2uNQpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=TBeYpA+ZER3k/7FfAniVy3+DDhg63t94WdSvWr+H9BM=;
 b=XozUUan99xTYqo1meKDDnbRfhkHWoQTIAB5P409fao19AYiBQ6bKgtTgyNEmJF8fLw
 OPrQUzi21WhNDSM3NnztbFFQDzonN12iTXkXNycLkJWR1CJNdTnZAJWg5OXY+8AZuBHA
 6RXMrkn0zA3BsQ2F/dq0rEqa3F4pkByJCY3P8nVm8J/aR0KVDDJeTnd4NnONOngRZ1fe
 DT9MgFC3iSne23GxVOuHbW04LnS0R5j8uusG2vxkduMFNLyUjt49txRE9W3zu66OSkrY
 aB7AOuLUshiEbj9sVVSZHZHQ4rsgX2g2ujLgFRCCjD6i1Ge46jSNb0vO1tTOeB4ozRkr
 YbUQ==
X-Gm-Message-State: AA+aEWbQycEXk2MAo4V9UqwyUpNX5Ddlc1WWYvKilgB89qvaHy8SLZKJ
 InMQEZvymcbQhnJrcFDmWg+ugw==
X-Google-Smtp-Source: AFSGD/UjQ3OTNyO6YJMQpLq3ZRqdIy0AMuUGPKYrYCFKqRJRBppcvQvKeFM0ZRsyQBfVEEM3tJzqVA==
X-Received: by 2002:a1c:d74a:: with SMTP id o71mr2708065wmg.73.1545395807382; 
 Fri, 21 Dec 2018 04:36:47 -0800 (PST)
Received: from [192.168.1.2] (119.red-79-146-81.dynamicip.rima-tde.net.
 [79.146.81.119])
 by smtp.gmail.com with ESMTPSA id k135sm17256615wmd.42.2018.12.21.04.36.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Dec 2018 04:36:46 -0800 (PST)
Subject: Re: [PATCH 01/13] clk: qcom: gcc: limit GPLL0_AO_OUT operating
 frequency
To: Taniya Das <tdas@codeaurora.org>, robh+dt@kernel.org,
 mark.rutland@arm.com, andy.gross@linaro.org, david.brown@linaro.org,
 sboyd@kernel.org, will.deacon@arm.com, mturquette@baylibre.com,
 jassisinghbrar@gmail.com
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <e97d9050-effc-56d7-0f9b-768df90dd73a@codeaurora.org>
From: Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Message-ID: <6814777f-1e5f-bd99-db63-a0050dcdd930@linaro.org>
Date: Fri, 21 Dec 2018 13:36:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <e97d9050-effc-56d7-0f9b-768df90dd73a@codeaurora.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_043659_868405_C72E0D3A 
X-CRM114-Status: GOOD (  18.00  )
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
Cc: devicetree@vger.kernel.org, heiko@sntech.de, arnd@arndb.de, olof@lixom.net,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, bjorn.andersson@linaro.org,
 enric.balletbo@collabora.com, vkoul@kernel.org, sibis@codeaurora.org,
 niklas.cassel@linaro.org, horms+renesas@verge.net.au, georgi.djakov@linaro.org,
 linux-arm-kernel@lists.infradead.org, jagan@amarulasolutions.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMTIvMjEvMTggMTI6MTksIFRhbml5YSBEYXMgd3JvdGU6Cj4KPgo+IE9uIDEyLzE3LzIwMTgg
MzoxNiBQTSwgSm9yZ2UgUmFtaXJlei1PcnRpeiB3cm90ZToKPj4gTGltaXQgdGhlIEdQTEwwX0FP
X09VVF9NQUlOIG9wZXJhdGluZyBmcmVxdWVuY3kgYXMgcGVyIGl0cyBoYXJkd2FyZQo+PiBzcGVj
aWZpY2F0aW9ucy4KPj4KPj4gQ28tZGV2ZWxvcGVkLWJ5OiBOaWtsYXMgQ2Fzc2VsIDxuaWtsYXMu
Y2Fzc2VsQGxpbmFyby5vcmc+Cj4+IFNpZ25lZC1vZmYtYnk6IE5pa2xhcyBDYXNzZWwgPG5pa2xh
cy5jYXNzZWxAbGluYXJvLm9yZz4KPj4gU2lnbmVkLW9mZi1ieTogSm9yZ2UgUmFtaXJlei1PcnRp
eiA8am9yZ2UucmFtaXJlei1vcnRpekBsaW5hcm8ub3JnPgo+PiAtLS0KPj4gwqAgZHJpdmVycy9j
bGsvcWNvbS9nY2MtcWNzNDA0LmMgfCA2ICsrKysrKwo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgNiBp
bnNlcnRpb25zKCspCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9xY29tL2djYy1xY3M0
MDQuYyAKPj4gYi9kcml2ZXJzL2Nsay9xY29tL2djYy1xY3M0MDQuYwo+PiBpbmRleCA2NGRhMDMy
Li44MzM0MzZhIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2Nsay9xY29tL2djYy1xY3M0MDQuYwo+
PiArKysgYi9kcml2ZXJzL2Nsay9xY29tL2djYy1xY3M0MDQuYwo+PiBAQCAtMzA0LDEwICszMDQs
MTYgQEAgc3RhdGljIHN0cnVjdCBjbGtfYWxwaGFfcGxsIGdwbGwwX291dF9tYWluID0gewo+PiDC
oMKgwqDCoMKgIH0sCj4+IMKgIH07Cj4+IMKgICtzdGF0aWMgY29uc3Qgc3RydWN0IHBsbF92Y28g
Z3BsbDBfYW9fb3V0X3Zjb1tdID0gewo+PiArwqDCoMKgIHsgODAwMDAwMDAwLCA4MDAwMDAwMDAs
IDAgfSwKPj4gK307Cj4+ICsKPj4gwqAgc3RhdGljIHN0cnVjdCBjbGtfYWxwaGFfcGxsIGdwbGww
X2FvX291dF9tYWluID0gewo+PiDCoMKgwqDCoMKgIC5vZmZzZXQgPSAweDIxMDAwLAo+PiDCoMKg
wqDCoMKgIC5yZWdzID0gY2xrX2FscGhhX3BsbF9yZWdzW0NMS19BTFBIQV9QTExfVFlQRV9ERUZB
VUxUXSwKPj4gwqDCoMKgwqDCoCAuZmxhZ3MgPSBTVVBQT1JUU19GU01fTU9ERSwKPj4gK8KgwqDC
oCAudmNvX3RhYmxlID0gZ3BsbDBfYW9fb3V0X3ZjbywKPj4gK8KgwqDCoCAubnVtX3ZjbyA9IEFS
UkFZX1NJWkUoZ3BsbDBfYW9fb3V0X3ZjbyksCj4KPiBDb3VsZCB5b3UgcGxlYXNlIGhlbHAgYXMg
dG8gd2h5IHRoaXMgaXMgcmVxdWlyZWQ/IFRoaXMgaXMgYSBmaXhlZCBQTEwgCj4gYW5kIHdlIGRv
IG5vdCByZXF1aXJlIGEgVkNPIHRhYmxlIGZvciBpdC4KCkhpIFRhbml5YSwKCnRoaXMgcGF0Y2gg
LSB0aGUgYWRkaXRpb25hbCBpbmZvcm1hdGlvbiB0aGF0IGl0IHByb3ZpZGVzIGFib3V0IHRoZSAK
aGFyZHdhcmUgLSBoZWxwcyB0byBzZWxlY3QgdGhlIHJpZ2h0IHBhcmVudCBjbG9jayBmb3IgYSBn
aXZlbiBmcmVxdWVuY3kuCgpPbiB0aGUgcWNzNDA0IHRoaXMgY2xvY2sgaXMgb25lIG9mIHRoZSB0
d28gcGFyZW50IGNsb2NrcyBvZiB0aGUgYXBjcyAKY2xvY2sgY29udHJvbGxlciAodGhlIG90aGVy
IG9uZSBiZWluZyB0aGUgaGlnaCBmcmVxdWVuY3kgcGxsKQpXaGVuIGNwdWZyZXEgc2V0cyBhIHRh
cmdldCBmcmVxdWVuY3ksIHRoZXJlIGlzIGFuIGl0ZXJhdGlvbiB0aHJvdWdoIHRoZSAKbGlzdCBv
ZiBwYXJlbnRzIHRvIHNlbGVjdCB0aGUgb25lIHRoYXQgZGVsaXZlcnMgdGhlIGJlc3QgbWF0Y2gu
CgpXaGVuIGF0dGVtcHRpbmcgdG8gc2V0IHRoZSBjbG9jayBmb3IgYW4gYWxwaGFfcGxsLCB0aGUg
b3BlcmF0aW9uIGRvZXMgYSAKc2FuaXR5IGNoZWNrIHRvIHZhbGlkYXRlIHRoYXQgdGhlIHJlcXVl
c3RlZCBmcmVxdWVuY3kgaXMgaW4gZmFjdCAKcmVhY2hhYmxlIHVzaW5nIHRoZSB2Y28gcmFuZ2U6
IHRyeWluZyB0byBzZXQgYSB2YWx1ZSB0aGF0IGlzIG5vdCBpbiAKcmFuZ2Ugd2lsbCBmYWlsLgoK
VGhpcyBwYXRjaCBtYWtlcyBzdXJlIHRoYXQgaXRzIHJhbmdlIGlzIGV4cGxpY2l0bHkgZGVmaW5l
ZC4KCkl0IGFsc28gaGVscHMgbWFraW5nIHN1cmUgdGhlcmUgYXJlIG5vIHJvdW5kaW5nIGlzc3Vl
cyB3aGVuIHNldHRpbmcgaXRzIAp2YWx1ZTogd2l0aG91dCBpdCB0aGUgY2xvY2sgd2FzIGJlaW5n
IHJlYWQgYXQgNzk5TUh6CgoKPgo+PiDCoMKgwqDCoMKgIC5jbGtyID0gewo+PiDCoMKgwqDCoMKg
wqDCoMKgwqAgLmVuYWJsZV9yZWcgPSAweDQ1MDAwLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgLmVu
YWJsZV9tYXNrID0gQklUKDApLAo+Pgo+CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
