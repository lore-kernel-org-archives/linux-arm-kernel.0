Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61698C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:39:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 306C220881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kVLjgR/j";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="B723pNcz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 306C220881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VfxKQZPgpAe7d5+X7t9j7KoNQ7qvqTvDZ/7igJUA/9s=; b=kVLjgR/jkDRiMs
	OYq44wIFREDz8ps7CVGQYzmuuq8JvAUDsHcN1HUuX0SscZQtskdI7V75bBHsz4DpIIVPhu8TdV0kb
	+ckAQusc/kFfvfEZzyo6YdEuaqnMxo0fAq20jqO6UuncIAKc5wl6P7x+dkp0AM41ahh30XKmbtPAS
	96eavFf9wSfKnzMVvZWF3jfqZt//SF3NEE2faBvZaur5nVJhTXQ1/Cp2pp1DQku3aibH1LbjYWBe1
	jJOjUdep5wQVS8BYIi2TCgLYYtN2CkpG7NugDC7RCkDJ3ViY14vL+hP1fTyT5wvvizm4O1tOp++0y
	x41Mvi4bzCaalh6odUlQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go2Rz-0004wZ-8U; Mon, 28 Jan 2019 08:39:27 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go2Rv-0004w9-GN
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 08:39:25 +0000
Received: by mail-wr1-x441.google.com with SMTP id p7so17046310wru.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 00:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=HvCmuadj0C3VfhNvieaFfPciyvU0URb0jZw5i6fE1eQ=;
 b=B723pNczchkl703bz0+GZNNPX2lJFzG8gZsIagGCv3zYMg3H/R9MEc43d/KYfhl0mr
 JPEsFKac5+VoU4GB5GerekvdiXsOGHBTzSRk++ZDcIFHzH1uGtDgwYp0lSZt79KqqcwN
 AjLdtThJWUCe+y7CxqyhUZm/OyYkhjskKfNaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HvCmuadj0C3VfhNvieaFfPciyvU0URb0jZw5i6fE1eQ=;
 b=kttf/2glU+W5UUeB9ONHZECQfPOY0GcBoBofvta71X+oTeV9BuaU7a6LsH6wLJsv/3
 NExMkW36LCDFLNsbCHr1zE9oR7oT5clpjTHZM9Xe6qY/JWTW1L0zKzzP5d2KDR84W//K
 2uawUJbLjsvRcO4lLJ6FUgegNoFUpwD4J2VcFdHRFBVJaRDsW8elQMRVdhYIkxRrHHZZ
 DF1i4J6mLusZGX4TFlIMzIlHozXnW7+M1vEDkDky6avM1F/tWqYv4pLgHBcsnt5cTe04
 8WQh2/QD5SMzuP9oSP5eqQuTJLjtkWg75mhA4VBtosLl3a+nNp+99M4ym6ex6Izouhy8
 5/LQ==
X-Gm-Message-State: AJcUukeyNeE79aNfDPakscaCUXguhA4GZ+0HVz0BXHu0fdCQ1eaw4ss9
 x0BkgO07kS/H4v6PmxSaeWxQLQ==
X-Google-Smtp-Source: ALg8bN4GsfEOEZMdbH2rQdepzEv/eAgIC8pJQISLyRASTjC6hqDe5KIKs9lW02JxCDrBkpqRJidnwQ==
X-Received: by 2002:adf:f1cb:: with SMTP id z11mr20530227wro.35.1548664761341; 
 Mon, 28 Jan 2019 00:39:21 -0800 (PST)
Received: from [192.168.0.41] (20.36.129.77.rev.sfr.net. [77.129.36.20])
 by smtp.googlemail.com with ESMTPSA id h2sm128227075wrv.87.2019.01.28.00.39.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Jan 2019 00:39:20 -0800 (PST)
Subject: Re: [PATCH v4 8/9] cpufreq: scmi: Use auto-registration of thermal
 cooling device
To: Amit Kucheria <amit.kucheria@linaro.org>, linux-kernel@vger.kernel.org
References: <cover.1548654899.git.amit.kucheria@linaro.org>
 <81d81c0016fb275728b7b604020c22d8f53991b1.1548654899.git.amit.kucheria@linaro.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <49b6cb24-6f38-750d-e652-cc4e47f96db0@linaro.org>
Date: Mon, 28 Jan 2019 09:39:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <81d81c0016fb275728b7b604020c22d8f53991b1.1548654899.git.amit.kucheria@linaro.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_003923_548765_96E0A468 
X-CRM114-Status: GOOD (  18.67  )
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
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 dianders@chromium.org, swboyd@chromium.org, edubezval@gmail.com,
 mka@chromium.org, viresh.kumar@linaro.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMjgvMDEvMjAxOSAwNzo0MSwgQW1pdCBLdWNoZXJpYSB3cm90ZToKPiBVc2UgdGhlIENQVUZS
RVFfQVVUT19SRUdJU1RFUl9DT09MSU5HX0RFViBmbGFnIHRvIGFsbG93IGNwdWZyZXEgY29yZSB0
bwo+IGF1dG9tYXRpY2FsbHkgcmVnaXN0ZXIgYXMgYSB0aGVybWFsIGNvb2xpbmcgZGV2aWNlLgo+
IAo+IFRoaXMgYWxsb3dzIHJlbW92YWwgb2YgYm9pbGVyIHBsYXRlIGNvZGUgZnJvbSB0aGUgZHJp
dmVyLgo+IAo+IFNpZ25lZC1vZmYtYnk6IEFtaXQgS3VjaGVyaWEgPGFtaXQua3VjaGVyaWFAbGlu
YXJvLm9yZz4KPiBBY2tlZC1ieTogU3VkZWVwIEhvbGxhIDxzdWRlZXAuaG9sbGFAYXJtLmNvbT4K
ClJldmlld2VkLWJ5OiBEYW5pZWwgTGV6Y2FubyA8ZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZz4K
Cj4gLS0tCj4gIGRyaXZlcnMvY3B1ZnJlcS9zY21pLWNwdWZyZXEuYyB8IDE0ICsrLS0tLS0tLS0t
LS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQo+
IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2NwdWZyZXEvc2NtaS1jcHVmcmVxLmMgYi9kcml2ZXJz
L2NwdWZyZXEvc2NtaS1jcHVmcmVxLmMKPiBpbmRleCAyNDJjMzM3MDU0NGUuLmIxOWU5ZDEyOWY4
ZiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2NwdWZyZXEvc2NtaS1jcHVmcmVxLmMKPiArKysgYi9k
cml2ZXJzL2NwdWZyZXEvc2NtaS1jcHVmcmVxLmMKPiBAQCAtMTEsNyArMTEsNiBAQAo+ICAjaW5j
bHVkZSA8bGludXgvY3B1Lmg+Cj4gICNpbmNsdWRlIDxsaW51eC9jcHVmcmVxLmg+Cj4gICNpbmNs
dWRlIDxsaW51eC9jcHVtYXNrLmg+Cj4gLSNpbmNsdWRlIDxsaW51eC9jcHVfY29vbGluZy5oPgo+
ICAjaW5jbHVkZSA8bGludXgvZXhwb3J0Lmg+Cj4gICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4K
PiAgI2luY2x1ZGUgPGxpbnV4L3BtX29wcC5oPgo+IEBAIC0yMiw3ICsyMSw2IEBACj4gIHN0cnVj
dCBzY21pX2RhdGEgewo+ICAJaW50IGRvbWFpbl9pZDsKPiAgCXN0cnVjdCBkZXZpY2UgKmNwdV9k
ZXY7Cj4gLQlzdHJ1Y3QgdGhlcm1hbF9jb29saW5nX2RldmljZSAqY2RldjsKPiAgfTsKPiAgCj4g
IHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc2NtaV9oYW5kbGUgKmhhbmRsZTsKPiBAQCAtMTg1LDcgKzE4
Myw2IEBAIHN0YXRpYyBpbnQgc2NtaV9jcHVmcmVxX2V4aXQoc3RydWN0IGNwdWZyZXFfcG9saWN5
ICpwb2xpY3kpCj4gIHsKPiAgCXN0cnVjdCBzY21pX2RhdGEgKnByaXYgPSBwb2xpY3ktPmRyaXZl
cl9kYXRhOwo+ICAKPiAtCWNwdWZyZXFfY29vbGluZ191bnJlZ2lzdGVyKHByaXYtPmNkZXYpOwo+
ICAJZGV2X3BtX29wcF9mcmVlX2NwdWZyZXFfdGFibGUocHJpdi0+Y3B1X2RldiwgJnBvbGljeS0+
ZnJlcV90YWJsZSk7Cj4gIAlrZnJlZShwcml2KTsKPiAgCWRldl9wbV9vcHBfcmVtb3ZlX2FsbF9k
eW5hbWljKHByaXYtPmNwdV9kZXYpOwo+IEBAIC0xOTMsMTcgKzE5MCwxMSBAQCBzdGF0aWMgaW50
IHNjbWlfY3B1ZnJlcV9leGl0KHN0cnVjdCBjcHVmcmVxX3BvbGljeSAqcG9saWN5KQo+ICAJcmV0
dXJuIDA7Cj4gIH0KPiAgCj4gLXN0YXRpYyB2b2lkIHNjbWlfY3B1ZnJlcV9yZWFkeShzdHJ1Y3Qg
Y3B1ZnJlcV9wb2xpY3kgKnBvbGljeSkKPiAtewo+IC0Jc3RydWN0IHNjbWlfZGF0YSAqcHJpdiA9
IHBvbGljeS0+ZHJpdmVyX2RhdGE7Cj4gLQo+IC0JcHJpdi0+Y2RldiA9IG9mX2NwdWZyZXFfY29v
bGluZ19yZWdpc3Rlcihwb2xpY3kpOwo+IC19Cj4gLQo+ICBzdGF0aWMgc3RydWN0IGNwdWZyZXFf
ZHJpdmVyIHNjbWlfY3B1ZnJlcV9kcml2ZXIgPSB7Cj4gIAkubmFtZQk9ICJzY21pIiwKPiAgCS5m
bGFncwk9IENQVUZSRVFfU1RJQ0tZIHwgQ1BVRlJFUV9IQVZFX0dPVkVSTk9SX1BFUl9QT0xJQ1kg
fAo+IC0JCSAgQ1BVRlJFUV9ORUVEX0lOSVRJQUxfRlJFUV9DSEVDSywKPiArCQkgIENQVUZSRVFf
TkVFRF9JTklUSUFMX0ZSRVFfQ0hFQ0sgfAo+ICsJCSAgQ1BVRlJFUV9BVVRPX1JFR0lTVEVSX0NP
T0xJTkdfREVWLAo+ICAJLnZlcmlmeQk9IGNwdWZyZXFfZ2VuZXJpY19mcmVxdWVuY3lfdGFibGVf
dmVyaWZ5LAo+ICAJLmF0dHIJPSBjcHVmcmVxX2dlbmVyaWNfYXR0ciwKPiAgCS50YXJnZXRfaW5k
ZXgJPSBzY21pX2NwdWZyZXFfc2V0X3RhcmdldCwKPiBAQCAtMjExLDcgKzIwMiw2IEBAIHN0YXRp
YyBzdHJ1Y3QgY3B1ZnJlcV9kcml2ZXIgc2NtaV9jcHVmcmVxX2RyaXZlciA9IHsKPiAgCS5nZXQJ
PSBzY21pX2NwdWZyZXFfZ2V0X3JhdGUsCj4gIAkuaW5pdAk9IHNjbWlfY3B1ZnJlcV9pbml0LAo+
ICAJLmV4aXQJPSBzY21pX2NwdWZyZXFfZXhpdCwKPiAtCS5yZWFkeQk9IHNjbWlfY3B1ZnJlcV9y
ZWFkeSwKPiAgfTsKPiAgCj4gIHN0YXRpYyBpbnQgc2NtaV9jcHVmcmVxX3Byb2JlKHN0cnVjdCBz
Y21pX2RldmljZSAqc2RldikKPiAKCgotLSAKIDxodHRwOi8vd3d3LmxpbmFyby5vcmcvPiBMaW5h
cm8ub3JnIOKUgiBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3IgQVJNIFNvQ3MKCkZvbGxvdyBMaW5h
cm86ICA8aHR0cDovL3d3dy5mYWNlYm9vay5jb20vcGFnZXMvTGluYXJvPiBGYWNlYm9vayB8Cjxo
dHRwOi8vdHdpdHRlci5jb20vIyEvbGluYXJvb3JnPiBUd2l0dGVyIHwKPGh0dHA6Ly93d3cubGlu
YXJvLm9yZy9saW5hcm8tYmxvZy8+IEJsb2cKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
