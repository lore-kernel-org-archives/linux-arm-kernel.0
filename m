Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82594C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:05:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 514AF20660
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qTMpuDA+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u1R4WoIt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 514AF20660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XsxPJz+9aBI+QD+CsLDG6kGjCAZ3j/zNQB4cctlwR+s=; b=qTMpuDA+VzWKuI
	l44Aw1pnlQRR8fZ6AeXI9wrakDogYr0ijuolZ7IWlZugW1I/OJyJrz71BxASNKFE85Q89JaSFe1Y2
	lMUjWzMCATIl+fbsXM5fdbuzfOv4p2IEThV9xmmzEtRAyHmrA5LZ29MeiTKGdiAni1bmzqOSm+Swp
	4LMSf5OjhXPo0zNRXAzXp+4QjzMf0BxvneXpYgjyzPAQ3A2mictwRheIpEBSVtcMKPd9hDLMEW9Ug
	Qpz7pR63enWLLRE5jXXogphew9t3y6bk/96eLYuRjiG6ScOZ3mRFfgMuQxQ4hTzuRlw5xPIr8G3+w
	g6geP0tn6nAGre4cxwqg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggxdM-0000vD-50; Tue, 08 Jan 2019 20:05:56 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggxcw-0000QK-1J
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 20:05:33 +0000
Received: by mail-lj1-x243.google.com with SMTP id q2-v6so4483093lji.10
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 08 Jan 2019 12:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KjuAmgjHlhPWg7vZv/M0TlOMAshH0WF7o8w6mNSkFXw=;
 b=u1R4WoItDbfO6hhHhsjLfP7o7pC7bq+5OE70Y3mc1vKCha4OdZYEpjXJbUWrFatenH
 UjWL1dq+TwAHuGoV/VfZsUS0FxaaxBF9Jd7FBdNhzHdaCW2eq5mMLIX4l6gg6Rl+Sh8n
 r3ddpAJ6TfFOgFx4b1LCe7n865Kcq+OwAkT9th8YQvGABZE5xkaele7YBs1TT7tLA4SI
 tRJFICpi6FTtvxju9xECpA9+ozkfkwf9Sa7sU/RV+ylrCeq7PeQwR5sx8g/bkvToaO9P
 8dbGPJNYtBuPgLm3bPxbvktiN9cmmod3WfQGBgmlhTUWDhOsUuLJaInMy4Q10c7shjAX
 J4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KjuAmgjHlhPWg7vZv/M0TlOMAshH0WF7o8w6mNSkFXw=;
 b=idV6c+QwoTUtyMWWhjBMlVBnIVTTLVnRZdXYFgNgkFl1bddYSMIe2FvpDq5H4U1cwb
 LN4tYujhGASVmd7KBk9fTG87OWEKlqsoNaF/PujqLcDWSk6YX0rcR/EbPgCk4UV+SgIF
 9bI9eiiCho1XLxVrf7o9Lx/odxn59g/khuwVOeS5A39pWDnl++BmOZWoRMkCDIxuC4WN
 dpjGq/Dvm6jbZbfcfsk+RrVhi5GdZpxQqLR8k/pra3Qx+2DC6fZsi47s0AZvJByVFEmq
 pNz0GMnRACD2Rgk/LhzXlT656kqxeoU0/s34ed4AhU7DkynOgjFClgTtV1VjD5T9OxT9
 vQsQ==
X-Gm-Message-State: AJcUukdy0gEwA+R7QCRLkTLQeTuYU35wVJEVMHOjEo+NvINVKKlOWc2N
 dFBEGD+q4KfFRlq0bjmSczE=
X-Google-Smtp-Source: ALg8bN5pT46pkrxZpK7o+mLATemc0Niur+ce7kuw8r+G1YGgUn7ukO1fkhqYJIVugFOyvbwxKsnDoQ==
X-Received: by 2002:a2e:4218:: with SMTP id
 p24-v6mr1826784lja.58.1546977927995; 
 Tue, 08 Jan 2019 12:05:27 -0800 (PST)
Received: from localhost.localdomain
 ([2a02:a315:5445:5300:d033:e708:8ec7:810d])
 by smtp.googlemail.com with ESMTPSA id
 y23-v6sm14486768ljk.95.2019.01.08.12.05.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Jan 2019 12:05:27 -0800 (PST)
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: kgene@kernel.org
Subject: [PATCH 4/4] ARM: defconfig: s5pv210: Add cpufreq support
Date: Tue,  8 Jan 2019 21:05:09 +0100
Message-Id: <20190108200509.30494-5-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190108200509.30494-1-pawel.mikolaj.chmiel@gmail.com>
References: <20190108200509.30494-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_120530_517128_6928386D 
X-CRM114-Status: GOOD (  10.68  )
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
 linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
 viresh.kumar@linaro.org, rjw@rjwysocki.net, linux@armlinux.org.uk,
 krzk@kernel.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VGhpcyBjb21taXQgZW5hYmxlcyBjcHVmcmVxIHN1cHBvcnQgZm9yIGFsbCBzNXB2MjEwIGRldmlj
ZXMuCgpTaWduZWQtb2ZmLWJ5OiBQYXdlxYIgQ2htaWVsIDxwYXdlbC5taWtvbGFqLmNobWllbEBn
bWFpbC5jb20+Ci0tLQogYXJjaC9hcm0vY29uZmlncy9zNXB2MjEwX2RlZmNvbmZpZyB8IDYgKysr
KysrCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvYXJjaC9h
cm0vY29uZmlncy9zNXB2MjEwX2RlZmNvbmZpZyBiL2FyY2gvYXJtL2NvbmZpZ3MvczVwdjIxMF9k
ZWZjb25maWcKaW5kZXggOTUxMTk2YmRmMDA4Li5mZDRmMjhhYWJkYTYgMTAwNjQ0Ci0tLSBhL2Fy
Y2gvYXJtL2NvbmZpZ3MvczVwdjIxMF9kZWZjb25maWcKKysrIGIvYXJjaC9hcm0vY29uZmlncy9z
NXB2MjEwX2RlZmNvbmZpZwpAQCAtMTEsNiArMTEsMTIgQEAgQ09ORklHX0FSQ0hfUzVQVjIxMD15
CiBDT05GSUdfVk1TUExJVF8yRz15CiBDT05GSUdfQVJNX0FQUEVOREVEX0RUQj15CiBDT05GSUdf
Q01ETElORT0icm9vdD0vZGV2L3JhbTAgcncgcmFtZGlzaz04MTkyIGluaXRyZD0weDIwODAwMDAw
LDhNIGNvbnNvbGU9dHR5U0FDMSwxMTUyMDAgaW5pdD0vbGludXhyYyIKK0NPTkZJR19DUFVfRlJF
UT15CitDT05GSUdfQ1BVX0ZSRVFfU1RBVD15CitDT05GSUdfQ1BVX0ZSRVFfREVGQVVMVF9HT1Zf
T05ERU1BTkQ9eQorQ09ORklHX0NQVV9GUkVRX0dPVl9QT1dFUlNBVkU9bQorQ09ORklHX0NQVV9G
UkVRX0dPVl9VU0VSU1BBQ0U9bQorQ09ORklHX0NQVV9GUkVRX0dPVl9DT05TRVJWQVRJVkU9bQog
Q09ORklHX1ZGUD15CiBDT05GSUdfTkVPTj15CiBDT05GSUdfTU9EVUxFUz15Ci0tIAoyLjE3LjEK
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1h
cm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0t
a2VybmVsCg==
