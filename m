Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22115C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:04:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4362214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mvFTJV1a";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHghWIdH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4362214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=tjKnZ6zVsYcfQj6ltSGpNfX14HhD8aSg+nL7lO73b3s=; b=mvFTJV1aNw7HnY
	5gAHpO/iv1a7rCi1Oe/tPSltMXS2ynefis7s+eAE+Ff4g+T8fPE9JZCY/zM2fQ/lCmsA619I+o8Pf
	cVLGkZIsfbH0TSw91CXjttHLbeFtORjz2drOxwmvswYY+INtMctYYDu+zHXWLgkW2zFb1FC0tXZxI
	ITSnfCqxPkF925nCnUHLdPT+hM1vS1aCKkB6n37W0sfefaB6qfz+7shaVOYUagNOAp64x5V+3fNRj
	hCtgjZuVeMjAuWUgY7acS0QfIqye8gS+nOXkxfgwCAyuXI/a0vu+BIszOnSFxAoVZMSmZbkieDof7
	JoJXAYRtEX8phZHbX2/w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZeKv-00011B-3a; Wed, 19 Dec 2018 16:04:41 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZeKr-00010K-IN
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 16:04:39 +0000
Received: by mail-lj1-x243.google.com with SMTP id x85-v6so17881785ljb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 19 Dec 2018 08:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SAUcPazIZwM1OnutktLk/uqXZzFMyPW/6RsuxIaDmiQ=;
 b=eHghWIdHJ+NjjhpXisQfhM3d67/F8mAexOkNDBE00gRdvjyZ7/YJjehGqxMt32ohU3
 sO/QXaUWemTQs12nJjBEHtbwUqN715D4m4+GFFiH3auMZR8YrgAnEcW0ovjXp+Xt35uU
 Eqyyq8v9LyEd83076NvYJeyIlSLvS434CikVvIjXQ/MAI+8Oge1R2VEjbyRgEmf13Vb8
 iIzBUdN3uDprrB+Uy8JZLMx4BZKgOkAuV+2j+mVKGez+nlmA8wRdtTKptkpKDfyAKkwO
 8GqUiJl/rdn2CTcGtSrQB3Q4XST393NPDVFvfPJRajKKFKpv3Pl0OyarwmAibx+MF5pI
 9wUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SAUcPazIZwM1OnutktLk/uqXZzFMyPW/6RsuxIaDmiQ=;
 b=asQ+4AwheaxUXgz5Bv3qUjJib4bnkTxDye2pEMkTCQ5C0v9nlzCot+S/Rc24DDKLN3
 9GajuUd5NMQAGMJu7H8DeyiwgalNptKDNFv6/voKXBuIQPxwbZ85jqwUxSmAGMOTwUrV
 gzhNca4Z+JIcKBnW9V/Ktnu8KQGycGYiLm/cPT7im0gk8n1KnQ1+Ny/QO/uaXXhN33LU
 GgZ1K6Nzh2C+oLEkEurEiuCeIdfLL2rz8fa6nAZQcPrvZ7q1ECAJzqwP9QcQlHEqli5c
 UuwC8oQL2y89qNjNLOZ0JyuheU2Uaw/QrRTaaBeVil6HQe5iy+KU3S7sa74LhJ5uMabV
 SfuQ==
X-Gm-Message-State: AA+aEWZde7yu4nHViIL9pK3qBjtxAyRYxav6ujYQk66plXU070ifZMbR
 HP8bQc/UgQ9vTBAJvTWMeSA=
X-Google-Smtp-Source: AFSGD/VeNDhvZLGS2jLxCp2f5Be6z8S92etd3HVV4WESVDWzEoFPQGOPJJSh8w/Rbn/uYg4B0uDGLw==
X-Received: by 2002:a2e:6109:: with SMTP id
 v9-v6mr6578802ljb.126.1545235465190; 
 Wed, 19 Dec 2018 08:04:25 -0800 (PST)
Received: from localhost.localdomain
 ([2a02:a315:5445:5300:253f:4197:555d:bfba])
 by smtp.googlemail.com with ESMTPSA id i75sm3943979lfb.58.2018.12.19.08.04.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 19 Dec 2018 08:04:24 -0800 (PST)
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: inki.dae@samsung.com,
	krzk@kernel.org,
	airlied@linux.ie
Subject: [PATCH 0/3] drm/exynos: rotator: Add support for s5pv210
Date: Wed, 19 Dec 2018 16:57:01 +0100
Message-Id: <20181219155704.15264-1-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_080437_632133_1CEA2B92 
X-CRM114-Status: GOOD (  11.64  )
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
 linux-samsung-soc@vger.kernel.org, jy0922.shim@samsung.com,
 sw0312.kim@samsung.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, robh+dt@kernel.org, kyungmin.park@samsung.com,
 kgene@kernel.org, linux-arm-kernel@lists.infradead.org,
 =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VGhpcyBwYXRjaHNldCBhZGRzIHN1cHBvcnQgZm9yIHM1cHYyMTAgc29jLCBpbnRvIApTYW1zdW5n
IERSTSBSb3RhdG9yIGRyaXZlci4gQ3VycmVudGx5IG9ubHkgTlYxMiBhbmQgWFJHQjg4ODggZm9y
bWF0cwogYXJlIHN1cHBvcnRlZC4KCkl0IHdhcyB0ZXN0ZWQgYnkgdXNpbmcgc2ltcGxlIHRvb2wg
ZnJvbSAKaHR0cHM6Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMvbGludXgtc2Ftc3VuZy1zb2MvbXNn
NjA0OTguaHRtbAoKUGF3ZcWCIENobWllbCAoMyk6CiAgZHJtL2V4eW5vczogcm90YXRvcjogQWRk
IHN1cHBvcnQgZm9yIHM1cHYyMTAKICBkdC1iaW5kaW5nczogZ3B1OiBzYW1zdW5nLXJvdGF0b3I6
IERvY3VtZW50IHM1cHYyMTAgc3VwcG9ydAogIEFSTTogZHRzOiBzNXB2MjEwOiBBZGQgbm9kZSBm
b3IgZXh5bm9zLXJvdGF0b3IKCiAuLi4vYmluZGluZ3MvZ3B1L3NhbXN1bmctcm90YXRvci50eHQg
ICAgICAgICAgfCAgMSArCiBhcmNoL2FybS9ib290L2R0cy9zNXB2MjEwLmR0c2kgICAgICAgICAg
ICAgICAgfCAgOSArKysrKysrKwogZHJpdmVycy9ncHUvZHJtL2V4eW5vcy9leHlub3NfZHJtX3Jv
dGF0b3IuYyAgIHwgMjMgKysrKysrKysrKysrKysrKysrKwogMyBmaWxlcyBjaGFuZ2VkLCAzMyBp
bnNlcnRpb25zKCspCgotLSAKMi4xNy4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
