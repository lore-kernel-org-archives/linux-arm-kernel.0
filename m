Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABDFCC282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:08:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BE5F2073D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jKugfagO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fGEQslgv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BE5F2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oQ3uPNmc183V/P8DcutbIiaHak2xGoDPJ/aeuJ+tD3Y=; b=jKugfagOg4/xni
	NpajhpAHgzFKBK/EZbKeK9dUxdEIqzeunn0RsjJHNVE/2a9KGN0UotfMNkcO2qsKbBjmQv948Q2/T
	Sgu6G0Kk3AaTNSev3hT/Eja4TSv/krO7+vWt/9fB4MMZmly1KHU2vRvugsGYO6BE+PyL9sYqFGF83
	x5FfpZWtQj13nnFZd1IsWFyOQPXe1crWL/yyFVGQArJAjCVTfN2Y8Vgmuwb9jOsnhXhKmVK41Loem
	hWZ0E5VFMDBZ3dBfew4WARRFiReF9w+wXMskLmJE2R1iEvOxV7tnB2MEiuTVuUN8Scz7jxXYoNR8x
	dCqd1udH86avsYKt1ZGA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtU3T-0003qw-8M; Tue, 12 Feb 2019 09:08:39 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtU3O-0003qV-Oq
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 09:08:36 +0000
Received: by mail-wr1-x444.google.com with SMTP id t27so1768369wra.6
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 01:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+BEHkIPnxNuYl01r30SPtz0G+P4sqTbcQQD+CaNVvT0=;
 b=fGEQslgvp5BuSUYCAlrp/WIkjDro0BmuGUycmttu3qbr32RQC77zY6M2V8+Sy/1DP8
 o37yH47oltnsZWNqbrSIlxh1VUCB/WQnYT1RemwwMHRTa4ryksN5jqBfwNdAcX+lSIZJ
 ZQjQgFYRDfAMkgi+3DRLibAljYaAxWnJq2XmTsxv6mW0pYllR0gCUPtjWiftrJomTifF
 W0lvxP/qizR+yl92mL3yK/HiLvath+AR/2PiaKh71PRS14JqqkxS7zNKggJeVoYQKZKp
 zUHUF18T3BN7a+cc1u0EZi6+6oAlrZUlvKPvbv9/s+QlzAfJ5DHSRnZG9TwWJE5Suyhl
 6UgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+BEHkIPnxNuYl01r30SPtz0G+P4sqTbcQQD+CaNVvT0=;
 b=KzyAMLj/jLmrkgcoPrua0JH+LGGXTOZ3/14UrU9TkimgiZS3ifKQs61X4FxHpiEPad
 Z0WTyelbe09D9zDjEX4QHQVxtS48NOV3GrnEquD8hZcIz+l3rFD1kP1zeyDbcn7nYBO1
 fhNu/vT6HxmUWpzBXd28lzYGkuth9y7s+u1lhkeBvDC7okctGYKT4lr5sP6IcaULdJYb
 SbBqRBSXSkx07jPe+6Ee7PcKoWP2V7vDS8OfvZ3+y/tTa2hXAl4ev6BoGD/KBOVt6nef
 m6BiJIE6nbYaPkmIaB0fx2erE/pQEIopxyZ1p/Q2q8DNDiv0UiTtDfQ/YTVgGrRGnFUj
 345w==
X-Gm-Message-State: AHQUAubBYvm3faOnSX1u7QGccJFDH1Bw9FLZBPEWvSvVzKQFHCBEVWQB
 3UxhPCpIHaRmzSbgkkjubErJMw==
X-Google-Smtp-Source: AHgI3Ia9S+X22vR7/yzpqJkACZGunUCgZnKuZ26IMIVPZhvf+gDHAdSfHEY4KiVOJZn4KkjiRMdX2g==
X-Received: by 2002:a5d:4149:: with SMTP id c9mr2118936wrq.58.1549962512843;
 Tue, 12 Feb 2019 01:08:32 -0800 (PST)
Received: from [192.168.27.65] (sju31-1-78-210-255-2.fbx.proxad.net.
 [78.210.255.2])
 by smtp.googlemail.com with ESMTPSA id r22sm2566097wmh.2.2019.02.12.01.08.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 01:08:31 -0800 (PST)
Subject: Re: [PATCH 1/3] clocksource: timer-ti-dm: Fix pwm dmtimer usage of
 fck reparenting
To: Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org
References: <20190122175717.13428-1-tony@atomide.com>
 <20190122175717.13428-2-tony@atomide.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <00e47cf9-b444-4fcf-0d1a-11ff61edf008@linaro.org>
Date: Tue, 12 Feb 2019 10:08:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190122175717.13428-2-tony@atomide.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_010834_850228_432AAF47 
X-CRM114-Status: GOOD (  21.12  )
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
Cc: Ladislav Michl <ladis@linux-mips.org>, Keerthy <j-keerthy@ti.com>,
 Sebastian Reichel <sre@kernel.org>, Tero Kristo <t-kristo@ti.com>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>, Pavel Machek <pavel@ucw.cz>,
 "H . Nikolaus Schaller" <hns@goldelico.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMjIvMDEvMjAxOSAxODo1NywgVG9ueSBMaW5kZ3JlbiB3cm90ZToKPiBDb21taXQgODRiYWRj
NWVjNWZjICgiQVJNOiBkdHM6IG9tYXA0OiBNb3ZlIGw0IGNoaWxkIGRldmljZXMgdG8gcHJvYmUK
PiB0aGVtIHdpdGggdGktc3lzYyIpIG1vdmVkIHNvbWUgb21hcDQgdGltZXJzIHRvIHByb2JlIHdp
dGggdGktc3lzYwo+IGludGVyY29ubmVjdCB0YXJnZXQgbW9kdWxlLiBUdXJucyBvdXQgdGhpcyBi
cm9rZSBwd20tb21hcC1kbXRpbWVyCj4gd2hlcmUgd2Ugbm93IHRyeSB0byByZXBhcmVudCB0aGUg
Y2xvY2sgdG8gaXRzZWxmIHdpdGggdGhlIGZvbGxvd2luZzoKPiAKPiBvbWFwX2RtX3RpbWVyX29m
X3NldF9zb3VyY2U6IGZhaWxlZCB0byBzZXQgcGFyZW50Cj4gCj4gV2l0aCB0aS1zeXNjLCB3ZSBj
YW4gbm93IGNvbmZpZ3VyZSB0aGUgY2xvY2sgc291cmNlcyBpbiB0aGUgZHRzCj4gd2l0aCBhc3Np
Z25lZC1jbG9ja3MgYW5kIGFzc2lnbmVkLWNsb2NrLXBhcmVudHMuIFNvIHdlIHNob3VsZCBiZSBh
YmxlCj4gdG8gcmVtb3ZlIG9tYXBfZG1fdGltZXJfb2Zfc2V0X3NvdXJjZSB3aXRoIGNsZWFuLXVw
IHBhdGNoZXMgbGF0ZXIgb24uCj4gQnV0IGZvciBub3csIGxldCdzIGp1c3QgZml4IGl0IGZpcnN0
IGJ5IGNoZWNraW5nIGlmIHBhcmVudCBhbmQgZmNrCj4gYXJlIHRoZSBzYW1lIGFuZCBiYWlsIG91
dCBvZiBzby4KPiAKPiBGaXhlczogODRiYWRjNWVjNWZjICgiQVJNOiBkdHM6IG9tYXA0OiBNb3Zl
IGw0IGNoaWxkIGRldmljZXMgdG8gcHJvYmUKPiB0aGVtIHdpdGggdGktc3lzYyIpCj4gQ2M6IEJh
cnRvc3ogR29sYXN6ZXdza2kgPGJnb2xhc3pld3NraUBiYXlsaWJyZS5jb20+Cj4gQ2M6IERhbmll
bCBMZXpjYW5vIDxkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnPgo+IENjOiBILiBOaWtvbGF1cyBT
Y2hhbGxlciA8aG5zQGdvbGRlbGljby5jb20+Cj4gQ2M6IEtlZXJ0aHkgPGota2VlcnRoeUB0aS5j
b20+Cj4gQ2M6IExhZGlzbGF2IE1pY2hsIDxsYWRpc0BsaW51eC1taXBzLm9yZz4KPiBDYzogUGF2
ZWwgTWFjaGVrIDxwYXZlbEB1Y3cuY3o+Cj4gQ2M6IFNlYmFzdGlhbiBSZWljaGVsIDxzcmVAa2Vy
bmVsLm9yZz4KPiBDYzogVGVybyBLcmlzdG8gPHQta3Jpc3RvQHRpLmNvbT4KPiBDYzogVGhpZXJy
eSBSZWRpbmcgPHRoaWVycnkucmVkaW5nQGdtYWlsLmNvbT4KPiBDYzogVGhvbWFzIEdsZWl4bmVy
IDx0Z2x4QGxpbnV0cm9uaXguZGU+Cj4gUmVwb3J0ZWQtYnk6IEguIE5pa29sYXVzIFNjaGFsbGVy
IDxobnNAZ29sZGVsaWNvLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBUb255IExpbmRncmVuIDx0b255
QGF0b21pZGUuY29tPgo+IC0tLQoKRG8geW91IHdhbnQgbWUgdG8gdGFrZSBpdCB0aHJvdWdoIG15
IHRyZWUgKDEgZXQgMyk/Cgo+ICBkcml2ZXJzL2Nsb2Nrc291cmNlL3RpbWVyLXRpLWRtLmMgfCA0
ICsrKysKPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2Nsb2Nrc291cmNlL3RpbWVyLXRpLWRtLmMgYi9kcml2ZXJzL2Nsb2Nrc291cmNl
L3RpbWVyLXRpLWRtLmMKPiAtLS0gYS9kcml2ZXJzL2Nsb2Nrc291cmNlL3RpbWVyLXRpLWRtLmMK
PiArKysgYi9kcml2ZXJzL2Nsb2Nrc291cmNlL3RpbWVyLXRpLWRtLmMKPiBAQCAtMTU0LDYgKzE1
NCwxMCBAQCBzdGF0aWMgaW50IG9tYXBfZG1fdGltZXJfb2Zfc2V0X3NvdXJjZShzdHJ1Y3Qgb21h
cF9kbV90aW1lciAqdGltZXIpCj4gIAlpZiAoSVNfRVJSKHBhcmVudCkpCj4gIAkJcmV0dXJuIC1F
Tk9ERVY7Cj4gIAo+ICsJLyogQmFpbCBvdXQgaWYgYm90aCBjbG9ja3MgcG9pbnQgdG8gZmNrICov
Cj4gKwlpZiAoY2xrX2lzX21hdGNoKHBhcmVudCwgdGltZXItPmZjbGspKQo+ICsJCXJldHVybiAw
Owo+ICsKPiAgCXJldCA9IGNsa19zZXRfcGFyZW50KHRpbWVyLT5mY2xrLCBwYXJlbnQpOwo+ICAJ
aWYgKHJldCA8IDApCj4gIAkJcHJfZXJyKCIlczogZmFpbGVkIHRvIHNldCBwYXJlbnRcbiIsIF9f
ZnVuY19fKTsKPiAKCgotLSAKIDxodHRwOi8vd3d3LmxpbmFyby5vcmcvPiBMaW5hcm8ub3JnIOKU
giBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3IgQVJNIFNvQ3MKCkZvbGxvdyBMaW5hcm86ICA8aHR0
cDovL3d3dy5mYWNlYm9vay5jb20vcGFnZXMvTGluYXJvPiBGYWNlYm9vayB8CjxodHRwOi8vdHdp
dHRlci5jb20vIyEvbGluYXJvb3JnPiBUd2l0dGVyIHwKPGh0dHA6Ly93d3cubGluYXJvLm9yZy9s
aW5hcm8tYmxvZy8+IEJsb2cKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
