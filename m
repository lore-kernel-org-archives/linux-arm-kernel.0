Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1214CC43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 07:52:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB8972086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 07:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p0Lbv1Be";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Api1M0le"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB8972086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BuWOu1owQNorTKcXsILgMscy3iT2y+mEvW6u+9R1Ycw=; b=p0Lbv1BeLP/dgM
	4uqW/RaCZf+0K0+qUxWJB9oyG9roJaRX3+B2J4zrx7jsp83nQjLeGYGglveK+YOWYC10sPDxLmtKO
	8YzrgIlw7dey36TxNt+vsIaXTqzBQx/+JQb7BvdY5cOgteWVRCMBoeG1XrmaY7JX52AGMK5M4pQRN
	vr/99uxUsDImIJMMSSrKZxQwXxSLF5PSADO9+OqZNW3Y6FKDMOeFCBZEh19a1exVYBSd9I85Fev77
	Pl7cuydFhGOiNn7abntEJaznNdgtLYHtWO+EBobn5Xr6x5CktUZWXPLHFpubZq+B8+Y8oqsAi5EFI
	WwY1syWc627FXGBTaW/g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gix2h-00066M-Nd; Mon, 14 Jan 2019 07:52:19 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gix2e-00065m-8F
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 07:52:17 +0000
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com
 [209.85.167.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E4FE520873
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 07:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547452333;
 bh=7St7aUOJaIWijS9yl62rkzDA8MFLn7sCTDGjRe648AI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Api1M0led/8WUeQTQxVpNZdbMFt10oaNZ+Cxl7mtjL+iVIbxek9hGlWg+72rPOKqG
 QMRkgg+LgihYZL+qVAbip60P5E9vfpDvyzeNR97koPTSnAfVFWyK36Yai63YS+jRPL
 laupYoqKttX/SuUZDrCOza8F3aB4OcAq3QhQNS4c=
Received: by mail-lf1-f41.google.com with SMTP id b20so14832032lfa.12
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 13 Jan 2019 23:52:12 -0800 (PST)
X-Gm-Message-State: AJcUukf+XI7ml9iZ9UB6926hKpv9QfArTII58UgMmiXolh+Hu11btqwg
 Ta7sRMscl1neCM4c+3nkKtTwboNV6QzI5pCvkrY=
X-Google-Smtp-Source: ALg8bN7XJmMKBAZQatGvjKB0aLZIBhNajxj93l3cVRSLI1sUGphrfzOYcFa+Ym8OLJXGPOMTbf1pUnhfhysVUsbF6X8=
X-Received: by 2002:a19:c396:: with SMTP id
 t144mr12232535lff.110.1547452331079; 
 Sun, 13 Jan 2019 23:52:11 -0800 (PST)
MIME-Version: 1.0
References: <20190113195754.30525-1-pawel.mikolaj.chmiel@gmail.com>
In-Reply-To: <20190113195754.30525-1-pawel.mikolaj.chmiel@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 14 Jan 2019 08:51:59 +0100
X-Gmail-Original-Message-ID: <CAJKOXPfvR6vATPiWbef_JiSJX78PkJxRXjF2xK7EYr5B3e8HbA@mail.gmail.com>
Message-ID: <CAJKOXPfvR6vATPiWbef_JiSJX78PkJxRXjF2xK7EYr5B3e8HbA@mail.gmail.com>
Subject: Re: [PATCH v4] cpufreq: s5pv210: Defer probe if getting regulators
 fail
To: =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190113_235216_316874_784994C0 
X-CRM114-Status: GOOD (  13.02  )
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
Cc: "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 linux-pm@vger.kernel.org, viresh.kumar@linaro.org, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, kgene@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gU3VuLCAxMyBKYW4gMjAxOSBhdCAyMDo1OCwgUGF3ZcWCIENobWllbAo8cGF3ZWwubWlrb2xh
ai5jaG1pZWxAZ21haWwuY29tPiB3cm90ZToKPgo+IFRoZXJlIGlzIHBvc3NpYmlsaXR5LCB0aGF0
IHdoZW4gcHJvYmluZyBkcml2ZXIsIHJlZ3VsYXRvcnMgYXJlIG5vdCB5ZXQKPiBpbml0aWFsaXpl
ZC4gSW4gdGhpcyBjYXNlIHdlIHNob3VsZCByZXR1cm4gRVBST0JFX0RFRkVSIGFuZCB3YWl0IHRp
bGwKPiB0aGV5J3JlIGluaXRpYWxpemVkLCBzaW5jZSB0aGV5J3JlIHJlcXVpcmVkIGN1cnJlbnRs
eSBmb3IgY3B1ZnJlcSBkcml2ZXIKPiB0byB3b3JrLiBBbHNvIG1vdmUgcmVndWxhdG9yIGluaXRp
YWxpemF0aW9uIGNvZGUgYXQgYmVnaW5uaW5nIG9mIHByb2JlLAo+IHNvIHdlIGNhbiBkZWZlciBh
cyBmYXN0IGFzIHBvc2liYmxlLgo+Cj4gU2lnbmVkLW9mZi1ieTogUGF3ZcWCIENobWllbCA8cGF3
ZWwubWlrb2xhai5jaG1pZWxAZ21haWwuY29tPgo+IC0tLQo+IENoYW5nZXMgZnJvbSB2MzoKPiAg
IC0gWmVybyBkbWNfYmFzZSBwb2ludGVycyBhZnRlciB1bm1hcHBpbmcgdGhlbQo+ICAgLSBJZiBn
ZXR0aW5nIHZkZGFybSByZWd1bGF0b3IgZmFpbHMganVzdCByZXR1cm4sIG5vIG5lZWQgdG8gZG8g
Z290bwo+ICAgICBqdW1wIHdoaWNoIHdvdWxkIGRvIHRoZSBzYW1lCj4KPiBDaGFuZ2VzIGZyb20g
djI6Cj4gICAtIEhhbmRsZSBhbGwgZXJyb3IgcGF0aHMgaW4gcHJvYmUKPgo+IENoYW5nZXMgZnJv
bSB2MToKPiAgIC0gRml4IGNvbXBpbGF0aW9uIGVycm9yCj4gICAtIFJlb3JnYW5pemUgY29kZSBz
byBpdCdzIHNtYWxsZXIKClJldmlld2VkLWJ5OiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprQGtl
cm5lbC5vcmc+CgpCZXN0IHJlZ2FyZHMsCktyenlzenRvZgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QK
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
