Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE7BC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:39:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EA69218A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Njuw4tar";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gL5Xl8NE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EA69218A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZPk1492d2/dVobRPA2F3X7XJaEk/TI3hp8TJe9LlE8s=; b=Njuw4tarUf80XK
	asre765vejk71RqUfe4g97GlQ1V3n0b54wPzMTAVh2KuMk0XrGq4TpCbvP9sjwvgkrk5ztjj+yKF9
	IgzrajXer75jX/TUeK8YGNnNXVvHfaGKKfADX4k3GTA431VqiylkQQMkF8SI38Pd+8TpxDp+pVKCm
	MuLJtjqIcziq9rnN0eOgQR0J8IQ6xnxGxTTbM9cS9tixewuomxAF5a9t4Hw7AvXJOE6dvoXjUn8LR
	Z8Jer4lC2i/xLmbVmdlgKVp2naXACRv7536lXcicGY6wpcBIxYJPxrz2VDHeiBmBb/QgKG4YXNqEy
	PGvevjenC/0SZNCZae0w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmbTX-000254-S3; Thu, 24 Jan 2019 09:39:07 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmbTS-00024E-Ig
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 09:39:05 +0000
Received: by mail-wm1-x341.google.com with SMTP id m1so2359377wml.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 01:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ac25Jice3h57eN8pcoXDQoHQmIr/VFnVEN4NgR0MbIE=;
 b=gL5Xl8NEau35LRK76hrQ5Q/CBwWDgAXYV4mn7ZLVcwLVR3v3Md/Kfs88A41gIDzhLx
 g0H8vdBYGfNaBriR/ve/XowBen0lK2BVRDXtX7jnqii1W0fy5Jc7EILUes4otY/1buYf
 7OUUzkOYcuh6YzYxpT8LoZ6pM9mpqidVErBo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ac25Jice3h57eN8pcoXDQoHQmIr/VFnVEN4NgR0MbIE=;
 b=PEhYxU5H2s8cRWNVBjkqki7cM2lVpvunzPphUJ+tMtj0QhZeGQ05FrWYU+/lHvHC/v
 vKU6dxZhGN8NcG2iEQgu2kVI3dM8OwQ3D0apXyFcSH+1dqkpyhXbNObNWHr6PBHyHwvi
 ELwS+xMl7eBV+o/aZ2yM4OFprT6cyu8RlA/+Fgt7igueIyHlVnT9yAdmcnlqepTHbPHs
 mQ2cY94o71uP6bCxcuSkfPy5XxhLDeJayJAXckHgLBomu1Q/N8iRTeMxoB00zZS7M62i
 YCDEOSj8pUY9Fr21WdaXZk/NxMz7bqHAo1fE1+2zyn9j5vSl7gNF2M1NyKe6x0ZbMRlB
 zFQA==
X-Gm-Message-State: AJcUukeYKBITye6MPjUE2z3hVRB7tEYTiTpOmHblTaPjhsQTbUK4C5AF
 F74UiWpkSp1ca5Blx1UVyYyD4w==
X-Google-Smtp-Source: ALg8bN4gdFyPqXJTlM7m3OH7VDeRz4DCRS0JJH2Wj3Bu6f4n35ugwQL/Ts9EklpqX+ZBTBXVTcAAjQ==
X-Received: by 2002:a1c:2787:: with SMTP id n129mr1910087wmn.128.1548322740193; 
 Thu, 24 Jan 2019 01:39:00 -0800 (PST)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net.
 [78.210.255.2])
 by smtp.googlemail.com with ESMTPSA id h10sm54334751wmf.44.2019.01.24.01.38.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Jan 2019 01:38:59 -0800 (PST)
Subject: Re: [PATCH] clocksource: sun5i: fail gracefully when clock rate is
 unavailable
To: Chen-Yu Tsai <wens@csie.org>
References: <20190110062207.18787-1-wens@csie.org>
 <0f9b4bc0-6969-97d3-8ac6-63931ea6db92@linaro.org>
 <CAGb2v65RJ2iwTr1bxXxXAROLtg2a1KP2x36uXpjGs=r38NrM6g@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <c00394ec-4817-629d-2a92-e62a7f2d31ab@linaro.org>
Date: Thu, 24 Jan 2019 10:38:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAGb2v65RJ2iwTr1bxXxXAROLtg2a1KP2x36uXpjGs=r38NrM6g@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_013902_614109_5C298B94 
X-CRM114-Status: GOOD (  14.47  )
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
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMjQvMDEvMjAxOSAwOTo1NiwgQ2hlbi1ZdSBUc2FpIHdyb3RlOgo+IE9uIFRodSwgSmFuIDEw
LCAyMDE5IGF0IDU6MTkgUE0gRGFuaWVsIExlemNhbm8KPiA8ZGFuaWVsLmxlemNhbm9AbGluYXJv
Lm9yZz4gd3JvdGU6Cj4+Cj4+IE9uIDEwLzAxLzIwMTkgMDc6MjIsIENoZW4tWXUgVHNhaSB3cm90
ZToKPj4+IElmIHRoZSBjbG9jayB0cmVlIGlzIG5vdCBmdWxseSBwb3B1bGF0ZWQgd2hlbiB0aGUg
dGltZXItc3VuNWkgaW5pdCBjb2RlCj4+PiBpcyBjYWxsZWQsIGF0dGVtcHRzIHRvIGdldCB0aGUg
Y2xvY2sgcmF0ZSBmb3IgdGhlIHRpbWVyIHdvdWxkIGZhaWwgYW5kCj4+PiByZXR1cm4gMC4KPj4+
Cj4+PiBNYWtlIHRoZSBpbml0IGNvZGUgZm9yIGJvdGggY2xvY2sgZXZlbnRzIGFuZCBjbG9ja3Nv
dXJjZSBjaGVjayB0aGUKPj4+IHJldHVybmVkIGNsb2NrIHJhdGUgYW5kIGZhaWwgZ3JhY2VmdWxs
eSBpZiB0aGUgcmVzdWx0IGlzIDAsIGluc3RlYWQgb2YKPj4+IGNhdXNpbmcgYSBkaXZpZGUgYnkg
MCBleGNlcHRpb24gbGF0ZXIgb24uCj4+Pgo+Pj4gRml4ZXM6IDRhNTkwNThmMGIwOSAoImNsb2Nr
c291cmNlL2RyaXZlcnMvc3VuNWk6IFJlZmFjdG9yIHRoZSBjdXJyZW50IGNvZGUiKQo+Pj4gU2ln
bmVkLW9mZi1ieTogQ2hlbi1ZdSBUc2FpIDx3ZW5zQGNzaWUub3JnPgo+Pj4gLS0tCj4+Cj4+IEFw
cGxpZWQgdGhhbmtzLgo+IAo+IEknbSBub3Qgc2VlaW5nIHRoaXMgaW4gbGludXgtbmV4dCwgbm9y
IHRoZSBwYXRjaAo+IAo+ICAgICBhcm02NDogYXJjaF90aW1lcjogV29ya2Fyb3VuZCBmb3IgQWxs
d2lubmVyIEE2NCB0aW1lciBpbnN0YWJpbGl0eQo+IAo+IEFueSBpZGVhIHdoZXJlIHRoZXNlIGVu
ZGVkIHVwPwoKWWVhaCwgSSBoYXZlIGEgcm91Z2ggaWRlYS4gVGhleSBhcmUgbm93IGluIGxpbnV4
LW5leHQgdmlhIHRoZQpjbG9ja2V2ZW50cy9uZXh0IGJyYW5jaC4KCgoKCi0tIAogPGh0dHA6Ly93
d3cubGluYXJvLm9yZy8+IExpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBB
Uk0gU29DcwoKRm9sbG93IExpbmFybzogIDxodHRwOi8vd3d3LmZhY2Vib29rLmNvbS9wYWdlcy9M
aW5hcm8+IEZhY2Vib29rIHwKPGh0dHA6Ly90d2l0dGVyLmNvbS8jIS9saW5hcm9vcmc+IFR3aXR0
ZXIgfAo8aHR0cDovL3d3dy5saW5hcm8ub3JnL2xpbmFyby1ibG9nLz4gQmxvZwoKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwg
bWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
