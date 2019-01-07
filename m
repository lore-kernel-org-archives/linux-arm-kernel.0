Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731FCC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 20:29:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21CD62173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 20:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Au4s8psr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21CD62173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OY85aWgsw3a8/eeL15hbupMKZAe6PSzIdC1Wg+jdjyo=; b=Au4s8psrWVV+6s
	Gj2MlaNyxUDA21ulcKDgbbFnV6HB8g+cQyN429B53nmoeqE/vMBvI+N4vP6gWEMBYiujL8Fjtj2yQ
	nSTnsaKj0EhlpitBHInqqL7tSc1O88s5odnJxyGV7vFeCiOcI7y3L2pe3710BXG3kCMhYJ5EyVX70
	0rIzZElXZ/48i4/oPaOz4ZJbq7HJCbE3utP4PEHXq7TsxixHmfpFrpNs8Fe6ivTQmB/0yhTD9aXVC
	GA6geWEliPVIOUYckmkVRxC5dOWICezN+9+nWG3oCbo5u/03YmLtXG67UYXUzgrb/6dWmyGdxNRjw
	HH2fhYgn9+ZfA36WaR0Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggbWT-00017w-LL; Mon, 07 Jan 2019 20:29:21 +0000
Received: from mail-ed1-f67.google.com ([209.85.208.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggbWQ-00017Q-9G
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 20:29:20 +0000
Received: by mail-ed1-f67.google.com with SMTP id b14so2146518edt.6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 07 Jan 2019 12:29:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=NLh9TviOHL95KaLbs99nNqTK8EJIAJzILq5WanPkzlA=;
 b=EPCNL/wPlflSycjrYzGMLcKK9OL5RlmslR1XWKbcY/FYg1hj7qftEXbf5XmcMZ3LEE
 /0bP44MNb9ENxWYB4zf5h2OvAGp1UWiM5WxTvrJCbAygANXdC2YVS+1qZnpqgCmEWUjM
 xt+LXeaXEVsXtNuIkKRXiHtxNbcTVEvdzZyk4EyGEOOy7nXy5yQy815TfKILz1rIkZH5
 bydxvvfOD65CIGLi9wab80Z52ZVZ626m21k3vh22FSccsFtpZnArM64GGBQa7AAlRwzt
 FXPQF2nB7o66iLCPUaoq8hN01xnvX/bVcGL77pKmWzO9f9JAvSg4bCmpRbGxMEvzgLry
 JGVQ==
X-Gm-Message-State: AA+aEWb1vh5rt8F5EW38UyRA9sQ+dMVtlp8zQL91OiK01QSRldxoWj/9
 QvXqSnY2XCliDKMdwgARcnI=
X-Google-Smtp-Source: AFSGD/VkPfTwc73TNzvTWivUfKtcLdLV9NeBpvpnKj/APJW+eu4Vj+t+n7uckkcgOOyrO2Y4/P3YuA==
X-Received: by 2002:a50:b623:: with SMTP id b32mr55094679ede.55.1546892956823; 
 Mon, 07 Jan 2019 12:29:16 -0800 (PST)
Received: from kozik-lap ([194.230.155.148])
 by smtp.googlemail.com with ESMTPSA id m14sm38643638edc.27.2019.01.07.12.29.15
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 07 Jan 2019 12:29:16 -0800 (PST)
Date: Mon, 7 Jan 2019 21:29:13 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Subject: Re: [PATCH v2 3/3] ARM: dts: s5pv210: Add node for exynos-rotator
Message-ID: <20190107202913.GB21920@kozik-lap>
References: <20181228151904.12079-1-pawel.mikolaj.chmiel@gmail.com>
 <20181228151904.12079-4-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181228151904.12079-4-pawel.mikolaj.chmiel@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_122918_316496_A730CFE3 
X-CRM114-Status: GOOD (  11.80  )
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
 linux-samsung-soc@vger.kernel.org, jy0922.shim@samsung.com, airlied@linux.ie,
 sw0312.kim@samsung.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, inki.dae@samsung.com, robh+dt@kernel.org,
 kyungmin.park@samsung.com, kgene@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gRnJpLCBEZWMgMjgsIDIwMTggYXQgMDQ6MTk6MDRQTSArMDEwMCwgUGF3ZcWCIENobWllbCB3
cm90ZToKPiBUaGlzIGNvbW1pdCBhZGRzIG5vZGUgZm9yIEV4eW5vcyBSb3JhdG9yIGRldmljZSwK
PiBzbyBpdCBjYW4gYmUgdXNlZCBvbiBhbGwgczVwdjIxMCBiYXNlZCBkZXZpY2VzLgo+IAo+IFNp
Z25lZC1vZmYtYnk6IFBhd2XFgiBDaG1pZWwgPHBhd2VsLm1pa29sYWouY2htaWVsQGdtYWlsLmNv
bT4KPiAtLS0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvczVwdjIxMC5kdHNpIHwgOSArKysrKysrKysK
ClRoYW5rcywgYXBwbGllZC4KCkJlc3QgcmVnYXJkcywKS3J6eXN6dG9mCgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWls
aW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
