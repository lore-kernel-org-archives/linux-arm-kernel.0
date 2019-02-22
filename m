Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B01C10F00
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:35:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C549020700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kt62aS8Q";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bc2z/mZZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C549020700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FatyJJmGQZO1i9dvN+dnWT3eWFTgH755QezZJrlCb+Y=; b=kt62aS8QgoRLK0
	elKWxXTpN+MDylMJPmsPCMaZrUDUiLpPWr5YA7KzXYuSyJqjXwMn8wvsYkZruwjVOV6CLAzmpkVLn
	s6Q785hzncgeNdKKz/AIug6WrqkW9XnOm4fXS5Rdjyo3iNxJmcJVN6iHvB4n6FtbpYzubLdc1VX4D
	aJ6mCWZAS9xok1xFxTZcAoav+fmj3U4HqH1SP4S0pay8jRyImNSS38fLPblfyMu8/oz67+8+Yr1dc
	kxi+hv7ukAJ/TeiwIlDxKTX9RKg7/n7JvQqwPTT/Tm/ROTD8iUKclKkHoHmQwdz60TIXvdeSyjjKl
	UV6w5FnubkXdeiRAKtgg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxGbs-0003df-1H; Fri, 22 Feb 2019 19:35:48 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxGbg-0003PR-QM
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 19:35:41 +0000
Received: by mail-pg1-x544.google.com with SMTP id h8so1057440pgp.6
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 11:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ef/pjs0sC4GxqdxxxUgy0sbHhpRnX1Oqj7kTNWdGqgw=;
 b=Bc2z/mZZ2PJ4XrRMfHMO32ZStzZd+1hYC5yRGRn77t6veG2OoL5m0uLia5spAabPB+
 9JD5OA0TakMPnRtqcYTTIKd0JXiYIkAD4B63SfDNd2T9MuWwfZZLbqbmJ6wfis8L3iuY
 4vIqGaONLeXz/rPRT6GxMAFPFcSm29vs+uPik97x5m/SjDIqv+KwSaSlJkxpKpGwOL+F
 +hy8FPTkGcfTJ2bOpn/ViCBC+uioWVxDsYjvO2sCQ9rqphXkEBK3qk58rJ6UeSEjpZdd
 Ls7d6rPlqNeB7KLcok6I0ujqZsIBImtAnT5i3Yr4icwCjP2ivEeYSPcXt2+b0+og+uXV
 bTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ef/pjs0sC4GxqdxxxUgy0sbHhpRnX1Oqj7kTNWdGqgw=;
 b=oojuFhO+492tFXLCpkYD+ZZDNVVXyIYz94oJApmeEqqmQTFyGZ2uNMswY+pEnPBKe+
 vONy14wFHsJjv1R0z0IJ2bIrerJzWB5J3yIqoMPT27wh1PwQjDgS59nCU4F6qbNFtIGz
 x5VgN+dRksSzVRH+pep6/jlLoswukbzaZrzn5jnALuvXBRks+GQUsIlKIsQ7smlgvudP
 3MCfHneqlB4Xb3drGx3c6Lh05oKv7e0+chlNiO65mZma8PaksV0QQNPh9aEL815R72uh
 bWnBzF5uZt8GGGQz6PNMN8Z/KyS8FKPBEhZZl344VoJOGrzbAZFjYXcthlWOiUtV8wdS
 l6KA==
X-Gm-Message-State: AHQUAuYHFxSywVrLl+9kJwg8oxB+emFjfAWcCif4fQ7j/7+8EWyDd6K1
 WOrdz2tUfihd9Imyfqi/KFc=
X-Google-Smtp-Source: AHgI3IYAV/BUgcnx+2e0YNF+UIlsi3IMuvr4ov+kFk3ReW9IxrOtUMWmFj+PAM2xyua2dyi4BKH8jw==
X-Received: by 2002:a63:8f45:: with SMTP id r5mr5418223pgn.222.1550864136209; 
 Fri, 22 Feb 2019 11:35:36 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru.
 [91.79.175.49])
 by smtp.gmail.com with ESMTPSA id e21sm7687190pfh.45.2019.02.22.11.35.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Feb 2019 11:35:35 -0800 (PST)
From: Dmitry Osipenko <digetx@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Robert Yang <decatf@gmail.com>,
 =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v6 1/7] ARM: trusted_foundations: Implement L2 cache
 initialization callback
Date: Fri, 22 Feb 2019 22:34:20 +0300
Message-Id: <20190222193426.10747-2-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222193426.10747-1-digetx@gmail.com>
References: <20190222193426.10747-1-digetx@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_113537_247814_6AC130B2 
X-CRM114-Status: GOOD (  14.32  )
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
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SW1wbGVtZW50IEwyIGNhY2hlIGluaXRpYWxpemF0aW9uIGZpcm13YXJlIGNhbGxiYWNrIHRoYXQg
c2hvdWxkIGJlCmludm9rZWQgZWFybHkgZHVyaW5nIGJvb3QgaW4gb3JkZXIgdG8gc2V0IHVwIHRo
ZSByZXF1aXJlZCBvdXRlciBjYWNoZQpkcml2ZXIncyBjYWxsYmFja3MuCgpQYXJ0aWFsbHkgYmFz
ZWQgb24gd29yayBkb25lIGJ5IE1pY2hhxYIgTWlyb3PFgmF3IFsxXS4KClsxXSBodHRwczovL3d3
dy5zcGluaWNzLm5ldC9saXN0cy9hcm0ta2VybmVsL21zZzU5NDc2NS5odG1sCgpTaWduZWQtb2Zm
LWJ5OiBEbWl0cnkgT3NpcGVua28gPGRpZ2V0eEBnbWFpbC5jb20+Ci0tLQogYXJjaC9hcm0vZmly
bXdhcmUvdHJ1c3RlZF9mb3VuZGF0aW9ucy5jIHwgNDYgKysrKysrKysrKysrKysrKysrKysrKysr
KwogMSBmaWxlIGNoYW5nZWQsIDQ2IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9hcmNoL2Fy
bS9maXJtd2FyZS90cnVzdGVkX2ZvdW5kYXRpb25zLmMgYi9hcmNoL2FybS9maXJtd2FyZS90cnVz
dGVkX2ZvdW5kYXRpb25zLmMKaW5kZXggNjg5ZTY1NjVhYmZjLi4zYmY2MWE1OTMzYjkgMTAwNjQ0
Ci0tLSBhL2FyY2gvYXJtL2Zpcm13YXJlL3RydXN0ZWRfZm91bmRhdGlvbnMuYworKysgYi9hcmNo
L2FybS9maXJtd2FyZS90cnVzdGVkX2ZvdW5kYXRpb25zLmMKQEAgLTE4LDggKzE4LDE1IEBACiAj
aW5jbHVkZSA8bGludXgvaW5pdC5oPgogI2luY2x1ZGUgPGxpbnV4L29mLmg+CiAjaW5jbHVkZSA8
YXNtL2Zpcm13YXJlLmg+CisjaW5jbHVkZSA8YXNtL2hhcmR3YXJlL2NhY2hlLWwyeDAuaD4KKyNp
bmNsdWRlIDxhc20vb3V0ZXJjYWNoZS5oPgogI2luY2x1ZGUgPGFzbS90cnVzdGVkX2ZvdW5kYXRp
b25zLmg+CiAKKyNkZWZpbmUgVEZfQ0FDSEVfTUFJTlQJCTB4ZmZmZmYxMDAKKworI2RlZmluZSBU
Rl9DQUNIRV9FTkFCTEUJCTEKKyNkZWZpbmUgVEZfQ0FDSEVfRElTQUJMRQkyCisKICNkZWZpbmUg
VEZfU0VUX0NQVV9CT09UX0FERFJfU01DIDB4ZmZmZmYyMDAKIAogI2RlZmluZSBURl9DUFVfUE0J
CTB4ZmZmZmZmZmMKQEAgLTY3LDkgKzc0LDQ4IEBAIHN0YXRpYyBpbnQgdGZfcHJlcGFyZV9pZGxl
KHZvaWQpCiAJcmV0dXJuIDA7CiB9CiAKKyNpZmRlZiBDT05GSUdfQ0FDSEVfTDJYMAorc3RhdGlj
IHZvaWQgdGZfY2FjaGVfd3JpdGVfc2VjKHVuc2lnbmVkIGxvbmcgdmFsLCB1bnNpZ25lZCBpbnQg
cmVnKQoreworCXN0YXRpYyB1MzIgbDJ4MF93YXlfbWFzayA9IDB4ZmY7CisJc3RhdGljIHUzMiBs
MngwX2F1eF9jdHJsID0gMDsKKworCXN3aXRjaCAocmVnKSB7CisJY2FzZSBMMlgwX0FVWF9DVFJM
OgorCQlsMngwX2F1eF9jdHJsID0gdmFsOworCisJCWlmIChsMngwX2F1eF9jdHJsICYgQklUKDE2
KSkKKwkJCWwyeDBfd2F5X21hc2sgPSAweGZmZmY7CisJCWJyZWFrOworCisJY2FzZSBMMlgwX0NU
Ukw6CisJCWlmICh2YWwgPT0gTDJYMF9DVFJMX0VOKQorCQkJdGZfZ2VuZXJpY19zbWMoVEZfQ0FD
SEVfTUFJTlQsIFRGX0NBQ0hFX0VOQUJMRSwKKwkJCQkgICAgICAgbDJ4MF9hdXhfY3RybCk7CisJ
CWVsc2UKKwkJCXRmX2dlbmVyaWNfc21jKFRGX0NBQ0hFX01BSU5ULCBURl9DQUNIRV9ESVNBQkxF
LAorCQkJCSAgICAgICBsMngwX3dheV9tYXNrKTsKKwkJYnJlYWs7CisKKwlkZWZhdWx0OgorCQli
cmVhazsKKwl9Cit9CisKK3N0YXRpYyBpbnQgdGZfaW5pdF9jYWNoZSh2b2lkKQoreworCW91dGVy
X2NhY2hlLndyaXRlX3NlYyA9IHRmX2NhY2hlX3dyaXRlX3NlYzsKKworCXJldHVybiAwOworfQor
I2VuZGlmIC8qIENPTkZJR19DQUNIRV9MMlgwICovCisKIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZmly
bXdhcmVfb3BzIHRydXN0ZWRfZm91bmRhdGlvbnNfb3BzID0gewogCS5zZXRfY3B1X2Jvb3RfYWRk
ciA9IHRmX3NldF9jcHVfYm9vdF9hZGRyLAogCS5wcmVwYXJlX2lkbGUgPSB0Zl9wcmVwYXJlX2lk
bGUsCisjaWZkZWYgQ09ORklHX0NBQ0hFX0wyWDAKKwkubDJ4MF9pbml0ID0gdGZfaW5pdF9jYWNo
ZSwKKyNlbmRpZgogfTsKIAogdm9pZCByZWdpc3Rlcl90cnVzdGVkX2ZvdW5kYXRpb25zKHN0cnVj
dCB0cnVzdGVkX2ZvdW5kYXRpb25zX3BsYXRmb3JtX2RhdGEgKnBkKQotLSAKMi4yMC4xCgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtl
cm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5l
bAo=
