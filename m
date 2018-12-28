Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79ACC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:19:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B68B520874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D8SEIMXP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5GrK7QW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B68B520874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=LWyazAz49dQXxKFqua6emPTf5VMV4uSjZRUJhMFS14M=; b=D8SEIMXP7BcAxm
	oJeZzfNpsTKGxH1zDCH/EHfyDi7xUdwxzdb7w/Cyxnie0InFpuBCfxH28FdykPySIvrzuMw2FLQi0
	m4XsTagVbyvzULCWIfjWhr6OSOoUTPZ5myV2CUZr0rPx6QwEiBAJaYtdzmO7B01rIGOvzDYO50dPy
	Uq9SNureEm6+9wJoqx9ZJiretJzsfJeUKa7MF2cssuKmO7DS67Lk9QwLOMhFg+jwRX3fOmngHtJFo
	7rw0Cwy2mvJnsv8BjhsypkabcZgQcKD0/kQExx/Fd0m0WuNuAHhSdYtlFImc/IoGQEg6nDaAhv4sR
	fXEeBtayTq3VWfPaVLtQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gctvN-0008WO-Ha; Fri, 28 Dec 2018 15:19:45 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gctvK-0008Vm-7C
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 15:19:44 +0000
Received: by mail-lf1-x144.google.com with SMTP id e26so14763469lfc.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 28 Dec 2018 07:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9d49aBJNh7GrHY65V1PzLXouo3n3U60A46Zt1GxLt60=;
 b=g5GrK7QW5rvkGbZVfcKa0UDTnZMhppExbS7Rh8AtxaYaabOp7Lx3+fXGXbiyA0rzG7
 hIE/R2KfUijQWlH+PL8Q3R1kT7wj8A6WlQSkCdc6Z8plxfWcr8qmivXrlsjSAqLLTQ+L
 cVdbiDy7EhVQ6qV0xmnY12N4BWzGxZkU8Pshr3IObch660jlHqC9xQzEd26TcELpGzyk
 kQbWUMQ7IjkhC9xtIvhp5lFLnGfIYCeHte21bwVptbS+edeqhCMiGI98RZGpvLN6Tx8P
 CaMSy/CYH8BvzWiSOl+VsyQGUDz6KgW8edjRRIAiFm2aDoOfpQmmDi4DLnf5r1ENsAXa
 3PJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9d49aBJNh7GrHY65V1PzLXouo3n3U60A46Zt1GxLt60=;
 b=tH7enhotkGO95agzFq0Tb2crD9LZO5gd95EWek0Qqz5uXUuljKPAIUeemV8XuD4Ryj
 YHNsOZsjV35f2iby3xfNgv4IN+ny+NJ76EmCBK4fugSDnUICIj10D+G8/oUsYBFeLLvM
 9vWtDWdZerdkNwI6zZK8gjJ88DGAfCGGBgDpUo8zIe1HPx/Ul4e2NhAX4JuFXxiTh4ue
 obUGlY9e4OA0cxtxF8rVjFOee5dBnQ3CV3MnrNnVkWfCDljQysR3IPZA7ajxflbxpSno
 +lXcU7cqxA0InQzahtksyA6bC0Fhy/seTa4yY0c+wAoQwMksQlSuajai6tR9yQNrgy7n
 Y98A==
X-Gm-Message-State: AA+aEWYYv/dblhnC9p2zA5GhI1IOmw7ZL4uQYkbZtGP64Cp4+kFl3pHQ
 yT772qq/PCLdGYGn/ZRZSoI=
X-Google-Smtp-Source: AFSGD/UTmAYOInFAWM4uvvTang73uSr38uYkOrdHoN7K5qcGiCjGYskp9put4k+MrxVZpvlYqkj5Tw==
X-Received: by 2002:a19:d5:: with SMTP id 204mr13259672lfa.116.1546010369714; 
 Fri, 28 Dec 2018 07:19:29 -0800 (PST)
Received: from localhost.localdomain
 ([2a02:a315:5445:5300:7146:fd07:48ff:9665])
 by smtp.googlemail.com with ESMTPSA id s24sm7872704lfc.30.2018.12.28.07.19.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 28 Dec 2018 07:19:28 -0800 (PST)
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: inki.dae@samsung.com,
	krzk@kernel.org,
	airlied@linux.ie
Subject: [PATCH v2 0/3] drm/exynos: rotator: Add support for s5pv210
Date: Fri, 28 Dec 2018 16:19:01 +0100
Message-Id: <20181228151904.12079-1-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_071942_284209_CE708DE4 
X-CRM114-Status: GOOD (  10.62  )
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
NjA0OTguaHRtbAoKQ2hhbmdlcyBmcm9tIHYxOgogIC0gZml4ZWQgb3JkZXIgb2YgY2hpcHNldHMg
aW4gZG9jdW1lbnRhdGlvbiBhbmQgcmVtb3ZlZCBvcmRlcmluZwogICAgZnJvbSBpdAoKUGF3ZcWC
IENobWllbCAoMyk6CiAgZHJtL2V4eW5vczogcm90YXRvcjogQWRkIHN1cHBvcnQgZm9yIHM1cHYy
MTAKICBkdC1iaW5kaW5nczogZ3B1OiBzYW1zdW5nLXJvdGF0b3I6IERvY3VtZW50IHM1cHYyMTAg
c3VwcG9ydAogIEFSTTogZHRzOiBzNXB2MjEwOiBBZGQgbm9kZSBmb3IgZXh5bm9zLXJvdGF0b3IK
CiAuLi4vYmluZGluZ3MvZ3B1L3NhbXN1bmctcm90YXRvci50eHQgICAgICAgICAgfCAgNyArKyst
LS0KIGFyY2gvYXJtL2Jvb3QvZHRzL3M1cHYyMTAuZHRzaSAgICAgICAgICAgICAgICB8ICA5ICsr
KysrKysrCiBkcml2ZXJzL2dwdS9kcm0vZXh5bm9zL2V4eW5vc19kcm1fcm90YXRvci5jICAgfCAy
MyArKysrKysrKysrKysrKysrKysrCiAzIGZpbGVzIGNoYW5nZWQsIDM2IGluc2VydGlvbnMoKyks
IDMgZGVsZXRpb25zKC0pCgotLSAKMi4xNy4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
