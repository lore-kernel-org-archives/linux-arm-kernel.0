Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1047EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 00:20:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFFB1218A6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 00:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f6+JYu07";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gB9bMMFS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFFB1218A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GSanIPqHPSKuowYdV4oy7cPtWSC/8xqH8OS+BCxfNDI=; b=f6+JYu07Rqas1P
	3A4t7pwu3aWGw4JK2/fc2CXh7K7td1LRYbgnXMn0x3zyvNiuo6mdRsB6fJfN20b+0XA5YaRXPhs7w
	t57SODiFGL/rfU4tv2V1wOiYwp32OSZMxZKqSzsLeL+Mf0XDJqL6ViQV6fEpXD5yLjuYoNHL0oAXM
	C4MSGzvjaFUSHyVxNj+fFyr++8P6XYar2sX2K0KVPGCR4BvT5byg8DJu+jsAFdf0vl09n19c2BU9y
	RK8E79ezLZzlU4wc3MtQDpspk0wbs4gH/mvFw92kGS9fN2Wr8NjA68TjIH+9TyzZUP6+rx9EILGIv
	YkR58/kx33h6KBJ96FcQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvWfr-0003yq-JV; Mon, 18 Feb 2019 00:20:43 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvWf2-0001uY-0S
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 00:20:16 +0000
Received: by mail-pg1-x542.google.com with SMTP id v28so7510645pgk.10
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 17 Feb 2019 16:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2F+WQtD7UmaE6gs1Qx5/njELVxXcgMmUvzMAMx63pSc=;
 b=gB9bMMFSzwZ9meu2aeUtRAv9eaagO4RP/PZXideuQH11PlskQYAV0/0AI1p0mN1vls
 cQBn7XJCpgM9BKufliY1Aob2SAFS/VWCSjtvdyPOBShuEnznafNwrWblOsnTbs352gYt
 BL9rN/kDdZKieUh6kIUO3rwnchKqFlZ2TWQJ2lENfS0y8EpisD/vSJf/4X4ruPebebiP
 X1/HmJ2qSPpey3azelAgTK5eW6AvpYZrHCskIwXYW65quJdLtBvyrzdHQ8+CVpgHMien
 1g6S3vQfbXzaFvVhmsCGsdBiEie6fM3ALnYNbkt0O1VLJSqyB4zbOQF9J8SajPVujZJl
 psdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2F+WQtD7UmaE6gs1Qx5/njELVxXcgMmUvzMAMx63pSc=;
 b=mrxfoRkB4vyoqLzcS2MQjbaMjWvpjgvEZ2trlPEYdG8lObgx4Kpyt9DqP4EYiOIxTH
 SWLE02VnAWy7VJjQ3CbM0Lvr48Oh7jJHXbnhx3/H/NYB/MO1kydEGnl6iJBdbxf/KYFP
 fuIduPBDERn03VjtpYeWPtI/CPaQJtMsFH//ZHeB7M40U9beV7rSEvsEEsIEqc7ennbo
 TkJ4np+cp58JtMLMxeilygXAz4g6T3pbLjgApm22TMKEQrtJZ8kz3zlvhkwymEwRu5Ib
 hZhAoKr7alQyCyVCMBsLTJAFrVIl3175uO9AQ5zDlZz0jFJcKEnM3UI8x+AGzarnFBMk
 +HWw==
X-Gm-Message-State: AHQUAuZXE6app+svAEYqC/yTeCDAhV9NFAwbWhVGJiDdeIls9EtFZ0RI
 uY1mIVaVm3poQi2da1LNABU=
X-Google-Smtp-Source: AHgI3IZXQewZkIHo+DfcVSHmKaZuYEfvh/PFGdQgSBCWv2Io+bWsBLaObZg45pfP04lAgsTNuQPINg==
X-Received: by 2002:a63:1c42:: with SMTP id c2mr16100598pgm.265.1550449191560; 
 Sun, 17 Feb 2019 16:19:51 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru.
 [91.79.175.49])
 by smtp.gmail.com with ESMTPSA id s73sm31518071pfi.124.2019.02.17.16.19.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 17 Feb 2019 16:19:51 -0800 (PST)
From: Dmitry Osipenko <digetx@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Robert Yang <decatf@gmail.com>,
 =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v4 5/8] ARM: tegra: Don't apply CPU erratas in insecure mode
Date: Mon, 18 Feb 2019 03:17:23 +0300
Message-Id: <20190218001726.16785-6-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218001726.16785-1-digetx@gmail.com>
References: <20190218001726.16785-1-digetx@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_161952_419314_6BE119E0 
X-CRM114-Status: GOOD (  14.98  )
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
b20+Ci0tLQogYXJjaC9hcm0vbWFjaC10ZWdyYS9yZXNldC1oYW5kbGVyLlMgfCAyNCArKysrKysr
KysrKystLS0tLS0tLS0tLS0KIGFyY2gvYXJtL21hY2gtdGVncmEvcmVzZXQuYyAgICAgICAgIHwg
IDMgKysrCiBhcmNoL2FybS9tYWNoLXRlZ3JhL3Jlc2V0LmggICAgICAgICB8ICA5ICsrKysrKyst
LQogYXJjaC9hcm0vbWFjaC10ZWdyYS9zbGVlcC10ZWdyYTIwLlMgfCAgNCArKysrCiA0IGZpbGVz
IGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L2FyY2gvYXJtL21hY2gtdGVncmEvcmVzZXQtaGFuZGxlci5TIGIvYXJjaC9hcm0vbWFjaC10ZWdy
YS9yZXNldC1oYW5kbGVyLlMKaW5kZXggODA1ZjMwNmZhNmY3Li5hOWYxMzIzMGRhMmYgMTAwNjQ0
Ci0tLSBhL2FyY2gvYXJtL21hY2gtdGVncmEvcmVzZXQtaGFuZGxlci5TCisrKyBiL2FyY2gvYXJt
L21hY2gtdGVncmEvcmVzZXQtaGFuZGxlci5TCkBAIC0yOSw4ICsyOSw2IEBACiAKICNkZWZpbmUg
UE1DX1NDUkFUQ0g0MQkweDE0MAogCi0jZGVmaW5lIFJFU0VUX0RBVEEoeCkJKChURUdSQV9SRVNF
VF8jI3gpKjQpCi0KICNpZmRlZiBDT05GSUdfUE1fU0xFRVAKIC8qCiAgKgl0ZWdyYV9yZXN1bWUK
QEAgLTEyMSw2ICsxMTksMTIgQEAgRU5UUlkoX190ZWdyYV9jcHVfcmVzZXRfaGFuZGxlcikKIAlj
cHNpZAlhaWYsIDB4MTMJCQlAIFNWQyBtb2RlLCBpbnRlcnJ1cHRzIGRpc2FibGVkCiAKIAl0ZWdy
YV9nZXRfc29jX2lkIFRFR1JBX0FQQl9NSVNDX0JBU0UsIHI2CisKKwlhZHIJcjEyLCBfX3RlZ3Jh
X2NwdV9yZXNldF9oYW5kbGVyX2RhdGEKKwlsZHIJcjUsIFtyMTIsICNSRVNFVF9EQVRBKFRGX1BS
RVNFTlQpXQorCWNtcAlyNSwgIzAKKwlibmUJYWZ0ZXJfZXJyYXRhCisKICNpZmRlZiBDT05GSUdf
QVJDSF9URUdSQV8yeF9TT0MKIHQyMF9jaGVjazoKIAljbXAJcjYsICNURUdSQTIwCkBAIC0xNTUs
NyArMTU5LDYgQEAgYWZ0ZXJfZXJyYXRhOgogCWFuZAlyMTAsIHIxMCwgIzB4MwkJCUAgUjEwID0g
Q1BVIG51bWJlcgogCW1vdglyMTEsICMxCiAJbW92CXIxMSwgcjExLCBsc2wgcjEwICAJCUAgUjEx
ID0gQ1BVIG1hc2sKLQlhZHIJcjEyLCBfX3RlZ3JhX2NwdV9yZXNldF9oYW5kbGVyX2RhdGEKIAog
I2lmZGVmIENPTkZJR19TTVAKIAkvKiBEb2VzIHRoZSBPUyBrbm93IGFib3V0IHRoaXMgQ1BVPyAq
LwpAQCAtMTY5LDEwICsxNzIsOSBAQCBhZnRlcl9lcnJhdGE6CiAJY21wCXI2LCAjVEVHUkEyMAog
CWJuZQkxZgogCS8qIElmIG5vdCBDUFUwLCBkb24ndCBsZXQgQ1BVMCByZXNldCBDUFUxIG5vdyB0
aGF0IENQVTEgaXMgY29taW5nIHVwLiAqLwotCW1vdjMyCXI1LCBURUdSQV9JUkFNX0JBU0UgKyBU
RUdSQV9JUkFNX1JFU0VUX0hBTkRMRVJfT0ZGU0VUCiAJbW92CXIwLCAjQ1BVX05PVF9SRVNFVFRB
QkxFCiAJY21wCXIxMCwgIzAKLQlzdHJuZWIJcjAsIFtyNSwgI19fdGVncmEyMF9jcHUxX3Jlc2V0
dGFibGVfc3RhdHVzX29mZnNldF0KKwlzdHJuZWIJcjAsIFtyMTIsICNSRVNFVF9EQVRBKFJFU0VU
VEFCTEVfU1RBVFVTKV0KIDE6CiAjZW5kaWYKIApAQCAtMjc3LDE0ICsyNzksMTIgQEAgRU5EUFJP
QyhfX3RlZ3JhX2NwdV9yZXNldF9oYW5kbGVyKQogCS5hbGlnbiBMMV9DQUNIRV9TSElGVAogCS50
eXBlCV9fdGVncmFfY3B1X3Jlc2V0X2hhbmRsZXJfZGF0YSwgJW9iamVjdAogCS5nbG9ibAlfX3Rl
Z3JhX2NwdV9yZXNldF9oYW5kbGVyX2RhdGEKKwkuZ2xvYmwJX190ZWdyYV9jcHVfcmVzZXRfaGFu
ZGxlcl9kYXRhX29mZnNldAorCS5lcXUJX190ZWdyYV9jcHVfcmVzZXRfaGFuZGxlcl9kYXRhX29m
ZnNldCwgXAorCQkJCQkuIC0gX190ZWdyYV9jcHVfcmVzZXRfaGFuZGxlcl9zdGFydAogX190ZWdy
YV9jcHVfcmVzZXRfaGFuZGxlcl9kYXRhOgotCS5yZXB0CVRFR1JBX1JFU0VUX0RBVEFfU0laRQot
CS5sb25nCTAKKwkucmVwdCAgIFRFR1JBX1JFU0VUX0RBVEFfU0laRQorCS5sb25nICAgMAogCS5l
bmRyCi0JLmdsb2JsCV9fdGVncmEyMF9jcHUxX3Jlc2V0dGFibGVfc3RhdHVzX29mZnNldAotCS5l
cXUJX190ZWdyYTIwX2NwdTFfcmVzZXR0YWJsZV9zdGF0dXNfb2Zmc2V0LCBcCi0JCQkJCS4gLSBf
X3RlZ3JhX2NwdV9yZXNldF9oYW5kbGVyX3N0YXJ0Ci0JLmJ5dGUJMAogCS5hbGlnbiBMMV9DQUNI
RV9TSElGVAotCiBFTlRSWShfX3RlZ3JhX2NwdV9yZXNldF9oYW5kbGVyX2VuZCkKZGlmZiAtLWdp
dCBhL2FyY2gvYXJtL21hY2gtdGVncmEvcmVzZXQuYyBiL2FyY2gvYXJtL21hY2gtdGVncmEvcmVz
ZXQuYwppbmRleCBkYzU1ODg5Mjc1M2MuLmIwMmFlNzY5OTg0MiAxMDA2NDQKLS0tIGEvYXJjaC9h
cm0vbWFjaC10ZWdyYS9yZXNldC5jCisrKyBiL2FyY2gvYXJtL21hY2gtdGVncmEvcmVzZXQuYwpA
QCAtMjQsNiArMjQsNyBAQAogI2luY2x1ZGUgPGFzbS9jYWNoZWZsdXNoLmg+CiAjaW5jbHVkZSA8
YXNtL2Zpcm13YXJlLmg+CiAjaW5jbHVkZSA8YXNtL2hhcmR3YXJlL2NhY2hlLWwyeDAuaD4KKyNp
bmNsdWRlIDxhc20vdHJ1c3RlZF9mb3VuZGF0aW9ucy5oPgogCiAjaW5jbHVkZSAiaW9tYXAuaCIK
ICNpbmNsdWRlICJpcmFtbWFwLmgiCkBAIC04OSw2ICs5MCw4IEBAIHN0YXRpYyB2b2lkIF9faW5p
dCB0ZWdyYV9jcHVfcmVzZXRfaGFuZGxlcl9lbmFibGUodm9pZCkKIAogdm9pZCBfX2luaXQgdGVn
cmFfY3B1X3Jlc2V0X2hhbmRsZXJfaW5pdCh2b2lkKQogeworCV9fdGVncmFfY3B1X3Jlc2V0X2hh
bmRsZXJfZGF0YVtURUdSQV9SRVNFVF9URl9QUkVTRU5UXSA9CisJCXRydXN0ZWRfZm91bmRhdGlv
bnNfcmVnaXN0ZXJlZCgpOwogCiAjaWZkZWYgQ09ORklHX1NNUAogCV9fdGVncmFfY3B1X3Jlc2V0
X2hhbmRsZXJfZGF0YVtURUdSQV9SRVNFVF9NQVNLX1BSRVNFTlRdID0KZGlmZiAtLWdpdCBhL2Fy
Y2gvYXJtL21hY2gtdGVncmEvcmVzZXQuaCBiL2FyY2gvYXJtL21hY2gtdGVncmEvcmVzZXQuaApp
bmRleCA5YzQ3OWM3OTI1YjguLmRiMGU2YjMwOTdhYiAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFj
aC10ZWdyYS9yZXNldC5oCisrKyBiL2FyY2gvYXJtL21hY2gtdGVncmEvcmVzZXQuaApAQCAtMjUs
NyArMjUsMTEgQEAKICNkZWZpbmUgVEVHUkFfUkVTRVRfU1RBUlRVUF9TRUNPTkRBUlkJMwogI2Rl
ZmluZSBURUdSQV9SRVNFVF9TVEFSVFVQX0xQMgkJNAogI2RlZmluZSBURUdSQV9SRVNFVF9TVEFS
VFVQX0xQMQkJNQotI2RlZmluZSBURUdSQV9SRVNFVF9EQVRBX1NJWkUJCTYKKyNkZWZpbmUgVEVH
UkFfUkVTRVRfUkVTRVRUQUJMRV9TVEFUVVMJNgorI2RlZmluZSBURUdSQV9SRVNFVF9URl9QUkVT
RU5UCQk3CisjZGVmaW5lIFRFR1JBX1JFU0VUX0RBVEFfU0laRQkJOAorCisjZGVmaW5lIFJFU0VU
X0RBVEEoeCkJKChURUdSQV9SRVNFVF8jI3gpKjQpCiAKICNpZm5kZWYgX19BU1NFTUJMWV9fCiAK
QEAgLTQ5LDcgKzUzLDggQEAgdm9pZCBfX3RlZ3JhX2NwdV9yZXNldF9oYW5kbGVyX2VuZCh2b2lk
KTsKIAkgKHUzMilfX3RlZ3JhX2NwdV9yZXNldF9oYW5kbGVyX3N0YXJ0KSkpCiAjZGVmaW5lIHRl
Z3JhMjBfY3B1MV9yZXNldHRhYmxlX3N0YXR1cyBcCiAJKElPX0FERFJFU1MoVEVHUkFfSVJBTV9C
QVNFICsgVEVHUkFfSVJBTV9SRVNFVF9IQU5ETEVSX09GRlNFVCArIFwKLQkgKHUzMilfX3RlZ3Jh
MjBfY3B1MV9yZXNldHRhYmxlX3N0YXR1c19vZmZzZXQpKQorCSgodTMyKSZfX3RlZ3JhX2NwdV9y
ZXNldF9oYW5kbGVyX2RhdGFbVEVHUkFfUkVTRVRfUkVTRVRUQUJMRV9TVEFUVVNdIC0gXAorCSAo
dTMyKV9fdGVncmFfY3B1X3Jlc2V0X2hhbmRsZXJfc3RhcnQpKSkKICNlbmRpZgogCiAjZGVmaW5l
IHRlZ3JhX2NwdV9yZXNldF9oYW5kbGVyX29mZnNldCBcCmRpZmYgLS1naXQgYS9hcmNoL2FybS9t
YWNoLXRlZ3JhL3NsZWVwLXRlZ3JhMjAuUyBiL2FyY2gvYXJtL21hY2gtdGVncmEvc2xlZXAtdGVn
cmEyMC5TCmluZGV4IGRlZGVlYmZjY2M1NS4uNTBkNTFkMzQ2NWY2IDEwMDY0NAotLS0gYS9hcmNo
L2FybS9tYWNoLXRlZ3JhL3NsZWVwLXRlZ3JhMjAuUworKysgYi9hcmNoL2FybS9tYWNoLXRlZ3Jh
L3NsZWVwLXRlZ3JhMjAuUwpAQCAtMjgsNiArMjgsNyBAQAogI2luY2x1ZGUgPGFzbS9jYWNoZS5o
PgogCiAjaW5jbHVkZSAiaXJhbW1hcC5oIgorI2luY2x1ZGUgInJlc2V0LmgiCiAjaW5jbHVkZSAi
c2xlZXAuaCIKIAogI2RlZmluZSBFTUNfQ0ZHCQkJCTB4YwpAQCAtNTMsNiArNTQsOSBAQAogI2Rl
ZmluZSBBUEJfTUlTQ19YTTJDRkdDUEFEQ1RSTDIJMHg4ZTQKICNkZWZpbmUgQVBCX01JU0NfWE0y
Q0ZHRFBBRENUUkwyCTB4OGU4CiAKKyNkZWZpbmUgX190ZWdyYTIwX2NwdTFfcmVzZXR0YWJsZV9z
dGF0dXNfb2Zmc2V0IFwKKwkoX190ZWdyYV9jcHVfcmVzZXRfaGFuZGxlcl9kYXRhX29mZnNldCAr
IFJFU0VUX0RBVEEoUkVTRVRUQUJMRV9TVEFUVVMpKQorCiAubWFjcm8gcGxsX2VuYWJsZSwgcmQs
IHJfY2FyX2Jhc2UsIHBsbF9iYXNlCiAJbGRyCVxyZCwgW1xyX2Nhcl9iYXNlLCAjXHBsbF9iYXNl
XQogCXRzdAlccmQsICMoMSA8PCAzMCkKLS0gCjIuMjAuMQoKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0
CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
