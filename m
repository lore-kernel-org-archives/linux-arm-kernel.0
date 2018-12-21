Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89026C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:45:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52EC22190A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W6HBVB+k";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hJ/qut51"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52EC22190A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0JRvu+7DML/CeXJnHewbmUKn4xcyHhDb1AJULsiQym8=; b=W6HBVB+kZCgOfDUH+YaUjVVCF
	yYG6KS5xKXtuVDjszDA22kaY1A4sgA8xaJZhIUt1rm6vACWayQf2genj8kng8pGjOIgf55HQYN2I9
	9zWWOrBQdZUAzes6iqPF8Rd/zDlzymtiUByqIP4y8u1wZtkoogv0dAs4UHunk6bMLoYgWc7LsuO6+
	gMbv7/M/NZ2ZJSfXeNBjcX6R2hZZTiTV5bK28via2z+DYvra2T5qVFn/C+PyEWIk9uHZW5tbNVgJ7
	sE7CBYKI1yzI4NQZ9IjL+V/F548KgOpVCwtEd7Xls6pbYvo1UL2PPK2UKK3E75SMf8OuZz51X+w/v
	n+WOoDDCQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaQjy-0002C5-Ko; Fri, 21 Dec 2018 19:45:46 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaQjv-0002BI-0R
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 19:45:45 +0000
Received: by mail-wm1-x342.google.com with SMTP id c126so6784417wmh.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 21 Dec 2018 11:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=bPsdJXvaDKjMpm+MxiZxTRI2Embzlx3Zwq30nS6yXJw=;
 b=hJ/qut51LkniPzqQhs719iid4FVamcxiB6jBKTvZhuttF1u/LA5u0gTA26uzDzrbuN
 cbveu4ZquLtyTUEouTScXsYnK2Go6nXnTUU3QFxcTY+3ZJlrO8euUbkUbqQNvhIb3msi
 VAQ9+WRQajoTmMHaw/rYBMNhPFfsMiUe6CrKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=bPsdJXvaDKjMpm+MxiZxTRI2Embzlx3Zwq30nS6yXJw=;
 b=Uk5KUEFsY1i2sxaVkBHMsFNnJIfrp2f617SlsX4Ul/u/Gjmg5MA3QxwzsjBaJ8eCkA
 bmV09fJz2Pt9VFjadh0E3L8k/xr9pT4zIojRss3+hcY2TsW/v4yaMHyCLUBH4AJEj/IE
 6FnqHajLtaJ+Mmao35JO3YDjqTuRl0kbD0Rzx8/GS9GA09QDTyoscLcYDqvpgQs9hw+L
 p28xvDoGhvwQNUuuqdZnjlq+H8IQBUTYCRdnXvomkn2AenLP0YQuyHyQ1NszlcQ9Z8zR
 6Bku8wxVs2YrUvlNEfBZsI1GQcdfAxS4XXQSrSVDWBeUir1HxfvE/inL7c/Ey9CL5Jx2
 qtYw==
X-Gm-Message-State: AA+aEWZmjyBdlPwCx9vcDRiP7EDoGAb4bRBGTSXCJ9oW1VUyATjGr39Y
 VVsYvEihQW7QsKoix/EPD7X4iA==
X-Google-Smtp-Source: AFSGD/VmeVwISoEhsSm7H7yJYXVWxXpelLTbavp1NLiLUl4fsBfj4XRsTgkYRgSrLUoqTZOn8JA8iQ==
X-Received: by 2002:a1c:1286:: with SMTP id 128mr4244346wms.70.1545421531174; 
 Fri, 21 Dec 2018 11:45:31 -0800 (PST)
Received: from [192.168.1.2] (119.red-79-146-81.dynamicip.rima-tde.net.
 [79.146.81.119])
 by smtp.gmail.com with ESMTPSA id j129sm9760935wmb.39.2018.12.21.11.45.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Dec 2018 11:45:30 -0800 (PST)
Subject: Re: [PATCH 01/13] clk: qcom: gcc: limit GPLL0_AO_OUT operating
 frequency
To: Bjorn Andersson <bjorn.andersson@linaro.org>,
 Taniya Das <tdas@codeaurora.org>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <e97d9050-effc-56d7-0f9b-768df90dd73a@codeaurora.org>
 <6814777f-1e5f-bd99-db63-a0050dcdd930@linaro.org>
 <874ce15d-67f5-8e55-8b62-73071fe6ae06@codeaurora.org>
 <20181221192823.GA9704@minitux>
From: Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Message-ID: <94b12f58-b586-6b4b-6c0c-b4adad80d7b0@linaro.org>
Date: Fri, 21 Dec 2018 20:45:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181221192823.GA9704@minitux>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_114543_067119_B31B08EA 
X-CRM114-Status: GOOD (  23.07  )
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
Cc: mark.rutland@arm.com, heiko@sntech.de, mturquette@baylibre.com,
 will.deacon@arm.com, david.brown@linaro.org, linux-clk@vger.kernel.org,
 jassisinghbrar@gmail.com, jagan@amarulasolutions.com, andy.gross@linaro.org,
 sibis@codeaurora.org, devicetree@vger.kernel.org, arnd@arndb.de,
 niklas.cassel@linaro.org, robh+dt@kernel.org, horms+renesas@verge.net.au,
 linux-arm-kernel@lists.infradead.org, olof@lixom.net, sboyd@kernel.org,
 linux-kernel@vger.kernel.org, amit.kucheria@linaro.org, vkoul@kernel.org,
 enric.balletbo@collabora.com, georgi.djakov@linaro.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMTIvMjEvMTggMjA6MjgsIEJqb3JuIEFuZGVyc3NvbiB3cm90ZToKPiBPbiBGcmkgMjEgRGVj
IDA5OjU4IFBTVCAyMDE4LCBUYW5peWEgRGFzIHdyb3RlOgo+Cj4+IEhlbGxvLAo+Pgo+PiBPbiAx
Mi8yMS8yMDE4IDY6MDYgUE0sIEpvcmdlIFJhbWlyZXogd3JvdGU6Cj4+PiBPbiAxMi8yMS8xOCAx
MjoxOSwgVGFuaXlhIERhcyB3cm90ZToKPj4+Pgo+Pj4+IE9uIDEyLzE3LzIwMTggMzoxNiBQTSwg
Sm9yZ2UgUmFtaXJlei1PcnRpeiB3cm90ZToKPj4+Pj4gTGltaXQgdGhlIEdQTEwwX0FPX09VVF9N
QUlOIG9wZXJhdGluZyBmcmVxdWVuY3kgYXMgcGVyIGl0cyBoYXJkd2FyZQo+Pj4+PiBzcGVjaWZp
Y2F0aW9ucy4KPj4+Pj4KPj4+Pj4gQ28tZGV2ZWxvcGVkLWJ5OiBOaWtsYXMgQ2Fzc2VsIDxuaWts
YXMuY2Fzc2VsQGxpbmFyby5vcmc+Cj4+Pj4+IFNpZ25lZC1vZmYtYnk6IE5pa2xhcyBDYXNzZWwg
PG5pa2xhcy5jYXNzZWxAbGluYXJvLm9yZz4KPj4+Pj4gU2lnbmVkLW9mZi1ieTogSm9yZ2UgUmFt
aXJlei1PcnRpeiA8am9yZ2UucmFtaXJlei1vcnRpekBsaW5hcm8ub3JnPgo+Pj4+PiAtLS0KPj4+
Pj4gIMKgIGRyaXZlcnMvY2xrL3Fjb20vZ2NjLXFjczQwNC5jIHwgNiArKysrKysKPj4+Pj4gIMKg
IDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykKPj4+Pj4KPj4+Pj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvY2xrL3Fjb20vZ2NjLXFjczQwNC5jCj4+Pj4+IGIvZHJpdmVycy9jbGsvcWNvbS9n
Y2MtcWNzNDA0LmMKPj4+Pj4gaW5kZXggNjRkYTAzMi4uODMzNDM2YSAxMDA2NDQKPj4+Pj4gLS0t
IGEvZHJpdmVycy9jbGsvcWNvbS9nY2MtcWNzNDA0LmMKPj4+Pj4gKysrIGIvZHJpdmVycy9jbGsv
cWNvbS9nY2MtcWNzNDA0LmMKPj4+Pj4gQEAgLTMwNCwxMCArMzA0LDE2IEBAIHN0YXRpYyBzdHJ1
Y3QgY2xrX2FscGhhX3BsbCBncGxsMF9vdXRfbWFpbiA9IHsKPj4+Pj4gIMKgwqDCoMKgwqAgfSwK
Pj4+Pj4gIMKgIH07Cj4+Pj4+ICDCoCArc3RhdGljIGNvbnN0IHN0cnVjdCBwbGxfdmNvIGdwbGww
X2FvX291dF92Y29bXSA9IHsKPj4+Pj4gK8KgwqDCoCB7IDgwMDAwMDAwMCwgODAwMDAwMDAwLCAw
IH0sCj4+Pj4+ICt9Owo+Pj4+PiArCj4+Pj4+ICDCoCBzdGF0aWMgc3RydWN0IGNsa19hbHBoYV9w
bGwgZ3BsbDBfYW9fb3V0X21haW4gPSB7Cj4+Pj4+ICDCoMKgwqDCoMKgIC5vZmZzZXQgPSAweDIx
MDAwLAo+Pj4+PiAgwqDCoMKgwqDCoCAucmVncyA9IGNsa19hbHBoYV9wbGxfcmVnc1tDTEtfQUxQ
SEFfUExMX1RZUEVfREVGQVVMVF0sCj4+Pj4+ICDCoMKgwqDCoMKgIC5mbGFncyA9IFNVUFBPUlRT
X0ZTTV9NT0RFLAo+Pj4+PiArwqDCoMKgIC52Y29fdGFibGUgPSBncGxsMF9hb19vdXRfdmNvLAo+
Pj4+PiArwqDCoMKgIC5udW1fdmNvID0gQVJSQVlfU0laRShncGxsMF9hb19vdXRfdmNvKSwKPj4+
PiBDb3VsZCB5b3UgcGxlYXNlIGhlbHAgYXMgdG8gd2h5IHRoaXMgaXMgcmVxdWlyZWQ/IFRoaXMg
aXMgYSBmaXhlZAo+Pj4+IFBMTCBhbmQgd2UgZG8gbm90IHJlcXVpcmUgYSBWQ08gdGFibGUgZm9y
IGl0Lgo+Pj4gSGkgVGFuaXlhLAo+Pj4KPj4+IHRoaXMgcGF0Y2ggLSB0aGUgYWRkaXRpb25hbCBp
bmZvcm1hdGlvbiB0aGF0IGl0IHByb3ZpZGVzIGFib3V0IHRoZQo+Pj4gaGFyZHdhcmUgLSBoZWxw
cyB0byBzZWxlY3QgdGhlIHJpZ2h0IHBhcmVudCBjbG9jayBmb3IgYSBnaXZlbiBmcmVxdWVuY3ku
Cj4+Pgo+Pj4gT24gdGhlIHFjczQwNCB0aGlzIGNsb2NrIGlzIG9uZSBvZiB0aGUgdHdvIHBhcmVu
dCBjbG9ja3Mgb2YgdGhlIGFwY3MKPj4+IGNsb2NrIGNvbnRyb2xsZXIgKHRoZSBvdGhlciBvbmUg
YmVpbmcgdGhlIGhpZ2ggZnJlcXVlbmN5IHBsbCkKPj4+IFdoZW4gY3B1ZnJlcSBzZXRzIGEgdGFy
Z2V0IGZyZXF1ZW5jeSwgdGhlcmUgaXMgYW4gaXRlcmF0aW9uIHRocm91Z2ggdGhlCj4+PiBsaXN0
IG9mIHBhcmVudHMgdG8gc2VsZWN0IHRoZSBvbmUgdGhhdCBkZWxpdmVycyB0aGUgYmVzdCBtYXRj
aC4KPj4+Cj4+PiBXaGVuIGF0dGVtcHRpbmcgdG8gc2V0IHRoZSBjbG9jayBmb3IgYW4gYWxwaGFf
cGxsLCB0aGUgb3BlcmF0aW9uIGRvZXMgYQo+Pj4gc2FuaXR5IGNoZWNrIHRvIHZhbGlkYXRlIHRo
YXQgdGhlIHJlcXVlc3RlZCBmcmVxdWVuY3kgaXMgaW4gZmFjdAo+Pj4gcmVhY2hhYmxlIHVzaW5n
IHRoZSB2Y28gcmFuZ2U6IHRyeWluZyB0byBzZXQgYSB2YWx1ZSB0aGF0IGlzIG5vdCBpbgo+Pj4g
cmFuZ2Ugd2lsbCBmYWlsLgo+Pj4KPj4+IFRoaXMgcGF0Y2ggbWFrZXMgc3VyZSB0aGF0IGl0cyBy
YW5nZSBpcyBleHBsaWNpdGx5IGRlZmluZWQuCj4+Pgo+Pj4gSXQgYWxzbyBoZWxwcyBtYWtpbmcg
c3VyZSB0aGVyZSBhcmUgbm8gcm91bmRpbmcgaXNzdWVzIHdoZW4gc2V0dGluZyBpdHMKPj4+IHZh
bHVlOiB3aXRob3V0IGl0IHRoZSBjbG9jayB3YXMgYmVpbmcgcmVhZCBhdCA3OTlNSHoKPj4+Cj4+
Pgo+PiBJZiB0aGUgUExMIGlzIGJlaW5nIHJlYWQgYXMgNzk5TUh6IGl0IHdvdWxkIGJlY2F1c2Ug
bm90IGFsbCB0aGUgNDAgYml0cyBvZgo+PiB0aGUgQUxQSEFfVkFMIGJlaW5nIHByb2dyYW1tZWQg
YnkgdGhlIGJvb3Rsb2FkZXJzKHdoaWNoIGFyZSB0aGUgb3JpZ2luYWwKPj4gb3duZXJzIG9mIHRo
aXMgUExMKS4gU28gd2Ugc2hvdWxkIGdvIHdpdGggdGhlIHdheSB0aGV5IGFyZSBiZWluZyBzZXQg
YnkKPj4gYm9vdGxvYWRlcnMgYW5kIHJlYWQgYnkgSExPUyBkcml2ZXIuCj4+Cj4+IEFuZCBhIFZD
TyByYW5nZSB5b3UgaGF2ZSBjb25zaWRlcmVkIGlzIHdyb25nIGZyb20gYSBQTEwgcGVyc3BlY3Rp
dmUuIEFzCj4+IHRoZXNlIGFyZSBmaXhlZCBQTExzIGFuZCBWQ08gcmFuZ2UgcmVhbGx5IGRvZXMg
bm90IG1hdHRlciBoZXJlLCBzbyBwbGVhc2UKPj4gZHJvcCB0aGlzIGNoYW5nZS4KPj4KPiBUaGUg
cHJvYmxlbSBoZXJlIGlzIHRoYXQgdGhlIFBMTCBzaG91bGQgYmUgZml4ZWQgYXQgODAwTUh6LCBi
dXQgdGhlCj4gYWxwaGEgUExMIGlzIGRlZmluZWQgc3VjaCB0aGF0IGl0IGNhbiBjaGFuZ2UuIFNv
IHdoZW4gdGhlIG11eC1kaXYgaXMKPiBsb29raW5nIGZvciBhIHN1aXRhYmxlIHBhcmVudCBhbmQg
ZGl2aWRlciBmb3Igb3VyIENQVSBjbG9jayBpdCBjb25jbHVkZXMKPiB0aGF0IHRoZSBiZXN0IHdh
eSB0byByZWFjaCBjZXJ0YWluIGZyZXF1ZW5jaWVzIGlzIHRvIGNoYW5nZSB0aGUgcmF0ZSBvZgo+
IEdQTEwwLgo+Cj4gQWRkaW5nIHRoZSB2Y29fdGFibGUgbGltaXRzIHRoZSBhdmFpbGFibGUgZnJl
cXVlbmNpZXMgZm9yIEdQTEwwIGluCj4gUUNTNDA0LCB3aXRob3V0IG1vZGlmeWluZyB0aGUgaW1w
bGVtZW50YXRpb24gb2YgdGhlIGFscGhhIFBMTC4KPgo+IFBlcmhhcHMgdGhlcmUncyBhIGJldHRl
ciB3YXkgdG8gZGVmaW5lIHRoYXQgdGhpcyBwYXJ0aWN1bGFyIGNsb2NrCj4gaGFyZHdhcmUgY2Fu
IGNoYW5nZSByYXRlLCBidXQgaW4gdGhpcyBpbXBsZW1lbnRhdGlvbiBpdCBtdXN0IG5vdD8KCnRo
ZSBpbml0aWFsaXphdGlvbiBmb3IgdGhpcyBwYXJ0aWN1bGFyIFBMTCBvbiB0aGlzIHBhcnRpY3Vs
YXIgcGxhdGZvcm0gCmlzIHdyb25nCmFzIHRoZSBpbnRlcmZhY2UgZG9lcyBub3QgYXBwbHkgdG8g
dGhlIHBsYXRmb3JtIG5lZWRzIGV2ZW4gdGhvdWdoIGl0IGlzIGFuCmFscGhhX3BsbAoKaWYgdGhl
IFZDTyBpcyBub3QgYW4gb3B0aW9uIC1ldmVuIHRob3VnaCBpdCByZWZsZWN0cyB0aGUgcGxhdGZv
cm0gCmNvbnN0cmFpbnMtCkkgd291bGQgc3VnZ2VzdCBudWxsaWZ5aW5nIHRoZSBhbHBoYV9wbGxf
b3BzIHRoYXQgZG8gbm90IGFwcGx5IHRvIHRoaXMgCnBsYXRmb3JtOgppZTogc2V0X3JhdGUsIHJv
dW5kX3JhdGUgc2V0IHRvIG51bGwgaW4gdGhlIHByb2JlLgoKYWxsb3dpbmcgdGhlIGludGVyZmFj
ZSBjYWxscyAob3BzKSB0byBnbyB0aHJvdWdoIHRvIGxhdGVyIG9uIG1ha2UgdGhlbSBmYWlsCmJh
c2VkIG9uIHNvbWUgc2V0dGluZyB3b3VsZCBiZSBmdW5kYW1lbnRhbGx5IHdyb25nIElNTwoKCgoK
CgoKCgoKCgo+Cj4gUmVnYXJkcywKPiBCam9ybgo+CgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
