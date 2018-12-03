Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537AEC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:54:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 222BA20848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ckSChnnu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRFT7NNc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 222BA20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RwAcEEkPOg6A7jIP16JlQdx/0lJKiAEKdxui0uzPDFk=; b=ckSChnnuTx5oA0
	ilgCariChGaGts+ZNSQkNQMgqXBk/7GAUkoVA4UXeOo35eImjApIsjPDtB/PqP6LMkHxit3/usVWN
	PBQvDeAt9bQ+edLeqbmEPcGnXGbygvg+LMq/AQlWizrI/deIzOVqng3V8xPJZtCDOS53q8Ibe4HnQ
	85vxkAaju9PXTuP2lv1Ldey5AU6M30uPE2JgOdzxD4wNiZq0xjbGlb6pwB0LwadEW3xMeAAajERru
	7u6oY9k1CcTealwlBxBbN8E5O4+x/Xm1dEHVTc0G9XVOsokaWhhyTBINWXRGqMDZ4J11mBBm2MtVl
	iisL37MFPHYIeVbL8nVw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTqYH-0004Bf-8m; Mon, 03 Dec 2018 15:54:29 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTqY9-0003ir-51
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 15:54:23 +0000
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com
 [209.85.160.174])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 32ADF20881
 for <linux-arm-kernel@lists.infradead.org>;
 Mon,  3 Dec 2018 15:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543852450;
 bh=zPkBlPtwUJ4e/hJsU/+mrYF7VvXkV+coF16HNC2xL1A=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=XRFT7NNcurH8Qm8xmevCDaDQd24ZeFhkid1MY/UBtNk/KLlIJdoYWWFkPE2Xohexs
 +8tbs31kuhHZlVTP5BINk+it+qVZ+7GHf21Uey6l/ofxltGApXkqkyVu3Vgq6KWHzD
 ZiHpfahDwlzwIwSbD7oyXStJN+xNxpJwJIXrsLP0=
Received: by mail-qt1-f174.google.com with SMTP id d18so14252372qto.8
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 07:54:10 -0800 (PST)
X-Gm-Message-State: AA+aEWZAdm6RhqU+qjaevVDw+Sxyc1fIpW0W7W4+g5vGNt6axjZW7Z4m
 mL/sNMN6VbwB/P1ZYAjyfya8EayFXUw/0hapNA==
X-Google-Smtp-Source: AFSGD/VWWsrKpQup9mQybfjJ6mMLlZgPdcX0XpE+Rn0txEtmCCKSO3FBTxaCtjBgTyPwzi0zs/hDyZW0mAqI6CB5uHU=
X-Received: by 2002:ac8:6b18:: with SMTP id w24mr16126319qts.144.1543852449415; 
 Mon, 03 Dec 2018 07:54:09 -0800 (PST)
MIME-Version: 1.0
References: <20181121033652.12247-1-manivannan.sadhasivam@linaro.org>
 <20181121033652.12247-7-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20181121033652.12247-7-manivannan.sadhasivam@linaro.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 3 Dec 2018 09:53:57 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ=88ORdgbRDn+VWk9=ydShidqwOxdAMfDbH4W2drnXzA@mail.gmail.com>
Message-ID: <CAL_JsqJ=88ORdgbRDn+VWk9=ydShidqwOxdAMfDbH4W2drnXzA@mail.gmail.com>
Subject: Re: [PATCH v2 06/15] arm: dts: Add devicetree for OrangePi 2G IoT
 board
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_075421_484267_4FF4AFAA 
X-CRM114-Status: GOOD (  15.33  )
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
Cc: devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Amit Kucheria <amit.kucheria@linaro.org>,
 "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
 Jiri Slaby <jslaby@suse.com>, Thomas Gleixner <tglx@linutronix.de>,
 overseas.sales@unisoc.com, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, zhao_steven@263.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVHVlLCBOb3YgMjAsIDIwMTggYXQgOTozOCBQTSBNYW5pdmFubmFuIFNhZGhhc2l2YW0KPG1h
bml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnPiB3cm90ZToKPgo+IEFkZCBpbml0aWFsIGRl
dmljZXRyZWUgc3VwcG9ydCBmb3IgT3JhbmdlUGkgMkcgSW9UIGJvYXJkIGZyb20gWHVubG9uZy4K
Pgo+IFNpZ25lZC1vZmYtYnk6IEFuZHJlYXMgRsOkcmJlciA8YWZhZXJiZXJAc3VzZS5kZT4KPiBT
aWduZWQtb2ZmLWJ5OiBNYW5pdmFubmFuIFNhZGhhc2l2YW0gPG1hbml2YW5uYW4uc2FkaGFzaXZh
bUBsaW5hcm8ub3JnPgo+IC0tLQo+ICBhcmNoL2FybS9ib290L2R0cy9NYWtlZmlsZSAgICAgICAg
ICAgICAgICAgICAgfCAgMiArCj4gIC4uLi9ib290L2R0cy9yZGE4ODEwcGwtb3JhbmdlcGktMmct
aW90LmR0cyAgICB8IDQwICsrKysrKysrKysrKysrKysrKysKPiAgMiBmaWxlcyBjaGFuZ2VkLCA0
MiBpbnNlcnRpb25zKCspCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybS9ib290L2R0cy9y
ZGE4ODEwcGwtb3JhbmdlcGktMmctaW90LmR0cwo+Cj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jv
b3QvZHRzL01ha2VmaWxlIGIvYXJjaC9hcm0vYm9vdC9kdHMvTWFrZWZpbGUKPiBpbmRleCBiMGU5
NjZkNjI1YjkuLmEwZmRhZDhmMTBkZCAxMDA2NDQKPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9N
YWtlZmlsZQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL01ha2VmaWxlCj4gQEAgLTgwNiw2ICs4
MDYsOCBAQCBkdGItJChDT05GSUdfQVJDSF9RQ09NKSArPSBcCj4gICAgICAgICBxY29tLW1zbTg5
NzQtc29ueS14cGVyaWEtY2FzdG9yLmR0YiBcCj4gICAgICAgICBxY29tLW1zbTg5NzQtc29ueS14
cGVyaWEtaG9uYW1pLmR0YiBcCj4gICAgICAgICBxY29tLW1kbTk2MTUtd3A4NTQ4LW1hbmdvaC1n
cmVlbi5kdGIKPiArZHRiLSQoQ09ORklHX0FSQ0hfUkRBKSArPSBcCj4gKyAgICAgICByZGE4ODEw
cGwtb3JhbmdlcGktMmctaW90LmR0Ygo+ICBkdGItJChDT05GSUdfQVJDSF9SRUFMVklFVykgKz0g
XAoKUXVlc3Rpb24gZm9yIEFybmQvT2xvZjogY2FuIHdlICpwbGVhc2UqIHN0YXJ0IHB1dHRpbmcg
bmV3IFNvQyBmYW1pbGllcwppbiBzdWItZGlycz8KClJvYgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QK
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
