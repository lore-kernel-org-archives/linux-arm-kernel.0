Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA576C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:05:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA96F21873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aLu5kfzM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="f6ivAqyq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA96F21873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cPuos1iimq4A1/IGNODBZeEYvxZ2bYOMpzcjPQuG0yg=; b=aLu5kfzMYQLpgC
	2fI4PMysDKm8Ch+zaD7zkqzVf9lQTr15J3DXfKQsFXD6ahut5Pojcnfg4iGKHcycuq3shk+/NO40C
	5nE65FnUtuwZZAxejgAfWxotXx4//KE4O6fmDfv3ILhyHtuJEHMEe1w8dv8KoLVxocSjPoEIVy1eN
	HkPiCx8ji1OCU4iRMA1S3Ew2a77TcNvWE14Q1RLf0oeQV3Tht0LoUMCeKlGw5C8mdDWjDO7vBWFCU
	ouKjJircU0dpT/KwraOWXkrI81QtAR1ma8qCOZltSOMYYHBla7tL5GEyPkuqP5CKSsd/8bvBEDUhJ
	Nn2FG1YbUCr01k2709EA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZGw0-00038L-UZ; Tue, 18 Dec 2018 15:05:24 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZGuh-0000n5-QT
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 15:04:19 +0000
Received: by mail-pf1-x441.google.com with SMTP id z9so8268613pfi.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 07:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zcGwIisGD3xe1Hi10sfTFo4sWeyzLGuK/X6UgTn9Mq8=;
 b=f6ivAqyq0w5nlhZ64fTOLvUYLzZCviL2IHcDV94FRjYkb0hO0NBSAsTuGvvRQfhbLM
 IwTNxva5mndlup6iOhak/AtnTwbiJ1iKCa+CaAWCe4OaMy3a6ma33tcuxN8K8z8vFRvc
 DqKEee/E1gR9OIsfDHQ49/vXQfOAA3695ETos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zcGwIisGD3xe1Hi10sfTFo4sWeyzLGuK/X6UgTn9Mq8=;
 b=GjPm1UyQJrqvPBcD0UEXhX1+1u0y8oS9wj8LK4306uDw58+aMEaxUbYj+RzPtJiCgK
 kU/6hK28CIyYffhXQplPv2y36hASv0vKsvbtEjyMaXCCWymkS60n5SqDhEW6sCjN9G8c
 yzhNDxhPHxB3Q06RZtc1C3mfkxhJ2y6UNcWyUmfeZxwAyT6DjfTOeOqmKOwLzVvAHjaM
 xHM7m5VBu/g7mFUw8yL40IvzwTRjft5LznTrziB4xL7z1k5NTUbGqpOOfIJA5T1N3mU5
 4sQuaDkOUt3nYZl4O9t01mMZzRFq1wTn/a2cdRV15Nyvibt988st+v4OomtYOF7+peNl
 +mtg==
X-Gm-Message-State: AA+aEWaR6NH0aX81azLeVhb1ZgieB/Px6VkqJTOa8WaEwVroqh/mk9Nz
 0cBtitqOZdLzOzcBpPk4Cz8P
X-Google-Smtp-Source: AFSGD/UPjymwPQoXl7pFQFBvNtOwB9L8rNCGFVk4qL2jb46eilT7lTlW0tBBQGWkPvdR9FeaISMxzA==
X-Received: by 2002:a63:8742:: with SMTP id i63mr3163859pge.298.1545145433135; 
 Tue, 18 Dec 2018 07:03:53 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
 by smtp.gmail.com with ESMTPSA id m198sm28798688pga.10.2018.12.18.07.03.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Dec 2018 07:03:52 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: olof@lixom.net, arnd@arndb.de, arm@kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 07/11] ARM: dts: rda8810pl: Add timer support
Date: Tue, 18 Dec 2018 20:32:34 +0530
Message-Id: <20181218150238.23010-8-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218150238.23010-1-manivannan.sadhasivam@linaro.org>
References: <20181218150238.23010-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_070403_984881_E39D918B 
X-CRM114-Status: GOOD (  12.59  )
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
Cc: devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
 linus.walleij@linaro.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-kernel@vger.kernel.org, amit.kucheria@linaro.org,
 linux-unisoc@lists.infradead.org, robh+dt@kernel.org,
 linux-serial@vger.kernel.org, jslaby@suse.com, afaerber@suse.de,
 zhao_steven@263.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QWRkIHRpbWVyIHN1cHBvcnQgZm9yIFJEQSBNaWNybyBSREE4ODEwUEwgU29DLgoKU2lnbmVkLW9m
Zi1ieTogQW5kcmVhcyBGw6RyYmVyIDxhZmFlcmJlckBzdXNlLmRlPgpTaWduZWQtb2ZmLWJ5OiBN
YW5pdmFubmFuIFNhZGhhc2l2YW0gPG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnPgpB
Y2tlZC1ieTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4KLS0tCiBhcmNoL2FybS9ib290
L2R0cy9yZGE4ODEwcGwuZHRzaSB8IDEwICsrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxMCBp
bnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvcmRhODgxMHBsLmR0
c2kgYi9hcmNoL2FybS9ib290L2R0cy9yZGE4ODEwcGwuZHRzaQppbmRleCAxNTU0N2IxMzg5Nzcu
Ljg0YmFhNGMwYTE0YyAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvcmRhODgxMHBsLmR0
c2kKKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvcmRhODgxMHBsLmR0c2kKQEAgLTYsNiArNiw4IEBA
CiAgKiBDb3B5cmlnaHQgKGMpIDIwMTggTWFuaXZhbm5hbiBTYWRoYXNpdmFtCiAgKi8KIAorI2lu
Y2x1ZGUgPGR0LWJpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL2lycS5oPgorCiAvIHsKIAlj
b21wYXRpYmxlID0gInJkYSw4ODEwcGwiOwogCWludGVycnVwdC1wYXJlbnQgPSA8JmludGM+OwpA
QCAtNTAsNiArNTIsMTQgQEAKIAkJI2FkZHJlc3MtY2VsbHMgPSA8MT47CiAJCSNzaXplLWNlbGxz
ID0gPDE+OwogCQlyYW5nZXMgPSA8MHgwIDB4MjA5MDAwMDAgMHgxMDAwMDA+OworCisJCXRpbWVy
QDEwMDAwIHsKKwkJCWNvbXBhdGlibGUgPSAicmRhLDg4MTBwbC10aW1lciI7CisJCQlyZWcgPSA8
MHgxMDAwMCAweDEwMDA+OworCQkJaW50ZXJydXB0cyA9IDwxNiBJUlFfVFlQRV9MRVZFTF9ISUdI
PiwKKwkJCQkgICAgIDwxNyBJUlFfVFlQRV9MRVZFTF9ISUdIPjsKKwkJCWludGVycnVwdC1uYW1l
cyA9ICJod3RpbWVyIiwgIm9zdGltZXIiOworCQl9OwogCX07CiAKIAlhcGJAMjBhMDAwMDAgewot
LSAKMi4xNy4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtYXJtLWtlcm5lbAo=
