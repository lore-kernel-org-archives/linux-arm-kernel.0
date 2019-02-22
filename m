Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95525C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:36:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 620CF20700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rWD3xEEW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsIWcPQX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 620CF20700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9SqpaXlY4kDVDCaz9lCY2Fx3fYuqH92FWJpIf5oQL8c=; b=rWD3xEEWh+bVd4
	pMneykbuJ0+FsoRQw1GwBEKEZF1ePAoqnPc+YpTy0DRnBZWwQXO16VBKghxMqRHWKXQq/sf7lFKJK
	LSsYOgfTdLWw9Mb1PKVh+JEMP87gN/C1+q9EMwMdNCPLwLUA2DVlNaX5XaHccqofqpwqGWjFx4g1s
	+2Bt8C1+8NC3Q3r47ynFL2RtszIWmu5rq3D+0ACTBRF/UdKtJMGef7GVJJZwMckX3z+JemxG9qvX5
	da1RTN6z2uYLWvHa+JuH7F+Lfv1qSm0wOdB3KiWLJLOpruYjQdcK+ZkJA3Gw6teAGmo2w2KqCr2Od
	951TeL5Q0lFwzgGa4XVQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxGcm-0004i2-PI; Fri, 22 Feb 2019 19:36:44 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxGc6-0003yP-CA
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 19:36:14 +0000
Received: by mail-pl1-x644.google.com with SMTP id s1so1518269plp.9
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 11:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YrdurJIx2ld6iD2HW3AERYM3O3FQwL4YTObVlgwwugY=;
 b=QsIWcPQXAzbb6uZrfIis+xBs77qjr0BU+D0w07M5eQQYqp2M//xMcU5g96MOELlN17
 WEhzsTB+lySILZx3VD4NM8f6mi3P4ed++C7Akex+/b4rqB9RVS4Thd6tBqzq2Vhhoyz9
 L76AhYVT5BaW56uwHiFEvv/I7Pl14lRYL+xCefOrO2K/Y/hHOu75+aTcuxLAJbUCvx1L
 KY62NVZCG4RvelkCBW1oZJ2e3FCgEpxkxN7Vh+ZCbwZC18ekoqMOZ954ch902VpaRVwA
 FRd3fEdsd4jlyyu8UCNe9XfvbJkQ1feUmAuBcGDaarauYIxV3G88mCWsCBwXyPSSxDRE
 2CMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YrdurJIx2ld6iD2HW3AERYM3O3FQwL4YTObVlgwwugY=;
 b=eWJrN4KUOfmTvAtRDJBbPwPU9ytumSD6Cf3/H5pqnMsuCTcf5apMcBVk7TF7gOASDB
 9Sk1E0f5TbYtq0gdyWWtYgsFv9y0v+uYOHSwja1H6D1uTqQUuUflAE6h7kN1nriwrxAS
 wzdkyEr3QHp681pcUK9izuzvz7ztKRQFR7+4q4rTDaTB9Be3f9r5ieWvkAErqh3qjFRO
 Tg3omVxrdPO+tgkpVKXanKIIPNAwFE+L1RziJCBBUskvneZb7JW85LyuNDdY65MAFkQv
 mFzC6mVkT68VglZnPpeLHg+SvP+mviZUYjcXSE1To6FxWTdU1F9ied5LHkfNY60kLbUo
 dvgQ==
X-Gm-Message-State: AHQUAubZKP5dNHPd5uxm67odcvZmFOdWFbc4VZ7RWb8CRq2mbstPOvS4
 35fURH4ES1Y1hpTstCFOcKI=
X-Google-Smtp-Source: AHgI3Ia7hqgW/kb9OTCGGT3iuulY64/F+vtW0SruFmUxap4EncdfxbUcxjoZaBybhy6gnjvpr2TmIw==
X-Received: by 2002:a17:902:1101:: with SMTP id
 d1mr5598889pla.19.1550864161588; 
 Fri, 22 Feb 2019 11:36:01 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru.
 [91.79.175.49])
 by smtp.gmail.com with ESMTPSA id e21sm7687190pfh.45.2019.02.22.11.35.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Feb 2019 11:36:01 -0800 (PST)
From: Dmitry Osipenko <digetx@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Robert Yang <decatf@gmail.com>,
 =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v6 5/7] ARM: tegra: Don't apply CPU erratas in insecure mode
Date: Fri, 22 Feb 2019 22:34:24 +0300
Message-Id: <20190222193426.10747-6-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222193426.10747-1-digetx@gmail.com>
References: <20190222193426.10747-1-digetx@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_113602_869372_200B9890 
X-CRM114-Status: GOOD (  14.49  )
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
