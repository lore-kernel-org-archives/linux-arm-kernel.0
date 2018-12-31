Return-Path: <SRS0=D6bT=PI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B6FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 13:36:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 640B821019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 13:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kA+LjMny";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ho7v6gsq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 640B821019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pvNcIVuW3vtQaPKnp4KUnlVDMRmIZwnBOh4Gp19KR5w=; b=kA+LjMnyqO8l5i
	PRVv6KdVKnY96UxdV0PcZN8sb9DCooOfyrSAkfcr/OGEYyCcRIkUJZGJTReKyqIsx+5QGmka+vGBm
	obq7u3jZUkw+XWfpJ/1AflmQFH0sil/tAPP8eYdpsyEqZQVM/4ANym+xQVNZRCyxSFQiqDVAoxs7x
	8tEucb3jyUL0radocChG5moTlD4tBJVAXAgQG8xF8D70on660EoCRRy5yMoDuJ5Dg7BqaQFHD8Oz5
	aftlzEEK2UJ7W07ML/eSzzgYbI0sAsWfsSeLf8Z7prhAIwwvB8M6Z/kC1ypSvbD39l9/L/kI9CXgD
	hPIHg9CcVJbj9bqS+Y3w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gdxjo-0003oB-Ga; Mon, 31 Dec 2018 13:36:12 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gdxjl-0003nd-5Q
 for linux-arm-kernel@lists.infradead.org; Mon, 31 Dec 2018 13:36:10 +0000
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com
 [209.85.208.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7362221871
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 31 Dec 2018 13:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546263368;
 bh=tXCnYMeQWRObpJ37q4tKhu5guivGxoqG+sedlVwZjOM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Ho7v6gsqKUc9H4fxSv3dgdqtZu0I1RxFT35xwoY4S8Ju2ExOxHIoXsD2nU510KBhy
 8IoQLbt5R+O3JQzuHLlVMRpl21XEqfwYLnDWQBqGTjw5HKBFtFnqT6pEW0Eci2rlvs
 YNAAkNr0WhOr5iMzdU1+tYKDAe6/yZsVw4SJzvwM=
Received: by mail-lj1-f173.google.com with SMTP id c19-v6so23627141lja.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 31 Dec 2018 05:36:08 -0800 (PST)
X-Gm-Message-State: AJcUukeg8ExUJuNLF4SEyQxKO3j6hqTr+KdudYFrXTNvyKOBtEhcor0o
 rXxbJARyeqfT94pmzx9hYsHotLejx7zljVbAmtk=
X-Google-Smtp-Source: ALg8bN6ZnZ8v3AdOQSsMsFhmNvc24doDUzk83f3TiKRz7QlVWXONzFPDHZCJzlZduPHoqPYKBEXAq3aFCehzHK6p02A=
X-Received: by 2002:a2e:c41:: with SMTP id
 o1-v6mr21530785ljd.152.1546263366548; 
 Mon, 31 Dec 2018 05:36:06 -0800 (PST)
MIME-Version: 1.0
References: <20181228161819.18931-1-pawel.mikolaj.chmiel@gmail.com>
 <20181228161819.18931-6-pawel.mikolaj.chmiel@gmail.com>
In-Reply-To: <20181228161819.18931-6-pawel.mikolaj.chmiel@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 31 Dec 2018 14:35:55 +0100
X-Gmail-Original-Message-ID: <CAJKOXPf3Z9=mjq_UWyD1oVEapvnNR71cDfyJP1Y_VLkXkFcyew@mail.gmail.com>
Message-ID: <CAJKOXPf3Z9=mjq_UWyD1oVEapvnNR71cDfyJP1Y_VLkXkFcyew@mail.gmail.com>
Subject: Re: [PATCH 5/6] ARM: dts: s5pv210: aries: Support for more devices
 present on Aries
To: =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181231_053609_243922_7860D097 
X-CRM114-Status: GOOD (  16.97  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 xc-racer2@live.ca, linux@armlinux.org.uk, robh+dt@kernel.org,
 linux-kernel@vger.kernel.org, kgene@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gRnJpLCAyOCBEZWMgMjAxOCBhdCAxNzoxOCwgUGF3ZcWCIENobWllbAo8cGF3ZWwubWlrb2xh
ai5jaG1pZWxAZ21haWwuY29tPiB3cm90ZToKPgo+IEZyb206IEpvbmF0aGFuIEJha2tlciA8eGMt
cmFjZXIyQGxpdmUuY2E+Cj4KPiBUaGlzIGNvbW1pdCBlbmFibGVzIGZvbGxvd2luZyBkZXZpY2Vz
IHByZXNlbnQgb24gQXJpZXMgYmFzZWQgcGhvbmVzOgo+IC0gcHdtLXZpYnJhdG9yIGF0dGFjaGVk
IHRvIFBXTSAxCj4gLSBwb3dlcm9mZiBzdXBwb3J0Cj4gLSBBdG1lbCBtYVhUb3VjaCB0b3VjaHNj
cmVlbi4gSXQncyBjb25uZWN0ZWQgdG8gaTJjMgo+IC0gQnJvYWRjb20gQkNNNDMyOSBibHVldG9v
dGggb3ZlciB1YXJ0MAo+Cj4gU2lnbmVkLW9mZi1ieTogSm9uYXRoYW4gQmFra2VyIDx4Yy1yYWNl
cjJAbGl2ZS5jYT4KPiBTaWduZWQtb2ZmLWJ5OiBQYXdlxYIgQ2htaWVsIDxwYXdlbC5taWtvbGFq
LmNobWllbEBnbWFpbC5jb20+Cj4gLS0tCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL3M1cHYyMTAtYXJp
ZXMuZHRzaSB8IDY4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysKPiAgMSBmaWxlIGNoYW5n
ZWQsIDY4IGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9z
NXB2MjEwLWFyaWVzLmR0c2kgYi9hcmNoL2FybS9ib290L2R0cy9zNXB2MjEwLWFyaWVzLmR0c2kK
PiBpbmRleCAzNWJhMDA5YTFhMzMuLmI3MjQ2Zjg3OTY0OCAxMDA2NDQKPiAtLS0gYS9hcmNoL2Fy
bS9ib290L2R0cy9zNXB2MjEwLWFyaWVzLmR0c2kKPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9z
NXB2MjEwLWFyaWVzLmR0c2kKPiBAQCAtNDEsNiArNDEsMTMgQEAKPiAgICAgICAgICAgICAgICAg
fTsKPiAgICAgICAgIH07Cj4KPiArICAgICAgIHZpYnJhdG9yX3B3cjogcmVndWxhdG9yLWZpeGVk
LTAgewo+ICsgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gInJlZ3VsYXRvci1maXhlZCI7Cj4g
KyAgICAgICAgICAgICAgIHJlZ3VsYXRvci1uYW1lID0gInZpYnJhdG9yLWVuIjsKPiArICAgICAg
ICAgICAgICAgZW5hYmxlLWFjdGl2ZS1oaWdoOwo+ICsgICAgICAgICAgICAgICBncGlvID0gPCZn
cGoxIDEgR1BJT19BQ1RJVkVfSElHSD47Cj4gKyAgICAgICB9Owo+ICsKPiAgICAgICAgIHdpZmlf
cHdyc2VxOiB3aWZpLXB3cnNlcSB7Cj4gICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAibW1j
LXB3cnNlcS1zaW1wbGUiOwo+ICAgICAgICAgICAgICAgICByZXNldC1ncGlvcyA9IDwmZ3BnMSAy
IEdQSU9fQUNUSVZFX0xPVz47Cj4gQEAgLTMxNCw2ICszMjEsMjIgQEAKPiAgICAgICAgICAgICAg
ICAgICAgICAgICByZWcgPSA8MHgzNj47Cj4gICAgICAgICAgICAgICAgIH07Cj4gICAgICAgICB9
Owo+ICsKPiArICAgICAgIHZpYnJhdG9yOiBwd20tdmlicmF0b3Igewo+ICsgICAgICAgICAgICAg
ICBjb21wYXRpYmxlID0gInB3bS12aWJyYXRvciI7Cj4gKyAgICAgICAgICAgICAgIHB3bXMgPSA8
JnB3bSAxIDQ0NjQyIDA+Owo+ICsgICAgICAgICAgICAgICBwd20tbmFtZXMgPSAiZW5hYmxlIjsK
PiArICAgICAgICAgICAgICAgdmNjLXN1cHBseSA9IDwmdmlicmF0b3JfcHdyPjsKPiArICAgICAg
ICAgICAgICAgcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsKPiArICAgICAgICAgICAgICAgcGlu
Y3RybC0wID0gPCZwd20xX291dD47Cj4gKyAgICAgICB9Owo+ICsKPiArICAgICAgIHBvd2Vyb2Zm
OiBzeXNjb24tcG93ZXJvZmYgewo+ICsgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gInN5c2Nv
bi1wb3dlcm9mZiI7Cj4gKyAgICAgICAgICAgICAgIHJlZ21hcCA9IDwmcG11X3N5c2Nvbj47Cj4g
KyAgICAgICAgICAgICAgIG9mZnNldCA9IDwweDY4MWM+OyAvKiBQU19IT0xEX0NPTlRST0wgKi8K
PiArICAgICAgICAgICAgICAgdmFsdWUgPSA8MHg1MjAwPjsKPiArICAgICAgIH07Cj4gIH07Cj4K
PiAgJmZpbWQgewo+IEBAIC0zNDcsNiArMzcwLDIzIEBACj4gICAgICAgICBzdGF0dXMgPSAib2th
eSI7Cj4gIH07Cj4KPiArJmkyYzIgewo+ICsgICAgICAgc2Ftc3VuZyxpMmMtc2RhLWRlbGF5ID0g
PDEwMD47Cj4gKyAgICAgICBzYW1zdW5nLGkyYy1tYXgtYnVzLWZyZXEgPSA8NDAwMDAwPjsKPiAr
ICAgICAgIHNhbXN1bmcsaTJjLXNsYXZlLWFkZHIgPSA8MHgxMD47Cj4gKyAgICAgICBzdGF0dXMg
PSAib2theSI7Cj4gKwo+ICsgICAgICAgdG91Y2hzY3JlZW5ANGEgewo+ICsgICAgICAgICAgICAg
ICBjb21wYXRpYmxlID0gImF0bWVsLG1heHRvdWNoIjsKPiArICAgICAgICAgICAgICAgcmVnID0g
PDB4NGE+Owo+ICsgICAgICAgICAgICAgICBpbnRlcnJ1cHQtcGFyZW50ID0gPCZncGowPjsKPiAr
ICAgICAgICAgICAgICAgaW50ZXJydXB0cyA9IDw1IElSUV9UWVBFX0xFVkVMX0xPVz47Cj4gKyAg
ICAgICAgICAgICAgIHBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7Cj4gKyAgICAgICAgICAgICAg
IHBpbmN0cmwtMCA9IDwmdHNfaXJxPjsKPiArICAgICAgICAgICAgICAgcmVzZXQtZ3Bpb3MgPSA8
JmdwajEgMyBHUElPX0FDVElWRV9ISUdIPjsKPiArICAgICAgIH07Cj4gK307Cj4gKwo+ICAmbWZj
IHsKPiAgICAgICAgIG1lbW9yeS1yZWdpb24gPSA8Jm1mY19sZWZ0PiwgPCZtZmNfcmlnaHQ+Owo+
ICB9Owo+IEBAIC0zNzIsNiArNDEyLDEzIEBACj4gICAgICAgICAgICAgICAgIHNhbXN1bmcscGlu
LWRydiA9IDxFWFlOT1M0X1BJTl9EUlZfTFYxPjsKPiAgICAgICAgIH07Cj4KPiArICAgICAgIGJ0
X2hvc3Rfd2FrZTogYnQtaG9zdC13YWtlIHsKPiArICAgICAgICAgICAgICAgc2Ftc3VuZyxwaW5z
ID0gImdwaDItNSI7Cj4gKyAgICAgICAgICAgICAgIHNhbXN1bmcscGluLWZ1bmN0aW9uID0gPEVY
WU5PU19QSU5fRlVOQ19JTlBVVD47Cj4gKyAgICAgICAgICAgICAgIHNhbXN1bmcscGluLXB1ZCA9
IDxTM0M2NFhYX1BJTl9QVUxMX0RPV04+Owo+ICsgICAgICAgICAgICAgICBzYW1zdW5nLHBpbi1k
cnYgPSA8RVhZTk9TNF9QSU5fRFJWX0xWMT47Cj4gKyAgICAgICB9Owo+ICsKPiAgICAgICAgIHRm
X2RldGVjdDogdGYtZGV0ZWN0IHsKPiAgICAgICAgICAgICAgICAgc2Ftc3VuZyxwaW5zID0gImdw
aDMtNCI7Cj4gICAgICAgICAgICAgICAgIHNhbXN1bmcscGluLWZ1bmN0aW9uID0gPEVYWU5PU19Q
SU5fRlVOQ19JTlBVVD47Cj4gQEAgLTM4NCw2ICs0MzEsMTcgQEAKPiAgICAgICAgICAgICAgICAg
c2Ftc3VuZyxwaW4tZnVuY3Rpb24gPSA8RVhZTk9TX1BJTl9GVU5DX09VVFBVVD47Cj4gICAgICAg
ICAgICAgICAgIHNhbXN1bmcscGluLXB1ZCA9IDxTM0M2NFhYX1BJTl9QVUxMX05PTkU+Owo+ICAg
ICAgICAgfTsKPiArCj4gKyAgICAgICB0c19pcnE6IHRzLWlycSB7Cj4gKyAgICAgICAgICAgICAg
IHNhbXN1bmcscGlucyA9ICJncGowLTUiOwo+ICsgICAgICAgICAgICAgICBzYW1zdW5nLHBpbi1m
dW5jdGlvbiA9IDxFWFlOT1NfUElOX0ZVTkNfSU5QVVQ+Owo+ICsgICAgICAgICAgICAgICBzYW1z
dW5nLHBpbi1wdWQgPSA8UzNDNjRYWF9QSU5fUFVMTF9VUD47CgpJdCBzZWVtcyB0aGVyZSBpcyBh
IGRpZmZlcmVuY2UgaGVyZSBiZXR3ZWVuIEFyaWVzIGFuZCBGYXNjaW5hdGUuIEF0CmxlYXN0IGlu
IHZlbmRvciBrZXJuZWwuIE9uZSBkaXNhYmxlcyBwdWxsIGFuZCBzZWNvbmQgcHVsbHMgZG93bi4K
QW55d2F5IG5laXRoZXIgb2YgdGhlbSBwdWxscyBpdCB1cC4KCkJlc3QgcmVnYXJkcywKS3J6eXN6
dG9mCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51
eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1h
cm0ta2VybmVsCg==
