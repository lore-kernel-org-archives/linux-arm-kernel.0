Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14160C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:11:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D36692184A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Kf3VdjxM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="B8aD/Kvm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D36692184A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=m5qfw1OJEqqtUvEl1adzQUgKzuFFFlUVKQhPiaPMuGo=; b=Kf3VdjxMvAwv/N
	q2/MgEITOy0dohvsX5vmQPufaiAuoP6JU6IqfaXkbjmLSlUD8q3i6vh4UNsDK/4W1H3J98pc/23as
	UAEQhAR3IqK/jOenuZo0M+QePCAx9hGbXe2S9rFU1hs+QaAiFzbJDll3WFojSFbDAY2uhtg3hOIzX
	5w6ZcRFqogk+rWHFClf8rsXmN9fFBXsDK1FSPLsKLNFDJ5kIJPT6aOMxGATp29CtF8C/xzqZR7ARm
	mu9dsJxpHmmGY83M6c9YND8ARMXhzPWJ4yGFPVOxweLLJ+gBvUERXYSmShB22Dy8RowdpluzFBAdR
	7JrW/uvH9VujkzOy8TUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZahD-0003SI-U3; Wed, 19 Dec 2018 12:11:27 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZahA-0003Qo-SP
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 12:11:26 +0000
Received: by mail-wm1-x342.google.com with SMTP id a62so5845457wmh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 19 Dec 2018 04:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=MJgigoAEMRh0bL7kvRBa2oK6duFi0d/HTVCR+ewvWPY=;
 b=B8aD/Kvm88qVdxu7bJxpA4AspuneOKh8r9RPhZ17P3b0JYxbxLbyJ3D3k5OUkVbn69
 VLudeH0ZKSB8AwyYo/BZ3d9EbyVwhB3dyJLqWI2GOuNZVvNRfS6xgnFv0TJSLtkYcQUi
 3BUnmkKIIMGva2hL5M0J+yuuD6lef/JZv8BOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MJgigoAEMRh0bL7kvRBa2oK6duFi0d/HTVCR+ewvWPY=;
 b=b8cOcchg0TetJMPVsMa0XEprxHyAPc87Zke3QSWJx94tzYoT70Jpgd+k/+P8jDMxni
 bnOrl+0uy2fsRhINiUyxSiso4oxtXajWQ3Y3HkXsseCM2qI0Bm/zdSelNqN2qiwNaMVI
 S9G5cafgGDXB5Kog77FDpLM1piEcwJfw30NehQaVXGB52R7nMP4QQj0PGMkKflapkrT/
 EUxQb/gbd6HEY723VamMA644xhmsj4Dp+RWS6/IUKNz2CEdjpRqlzktdKpAFPwdDiJ9Y
 aLdCxT8rjDTzwSaLfWamTYYFuPiYlhP55QirFwvjQMRowa+S358tZg+OrZC3DrlCcexw
 V8kw==
X-Gm-Message-State: AA+aEWZuIw6W5cf/+pT/R5sCsXi7e4ntUGNCfgp0w8IcCdUyC7eXVHlz
 gShhwgEW/SyhMWBa5i3w1hPoDg==
X-Google-Smtp-Source: AFSGD/WI3XwES6zzsqUn8GajK1G3BL3BuKDgDhDMsBWbvF+jjWkWk890aDsfxgI0Rb/5uxE9HynD/w==
X-Received: by 2002:a1c:aad2:: with SMTP id t201mr6831123wme.148.1545221472026; 
 Wed, 19 Dec 2018 04:11:12 -0800 (PST)
Received: from [192.168.0.40] (197.26.136.77.rev.sfr.net. [77.136.26.197])
 by smtp.googlemail.com with ESMTPSA id l19sm5411096wme.21.2018.12.19.04.11.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 19 Dec 2018 04:11:11 -0800 (PST)
Subject: Re: [PATCH v10 13/27] drivers: firmware: psci: Support hierarchical
 CPU idle states
To: Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla
 <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-14-ulf.hansson@linaro.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <a5c19c01-31d5-f703-663c-3d5bd2ea8201@linaro.org>
Date: Wed, 19 Dec 2018 13:11:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181129174700.16585-14-ulf.hansson@linaro.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_041124_922058_E2F3708A 
X-CRM114-Status: GOOD (  20.84  )
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
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Kevin Hilman <khilman@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org,
 Lina Iyer <ilina@codeaurora.org>, Tony Lindgren <tony@atomide.com>,
 Lina Iyer <lina.iyer@linaro.org>, linux-arm-msm@vger.kernel.org,
 "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMjkvMTEvMjAxOCAxODo0NiwgVWxmIEhhbnNzb24gd3JvdGU6Cj4gRnJvbTogTGluYSBJeWVy
IDxsaW5hLml5ZXJAbGluYXJvLm9yZz4KPiAKPiBDdXJyZW50bHkgQ1BVJ3MgaWRsZSBzdGF0ZXMg
YXJlIHJlcHJlc2VudGVkIGluIGEgZmxhdHRlbmVkIG1vZGVsLCB2aWEgdGhlCj4gImNwdS1pZGxl
LXN0YXRlcyIgYmluZGluZyBmcm9tIHdpdGhpbiB0aGUgQ1BVJ3MgZGV2aWNlIG5vZGVzLgo+IAo+
IFN1cHBvcnQgdGhlIGhpZXJhcmNoaWNhbCBsYXlvdXQsIHNpbXBseSBieSBjb252ZXJ0aW5nIHRv
IGNhbGxpbmcgdGhlIG5ldyBPRgo+IGhlbHBlciwgb2ZfZ2V0X2NwdV9zdGF0ZV9ub2RlKCkuCj4g
Cj4gQ2M6IExpbmEgSXllciA8aWxpbmFAY29kZWF1cm9yYS5vcmc+Cj4gU3VnZ2VzdGVkLWJ5OiBT
dWRlZXAgSG9sbGEgPHN1ZGVlcC5ob2xsYUBhcm0uY29tPgo+IFNpZ25lZC1vZmYtYnk6IExpbmEg
SXllciA8bGluYS5peWVyQGxpbmFyby5vcmc+Cj4gQ28tZGV2ZWxvcGVkLWJ5OiBVbGYgSGFuc3Nv
biA8dWxmLmhhbnNzb25AbGluYXJvLm9yZz4KPiBTaWduZWQtb2ZmLWJ5OiBVbGYgSGFuc3NvbiA8
dWxmLmhhbnNzb25AbGluYXJvLm9yZz4KPiAtLS0KCkZvbGQgaXQgd2l0aCAwNy8yNyA/Cgo+IAo+
IENoYW5nZXMgaW4gdjEwOgo+IAktIE5vbmUuCj4gCj4gLS0tCj4gIGRyaXZlcnMvZmlybXdhcmUv
cHNjaS9wc2NpLmMgfCAyICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBk
ZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Zpcm13YXJlL3BzY2kvcHNjaS5j
IGIvZHJpdmVycy9maXJtd2FyZS9wc2NpL3BzY2kuYwo+IGluZGV4IGNiZmM5MzZkMjUxYy4uNjMx
ZTIwNzIwYTIyIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZmlybXdhcmUvcHNjaS9wc2NpLmMKPiAr
KysgYi9kcml2ZXJzL2Zpcm13YXJlL3BzY2kvcHNjaS5jCj4gQEAgLTMwMCw3ICszMDAsNyBAQCBz
dGF0aWMgaW50IHBzY2lfZHRfY3B1X2luaXRfaWRsZShzdHJ1Y3QgY3B1aWRsZV9kcml2ZXIgKmRy
diwKPiAgCQlyZXR1cm4gLUVOT01FTTsKPiAgCj4gIAlmb3IgKGkgPSAwOyBpIDwgbnVtX3N0YXRl
X25vZGVzOyBpKyspIHsKPiAtCQlzdGF0ZV9ub2RlID0gb2ZfcGFyc2VfcGhhbmRsZShjcHVfbm9k
ZSwgImNwdS1pZGxlLXN0YXRlcyIsIGkpOwo+ICsJCXN0YXRlX25vZGUgPSBvZl9nZXRfY3B1X3N0
YXRlX25vZGUoY3B1X25vZGUsIGkpOwo+ICAJCWlmICghc3RhdGVfbm9kZSkKPiAgCQkJYnJlYWs7
Cj4gIAo+IAoKCi0tIAogPGh0dHA6Ly93d3cubGluYXJvLm9yZy8+IExpbmFyby5vcmcg4pSCIE9w
ZW4gc291cmNlIHNvZnR3YXJlIGZvciBBUk0gU29DcwoKRm9sbG93IExpbmFybzogIDxodHRwOi8v
d3d3LmZhY2Vib29rLmNvbS9wYWdlcy9MaW5hcm8+IEZhY2Vib29rIHwKPGh0dHA6Ly90d2l0dGVy
LmNvbS8jIS9saW5hcm9vcmc+IFR3aXR0ZXIgfAo8aHR0cDovL3d3dy5saW5hcm8ub3JnL2xpbmFy
by1ibG9nLz4gQmxvZwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LWFybS1rZXJuZWwK
