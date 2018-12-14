Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3594EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:13:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10B98206A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Rz/GpTqv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2Yeas6Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10B98206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=xP2o9PbR3M/WicELNAwYnv6DvzNH2bypCWG7NczZxDs=; b=Rz/GpTqvBj5pNB
	MXRPTPry25xVbrxKYKoSgxuf/3NTUfOOqEPv1RIqW47Fvqm6WOujLGwXe4Wb9ZN9MUxRMo93sFr3t
	MjGFCfCY1WbhdMpF1Ks7j5W/CEZ+GoBiEKJuvDUgS2oDYN2yDCbd44Yz2Rt1f9yRVJ8TFTkOXq0k9
	+pH2S/wDZ2MU4jwta5drDXSV9lnreeB77xGWm+H0tJ+EW+0xcYWw/qOSV1T27qEceiqz4mPYLmBqx
	gsiT1esvSa/TzFZZYCw1v4O/vHiHQX21IOiLBBq0mUZ2sdP8pEBpe1OoHiPqPC3u26JeY7SlpJUie
	VQ6TtIsc8sMZ/ZET6XUw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXp9k-0001yz-P2; Fri, 14 Dec 2018 15:13:36 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXp90-0001EM-CO
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 15:13:04 +0000
Received: by mail-lj1-x243.google.com with SMTP id e5-v6so5195959lja.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 14 Dec 2018 07:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OPHoOoeJrXFhGW2NBg+BqikfLbQmuY9aUqs4/W1ky7c=;
 b=W2Yeas6ZXnzwszhlrs0ZnACmpcAZ9cbC3GBmbyIXz4dpJz1UR8r8UQkptMVFfw9zG/
 LQgCKTHvkCozMA+GdaA1YUOuwZyarbwEap0SnZepjk2hxeVp3TUJacwX9v/FdDjjR3XP
 qbUcNjROXPKo26zMxTP3/U8GZPRtSVFd8/NFqcn2xGglj3MALW0Xu029bDOt0kmR5O9I
 puXi1MYcH5q2O08MuF8OzTQ1NstIa8Z+SH6NaxXrFVTzinp4SUGsnnFWcAqyAEUZbtlg
 6E8gbOnKeXUHqZe4l8E7mPQDGBQDM6uRk91C0EPqCreOX3rJUjQu5QMGrrZvVM9mm8Ju
 maxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OPHoOoeJrXFhGW2NBg+BqikfLbQmuY9aUqs4/W1ky7c=;
 b=WWM/vRLu6CC84d6C/zSX3TFbCihi/1QbSl/qB2mK/T91hSqGKJHeVrY/ynNOlugd0H
 8i0mmn26T2k8abFH6iAdEcjQ3Vfxrf1AeiGqbfJgQS1C1XLwYf03y1PGkCaXPrjMCVPV
 vPBSAFsjHsduTZlBTpiu3HpaSmP/dMSZATBchmUzMzYpyE7YJEqIHdZ3J1k4O30Z3AI4
 WZ7NBM+PzhoOpNH3jfy3jjV/G4E7vl6y/ydfxq/g5nOxRjdcPVd+A/Ryf0aiKtXY93NY
 eEwEkmvu9YWu8KtXM1SOEXuW0fXJybExNmuBXyTKfyJYuM88JfWKUI8g6LybdncfVGeJ
 SFow==
X-Gm-Message-State: AA+aEWZATAiifm0I7j8Rp7PdquGvI0R1/qJ2G4FV+LgnvGK9DIstYpmP
 PYzyOV7GeXfC1bjKK/DDNM8=
X-Google-Smtp-Source: AFSGD/U+9KaXGsGqwuBABPN/lwCpvYF8mj5iSDHz0VERNJNL16gje4tgrlv3GuDznjavpqJHE9Mg5g==
X-Received: by 2002:a2e:9983:: with SMTP id
 w3-v6mr2256449lji.133.1544800358706; 
 Fri, 14 Dec 2018 07:12:38 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:976:99fb:a7e3:627c])
 by smtp.googlemail.com with ESMTPSA id o17sm951975lff.77.2018.12.14.07.12.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Dec 2018 07:12:37 -0800 (PST)
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: nick@shmanahar.org
Subject: [PATCH v5 0/3] Input: atmel_mxt_ts: Add support for optional
 regulators
Date: Fri, 14 Dec 2018 16:12:11 +0100
Message-Id: <20181214151214.5391-1-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_071250_867738_35540242 
X-CRM114-Status: GOOD (  13.39  )
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
 alexandre.belloni@bootlin.com, dmitry.torokhov@gmail.com,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, linux-input@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VGhpcyBwYXRjaCBzZXJpZXMgYWRkcyBvcHRpb25hbCByZWd1bGF0b3Igc3VwcG9ydCB0byBhdG1l
bF9teHRfdHMuCkZpcnN0IHBhdGNoIGFkZHMgcmVndWxhdG9ycyB0byBkcml2ZXIuClNlY29uZCBw
YXRjaCBlbnN1cmVzIHRoYXQgZGV2aWNlIGlzIHJlYWR5IGZvciBjb21tdW5pY2F0aW9uLgpUaGly
ZCBwYXRjaCB1cGRhdGVzIGRvY3VtZW50YXRpb24uCgpDaGFuZ2VzIGZyb20gdjQ6CiAgLSBBZGQg
bWlzc2luZyByZWd1bGF0b3JfZGlzYWJsZSBmb3IgdmRkIGluIGNhc2Ugb2YgZXJyb3IsCiAgICB3
aGVuIGVuYWJsaW5nIGF2ZGQgcmVndWxhdG9yCgpDaGFuZ2VzIGZyb20gdjM6CiAgLSBDaGVja3Bh
dGNoIGZpeGVzCiAgLSBEcm9wIHB1bmN0dWF0aW9uIGZyb20gc3ViamVjdCBvZiBvbmUgb2YgcGF0
Y2hlcwoKQ2hhbmdlcyBmcm9tIHYyOgogIC0gQWRkIHJldmlld2VkLWJ5IHRvIG9uZSBwYXRjaAog
IC0gTW92ZSBjb2RlIGZvciBlbmFibGluZyByZWd1bGF0b3JzIGludG8gc2VwYXJhdGUgbWV0aG9k
LAogICAgdG8gbWFrZSBjb2RlIG1vcmUgcmVhZGFibGUuCiAgLSBBZGQgd2FpdCBjb2RlLCB0byBl
bnN1cmUgdGhhdCBkZXZpY2UgaXMgcmVhZHkgZm9yIGNvbW11bmljYXRpb24uCgpDaGFuZ2VzIGZy
b20gdjE6CiAgLSBFbmFibGUgcmVndWxhdG9ycyBvbmx5IGlmIHJlc2V0X2dwaW8gaXMgcHJlc2Vu
dC4KICAtIFN3aXRjaCBmcm9tIGRldm1fcmVndWxhdG9yX2dldF9vcHRpb25hbCB0byBkZXZtX3Jl
Z3VsYXRvcl9nZXQuCgpQYXdlxYIgQ2htaWVsICgzKToKICBJbnB1dDogYXRtZWxfbXh0X3RzOiBB
ZGQgc3VwcG9ydCBmb3IgIG9wdGlvbmFsIHJlZ3VsYXRvcnMKICBJbnB1dDogYXRtZWxfbXh0X3Rz
OiBXYWl0IGZvciBkZXZpY2UgYmUgcmVhZHkgZm9yIGNvbW11bmljYXRpb24KICBJbnB1dDogYXRt
ZWxfbXh0X3RzOiBEb2N1bWVudCBvcHRpb25hbCB2b2x0YWdlIHJlZ3VsYXRvcnMKCiAuLi4vYmlu
ZGluZ3MvaW5wdXQvYXRtZWwsbWF4dG91Y2gudHh0ICAgICAgICAgfCAgOCArKwogZHJpdmVycy9p
bnB1dC90b3VjaHNjcmVlbi9hdG1lbF9teHRfdHMuYyAgICAgIHwgNzggKysrKysrKysrKysrKysr
KystLQogMiBmaWxlcyBjaGFuZ2VkLCA4MCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoK
LS0gCjIuMTcuMQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LWFybS1rZXJuZWwK
