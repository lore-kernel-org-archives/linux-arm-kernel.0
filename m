Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82D9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:34:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85CEB20872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O04bHDaR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4SQGBee"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85CEB20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HGTpS0xi9TzthlYQiJ697QmoaDopE4wSQpnnCD7bMZo=; b=O04bHDaRO4crKN
	vjZ4H18Kh0cZ6TgqY0BxgoYCAHO5xdc4NpyWrqRowciDDykB65y8L+SUf5rs6iHdtAoQ1TvNx3dLg
	XFIhAoesHRujuOBljlvFlJj7U0vhOGpq6L+WIWqeGyYaPo4URP6gNINux/BWfBKOL+Yzn88g4ro9Y
	G1pyyMPX1NpGq44KDYuUKUGloAE+evUQzjiSdxyPXu4/msoJTLIUsSsiTxmn3j5I73riXbpDg1h/A
	Vr+4jFRJSOt6t3xPVzNSXYKEn8UY/W2dSrxT09uBmEYu8vtmDLG8U0P7fuwzy9nCbuotTibuLwjaO
	kxl2H7Xy6c7oQ8+MRxcQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghsGM-0000lp-Bo; Fri, 11 Jan 2019 08:33:58 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghsGI-0000kT-NU
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 08:33:56 +0000
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com
 [209.85.208.175])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 101D720872
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 08:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547195634;
 bh=lYLZ1fsbLS8KYAm5cE4Qbzw1iabheBnVOksYYx2cEt8=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=d4SQGBeeBHWrwJWcT7yQsyOAUPUtl4xHwuFCgiog2A8xHeTGOAZ2ReObQhFFiLjhC
 wwbQkHD6RvUjNhcsQPW6NVMG6DUXpCYVZoRzy6LzbjMePtakmT/5ayEcUX5M5L4hgf
 jM5qDs+dA70KtlehkgqQx4z0I6IrwA46Asue67oo=
Received: by mail-lj1-f175.google.com with SMTP id k15-v6so12156907ljc.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 00:33:53 -0800 (PST)
X-Gm-Message-State: AJcUukfjOEPFT0YtBaQZ2QXCLSeX2LdS+nGYYNFSKKznqUAufsdPuAyp
 PmdLN59XrqNlGZjVPMNi/HBDK2g7NgWCbc5v7Es=
X-Google-Smtp-Source: ALg8bN4idQMnzlcuSVedLIDuqNpTFTh1SZJsuMqGXJfGMLxlNexMV53bkJp/fAhAHSNfmwkePvxO3I0YOPRheSYeYAs=
X-Received: by 2002:a2e:5d12:: with SMTP id
 r18-v6mr8884448ljb.89.1547195632259; 
 Fri, 11 Jan 2019 00:33:52 -0800 (PST)
MIME-Version: 1.0
References: <20190108165601.25708-1-pawel.mikolaj.chmiel@gmail.com>
 <20190108165601.25708-3-pawel.mikolaj.chmiel@gmail.com>
In-Reply-To: <20190108165601.25708-3-pawel.mikolaj.chmiel@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 11 Jan 2019 09:33:41 +0100
X-Gmail-Original-Message-ID: <CAJKOXPdZPTP1c1GN-274G0jBMCHZiXk1C3Q+JnergehkuExPXg@mail.gmail.com>
Message-ID: <CAJKOXPdZPTP1c1GN-274G0jBMCHZiXk1C3Q+JnergehkuExPXg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] ARM: dts: s5pv210: aries: Support for more devices
 present on Aries
To: =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_003354_904173_D8775865 
X-CRM114-Status: GOOD (  13.08  )
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

T24gVHVlLCA4IEphbiAyMDE5IGF0IDE3OjU2LCBQYXdlxYIgQ2htaWVsCjxwYXdlbC5taWtvbGFq
LmNobWllbEBnbWFpbC5jb20+IHdyb3RlOgo+Cj4gRnJvbTogSm9uYXRoYW4gQmFra2VyIDx4Yy1y
YWNlcjJAbGl2ZS5jYT4KPgo+IFRoaXMgY29tbWl0IGVuYWJsZXMgZm9sbG93aW5nIGRldmljZXMg
cHJlc2VudCBvbiBBcmllcyBiYXNlZCBwaG9uZXM6Cj4gLSBwd20tdmlicmF0b3IgYXR0YWNoZWQg
dG8gUFdNIDEKPiAtIHBvd2Vyb2ZmIHN1cHBvcnQKPiAtIEF0bWVsIG1hWFRvdWNoIHRvdWNoc2Ny
ZWVuLCBjb25uZWN0ZWQgdG8gaTJjMgo+IC0gQnJvYWRjb20gQkNNNDMyOSBibHVldG9vdGggb3Zl
ciB1YXJ0MAo+Cj4gU2lnbmVkLW9mZi1ieTogSm9uYXRoYW4gQmFra2VyIDx4Yy1yYWNlcjJAbGl2
ZS5jYT4KPiBTaWduZWQtb2ZmLWJ5OiBQYXdlxYIgQ2htaWVsIDxwYXdlbC5taWtvbGFqLmNobWll
bEBnbWFpbC5jb20+Cj4gLS0tCj4gQ2hhbmdlcyBmcm9tIHYxOgo+ICAgIC0gVG91Y2hzY3JlZW4g
aXJxIHBpbiBzaG91bGQgaGF2ZSBQVUxMX05PTkUsIHNpbmNlIGl0J3MgYWxyZWFkeQo+ICAgICAg
cHVsbGVkIHVwIHdpdGggMi44dgo+ICAgIC0gVG91Y2hzY3JlZW4gaXJxIHNob3VsZCBiZSBlZGdl
IGZhaWxpbmcgKGxpa2UgaW4gdmVuZG9yIHNvdXJjZXMpCj4gLS0tCj4gIGFyY2gvYXJtL2Jvb3Qv
ZHRzL3M1cHYyMTAtYXJpZXMuZHRzaSB8IDY4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysK
PiAgMSBmaWxlIGNoYW5nZWQsIDY4IGluc2VydGlvbnMoKykKClRoYW5rcywgYXBwbGllZC4KCkJl
c3QgcmVnYXJkcywKS3J6eXN6dG9mCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
