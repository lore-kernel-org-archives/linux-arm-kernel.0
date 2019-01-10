Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094E8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:20:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE53B206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pNcxujNC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="egquyVnI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE53B206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rmNrx2DAVm0nr0O/QqMni/rv1x19EOZ3y8vEMStDoOc=; b=pNcxujNCx0Iil3
	tUUHxyIZDySy6Iry9GuLB17VCaOu2nhdyQEeO0I/ahnj1hmnnXHtkMGjeyWY8j4PyzIpoc4DxgU2H
	gvLcLUYN/+sZBxjBmMHg4IppdUlKOv90FhNPS2s7wtB0g8lyvHCOIbJx/nUAP8TMF9qWSBTBIM+P4
	M31JDuILgfIb9P5wSkJJXnWIg6ya7SYbzhRpUbIq82YCIYmg8lh2sP9l1MyBCdRYR2YGKst7ME1q7
	s/MOPlMhCDg99WGr4ro81gMEL3V8B9GLTAfKOEfN0ZqPS3ZwqGA6TuOclFAg3uD0YeFrWdbDvN7VD
	GDqFJo3uubYJe3E20r5g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghWVN-0007NY-LH; Thu, 10 Jan 2019 09:20:01 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghWVK-0007MO-0G
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 09:19:59 +0000
Received: by mail-wm1-x343.google.com with SMTP id y185so12865643wmd.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 01:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=OD1+wIfwZ2uNgOTjuWtkujAAZ4dcxoAtRZ4lNOYiVCc=;
 b=egquyVnId82EkIKvId07s+fSw7l+2AjlQqHNCecA4S2nQDHzff2QlVWSfUM2xHimB9
 /WakPwhibPhy73FCxFurUDmLbaP+Uc5Is3SyfEVoMqZgrx2DcBRW/jeKTDCIAjBtN3ZT
 28Ldaz61ImMMUnsT8DmFnCoYZkH015Epcx2rg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OD1+wIfwZ2uNgOTjuWtkujAAZ4dcxoAtRZ4lNOYiVCc=;
 b=UxDUJK0PmMliN9qvCBmQgL9uJjjreHwYgp6ALRXU5VA44Y7n8tvIJx7w0T1KLo9xUN
 +6/qq06+3EgwSUs3+cSlHxY73XtF3g8vAPwvgkirp5sw1IoPLRswlHBPJEDMe1uHVL3u
 MTN3LFpCG4yiEq42Psi2E0WsOShLuh+Q019pkwAhN5ie3akH/iW96/dBFRgekAFidrQk
 UVv8l6q9brR6CFDk15we+NGM5Z5JfgpGg4iOhGQoYiWwtpPOIDqqNLIV91/5GsCVPfKm
 dU7Yl+mOWQfqR7ilTM6/a5omdH5/qSrMP6Tb6BVpJ7vQz4WBuykLZW+XlOgmWjWHOb+E
 kVwg==
X-Gm-Message-State: AJcUukcy/+UYiEmfLLqHhBYFn2xtQvnxpsyLyWp1cOxlNs8eqjFWyP7W
 KT5oC578qPFwbPQ8o63A7VawAA==
X-Google-Smtp-Source: ALg8bN6tEh5EhBT5omEz7Hlc8aEQQx5yjIeWSrZgfyhC4eiRkPaneW9viQlLWuEP53B7ZVwmHacr6w==
X-Received: by 2002:a1c:e287:: with SMTP id z129mr8908212wmg.71.1547111994333; 
 Thu, 10 Jan 2019 01:19:54 -0800 (PST)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net.
 [78.210.255.2])
 by smtp.googlemail.com with ESMTPSA id q14sm49768464wrw.39.2019.01.10.01.19.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 10 Jan 2019 01:19:53 -0800 (PST)
Subject: Re: [PATCH] clocksource: sun5i: fail gracefully when clock rate is
 unavailable
To: Chen-Yu Tsai <wens@csie.org>, Thomas Gleixner <tglx@linutronix.de>,
 Maxime Ripard <maxime.ripard@bootlin.com>
References: <20190110062207.18787-1-wens@csie.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <0f9b4bc0-6969-97d3-8ac6-63931ea6db92@linaro.org>
Date: Thu, 10 Jan 2019 10:19:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190110062207.18787-1-wens@csie.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_011958_042583_76043083 
X-CRM114-Status: GOOD (  14.78  )
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
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMTAvMDEvMjAxOSAwNzoyMiwgQ2hlbi1ZdSBUc2FpIHdyb3RlOgo+IElmIHRoZSBjbG9jayB0
cmVlIGlzIG5vdCBmdWxseSBwb3B1bGF0ZWQgd2hlbiB0aGUgdGltZXItc3VuNWkgaW5pdCBjb2Rl
Cj4gaXMgY2FsbGVkLCBhdHRlbXB0cyB0byBnZXQgdGhlIGNsb2NrIHJhdGUgZm9yIHRoZSB0aW1l
ciB3b3VsZCBmYWlsIGFuZAo+IHJldHVybiAwLgo+IAo+IE1ha2UgdGhlIGluaXQgY29kZSBmb3Ig
Ym90aCBjbG9jayBldmVudHMgYW5kIGNsb2Nrc291cmNlIGNoZWNrIHRoZQo+IHJldHVybmVkIGNs
b2NrIHJhdGUgYW5kIGZhaWwgZ3JhY2VmdWxseSBpZiB0aGUgcmVzdWx0IGlzIDAsIGluc3RlYWQg
b2YKPiBjYXVzaW5nIGEgZGl2aWRlIGJ5IDAgZXhjZXB0aW9uIGxhdGVyIG9uLgo+IAo+IEZpeGVz
OiA0YTU5MDU4ZjBiMDkgKCJjbG9ja3NvdXJjZS9kcml2ZXJzL3N1bjVpOiBSZWZhY3RvciB0aGUg
Y3VycmVudCBjb2RlIikKPiBTaWduZWQtb2ZmLWJ5OiBDaGVuLVl1IFRzYWkgPHdlbnNAY3NpZS5v
cmc+Cj4gLS0tCgpBcHBsaWVkIHRoYW5rcy4KLS0gCiA8aHR0cDovL3d3dy5saW5hcm8ub3JnLz4g
TGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFSTSBTb0NzCgpGb2xsb3cg
TGluYXJvOiAgPGh0dHA6Ly93d3cuZmFjZWJvb2suY29tL3BhZ2VzL0xpbmFybz4gRmFjZWJvb2sg
fAo8aHR0cDovL3R3aXR0ZXIuY29tLyMhL2xpbmFyb29yZz4gVHdpdHRlciB8CjxodHRwOi8vd3d3
LmxpbmFyby5vcmcvbGluYXJvLWJsb2cvPiBCbG9nCgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
