Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0D7C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:47:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 092002190C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T5isXbes";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wzwe1Fwg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 092002190C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qr8Jh5OY2LfVbiYLhteANL4tBKshRxZphBtrgxg7kaQ=; b=T5isXbesa/Ms4u
	BH6kMeXupCVqfh8SMg0ZYEKPdsQyGlJ3nGLmc1Z7Z7S0gAeEiIRuJxH6ITuaT9YhcBm3kXsZuQav7
	zXSMeVAMxE8mrhV6+9anmsfvdmZndXijkZV6WonQXrS9SavZBYJstXl8GdA25Vw0BC97aqTUI3rGO
	fA2gUzYwArhdnNyzxAyaqEeGEapqaJmXRRl0hiAqFST3C5ij+4Lj2Naed5T2Wk5otpJ7dELbdcQt+
	yldNkfuvF8YE78tDwK1kBg2JFaPTwtd2zG2dJI1sxvq3ysAw6KF2dLH1uUIMD+JFBJb8oJIoTZlIw
	fUBqXZHoAmH5h7NOA/Qw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gufiC-0002Hs-3T; Fri, 15 Feb 2019 15:47:36 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gufi9-0002HV-46
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 15:47:34 +0000
Received: by mail-wm1-x342.google.com with SMTP id j125so10081372wmj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 07:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=RMUun5stcbAUFaPEFDyyPGTheX43f20qFfrpWKgUyO4=;
 b=wzwe1FwgzrnK/5AnAgiUcOmo+l5Y/wTtL5jlsoamzD79KHZLe/MRp0y3y4geUDdzo2
 wCX2/xbToFxFDaA1HKM+zcCSNTbS+rZiXhpAY8L1EjFPBIxOrFAxKcQLG3H5ZYSUVBdA
 YAAoiVS3grJMhNEsDzMnnEH6rLOIOh+QRAmddQA6fUglW+nzZDM/cI9zBECaQxw6/dgG
 NAaGXv60SGR8YXtJoRk9BHpujVXrdOCKj0j0byxWrK7mnqdHfmX/3Eeur+0TdN7R5q0I
 wrt5zxokdPeSoH/ogs6fsTMllJ9inhLAEFb/Y529EZrdhpTRszzz145zdImnjtP7F2KT
 PFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RMUun5stcbAUFaPEFDyyPGTheX43f20qFfrpWKgUyO4=;
 b=SSn/ZHKNjcgq7LEp3wdFF67Eroos4N1XHqaqJEN1t6KTAVriYLqEVi3u0eGAgiyKQi
 HJ2sGbs4rz0HwwX+8bJQQp3JvI6udzdqZF4HEOToK4kuT9fgVzZg6qRBl/SM5QEIu/A8
 FUHuRUE906HwRfTMPZVl1i4RvxvQGJi2TapHQzCC8hSnlJqEEcS24689IR4mA8eh9Vmw
 JgrnmDRKnJrY6+7DioqoaIoqjUKSCOeBz3ZKG3PGWiWZ+GipzIPHkTYMCTN4oTwG7rUY
 4+8cDEweX24N57/tfh+hVZMKpi6RF3b5cw938Gbqd3qPmC5SS/JJHsaVQF/YI6Uf9Pzr
 nyhA==
X-Gm-Message-State: AHQUAubfCGTufa5aoTct7OTataJ6T5SN1buOgFb2aU3+WW8OhD6oSjbt
 IdPsXEH4bG5xk+GDCk38UmGz5Yu4dEg=
X-Google-Smtp-Source: AHgI3IZjK0lXSUgxpqAbHZMJhpk4m39ObgwTlM4RhaMg9VG/kO6LWnVErDlDMDeNKg8MtDXN1Wwyig==
X-Received: by 2002:a05:600c:2:: with SMTP id g2mr6970541wmc.109.1550245650828; 
 Fri, 15 Feb 2019 07:47:30 -0800 (PST)
Received: from [192.168.27.65] (sju31-1-78-210-255-2.fbx.proxad.net.
 [78.210.255.2])
 by smtp.googlemail.com with ESMTPSA id c65sm9075928wma.24.2019.02.15.07.47.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 15 Feb 2019 07:47:30 -0800 (PST)
Subject: Re: [PATCH V6 5/7] arm64: dts: tegra210: add CPU idle states
 properties
To: Joseph Lo <josephl@nvidia.com>, Thierry Reding
 <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20190201161654.18315-1-josephl@nvidia.com>
 <20190201161654.18315-6-josephl@nvidia.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <d98266b3-f0a4-cebe-174a-2ab5c4051fde@linaro.org>
Date: Fri, 15 Feb 2019 16:47:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190201161654.18315-6-josephl@nvidia.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_074733_165004_28E72385 
X-CRM114-Status: GOOD (  19.96  )
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
Cc: linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMDEvMDIvMjAxOSAxNzoxNiwgSm9zZXBoIExvIHdyb3RlOgo+IEFkZCBpZGxlIHN0YXRlcyBw
cm9wZXJ0aWVzIGZvciBnZW5lcmljIEFSTSBDUFUgaWRsZSBkcml2ZXIuIFRoaXMKPiBpbmNsdWRl
cyBhIEM3IHN0YXRlIHdoaWNoIGlzIHRoZSBwb3dlciBkb3duIHN0YXRlIG9mIENQVSBjb3Jlcy4K
PiAKPiBTaWduZWQtb2ZmLWJ5OiBKb3NlcGggTG8gPGpvc2VwaGxAbnZpZGlhLmNvbT4KPiBBY2tl
ZC1ieTogSm9uIEh1bnRlciA8am9uYXRoYW5oQG52aWRpYS5jb20+Cj4gLS0tCj4gdjY6Cj4gICog
YWRkIGFjayB0YWcgZnJvbSBKb24uCj4gdjU6Cj4gICogbm8gY2hhbmdlCj4gdjQ6Cj4gICogbm8g
Y2hhbmdlCj4gdjM6Cj4gICogbm8gY2hhbmdlCj4gdjI6Cj4gICogYWRkIGVudHJ5LWxhdGVuY3kt
dXMgYW5kIGV4aXQtbGF0ZW5jeS11cyBwcm9wZXJ0aWVzCj4gCj4gTm90ZToKPiBUaGlzIGR0IHBh
dGNoIGRlcGVuZHMgb24gdGhlIERUIGNoYW5nZXMgaW4gYmVsb3cgc2VyaWVzLgo+IGh0dHA6Ly9w
YXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L2xpbnV4LXRlZ3JhL2xpc3QvP3Nlcmllcz04NDM4
MAo+IC0tLQo+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL252aWRpYS90ZWdyYTIxMC5kdHNpIHwgMTkg
KysrKysrKysrKysrKysrKysrKwo+ICAxIGZpbGUgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKQo+
IAo+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL252aWRpYS90ZWdyYTIxMC5kdHNp
IGIvYXJjaC9hcm02NC9ib290L2R0cy9udmlkaWEvdGVncmEyMTAuZHRzaQo+IGluZGV4IDJiMzg3
MzY0YWZjMy4uNzU1MzQ2OTI2MDRjIDEwMDY0NAo+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMv
bnZpZGlhL3RlZ3JhMjEwLmR0c2kKPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL252aWRpYS90
ZWdyYTIxMC5kdHNpCj4gQEAgLTEzMTgsMjQgKzEzMTgsNDMgQEAKPiAgCQkJCSA8JmRmbGw+Owo+
ICAJCQljbG9jay1uYW1lcyA9ICJjcHVfZyIsICJwbGxfeCIsICJwbGxfcCIsICJkZmxsIjsKPiAg
CQkJY2xvY2stbGF0ZW5jeSA9IDwzMDAwMDA+Owo+ICsJCQljcHUtaWRsZS1zdGF0ZXMgPSA8JkM3
PjsKClBsZWFzZSBjaGFuZ2UgdGhlIEM3IG5hbWUsIHRoYXQgd2lsbCBiZSBjb25mdXNpbmcgd2l0
aCB0aGUgQy1zdGF0ZS4KCkNQVV9TTEVFUCB3b3VsZCBiZSBuaWNlIGFuZCBjb25zaXN0ZW50IHdp
dGggb3RoZXIgZHJpdmVycy4KCj4gIAkJfTsKPiAgCj4gIAkJY3B1QDEgewo+ICAJCQlkZXZpY2Vf
dHlwZSA9ICJjcHUiOwo+ICAJCQljb21wYXRpYmxlID0gImFybSxjb3J0ZXgtYTU3IjsKPiAgCQkJ
cmVnID0gPDE+Owo+ICsJCQljcHUtaWRsZS1zdGF0ZXMgPSA8JkM3PjsKPiAgCQl9Owo+ICAKPiAg
CQljcHVAMiB7Cj4gIAkJCWRldmljZV90eXBlID0gImNwdSI7Cj4gIAkJCWNvbXBhdGlibGUgPSAi
YXJtLGNvcnRleC1hNTciOwo+ICAJCQlyZWcgPSA8Mj47Cj4gKwkJCWNwdS1pZGxlLXN0YXRlcyA9
IDwmQzc+Owo+ICAJCX07Cj4gIAo+ICAJCWNwdUAzIHsKPiAgCQkJZGV2aWNlX3R5cGUgPSAiY3B1
IjsKPiAgCQkJY29tcGF0aWJsZSA9ICJhcm0sY29ydGV4LWE1NyI7Cj4gIAkJCXJlZyA9IDwzPjsK
PiArCQkJY3B1LWlkbGUtc3RhdGVzID0gPCZDNz47Cj4gKwkJfTsKPiArCj4gKwkJaWRsZS1zdGF0
ZXMgewo+ICsJCQllbnRyeS1tZXRob2QgPSAicHNjaSI7Cj4gKwo+ICsJCQlDNzogYzcgewo+ICsJ
CQkJY29tcGF0aWJsZSA9ICJhcm0saWRsZS1zdGF0ZSI7Cj4gKwkJCQlhcm0scHNjaS1zdXNwZW5k
LXBhcmFtID0gPDB4NDAwMDAwMDc+Owo+ICsJCQkJZW50cnktbGF0ZW5jeS11cyA9IDwyNTA+Owo+
ICsJCQkJZXhpdC1sYXRlbmN5LXVzID0gPDEwMD47Cj4gKwkJCQltaW4tcmVzaWRlbmN5LXVzID0g
PDEwMDA+Owo+ICsJCQkJd2FrZXVwLWxhdGVuY3ktdXMgPSA8MTMwPjsKClJlZ2FyZGluZyB0aGUg
ZW50cnkgYW5kIHRoZSBleGl0IGxhdGVuY3ksIHRoZSB3YWtldXAgbGF0ZW5jeSBzb3VuZHMgYQpi
aXQgc21hbGwuCgouL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2lkbGUtc3RhdGVzLnR4dAoKPiAr
CQkJCWlkbGUtc3RhdGUtbmFtZSA9ICJjNy1jcHUtcG93ZXJnYXRlZCI7CgoiY3B1LXNsZWVwIgoK
PiArCQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7Cj4gKwkJCX07Cj4gIAkJfTsKPiAgCX07Cj4gIAo+
IAoKCi0tIAogPGh0dHA6Ly93d3cubGluYXJvLm9yZy8+IExpbmFyby5vcmcg4pSCIE9wZW4gc291
cmNlIHNvZnR3YXJlIGZvciBBUk0gU29DcwoKRm9sbG93IExpbmFybzogIDxodHRwOi8vd3d3LmZh
Y2Vib29rLmNvbS9wYWdlcy9MaW5hcm8+IEZhY2Vib29rIHwKPGh0dHA6Ly90d2l0dGVyLmNvbS8j
IS9saW5hcm9vcmc+IFR3aXR0ZXIgfAo8aHR0cDovL3d3dy5saW5hcm8ub3JnL2xpbmFyby1ibG9n
Lz4gQmxvZwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LWFybS1rZXJuZWwK
