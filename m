Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C40FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:05:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C8E32070D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="im0fzUhF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLHvDNd3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C8E32070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9SqpaXlY4kDVDCaz9lCY2Fx3fYuqH92FWJpIf5oQL8c=; b=im0fzUhFxqMwVG
	p2zwi2GBil6/vGmb9NlHBb1EHQAoNUuSrssxaiYhYTSLWGg2BzUeB422zuForslSTw3L8wxnCGqxd
	AeauiD4GIiwH1fLO8+PjtTngc52AY5uee0PEPijFDXKQReUYWk7upTLrsOYbk2BO9eiRoE3Te6heR
	q01h1m2cfNJsh000U9pd7pT4chO1S1RQKdczND3JApgpqHbPRZuCfB9ATwtF7MeUHC5nI9W6RMckL
	k1LjDxAvN7Cx2tWNH9lttDC3HYTp3jLgEVXUpnTOoHdbSrA2ZH9JzU2xrIt7P44/YeXDOFrgj6Ddx
	tjufreZv0hLJONhdrenQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxFCq-0000qC-Sg; Fri, 22 Feb 2019 18:05:52 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxFBc-0006kq-Me
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 18:04:38 +0000
Received: by mail-lf1-x142.google.com with SMTP id v7so2403854lfd.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 10:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YrdurJIx2ld6iD2HW3AERYM3O3FQwL4YTObVlgwwugY=;
 b=KLHvDNd3HKZFZjZRgeZpXwSYdiARa23zz7JTiLfRfg2govPX6gVAiA0KYqkprkHxHX
 HN/jp2mhuUqoDrp8URxjY7FFHrL3X9AKrOY/WKy60rtZyd5Go4huixSdPCvLF+NylnXN
 MMjZ5cQWGv19uiYlW9sop/1h4J/ZZn1VhelIiQOhGvt5OGv2rebiNA2+sjqryCgCcxcF
 WHaS0fvyXqtbNYghotBqYZ49itkjYLLYSg4qUIye+DSs0lO1VOuRrlP85vbZ3SgzSaRg
 gkAjHAQRg8Xii5slsH1fll9CdZxiteoZbQLeonxRO/T0ZmouAXAdhC8t42Rh3TnKfrr6
 8sjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YrdurJIx2ld6iD2HW3AERYM3O3FQwL4YTObVlgwwugY=;
 b=hXt6+VOFz5NWKGuXRQwnpNM6OZ/Z0k6uhtCBxRbsU3xLynLWBZYf8mvxv3CivSa9P+
 B1vnLrtZmHUKayRetd7sVRR0Qt5WFjD+x2Pz/2wAn3wK8FnfJ9vyb4m0eUX8h0s7Ppse
 TGccKKjC3v4Jjz0ZTP6YgGtFFcSpGKu9xJH3X/qd+ZVuxaZA83bbZebNC7AM0pQX79ka
 gchl9vUQeJdChGDyqgx7C+k8zmw/cKHoIxedsNN04rpHaoyeNNYXQzL8O/2uRu0RimHp
 N6hUMmtSCzHMUgisVP13PtnbHDVlvgrfd+7zQVxQj1jy/irBzj9NqReXlJyVb/A5mL54
 CM9Q==
X-Gm-Message-State: AHQUAubOaOy/lKshrtDgAWPDTsDWtRobLmzOYvgax9AU+CLtVCaHNYR1
 T1AlOP8NjywicH+k7VRt3kE=
X-Google-Smtp-Source: AHgI3IaMHQLcrqfAKCsXbhRsCJFfxdHYSxsInLd8DhL+fUxpaI6Wx91utpDhzlAltimxvhk6ZQWX/Q==
X-Received: by 2002:a19:9c87:: with SMTP id f129mr3202893lfe.77.1550858675010; 
 Fri, 22 Feb 2019 10:04:35 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru.
 [91.79.175.49])
 by smtp.gmail.com with ESMTPSA id j12sm721202lfg.47.2019.02.22.10.04.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Feb 2019 10:04:34 -0800 (PST)
From: Dmitry Osipenko <digetx@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Robert Yang <decatf@gmail.com>,
 =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v5 5/8] ARM: tegra: Don't apply CPU erratas in insecure mode
Date: Fri, 22 Feb 2019 20:59:23 +0300
Message-Id: <20190222175926.23366-6-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222175926.23366-1-digetx@gmail.com>
References: <20190222175926.23366-1-digetx@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_100436_738110_2789AF86 
X-CRM114-Status: GOOD (  14.80  )
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

Q1BVIGlzbid0IGFsbG93ZWQgdG8gdG91Y2ggc2VjdXJlIHJlZ2lzdGVycyB3aGlsZSBydW5uaW5n
IHVuZGVyIHNlY3VyZQptb25pdG9yLiBIZW5jZSBza2lwIGFwcGx5aW5nIG9mIENQVSBlcnJhdGFz
IGluIHRoZSByZXNldCBoYW5kbGVyIGlmClRydXN0ZWQgRm91bmRhdGlvbnMgZmlybXdhcmUgcHJl
c2VudHMuCgpQYXJ0aWFsbHkgYmFzZWQgb24gd29yayBkb25lIGJ5IE1pY2hhxYIgTWlyb3PFgmF3
IFsxXS4KClsxXSBodHRwczovL3d3dy5zcGluaWNzLm5ldC9saXN0cy9hcm0ta2VybmVsL21zZzU5
NDc2OC5odG1sCgpTaWduZWQtb2ZmLWJ5OiBEbWl0cnkgT3NpcGVua28gPGRpZ2V0eEBnbWFpbC5j
b20+Ci0tLQogYXJjaC9hcm0vbWFjaC10ZWdyYS9yZXNldC1oYW5kbGVyLlMgfCAyMyArKysrKysr
KysrKystLS0tLS0tLS0tLQogYXJjaC9hcm0vbWFjaC10ZWdyYS9yZXNldC5jICAgICAgICAgfCAg
MyArKysKIGFyY2gvYXJtL21hY2gtdGVncmEvcmVzZXQuaCAgICAgICAgIHwgIDkgKysrKysrKy0t
CiBhcmNoL2FybS9tYWNoLXRlZ3JhL3NsZWVwLXRlZ3JhMjAuUyB8ICA0ICsrKysKIDQgZmlsZXMg
Y2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
YXJjaC9hcm0vbWFjaC10ZWdyYS9yZXNldC1oYW5kbGVyLlMgYi9hcmNoL2FybS9tYWNoLXRlZ3Jh
L3Jlc2V0LWhhbmRsZXIuUwppbmRleCA4MDVmMzA2ZmE2ZjcuLjZiZWE5NWQxNjVmYSAxMDA2NDQK
LS0tIGEvYXJjaC9hcm0vbWFjaC10ZWdyYS9yZXNldC1oYW5kbGVyLlMKKysrIGIvYXJjaC9hcm0v
bWFjaC10ZWdyYS9yZXNldC1oYW5kbGVyLlMKQEAgLTI5LDggKzI5LDYgQEAKIAogI2RlZmluZSBQ
TUNfU0NSQVRDSDQxCTB4MTQwCiAKLSNkZWZpbmUgUkVTRVRfREFUQSh4KQkoKFRFR1JBX1JFU0VU
XyMjeCkqNCkKLQogI2lmZGVmIENPTkZJR19QTV9TTEVFUAogLyoKICAqCXRlZ3JhX3Jlc3VtZQpA
QCAtMTIxLDYgKzExOSwxMiBAQCBFTlRSWShfX3RlZ3JhX2NwdV9yZXNldF9oYW5kbGVyKQogCWNw
c2lkCWFpZiwgMHgxMwkJCUAgU1ZDIG1vZGUsIGludGVycnVwdHMgZGlzYWJsZWQKIAogCXRlZ3Jh
X2dldF9zb2NfaWQgVEVHUkFfQVBCX01JU0NfQkFTRSwgcjYKKworCWFkcglyMTIsIF9fdGVncmFf
Y3B1X3Jlc2V0X2hhbmRsZXJfZGF0YQorCWxkcglyNSwgW3IxMiwgI1JFU0VUX0RBVEEoVEZfUFJF
U0VOVCldCisJY21wCXI1LCAjMAorCWJuZQlhZnRlcl9lcnJhdGEKKwogI2lmZGVmIENPTkZJR19B
UkNIX1RFR1JBXzJ4X1NPQwogdDIwX2NoZWNrOgogCWNtcAlyNiwgI1RFR1JBMjAKQEAgLTE1NSw3
ICsxNTksNiBAQCBhZnRlcl9lcnJhdGE6CiAJYW5kCXIxMCwgcjEwLCAjMHgzCQkJQCBSMTAgPSBD
UFUgbnVtYmVyCiAJbW92CXIxMSwgIzEKIAltb3YJcjExLCByMTEsIGxzbCByMTAgIAkJQCBSMTEg
PSBDUFUgbWFzawotCWFkcglyMTIsIF9fdGVncmFfY3B1X3Jlc2V0X2hhbmRsZXJfZGF0YQogCiAj
aWZkZWYgQ09ORklHX1NNUAogCS8qIERvZXMgdGhlIE9TIGtub3cgYWJvdXQgdGhpcyBDUFU/ICov
CkBAIC0xNjksMTAgKzE3Miw5IEBAIGFmdGVyX2VycmF0YToKIAljbXAJcjYsICNURUdSQTIwCiAJ
Ym5lCTFmCiAJLyogSWYgbm90IENQVTAsIGRvbid0IGxldCBDUFUwIHJlc2V0IENQVTEgbm93IHRo
YXQgQ1BVMSBpcyBjb21pbmcgdXAuICovCi0JbW92MzIJcjUsIFRFR1JBX0lSQU1fQkFTRSArIFRF
R1JBX0lSQU1fUkVTRVRfSEFORExFUl9PRkZTRVQKIAltb3YJcjAsICNDUFVfTk9UX1JFU0VUVEFC
TEUKIAljbXAJcjEwLCAjMAotCXN0cm5lYglyMCwgW3I1LCAjX190ZWdyYTIwX2NwdTFfcmVzZXR0
YWJsZV9zdGF0dXNfb2Zmc2V0XQorCXN0cm5lYglyMCwgW3IxMiwgI1JFU0VUX0RBVEEoUkVTRVRU
QUJMRV9TVEFUVVMpXQogMToKICNlbmRpZgogCkBAIC0yNzcsMTQgKzI3OSwxMyBAQCBFTkRQUk9D
KF9fdGVncmFfY3B1X3Jlc2V0X2hhbmRsZXIpCiAJLmFsaWduIEwxX0NBQ0hFX1NISUZUCiAJLnR5
cGUJX190ZWdyYV9jcHVfcmVzZXRfaGFuZGxlcl9kYXRhLCAlb2JqZWN0CiAJLmdsb2JsCV9fdGVn
cmFfY3B1X3Jlc2V0X2hhbmRsZXJfZGF0YQorCS5nbG9ibAlfX3RlZ3JhX2NwdV9yZXNldF9oYW5k
bGVyX2RhdGFfb2Zmc2V0CisJLmVxdQlfX3RlZ3JhX2NwdV9yZXNldF9oYW5kbGVyX2RhdGFfb2Zm
c2V0LCBcCisJCQkJCS4gLSBfX3RlZ3JhX2NwdV9yZXNldF9oYW5kbGVyX3N0YXJ0CiBfX3RlZ3Jh
X2NwdV9yZXNldF9oYW5kbGVyX2RhdGE6Ci0JLnJlcHQJVEVHUkFfUkVTRVRfREFUQV9TSVpFCi0J
LmxvbmcJMAorCS5yZXB0ICAgVEVHUkFfUkVTRVRfREFUQV9TSVpFCisJLmxvbmcgICAwCiAJLmVu
ZHIKLQkuZ2xvYmwJX190ZWdyYTIwX2NwdTFfcmVzZXR0YWJsZV9zdGF0dXNfb2Zmc2V0Ci0JLmVx
dQlfX3RlZ3JhMjBfY3B1MV9yZXNldHRhYmxlX3N0YXR1c19vZmZzZXQsIFwKLQkJCQkJLiAtIF9f
dGVncmFfY3B1X3Jlc2V0X2hhbmRsZXJfc3RhcnQKLQkuYnl0ZQkwCiAJLmFsaWduIEwxX0NBQ0hF
X1NISUZUCiAKIEVOVFJZKF9fdGVncmFfY3B1X3Jlc2V0X2hhbmRsZXJfZW5kKQpkaWZmIC0tZ2l0
IGEvYXJjaC9hcm0vbWFjaC10ZWdyYS9yZXNldC5jIGIvYXJjaC9hcm0vbWFjaC10ZWdyYS9yZXNl
dC5jCmluZGV4IGRjNTU4ODkyNzUzYy4uYjAyYWU3Njk5ODQyIDEwMDY0NAotLS0gYS9hcmNoL2Fy
bS9tYWNoLXRlZ3JhL3Jlc2V0LmMKKysrIGIvYXJjaC9hcm0vbWFjaC10ZWdyYS9yZXNldC5jCkBA
IC0yNCw2ICsyNCw3IEBACiAjaW5jbHVkZSA8YXNtL2NhY2hlZmx1c2guaD4KICNpbmNsdWRlIDxh
c20vZmlybXdhcmUuaD4KICNpbmNsdWRlIDxhc20vaGFyZHdhcmUvY2FjaGUtbDJ4MC5oPgorI2lu
Y2x1ZGUgPGFzbS90cnVzdGVkX2ZvdW5kYXRpb25zLmg+CiAKICNpbmNsdWRlICJpb21hcC5oIgog
I2luY2x1ZGUgImlyYW1tYXAuaCIKQEAgLTg5LDYgKzkwLDggQEAgc3RhdGljIHZvaWQgX19pbml0
IHRlZ3JhX2NwdV9yZXNldF9oYW5kbGVyX2VuYWJsZSh2b2lkKQogCiB2b2lkIF9faW5pdCB0ZWdy
YV9jcHVfcmVzZXRfaGFuZGxlcl9pbml0KHZvaWQpCiB7CisJX190ZWdyYV9jcHVfcmVzZXRfaGFu
ZGxlcl9kYXRhW1RFR1JBX1JFU0VUX1RGX1BSRVNFTlRdID0KKwkJdHJ1c3RlZF9mb3VuZGF0aW9u
c19yZWdpc3RlcmVkKCk7CiAKICNpZmRlZiBDT05GSUdfU01QCiAJX190ZWdyYV9jcHVfcmVzZXRf
aGFuZGxlcl9kYXRhW1RFR1JBX1JFU0VUX01BU0tfUFJFU0VOVF0gPQpkaWZmIC0tZ2l0IGEvYXJj
aC9hcm0vbWFjaC10ZWdyYS9yZXNldC5oIGIvYXJjaC9hcm0vbWFjaC10ZWdyYS9yZXNldC5oCmlu
ZGV4IDljNDc5Yzc5MjViOC4uZGIwZTZiMzA5N2FiIDEwMDY0NAotLS0gYS9hcmNoL2FybS9tYWNo
LXRlZ3JhL3Jlc2V0LmgKKysrIGIvYXJjaC9hcm0vbWFjaC10ZWdyYS9yZXNldC5oCkBAIC0yNSw3
ICsyNSwxMSBAQAogI2RlZmluZSBURUdSQV9SRVNFVF9TVEFSVFVQX1NFQ09OREFSWQkzCiAjZGVm
aW5lIFRFR1JBX1JFU0VUX1NUQVJUVVBfTFAyCQk0CiAjZGVmaW5lIFRFR1JBX1JFU0VUX1NUQVJU
VVBfTFAxCQk1Ci0jZGVmaW5lIFRFR1JBX1JFU0VUX0RBVEFfU0laRQkJNgorI2RlZmluZSBURUdS
QV9SRVNFVF9SRVNFVFRBQkxFX1NUQVRVUwk2CisjZGVmaW5lIFRFR1JBX1JFU0VUX1RGX1BSRVNF
TlQJCTcKKyNkZWZpbmUgVEVHUkFfUkVTRVRfREFUQV9TSVpFCQk4CisKKyNkZWZpbmUgUkVTRVRf
REFUQSh4KQkoKFRFR1JBX1JFU0VUXyMjeCkqNCkKIAogI2lmbmRlZiBfX0FTU0VNQkxZX18KIApA
QCAtNDksNyArNTMsOCBAQCB2b2lkIF9fdGVncmFfY3B1X3Jlc2V0X2hhbmRsZXJfZW5kKHZvaWQp
OwogCSAodTMyKV9fdGVncmFfY3B1X3Jlc2V0X2hhbmRsZXJfc3RhcnQpKSkKICNkZWZpbmUgdGVn
cmEyMF9jcHUxX3Jlc2V0dGFibGVfc3RhdHVzIFwKIAkoSU9fQUREUkVTUyhURUdSQV9JUkFNX0JB
U0UgKyBURUdSQV9JUkFNX1JFU0VUX0hBTkRMRVJfT0ZGU0VUICsgXAotCSAodTMyKV9fdGVncmEy
MF9jcHUxX3Jlc2V0dGFibGVfc3RhdHVzX29mZnNldCkpCisJKCh1MzIpJl9fdGVncmFfY3B1X3Jl
c2V0X2hhbmRsZXJfZGF0YVtURUdSQV9SRVNFVF9SRVNFVFRBQkxFX1NUQVRVU10gLSBcCisJICh1
MzIpX190ZWdyYV9jcHVfcmVzZXRfaGFuZGxlcl9zdGFydCkpKQogI2VuZGlmCiAKICNkZWZpbmUg
dGVncmFfY3B1X3Jlc2V0X2hhbmRsZXJfb2Zmc2V0IFwKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21h
Y2gtdGVncmEvc2xlZXAtdGVncmEyMC5TIGIvYXJjaC9hcm0vbWFjaC10ZWdyYS9zbGVlcC10ZWdy
YTIwLlMKaW5kZXggZGVkZWViZmNjYzU1Li41MGQ1MWQzNDY1ZjYgMTAwNjQ0Ci0tLSBhL2FyY2gv
YXJtL21hY2gtdGVncmEvc2xlZXAtdGVncmEyMC5TCisrKyBiL2FyY2gvYXJtL21hY2gtdGVncmEv
c2xlZXAtdGVncmEyMC5TCkBAIC0yOCw2ICsyOCw3IEBACiAjaW5jbHVkZSA8YXNtL2NhY2hlLmg+
CiAKICNpbmNsdWRlICJpcmFtbWFwLmgiCisjaW5jbHVkZSAicmVzZXQuaCIKICNpbmNsdWRlICJz
bGVlcC5oIgogCiAjZGVmaW5lIEVNQ19DRkcJCQkJMHhjCkBAIC01Myw2ICs1NCw5IEBACiAjZGVm
aW5lIEFQQl9NSVNDX1hNMkNGR0NQQURDVFJMMgkweDhlNAogI2RlZmluZSBBUEJfTUlTQ19YTTJD
RkdEUEFEQ1RSTDIJMHg4ZTgKIAorI2RlZmluZSBfX3RlZ3JhMjBfY3B1MV9yZXNldHRhYmxlX3N0
YXR1c19vZmZzZXQgXAorCShfX3RlZ3JhX2NwdV9yZXNldF9oYW5kbGVyX2RhdGFfb2Zmc2V0ICsg
UkVTRVRfREFUQShSRVNFVFRBQkxFX1NUQVRVUykpCisKIC5tYWNybyBwbGxfZW5hYmxlLCByZCwg
cl9jYXJfYmFzZSwgcGxsX2Jhc2UKIAlsZHIJXHJkLCBbXHJfY2FyX2Jhc2UsICNccGxsX2Jhc2Vd
CiAJdHN0CVxyZCwgIygxIDw8IDMwKQotLSAKMi4yMC4xCgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QK
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
