Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DD6C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:23:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D547A214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="COkbQmP5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HZ68djD0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D547A214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=zl3YsMg/ZeYv12dX04WhnteXTN+hyH1YvO8/RVLD+BA=; b=COkbQmP5kCjNDJS7hHMUPuDmvP
	j+14KSlyNxo8j2cOgPaM/fETEO6BpypqM2GtD81VXYvevqptt4IMSpfyM0cEXNXuV+IEYvc8m1p8H
	+TTs4AviDryP3JvfwNZrWFm8n40x+zZgcwr3Mji0uKpaEA+lo1L7x4SNh1TNGiOmUObWzUFlFl5c+
	0HfpaZwkfuS7th04YvPwWu64kgEHZcgKhkT3ftfTNLh3ls27Y1/sKx3PSjLZkx6uMUSC+4eEHlq3M
	Vr8Tg772K74v3vnCV75sWPUpIh8PP20SFMSWRqqBe4D8u1M+muRwUXO9PgOfto1OayfS+L/PKCBwH
	KEbjUyrg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt9gP-00036I-5M; Mon, 11 Feb 2019 11:23:29 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt9gK-00035Z-Ke
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 11:23:26 +0000
Received: by mail-wm1-x343.google.com with SMTP id b11so17182796wmj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 03:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=1j8bbri+HycsAw075of8V538dATVxD2rYwR0snuO0hQ=;
 b=HZ68djD0khJp7NqjFVusFF7uYDgrF1G9z0vyIMxB/DAx4aDZ2JjkywosAfGts5cceW
 +SVb4+RH58RAoiVt8rznPdRKGDVtoUlWnXgU7mK628VyABLx4bmpQl9yWo4Zd+2bgWgr
 5zDVR7pSFA7Gk/wJEJzgdagoEmzR5efLefBq/1fCKd/W6RyCYDHXLO98RH4zQemg2uI/
 oktf8nhGnl61Gq8EIvYlucYmbQH2EpDZmuFXbR6Wr9DSWyQ/sLIMdPwDZq68lZJAitGS
 tTk47U2e7eihwe8BJzH65uOvOi7YfDdxcQcJuxeXwELHQOsv9ffscw7nssEEpJJUr1Os
 gHiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1j8bbri+HycsAw075of8V538dATVxD2rYwR0snuO0hQ=;
 b=Dn7hNHaPNq+fGVZVtty4+2CAaNIiqm9i97OmPR4OCM56dUTJjPcQX7+f1ONnG5RUi7
 X7cMFyHDYIYY0f5MsB3ySVYPOVe8/NsplkwM5G4eda3x+PeCPLoRUNQWkOPRzh349Fee
 5qR5Mwb2OlFmAFXsR7bfkhHZwHWT2/AfsEEVzHH8QuImEn8ZL2+V/t/LwbcqbsoN79RP
 C+1hp4qLWddt9nCR53UL0GkCqt7IVo4Jds/XvMxs00Wzp/WQ+pAvH113s9U+y0k5WEw7
 sf6U5QpTR8+s05+17MrkhKHh6T6fN2XKwEF2I1gv5r/V/oeeOvMHowkRsjeHq1gCOLzj
 55Og==
X-Gm-Message-State: AHQUAuavkkCfWOK2cogtqxNi0JP6jbUNDtMOaXhfYRV4vkWiCXlrLHGk
 OlJ3VZA99uo6wf2ewkp2SYv3hGjD9uo=
X-Google-Smtp-Source: AHgI3IbRwgJ0aPz+iUuzS5rkHVHBVKHu2InhZwU9uVT2jruPLroczSXeTIObS5eZpH9nbPtUUPPRWQ==
X-Received: by 2002:a5d:4e8c:: with SMTP id e12mr17846964wru.21.1549884202298; 
 Mon, 11 Feb 2019 03:23:22 -0800 (PST)
Received: from [192.168.0.41] (13.50.92.92.rev.sfr.net. [92.92.50.13])
 by smtp.googlemail.com with ESMTPSA id o18sm14814644wrg.40.2019.02.11.03.23.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 11 Feb 2019 03:23:21 -0800 (PST)
Subject: Re: [PATCH 0/2] Subject: [PATCH 0/2] clocksource: exynos_mct: Clear
 timer interrupt when shutting down
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 Stuart Menefy <stuart.menefy@mathembedded.com>,
 linux-samsung-soc@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <CGME20190210225147epcas3p4cedebfc5692274bc6135ceabbcf2642d@epcas3p4.samsung.com>
 <20190210225114.20110-1-stuart.menefy@mathembedded.com>
 <e22c175a-d88a-81a7-9faa-42bb4fe09a22@samsung.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <e3637f0f-1e72-db3a-f744-ade0e878cfc5@linaro.org>
Date: Mon, 11 Feb 2019 12:23:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <e22c175a-d88a-81a7-9faa-42bb4fe09a22@samsung.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_032324_706711_99BFFA8B 
X-CRM114-Status: GOOD (  16.56  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMTEvMDIvMjAxOSAwODoxNCwgTWFyZWsgU3p5cHJvd3NraSB3cm90ZToKPiBIaSBTdHVhcnQK
PiAKPiBPbiAyMDE5LTAyLTEwIDIzOjUxLCBTdHVhcnQgTWVuZWZ5IHdyb3RlOgo+PiBXaGVuIGRl
YnVnZ2luZyBzdXNwZW5kIHByb2JsZW1zIG9uIEV4eW5vcyA1MjYwLCBJIGhhZCBhIGxhcmdlIG51
bWJlcgo+PiBvZiBkZWJ1Z2dpbmcgcHJpbnRzIGdvaW5nIHRvIHRoZSBzZXJpYWwgcG9ydCBhZnRl
ciBpbnRlcnJ1cHRzCj4+IGhhZCBiZWVuIGRpc2FibGVkIGJ1dCBiZWZvcmUgdGhlIHRpbWVyIGlu
dGVycnVwdCB3YXMgc2h1dGRvd24uIFRoaXMKPj4gd2FzIGxvbmcgZW5vdWdoIGZvciBhIHRpbWVy
IHRpY2sgdG8gb2NjdXIsIGJ1dCBhcyBpbnRlcnJ1cHRzIHdlcmUKPj4gZGlzYWJsZWQgdGhlIElT
UiBkaWRuJ3QgcnVuLCBhbmQgc28gdGhlIGludGVycnVwdCB3YXNuJ3QgY2xlYXJlZC4KPj4gTGF0
ZXIgd2hlbiB0aGUgdGltZXIgd2FzIHNodXRkb3duIHRoZSBpbnRlcnJ1cHQgd2FzIGxlZnQgYXNz
ZXJ0ZWQgYW5kCj4+IHNvIHRoZSB3ZmkgYXQgdGhlIGhlYXJ0IG9mIHRoZSBzdXNwZW5kIGNvZGUg
ZGlkbid0IHdhaXQsIGNhdXNpbmcKPj4gdGhlIHN1c3BlbmQgdG8gZmFpbC4KPj4KPj4gQ3VycmVu
dGx5IHRoZSBjb2RlIHdoaWNoIHN0b3BzIHRoZSB0aW1lciB3aGVuIGl0IGlzIG9uIG9uZS1zaG90
IG1vZGUKPj4gYW5kIHRoZSBpbnRlcnJ1cHQgb2NjdXJzIGlzIGluIGV4eW5vczRfbWN0X3RpY2tf
Y2xlYXIoKSwgbWVhbmluZyBpZiB3ZQo+PiBjYWxsZWQgdGhpcyBmcm9tIHRoZSBzaHV0ZG93biBj
b2RlIGV4eW5vczRfbWN0X3RpY2tfc3RvcCgpIGNvdWxkIGJlCj4+IGNhbGxlZCB0d2ljZS4gU28g
Zmlyc3QgcmVzdHJ1Y3R1cmUgdGhlIGV4aXN0aW5nIGNvZGUsIHNvIHRoZSBjaGVjayBmb3IKPj4g
b25lLXNob3QgbW9kZSBhbmQgc3RvcHBpbmcgdGhlIHRpbWVyIGlzIG1vdmVkIHRvIHRoZSBJU1Is
IGxlYXZpbmcKPj4gZXh5bm9zNF9tY3RfdGlja19jbGVhcigpIGp1c3QgY2xlYXJpbmcgdGhlIGlu
dGVycnVwdCBmbGFnLgo+Pgo+PiBPbmNlIHRoaXMgaGFzIGJlZW4gZG9uZSBzaW1wbHkgY2FsbCBl
eHlub3M0X21jdF90aWNrX2NsZWFyKCkgZnJvbQo+PiBzZXRfc3RhdGVfc2h1dGRvd24oKS4KPiAK
PiBUaGlzIGFsc28gZml4ZXMgbXlzdGVyaW91cyBzdXNwZW5kIGZhaWx1cmVzIG9uIE9kcm9pZCBY
VTMvWFU0L0hDMSA6KQo+IAo+IFRlc3RlZC1ieTogTWFyZWsgU3p5cHJvd3NraSA8bS5zenlwcm93
c2tpQHNhbXN1bmcuY29tPgoKQXBwbGllZC4gU2hhbGwgSSBhZGQgdGhlIHN0YWJsZUAgdGFnPwoK
Ci0tIAogPGh0dHA6Ly93d3cubGluYXJvLm9yZy8+IExpbmFyby5vcmcg4pSCIE9wZW4gc291cmNl
IHNvZnR3YXJlIGZvciBBUk0gU29DcwoKRm9sbG93IExpbmFybzogIDxodHRwOi8vd3d3LmZhY2Vi
b29rLmNvbS9wYWdlcy9MaW5hcm8+IEZhY2Vib29rIHwKPGh0dHA6Ly90d2l0dGVyLmNvbS8jIS9s
aW5hcm9vcmc+IFR3aXR0ZXIgfAo8aHR0cDovL3d3dy5saW5hcm8ub3JnL2xpbmFyby1ibG9nLz4g
QmxvZwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxp
bnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LWFybS1rZXJuZWwK
