Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3686AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:05:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 046FA218D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ON41G4tb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Je+P+wTi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 046FA218D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZXho4YqUi1p0MVtPlhHJEWv3jTZ81+/+HCrW3ys4ZHo=; b=ON41G4tb7TFWaY
	F7RI6sAzQ8NZMWhGcZk2XL0OIA0Y9+kIQkTyfT2TTyzvLwtgNeziFKutx+xF5IwmvtwARcKNKkPTY
	062n0mja9rhTEkOae2ifqf+7LFWN6PAbJu7Crw0Hin3bC9nCK5vEHuxG46eRj9BryatV2N3uDy7OG
	/Dzl1UZ71qFvjH5AwIKxIxd6hB0HxP9W4q9d2rCMFQozjTgGFm/jynw7JdYiqf1KNNxJE6E38vOeH
	kUwF24/ekT+wXawbEICxKPa0yT6issOZBDBSojPW85GzS/80EZUHCsUUi5Kgtt3uJ50lusWrgD0JA
	3/QNXDIF1+wim07zWS6w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZeLc-0002pC-VK; Wed, 19 Dec 2018 16:05:25 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZeKu-00010S-Ir
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 16:04:43 +0000
Received: by mail-lj1-x242.google.com with SMTP id q2-v6so6731215lji.10
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 19 Dec 2018 08:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ngVQAKuo8iZ2AhPYUfFDSDo8oErenzKZAMdi0+QR+xU=;
 b=Je+P+wTiSS132/OYNBJGWFuMnRcNMqVyFWYK6HkGA/dcKfF0tcaVSq+Ppt+Yyn8XMp
 sFLDoz+Ml1N9X/4/3qBnyGsF7uQmNYYqpJClJ1LO6luPJhV6TlMHlbyunVyvJfmQAkNm
 /Q3oFP6xQzsN73uAPPGe0TY3vByM2sUKE2uC+p8oVHjv9GDXJmLCY3Mqt8w6oXYmmBTo
 tgqvus6CGNGTYG6bPrxRO1UqHbh14e8SchEnY197n7b0+XQpJU499Yyoa9fTKpNOWHak
 rY+tEPSWPXfYjGYmriOY3WbK4udIuIt9o6+WpRlmEwjKu3OIPpxBgHJsnem0LEJ1YRcM
 5gkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ngVQAKuo8iZ2AhPYUfFDSDo8oErenzKZAMdi0+QR+xU=;
 b=IPN4ACc4ewZg1fLJOBwN1uYXHZLkeIQ12fj2IofGQG/tZ2tzkbY1zwjNADCIKwIuvy
 ojEqYx3NZRbzcbiLRN7Dnl6uvgEuwERpu2ajoh4tS8DYmlfmepw6G7hE8NuodN01Asjf
 AmmIqUg/ap76/+q+rh3QODrI4N0bpJkQYEvpCo7PNerKqWHX+WMtnJLzvk33sVIlO3DB
 OaoAcY9vlbh7Xe+gfG3u815aCLVQqj/u63NkbyOzFP4UpiWbPjtXx7DIEbLvzaKYTPJT
 pfxci9IQQVYLADiPqHYUMD4yJmI+mTR1bFkqRumXAZV1NXXM/00j07+LbKsQcniM93/V
 c1tQ==
X-Gm-Message-State: AA+aEWZEpIz8qhgtlLuFwitvP1vDMw2PfNzk4BmTGHAvIb91Jm9Ixp/j
 XWp3D1kh2MG2uXG7VhqAziI=
X-Google-Smtp-Source: AFSGD/UiKeMYiz1n1P+y93y49ttH2Vl+kPk/qIKf8YwCLriepYxMihJFvJpC/nHEu4WzLQnGn8WSSQ==
X-Received: by 2002:a2e:2a46:: with SMTP id
 q67-v6mr11164912ljq.38.1545235468587; 
 Wed, 19 Dec 2018 08:04:28 -0800 (PST)
Received: from localhost.localdomain
 ([2a02:a315:5445:5300:253f:4197:555d:bfba])
 by smtp.googlemail.com with ESMTPSA id i75sm3943979lfb.58.2018.12.19.08.04.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 19 Dec 2018 08:04:27 -0800 (PST)
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: inki.dae@samsung.com,
	krzk@kernel.org,
	airlied@linux.ie
Subject: [PATCH 2/3] dt-bindings: gpu: samsung-rotator: Document s5pv210
 support
Date: Wed, 19 Dec 2018 16:57:03 +0100
Message-Id: <20181219155704.15264-3-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181219155704.15264-1-pawel.mikolaj.chmiel@gmail.com>
References: <20181219155704.15264-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_080440_692264_3A406078 
X-CRM114-Status: GOOD (  13.24  )
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

VGhpcyBjb21taXQgZG9jdW1lbnRzIG5ldyBjb21wYXRpYmxlIGZvciBzNXB2MjEwIHNvYywKd2hp
Y2ggd2lsbCBiZSBhbHNvIHN1cHBvcnRlZCBieSB0aGlzIGRyaXZlci4KClNpZ25lZC1vZmYtYnk6
IFBhd2XFgiBDaG1pZWwgPHBhd2VsLm1pa29sYWouY2htaWVsQGdtYWlsLmNvbT4KLS0tCiBEb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZ3B1L3NhbXN1bmctcm90YXRvci50eHQgfCAx
ICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ncHUvc2Ftc3VuZy1yb3RhdG9yLnR4dCBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ncHUvc2Ftc3VuZy1yb3RhdG9yLnR4dAppbmRl
eCA4MmNkMWVkMGJlOTMuLjc4NjU4ZGVjNjk0MSAxMDA2NDQKLS0tIGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2dwdS9zYW1zdW5nLXJvdGF0b3IudHh0CisrKyBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ncHUvc2Ftc3VuZy1yb3RhdG9yLnR4dApAQCAtNSw2
ICs1LDcgQEAgUmVxdWlyZWQgcHJvcGVydGllczoKIAkoYSkgInNhbXN1bmcsZXh5bm9zNDIxMC1y
b3RhdG9yIiBmb3IgUm90YXRvciBJUCBpbiBFeHlub3M0MjEwCiAJKGIpICJzYW1zdW5nLGV4eW5v
czQyMTItcm90YXRvciIgZm9yIFJvdGF0b3IgSVAgaW4gRXh5bm9zNDIxMi80NDEyCiAJKGMpICJz
YW1zdW5nLGV4eW5vczUyNTAtcm90YXRvciIgZm9yIFJvdGF0b3IgSVAgaW4gRXh5bm9zNTI1MAor
CShkKSAic2Ftc3VuZyxzNXB2MjEwLXJvdGF0b3IiIGZvciBSb3RhdG9yIElQIGluIFM1UFYyMTAK
IAogICAtIHJlZyA6IFBoeXNpY2FsIGJhc2UgYWRkcmVzcyBvZiB0aGUgSVAgcmVnaXN0ZXJzIGFu
ZCBsZW5ndGggb2YgbWVtb3J5CiAJICBtYXBwZWQgcmVnaW9uLgotLSAKMi4xNy4xCgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5l
bCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
