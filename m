Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84931C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:26:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 518BE204FD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J5bfVFCk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sqVRVTDN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 518BE204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:From:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IWc38VTlS88PeD7G9SVfo9AfANelr/LpHveJ4QSD0p8=; b=J5bfVFCkTctyvL
	zxN326gDLwgoj0mMjJT1weCwU+I16K/EwDyhbgl5AsyFP8/0l3FGzSNHITksHq/YhYIhLyqLpWzHG
	JPwp0pKa490DiASpeGTZ+YD13MzNwBSjZcN2uwaZvee63dGb6rINmf+x38O8FI8TABoKSEhL/gDGQ
	7nzsL1vIgXpzjtQy4U65q1vNOdBokwCvm2anocG42ulYPBI/40UUooWN4U/PK/eGIwoWiZpF6D48a
	UfygOWcmB9cvEGXODL4lWZl/hJYpwfq4W1glcC8HwfsPhCq/K6l/0xP7BJGFHr2F/6uqaABGGqFGE
	rz3lPGeg9CQ2MIwkn2KA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxFWo-0001JO-OQ; Fri, 22 Feb 2019 18:26:30 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxFWj-0001DO-Fg
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 18:26:27 +0000
Received: by mail-lf1-x144.google.com with SMTP id n15so2446407lfe.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 10:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=KsmxRwp7SOmta/Ucao4e6WVvG+vtj6B7DkivFWsH1HI=;
 b=sqVRVTDNURoS/aTNCTpptmCDFgl2YIV8lI+mLmAScfKYJCtbD6JwQZcxr4l/1tcMbo
 lEuLnowAU6UEvg6W29qN2B3URPYniSW3k0QgUAd6LWRoo3lC0p5CRkxERwh1CPcQ1OdW
 n5YGx/wuDz3XUiQLRCvuQQVQ94+3h2kO0cQy7Bgjra8jVTNm/+A7mQd3/p9fdx83TVOx
 mE0Cl2EePhbK7R+dM+L0xLASJD6WGJII03lXY+RkZb5N2TVXxMmY09f6NZWkDrLgiYY9
 x1qhotxEjYPjepY8Ffody83vxWPwhnfCWMnS+e0bJ/iZ3/ni3aYwsoVRMdgVy2P2JqPU
 O6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KsmxRwp7SOmta/Ucao4e6WVvG+vtj6B7DkivFWsH1HI=;
 b=nL5J2VnHVps/tPw/+/FH5+v6QKtvPMCyr67uuX7QVuXtFem85CXRo4sBlXt8+bsKk0
 cwDAg079yIT0eCJUKO/g+QMVTroYMshC0cKo45RYHugnx9mey8vP0Wb0rjgh6uUfmRAi
 oP+YXHeByyf3UTLq1NY3eMaaiCNcFQ2yKf6tL1vGr+Uj+yam5rt1ruwfICeJ/4cTTv7V
 F/EpwbOR+VLPjRDDojcWwoTf8cZ4RCMT4qNnBjY1f7qKoE5notsIjh33+n0g5W0PqFiO
 AhsEt8EwwvX/un685skhsqa3TBc4r3FDUvCo0eg1KyACgRMu+ALcegDKgXSLjwApSRNA
 HaVA==
X-Gm-Message-State: AHQUAuZoPniZpm9LpoQa8afhHs4aj7b5GkYwXjc6cJEckEcu+jFcwizl
 1rn7my3PzFGEEjDlZxQrkRc=
X-Google-Smtp-Source: AHgI3Ia0DtY+SqdyZTDECU8sXwAnpo92rDzYlQrdn82mx+H2Xr27m8dM2WMhElVa1lknt5zfDQqvQA==
X-Received: by 2002:a19:7406:: with SMTP id v6mr3270867lfe.33.1550859983590;
 Fri, 22 Feb 2019 10:26:23 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru.
 [91.79.175.49])
 by smtp.googlemail.com with ESMTPSA id s14sm679732lje.4.2019.02.22.10.26.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Feb 2019 10:26:22 -0800 (PST)
Subject: Re: [PATCH v5 8/8] ARM: tegra: Add firmware calls required for
 suspend-resume
From: Dmitry Osipenko <digetx@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Robert Yang <decatf@gmail.com>,
 =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
References: <20190222175926.23366-1-digetx@gmail.com>
 <20190222175926.23366-9-digetx@gmail.com>
Message-ID: <1b58a7f4-8ad0-9b5a-4ca7-b01b3c47425f@gmail.com>
Date: Fri, 22 Feb 2019 21:26:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190222175926.23366-9-digetx@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_102625_563296_E87AA17D 
X-CRM114-Status: GOOD (  24.86  )
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
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

MjIuMDIuMjAxOSAyMDo1OSwgRG1pdHJ5IE9zaXBlbmtvINC/0LjRiNC10YI6Cj4gSW4gb3JkZXIg
dG8gcmVzdW1lIENQVSBmcm9tIHN1c3BlbmQgdmlhIHRydXN0ZWQgRm91bmRhdGlvbnMgZmlybXdh
cmUsCj4gdGhlIExQMS9MUDIgYm9vdCB2ZWN0b3JzIGFuZCBDUFUgY2FjaGVzIG5lZWQgdG8gYmUg
c2V0IHVwIHVzaW5nIHRoZQo+IGZpcm13YXJlIGNhbGxzLgo+IAo+IFNpZ25lZC1vZmYtYnk6IERt
aXRyeSBPc2lwZW5rbyA8ZGlnZXR4QGdtYWlsLmNvbT4KPiAtLS0KPiAgYXJjaC9hcm0vbWFjaC10
ZWdyYS9wbS5jICAgICAgICAgICAgfCA1MyArKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLQo+
ICBhcmNoL2FybS9tYWNoLXRlZ3JhL3Jlc2V0LWhhbmRsZXIuUyB8IDI2ICsrKysrKysrKysrKysr
Cj4gIGFyY2gvYXJtL21hY2gtdGVncmEvc2xlZXAuUyAgICAgICAgIHwgIDMgKy0KPiAgMyBmaWxl
cyBjaGFuZ2VkLCA2MSBpbnNlcnRpb25zKCspLCAyMSBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0t
Z2l0IGEvYXJjaC9hcm0vbWFjaC10ZWdyYS9wbS5jIGIvYXJjaC9hcm0vbWFjaC10ZWdyYS9wbS5j
Cj4gaW5kZXggNjZjOGNkNjNkZDg2Li5mMjA5ZjU5ZTBkYWYgMTAwNjQ0Cj4gLS0tIGEvYXJjaC9h
cm0vbWFjaC10ZWdyYS9wbS5jCj4gKysrIGIvYXJjaC9hcm0vbWFjaC10ZWdyYS9wbS5jCj4gQEAg
LTMzLDYgKzMzLDcgQEAKPiAgI2luY2x1ZGUgPHNvYy90ZWdyYS9wbWMuaD4KPiAgCj4gICNpbmNs
dWRlIDxhc20vY2FjaGVmbHVzaC5oPgo+ICsjaW5jbHVkZSA8YXNtL2Zpcm13YXJlLmg+Cj4gICNp
bmNsdWRlIDxhc20vaWRtYXAuaD4KPiAgI2luY2x1ZGUgPGFzbS9wcm9jLWZucy5oPgo+ICAjaW5j
bHVkZSA8YXNtL3NtcF9wbGF0Lmg+Cj4gQEAgLTE2MCw2ICsxNjEsMjggQEAgaW50IHRlZ3JhX2Nw
dV9kb19pZGxlKHZvaWQpCj4gIAo+ICBzdGF0aWMgaW50IHRlZ3JhX3NsZWVwX2NwdSh1bnNpZ25l
ZCBsb25nIHYycCkKPiAgewo+ICsJLyoKPiArCSAqIEwyIGNhY2hlIGRpc2FibGluZyB1c2luZyBr
ZXJuZWwgQVBJIG9ubHkgYWxsb3dlZCB3aGVuIGFsbAo+ICsJICogc2Vjb25kYXJ5IENQVSdzIGFy
ZSBvZmZsaW5lLiBDYWNoZSBoYXZlIHRvIGJlIGRpc2FibGVkIHdpdGgKPiArCSAqIE1NVS1vbiBp
ZiBjYWNoZSBtYWludGVuYW5jZSBpcyBkb25lIHZpYSBUcnVzdGVkIEZvdW5kYXRpb25zCj4gKwkg
KiBmaXJtd2FyZS4gTm90ZSB0aGF0IENQVUlETEUgd29uJ3QgZXZlciBlbnRlciBwb3dlcmdhdGUg
b24gVGVncmEzMAo+ICsJICogaWYgYW55IG9mIHNlY29uZGFyeSBDUFUncyBpcyBvbmxpbmUgYW5k
IHRoaXMgaXMgdGhlIExQMi1pZGxlCj4gKwkgKiBjb2RlLXBhdGggb25seSBmb3IgVGVncmEyMC8z
MC4KPiArCSAqLwo+ICsJaWYgKHRydXN0ZWRfZm91bmRhdGlvbnNfcmVnaXN0ZXJlZCgpKQo+ICsJ
CW91dGVyX2Rpc2FibGUoKTsKPiArCj4gKwkvKgo+ICsJICogTm90ZSB0aGF0IGJlc2lkZXMgb2Yg
c2V0dGluZyB1cCBDUFUgcmVzZXQgdmVjdG9yIHRoaXMgZmlybXdhcmUKPiArCSAqIGNhbGwgbWF5
IGFsc28gZG8gdGhlIGZvbGxvd2luZywgZGVwZW5kaW5nIG9uIHRoZSBGVyB2ZXJzaW9uOgo+ICsJ
ICogCTEpIERpc2FibGUgTDIuIEJ1dCB0aGlzIGRvZXNuJ3QgbWF0dGVyIHNpbmNlIHdlIGFscmVh
ZHkKPiArCSAqIAkgICBkaXNhYmxlZCB0aGUgTDIuCj4gKwkgKgkyKSBEaXNhYmxlIEQtY2FjaGUu
IFRoaXMgbmVlZCB0byBiZSB0YWtlbiBpbnRvIGFjY291bnQgaW4KPiArCSAqCSAgIHBhcnRpY3Vs
YXIgYnkgdGhlIHRlZ3JhX2Rpc2FibGVfY2xlYW5faW52X2RjYWNoZSgpIHdoaWNoCj4gKwkgKgkg
ICBzaGFsbCBhdm9pZCB0aGUgcmUtZGlzYWJsZS4KPiArCSAqLwo+ICsJY2FsbF9maXJtd2FyZV9v
cChwcmVwYXJlX2lkbGUsIFRGX1BNX01PREVfTFAyKTsKPiArCj4gIAlzZXR1cF9tbV9mb3JfcmVi
b290KCk7Cj4gIAl0ZWdyYV9zbGVlcF9jcHVfZmluaXNoKHYycCk7Cj4gIAo+IEBAIC0xOTYsMjQg
KzIxOSwxMyBAQCB2b2lkIHRlZ3JhX2lkbGVfbHAyX2xhc3Qodm9pZCkKPiAgCWNwdV9jbHVzdGVy
X3BtX2VudGVyKCk7Cj4gIAlzdXNwZW5kX2NwdV9jb21wbGV4KCk7Cj4gIAo+IC0JLyoKPiAtCSAq
IEwyIGNhY2hlIGRpc2FibGluZyB1c2luZyBrZXJuZWwgQVBJIG9ubHkgYWxsb3dlZCB3aGVuIGFs
bAo+IC0JICogc2Vjb25kYXJ5IENQVSdzIGFyZSBvZmZsaW5lLiBDYWNoZSBoYXZlIHRvIGJlIGRp
c2FibGVkIGVhcmx5Cj4gLQkgKiBpZiBjYWNoZSBtYWludGVuYW5jZSBpcyBkb25lIHZpYSBUcnVz
dGVkIEZvdW5kYXRpb25zIGZpcm13YXJlLgo+IC0JICogTm90ZSB0aGF0IENQVUlETEUgd29uJ3Qg
ZXZlciBlbnRlciBwb3dlcmdhdGUgb24gVGVncmEzMCBpZiBhbnkKPiAtCSAqIG9mIHNlY29uZGFy
eSBDUFUncyBpcyBvbmxpbmUgYW5kIHRoaXMgaXMgdGhlIExQMiBjb2RlcGF0aCBvbmx5Cj4gLQkg
KiBmb3IgVGVncmEyMC8zMC4KPiAtCSAqLwo+IC0JaWYgKHRydXN0ZWRfZm91bmRhdGlvbnNfcmVn
aXN0ZXJlZCgpKQo+IC0JCW91dGVyX2Rpc2FibGUoKTsKPiAtCj4gIAljcHVfc3VzcGVuZChQSFlT
X09GRlNFVCAtIFBBR0VfT0ZGU0VULCAmdGVncmFfc2xlZXBfY3B1KTsKPiAgCj4gIAkvKgo+ICAJ
ICogUmVzdW1lIEwyIGNhY2hlIGlmIGl0IHdhc24ndCByZS1lbmFibGVkIGVhcmx5IGR1cmluZyBy
ZXN1bWUsCj4gIAkgKiB3aGljaCBpcyB0aGUgY2FzZSBmb3IgVGVncmEzMCB0aGF0IGhhcyB0byBy
ZS1lbmFibGUgdGhlIGNhY2hlCj4gIAkgKiB2aWEgZmlybXdhcmUgY2FsbC4gSW4gb3RoZXIgY2Fz
ZXMgY2FjaGUgaXMgYWxyZWFkeSBlbmFibGVkIGFuZAo+IC0JICogaGVuY2UgcmUtZW5hYmxpbmcg
aXMgYSBuby1vcC4KPiArCSAqIGhlbmNlIHJlLWVuYWJsaW5nIGlzIGEgbm8tb3AuIFRoaXMgaXMg
YWx3YXlzIGEgbm8tb3Agb24gVGVncmExMTQrLgo+ICAJICovCj4gIAlvdXRlcl9yZXN1bWUoKTsK
PiAgCj4gQEAgLTIzNSw2ICsyNDcsMTUgQEAgZW51bSB0ZWdyYV9zdXNwZW5kX21vZGUgdGVncmFf
cG1fdmFsaWRhdGVfc3VzcGVuZF9tb2RlKAo+ICAKPiAgc3RhdGljIGludCB0ZWdyYV9zbGVlcF9j
b3JlKHVuc2lnbmVkIGxvbmcgdjJwKQo+ICB7Cj4gKwkvKgo+ICsJICogQ2FjaGUgaGF2ZSB0byBi
ZSBkaXNhYmxlZCB3aXRoIE1NVS1vbiBpZiBjYWNoZSBtYWludGVuYW5jZSBpcyBkb25lCj4gKwkg
KiB2aWEgVHJ1c3RlZCBGb3VuZGF0aW9ucyBmaXJtd2FyZS4gVGhpcyBpcyBhIG5vLW9wIG9uIFRl
Z3JhMTE0Ky4KPiArCSAqLwo+ICsJaWYgKHRydXN0ZWRfZm91bmRhdGlvbnNfcmVnaXN0ZXJlZCgp
KQo+ICsJCW91dGVyX2Rpc2FibGUoKTsKPiArCj4gKwljYWxsX2Zpcm13YXJlX29wKHByZXBhcmVf
aWRsZSwgVEZfUE1fTU9ERV9MUDEpOwo+ICsKPiAgCXNldHVwX21tX2Zvcl9yZWJvb3QoKTsKPiAg
CXRlZ3JhX3NsZWVwX2NvcmVfZmluaXNoKHYycCk7Cj4gIAo+IEBAIC0zNjAsMTQgKzM4MSw2IEBA
IHN0YXRpYyBpbnQgdGVncmFfc3VzcGVuZF9lbnRlcihzdXNwZW5kX3N0YXRlX3Qgc3RhdGUpCj4g
IAkJYnJlYWs7Cj4gIAl9Cj4gIAo+IC0JLyoKPiAtCSAqIENhY2hlIGhhdmUgdG8gYmUgZGlzYWJs
ZWQgZWFybHkgaWYgY2FjaGUgbWFpbnRlbmFuY2UgaXMgZG9uZQo+IC0JICogdmlhIFRydXN0ZWQg
Rm91bmRhdGlvbnMgZmlybXdhcmUuIE90aGVyd2lzZSB0aGlzIGlzIGEgbm8tb3AsCj4gLQkgKiBs
aWtlIG9uIFRlZ3JhMTE0Ky4KPiAtCSAqLwo+IC0JaWYgKHRydXN0ZWRfZm91bmRhdGlvbnNfcmVn
aXN0ZXJlZCgpKQo+IC0JCW91dGVyX2Rpc2FibGUoKTsKPiAtCj4gIAljcHVfc3VzcGVuZChQSFlT
X09GRlNFVCAtIFBBR0VfT0ZGU0VULCB0ZWdyYV9zbGVlcF9mdW5jKTsKClNlZW1zIEkgbWVzc2Vk
IHVwIHRoZSByZWJhc2luZyBhIHRhZC4gV2lsbCBzZW5kIGFub3RoZXIgdmVyc2lvbi4KCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJu
ZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
