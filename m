Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E448C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:32:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DA8120868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d+6TV1ft";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DCDly5GN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DA8120868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vfKbetmAnKf+knMG5uLZqXXaAab+HQs81Za1yNqHfO4=; b=d+6TV1ftpJYGiB
	QLHEioQvQrVVx7AzpMB4ugq40SxHXHzb1U4/VLvQblcWsPE7c1OldySH3ZsyMeuMH7eF5rUvZGoCZ
	bPkbKBCwvAg46moPhTg1gGR2Vr2VB9qRl8cTHXOOsHtjLFkFFMAiYSQTcTqlx67lj9CFEFUt1bgs+
	UvTbwI8PrDnAfIEFGPprdjYCXjOt2rqFfCHSbcLnh1AmGysYwmN4O/HNXB8csOT3VOy7ekbu75fft
	u5qR7juEsDU35yCj3A8NVsz5uQyM2I8VyHXdkRHljJcrlN6Ju6FzrgnUMTmAIJMrDlbi8TcNucrSW
	/0IMHzwysBurr/nUi6rg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUtle-0001IC-6W; Thu, 06 Dec 2018 13:32:38 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUtla-0001Gw-Qu
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 13:32:36 +0000
Received: by mail-wm1-x343.google.com with SMTP id q26so1026604wmf.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 05:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ma7F/MaGF7iButmMQePk0cKTz/A+1Gb0fFsb/aq9g6M=;
 b=DCDly5GNurc+2KWbcML7ieCgR10KD2oe7OHdxENylgHVysEA1EZQNyMX6WIk6UOTLy
 vrl54p25WekKlkg4u+T84aALSWjcO8YOyg9TFAo4z0PW0k90dd/MaThVAsxO4Zl06ISt
 YP/jc9pxjr2Bf4YLaO2VgmacYc8xxQZo7mrLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ma7F/MaGF7iButmMQePk0cKTz/A+1Gb0fFsb/aq9g6M=;
 b=Mv+0n+EAqvjqtXLjEwloW/ulStCw3k5lbBmImRtbCShJKOwl8aRZBvapVH2T2wXUeE
 9Ut638VyICdCHZcdq0U7Ksd5WBxq2CXY8NYCjy8iTgWAQZMJpExjNhi4BV57hnqYACUq
 bC3FVaY367dmJ0BP7dZjsWuqSKG/NGmWty+vVWAhPH3bdUpk4OQnB7t5QwJ8A+IEdHo4
 kxN3nnRIlNvFlLyETNNcLMLzc1P5AtsTc8wf7Lm+GQcRqUfl7A54MVILJ4yBmDEJdQG1
 dmtYzOTpwMmACgPx95QrZHGdRa7Q2b4LaU6iOlO14DjGjmlf2T/rv+Al9wlMslVC+n7K
 9HPg==
X-Gm-Message-State: AA+aEWZA52yCmrIcQD/lm0kixS/Ml2TMP3jayGAfFmeGEJBdJrvSQ8qd
 iHDiOgAV0PSz7w4hbIrK9dqt0w==
X-Google-Smtp-Source: AFSGD/XuZ/RhGcUUn+KzOqHjiBD9fkgMbTRRiAhklDRhuB4O3PNrIqviIVc9qYQnxVWfUH5N4mDuPQ==
X-Received: by 2002:a1c:f404:: with SMTP id z4mr19935873wma.68.1544103143229; 
 Thu, 06 Dec 2018 05:32:23 -0800 (PST)
Received: from [192.168.0.40] (172.220.136.77.rev.sfr.net. [77.136.220.172])
 by smtp.googlemail.com with ESMTPSA id d5sm788927wrx.22.2018.12.06.05.32.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Dec 2018 05:32:22 -0800 (PST)
Subject: Re: [PATCH] thermal: stm32: read factory settings inside
 stm_thermal_prepare
To: David HERNANDEZ SANCHEZ <david.hernandezsanchez@st.com>,
 Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre TORGUE <alexandre.torgue@st.com>
References: <1544102603-14899-1-git-send-email-david.hernandezsanchez@st.com>
 <1544102603-14899-2-git-send-email-david.hernandezsanchez@st.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <7999967d-6f6e-635c-4d43-c0e1cd58ec4b@linaro.org>
Date: Thu, 6 Dec 2018 14:32:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544102603-14899-2-git-send-email-david.hernandezsanchez@st.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_053234_869020_F90C1AB3 
X-CRM114-Status: GOOD (  18.83  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-stm32@st-md-mailman.stormreply.com"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMDYvMTIvMjAxOCAxNDoyMywgRGF2aWQgSEVSTkFOREVaIFNBTkNIRVogd3JvdGU6Cj4gQ2Fs
bGluZyBzdG1fdGhlcm1hbF9yZWFkX2ZhY3Rvcnlfc2V0dGluZ3MgYmVmb3JlIGNsb2NraW5nCj4g
aW50ZXJuYWwgcGVyaXBoZXJhbCBjYXVzZXMgYmFkIHJlZ2lzdGVyIHZhbHVlcyBhbmQgbWFrZXMK
PiB0ZW1wZXJhdHVyZSBjb21wdXRhdGlvbiB3cm9uZy4KPiAKPiBDYWxsaW5nIHN0bV90aGVybWFs
X3JlYWRfZmFjdG9yeV9zZXR0aW5ncyBpbnNpZGUKPiBzdG1fdGhlcm1hbF9wcmVwYXJlIGZpeGVz
IHRoaXMgcHJvYmxlbSBhcyBpbnRlcm5hbAo+IHBlcmlwaGVyYWwgaXMgd2VsbCBjbG9ja2VkIGF0
IHRoaXMgc3RhZ2UuCj4gCj4gU2lnbmVkLW9mZi1ieTogRGF2aWQgSGVybmFuZGV6IFNhbmNoZXog
PGRhdmlkLmhlcm5hbmRlenNhbmNoZXpAc3QuY29tPgo+IEZpeGVzOiAxZDY5MzE1NSAoInRoZXJt
YWw6IGFkZCBzdG0zMiB0aGVybWFsIGRyaXZlciIpCgpTYW1lIGNvbW1lbnQgYXMgdGhlIGZpcnN0
IHBhdGNoLgoKUmV2aWV3ZWQtYnk6IERhbmllbCBMZXpjYW5vIDxkYW5pZWwubGV6Y2Fub0BsaW5h
cm8ub3JnPgoKCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdGhlcm1hbC9zdC9zdG1fdGhlcm1hbC5j
IGIvZHJpdmVycy90aGVybWFsL3N0L3N0bV90aGVybWFsLmMKPiBpbmRleCA0NzYyM2RhLi5kYWEx
MjU3IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdGhlcm1hbC9zdC9zdG1fdGhlcm1hbC5jCj4gKysr
IGIvZHJpdmVycy90aGVybWFsL3N0L3N0bV90aGVybWFsLmMKPiBAQCAtNTMyLDYgKzUzMiwxMCBA
QCBzdGF0aWMgaW50IHN0bV90aGVybWFsX3ByZXBhcmUoc3RydWN0IHN0bV90aGVybWFsX3NlbnNv
ciAqc2Vuc29yKQo+ICAJaWYgKHJldCkKPiAgCQlyZXR1cm4gcmV0Owo+ICAKPiArCXJldCA9IHN0
bV90aGVybWFsX3JlYWRfZmFjdG9yeV9zZXR0aW5ncyhzZW5zb3IpOwo+ICsJaWYgKHJldCkKPiAr
CQlnb3RvIHRoZXJtYWxfdW5wcmVwYXJlOwo+ICsKPiAgCXJldCA9IHN0bV90aGVybWFsX2NhbGli
cmF0aW9uKHNlbnNvcik7Cj4gIAlpZiAocmV0KQo+ICAJCWdvdG8gdGhlcm1hbF91bnByZXBhcmU7
Cj4gQEAgLTYzNiwxMCArNjQwLDYgQEAgc3RhdGljIGludCBzdG1fdGhlcm1hbF9wcm9iZShzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQo+ICAJLyogUG9wdWxhdGUgc2Vuc29yICovCj4gIAlz
ZW5zb3ItPmJhc2UgPSBiYXNlOwo+ICAKPiAtCXJldCA9IHN0bV90aGVybWFsX3JlYWRfZmFjdG9y
eV9zZXR0aW5ncyhzZW5zb3IpOwo+IC0JaWYgKHJldCkKPiAtCQlyZXR1cm4gcmV0Owo+IC0KPiAg
CXNlbnNvci0+Y2xrID0gZGV2bV9jbGtfZ2V0KCZwZGV2LT5kZXYsICJwY2xrIik7Cj4gIAlpZiAo
SVNfRVJSKHNlbnNvci0+Y2xrKSkgewo+ICAJCWRldl9lcnIoJnBkZXYtPmRldiwgIiVzOiBmYWls
ZWQgdG8gZmV0Y2ggUENMSyBjbG9ja1xuIiwKPiAKCgotLSAKIDxodHRwOi8vd3d3LmxpbmFyby5v
cmcvPiBMaW5hcm8ub3JnIOKUgiBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3IgQVJNIFNvQ3MKCkZv
bGxvdyBMaW5hcm86ICA8aHR0cDovL3d3dy5mYWNlYm9vay5jb20vcGFnZXMvTGluYXJvPiBGYWNl
Ym9vayB8CjxodHRwOi8vdHdpdHRlci5jb20vIyEvbGluYXJvb3JnPiBUd2l0dGVyIHwKPGh0dHA6
Ly93d3cubGluYXJvLm9yZy9saW5hcm8tYmxvZy8+IEJsb2cKCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlz
dApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
