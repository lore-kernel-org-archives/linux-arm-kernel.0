Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA93C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:20:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5814A20874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l3ccmbcD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o3g+b1zR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5814A20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pS6YJzQGcncay4ExCb1ix5zMWk0xgICRPk50UVmHWqo=; b=l3ccmbcDzzmjP2
	AZW/SsMLc5LUVzO/zEczLcbfdrl8ZL0LaC38Rh0tx+iaCn5juu7JWzdO/9HYS2QKBlpZYZ2mfdvfJ
	xAKu7hs8pGSHer8EIu63UR38AW6KXe6H+3Z4wpg9CA0FZeFWPOEOMl7wRUjD0G8A00ltPj7MLvUK7
	OnpT89sQiI10i3wlErRYrcU4erYd+OW/95mfiU8PZGFvvInOWhSRtn/AbzZ2uVa20d9yHbV9fLgfr
	LPJ8IPTzCi/4ogp7AMiYuMNBsFzkfWthWk6ORqU941Y5HrR/ncE0SE38lrcWtX9PUyqh4adFaZjgu
	o1vFCCcTD523l24L/v5w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gctvr-00017L-Ra; Fri, 28 Dec 2018 15:20:15 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gctvO-0008Vs-Fo
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 15:19:49 +0000
Received: by mail-lf1-x142.google.com with SMTP id i26so14772591lfc.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 28 Dec 2018 07:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tl+fPCGKybsyERJ7fDUtUUMflSNz3puUm0HFiy6tknk=;
 b=o3g+b1zR4yXudKtvdOkeGyXSFEmW6vKH+L0u+xNaCjGtTYjiA10eqAsQwgWXE2ywwT
 vsijve+DBDyu6lX1Lo6SNuKcSIdjnbk1rPO3x7GlpvQxEfQLFoGhfwTBVcACbWQWBmn/
 MsNMrNnfxnVSmcezb306xvPpueMVSVDm7dNg/uBEfs6dPaBahTq0PUGT8C179AMA1Ggz
 PGGwtmNKxZYNLQQnI/4eMs7Q4Irs46qQ2kvUuFM3zdUYaP2deduuo2v/tgz15/Neb7gz
 RHrkKXFOvaOg2LgRqNGox9kSI+e9D+JRM+VCiE97xQEIR6A7YOZEHx3bF/CZv8/eWuv2
 WTKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tl+fPCGKybsyERJ7fDUtUUMflSNz3puUm0HFiy6tknk=;
 b=PZK/pHKuBICnTf8RgUmxPvf7v0W7sJmBGzAP+EMW4HvBpLw4kzB805t0uPhPlORiHM
 UswZ8qJcyReriGSW7TefceRoAwpTbxSiMbOHv/5EjNnttoW+TuLXrkngEmV99huVPOvS
 C6UZeKbVGuCBDPifGKp7gNHuj6s/OF7R1uBGd7bmQqOBboBp6ZUs4S8q7U/tfTEiejhR
 NiFcn+guZhStkzin6Il8G0bE5pBACetN0pFjdUEl5zMj17KnEdp0tNh1nsgqydEbozwq
 1GQXXGhUsLmSKiNoRnxTqeH2zGRsQ1LThklWVRjffSIhMJPEc4AOBvTZqyMUVyeNJd0i
 a3Uw==
X-Gm-Message-State: AA+aEWahl1bxIMGMJksTO3rWrqtRAH1gANFu8FjeU91qorIcZ4/1TbqR
 wxkRYFANMlGWTmq8gAbFQ6o6555RcsXsVw==
X-Google-Smtp-Source: AFSGD/WNijqlJG0IW6U3isW5JUkQDEUW6xM/8F6rqKt7QQmqv60+DZ3rvcSvOjn6p7ve6WJgMVHg5Q==
X-Received: by 2002:a19:5f1e:: with SMTP id t30mr13714028lfb.76.1546010374134; 
 Fri, 28 Dec 2018 07:19:34 -0800 (PST)
Received: from localhost.localdomain
 ([2a02:a315:5445:5300:7146:fd07:48ff:9665])
 by smtp.googlemail.com with ESMTPSA id s24sm7872704lfc.30.2018.12.28.07.19.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 28 Dec 2018 07:19:33 -0800 (PST)
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: inki.dae@samsung.com,
	krzk@kernel.org,
	airlied@linux.ie
Subject: [PATCH v2 2/3] dt-bindings: gpu: samsung-rotator: Document s5pv210
 support
Date: Fri, 28 Dec 2018 16:19:03 +0100
Message-Id: <20181228151904.12079-3-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181228151904.12079-1-pawel.mikolaj.chmiel@gmail.com>
References: <20181228151904.12079-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_071947_099859_B3DD1EFC 
X-CRM114-Status: GOOD (  12.63  )
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
IFBhd2XFgiBDaG1pZWwgPHBhd2VsLm1pa29sYWouY2htaWVsQGdtYWlsLmNvbT4KLS0tCkNoYW5n
ZXMgZnJvbSB2MToKICAtIFJlbW92ZWQgbGlzdCBlbnVtZXJhdGlvbgogIC0gUGxhY2VkIHM1cHYy
MTAgYXQgYmVnaW5uaW5nIG9mIGxpc3QgKGl0J3MgdGhlIG9sZGVzdCBjaGlwc2V0KQotLS0KIERv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ncHUvc2Ftc3VuZy1yb3RhdG9yLnR4dCB8
IDcgKysrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZ3B1L3Nh
bXN1bmctcm90YXRvci50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZ3B1
L3NhbXN1bmctcm90YXRvci50eHQKaW5kZXggODJjZDFlZDBiZTkzLi4zYWNhMjU3OGRhMGIgMTAw
NjQ0Ci0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ncHUvc2Ftc3VuZy1y
b3RhdG9yLnR4dAorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZ3B1L3Nh
bXN1bmctcm90YXRvci50eHQKQEAgLTIsOSArMiwxMCBAQAogCiBSZXF1aXJlZCBwcm9wZXJ0aWVz
OgogICAtIGNvbXBhdGlibGUgOiB2YWx1ZSBzaG91bGQgYmUgb25lIG9mIHRoZSBmb2xsb3dpbmc6
Ci0JKGEpICJzYW1zdW5nLGV4eW5vczQyMTAtcm90YXRvciIgZm9yIFJvdGF0b3IgSVAgaW4gRXh5
bm9zNDIxMAotCShiKSAic2Ftc3VuZyxleHlub3M0MjEyLXJvdGF0b3IiIGZvciBSb3RhdG9yIElQ
IGluIEV4eW5vczQyMTIvNDQxMgotCShjKSAic2Ftc3VuZyxleHlub3M1MjUwLXJvdGF0b3IiIGZv
ciBSb3RhdG9yIElQIGluIEV4eW5vczUyNTAKKwkqICJzYW1zdW5nLHM1cHYyMTAtcm90YXRvciIg
Zm9yIFJvdGF0b3IgSVAgaW4gUzVQVjIxMAorCSogInNhbXN1bmcsZXh5bm9zNDIxMC1yb3RhdG9y
IiBmb3IgUm90YXRvciBJUCBpbiBFeHlub3M0MjEwCisJKiAic2Ftc3VuZyxleHlub3M0MjEyLXJv
dGF0b3IiIGZvciBSb3RhdG9yIElQIGluIEV4eW5vczQyMTIvNDQxMgorCSogInNhbXN1bmcsZXh5
bm9zNTI1MC1yb3RhdG9yIiBmb3IgUm90YXRvciBJUCBpbiBFeHlub3M1MjUwCiAKICAgLSByZWcg
OiBQaHlzaWNhbCBiYXNlIGFkZHJlc3Mgb2YgdGhlIElQIHJlZ2lzdGVycyBhbmQgbGVuZ3RoIG9m
IG1lbW9yeQogCSAgbWFwcGVkIHJlZ2lvbi4KLS0gCjIuMTcuMQoKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBs
aXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
