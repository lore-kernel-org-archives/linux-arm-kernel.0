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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40BFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 16:19:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91D7820856
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 16:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AX6JKaww";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Os75tXHL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91D7820856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JXYO4FNF7+cqhdY878pwR61Eu03c9EIW5qLnDhkqmYg=; b=AX6JKawwML587Y
	AH2uqFHZu7Q/3uCVc1PFjga2djyZFQCweb3ferRW3mIK0rT54j0ODAI9mSNxT5eEx0ClUpP0OMeUa
	EQtFI1Kv4TIUsxWYo+UdbYFbjBYdqrONjna23G1wd0ao6+ilUSFjOlD+KGyToY+iSBFiVLigJCEOW
	qQjWLMI95YoV3/X6D5OgUtkCZ9j3QwLjpq6XpZrfVbJO63vQKHSOKKRY7w//vD4+6s2iNGXdCtu8W
	0LcZ8PpaIq577n8gcQB0xvAi2q4I4pRWzs9NhWpv9cWinP+qi+lRSjWKpTbNjQfySadPfL0kJxhYY
	ArfZq+qYZKUTgPmqDDEw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcuqv-0004gs-FB; Fri, 28 Dec 2018 16:19:13 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcuqT-0004Eb-RI
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 16:18:49 +0000
Received: by mail-lf1-x144.google.com with SMTP id y11so14838732lfj.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 28 Dec 2018 08:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wWKmTFS5ZShhZDX8uM7xr7EH6AMOt2sQtD7cbsV9khY=;
 b=Os75tXHLQ5Woz/aXfzxThmOiOs4nVjsc6VY+x1tXvnexcMuzCINJ/1pUslGGI4kDj0
 gy0+CS6BzZfwzQ4zW1FJPdu+W97jxanL5OINhESM5ys243LvLfv6OrXl9bkDYZ6pofPq
 P1ZmHwHLn4Nv742qOKlz/kjCL1BlGgTnI7ixV6siXwD74dmnaL1yTSCQBv5bPZTntTJK
 JD04Yl5+jGLC40naq1DQLFXlEEar1s+q6XiAbnDkmexg6WamP+wzvK0NIb0xCTLAEKaL
 8B3Yyd1CWkZ8MJREGyYq8i94tvpJCPqRx7YrFQSdlMQR7WYbE7nb328iUwpcQ/D5XcMS
 nhmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wWKmTFS5ZShhZDX8uM7xr7EH6AMOt2sQtD7cbsV9khY=;
 b=aouvHqm3cVAszSsgP8jGtF3Md7wXigcHVY/rnoAy4Cafu0hU1gvRtJyDdmB0strM9I
 lNo5ltbmu14Fsc4HaKak4auEiU4MEGgmDy0sFiKrK9tbT7dnmNqcMBZERapP76qQJxxK
 Op/pgA3xFHqR/UN/C3fcOPUIznqiOnWmpOZbQJOh84vs8b4aTMNP6RfmeQxRV/ffYPRJ
 G8g2WraD4/9ejxgsaGhTovKGw1FGnnpoEWDg7AWrY+vHumc9CXGItkG7Fco18y4reGIh
 5HN8zgjGJAyT65U/oA37uIZLlIx26n+jGirh2Kx86Mm7JR5EVXJjqx9ah2BdFzm3ei3s
 JKRw==
X-Gm-Message-State: AA+aEWbA/zbbKX2CVXC9DfAg11Qnd8YU7Y5gYZCCiLqpuSg4D95Zn74i
 fR5dnMIcFZAJtMrPL1O+LvM=
X-Google-Smtp-Source: AFSGD/XkKiOKri+TsOKI0Wu9s9m0XTlRujFeB/+xuDFxCjNCtdAGEH/qpP4bfLVKWukuh3FLijjRxA==
X-Received: by 2002:a19:e01e:: with SMTP id x30mr13629904lfg.89.1546013913934; 
 Fri, 28 Dec 2018 08:18:33 -0800 (PST)
Received: from localhost.localdomain
 ([2a02:a315:5445:5300:7146:fd07:48ff:9665])
 by smtp.googlemail.com with ESMTPSA id r4sm8136502lfe.60.2018.12.28.08.18.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 28 Dec 2018 08:18:33 -0800 (PST)
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: krzk@kernel.org
Subject: [PATCH 2/6] ARM: dts: s5pv210: galaxys: Remove hardcoded bootargs
Date: Fri, 28 Dec 2018 17:18:15 +0100
Message-Id: <20181228161819.18931-3-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181228161819.18931-1-pawel.mikolaj.chmiel@gmail.com>
References: <20181228161819.18931-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_081846_165189_A3CEB3EE 
X-CRM114-Status: GOOD (  10.89  )
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
 linux-samsung-soc@vger.kernel.org, xc-racer2@live.ca, linux@armlinux.org.uk,
 robh+dt@kernel.org, linux-kernel@vger.kernel.org, kgene@kernel.org,
 linux-arm-kernel@lists.infradead.org, pawel.mikolaj.chmiel@gmail.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

U2luY2Ugd2UgaGF2ZSB1Ym9vdCAoZmxhc2hlZCBpbiBwbGFjZSBvZiBzdG9jayBrZXJuZWwpLApp
dCdzIG5vdCBuZWVkZWQgYW55bW9yZSB0byBoYXJkY29kZSBib290YXJncy4KClNpZ25lZC1vZmYt
Ynk6IFBhd2XFgiBDaG1pZWwgPHBhd2VsLm1pa29sYWouY2htaWVsQGdtYWlsLmNvbT4KLS0tCiBh
cmNoL2FybS9ib290L2R0cy9zNXB2MjEwLWdhbGF4eXMuZHRzIHwgNyAtLS0tLS0tCiAxIGZpbGUg
Y2hhbmdlZCwgNyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9z
NXB2MjEwLWdhbGF4eXMuZHRzIGIvYXJjaC9hcm0vYm9vdC9kdHMvczVwdjIxMC1nYWxheHlzLmR0
cwppbmRleCA4NDIyNzY3NDk3MTcuLmNmMTYxYmJmYmFjZiAxMDA2NDQKLS0tIGEvYXJjaC9hcm0v
Ym9vdC9kdHMvczVwdjIxMC1nYWxheHlzLmR0cworKysgYi9hcmNoL2FybS9ib290L2R0cy9zNXB2
MjEwLWdhbGF4eXMuZHRzCkBAIC0xMSwxMyArMTEsNiBAQAogCiAJY2hvc2VuIHsKIAkJc3Rkb3V0
LXBhdGggPSAmdWFydDI7Ci0JCS8qCi0JCSAqIEl0J3MgaGFyZCB0byBjaGFuZ2UgdGhvc2UgcGFy
YW1ldGVycyBpbiBzdG9jayBib290bG9hZGVyLAotCQkgKiBzaW5jZSBpdCByZXF1aXJlcyBzcGVj
aWFsIGhhcmR3YXJlL2NhYmxlLgotCQkgKiBMZXQncyBoYXJkb2NkZSBib290YXJncyBmb3Igbm93
LCB0aWxsIHUtYm9vdCBwb3J0IGlzIGZpbmlzaGVkLAotCQkgKiB3aXRoIHdoaWNoIGl0IHNob3Vs
ZCBiZSBlYXNpZXIuCi0JCSAqLwotCQlib290YXJncyA9ICJyb290PS9kZXYvbW1jYmxrMnAxIHJ3
IHJvb3R3YWl0IGlnbm9yZV9sb2dsZXZlbCBlYXJseXByaW50ayI7CiAJfTsKIAogCW5hbmRfcHdy
c2VxOiBuYW5kLXB3cnNlcSB7Ci0tIAoyLjE3LjEKCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
