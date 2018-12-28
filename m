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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA4EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 16:34:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09B6D20874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 16:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J1pjTy9T";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlTubREK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09B6D20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LFf4YGwIP7v/EZi5J8vr/64RkJhjbZ0nI8IyfEjN9wc=; b=J1pjTy9TO7ACSr
	CNBQeO3E//L2K+ZGFPBhQxfr8HgrWB58BWRK/JTBNx1zeKuOSqh+CnYt84JcuhyRclmUsBtpxDUjP
	kvLRi8WMvvm9aD2Xl9daA/l4iJD7YPJLvPRfSbAkOtC6KAU/GiuuPrWghxfPQbvGFGVGxZK9ihIQF
	M2ER8x90U6NqucMYtKsDcBluAKZo813BWY6Pdwl8nYWI+wdZEQ0rT+3UUR/nm4x5/JVzyiui59ee6
	rTmzwiOntuoCLNdnA8jVZeyaa7PhfXxzFoSjFhbAjXdfyavVqUOVDlAUtbxsoaHCL4c/ZLFkJMAzt
	e4YqIuEpLKE1ies8QX4Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcv54-0001pa-9M; Fri, 28 Dec 2018 16:33:50 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcuqV-0004F1-Jt
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 16:18:54 +0000
Received: by mail-lf1-x143.google.com with SMTP id n18so14846322lfh.6
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 28 Dec 2018 08:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9w1ZLlGE2cGCBHYzebw54rG+E3I6QSZ6vGjxLu+2/ag=;
 b=DlTubREKfeCa9aZ7+uXRCp2OLRHkwN+4g7dbtuv/t8IW0kHRCAzVGpZAlWOD5+Yn1A
 yv2snEKvGbmkKWmpx0jDX7pRwfQ9q5DfRTDDwsVTj2wxAQU/Bc/EkU4mPrNf3weRgJBZ
 uBsRFGZ43flBbW330lKkcF7m09ZYiccQJVmYz+b7D6rC2IbXssH2bYqzaYWgRslRQPwo
 tswxDZRZ3IAOG0oYxqPNIZlBy1D2bwvTOjrlWUmUpvTxu+dn0rw5QDGQKgQPSV/cFYZ0
 QjZNFpQyU1rbQd5AEmhc0WR4i1ZIZZFOTMJgO7aPOOcp+6IB4JCEWv8IX7/QnajnqYD9
 3NFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9w1ZLlGE2cGCBHYzebw54rG+E3I6QSZ6vGjxLu+2/ag=;
 b=QZwxgUfQqRfBEOSMKmMyN498/v8lwz9STuAc5Mux7tOpv0shJr7pUyRFB+xWsR4iXu
 d0VkTaaRKH+meZb9UY3d6Ah6vdvMRdl+LsXqL7CP1NAHgccpZYhhH6rDx7EoVmukxO4j
 80XYeag8f9aC2bhgwk4J8r02gDdJHdgP9GqHComPWkSJQhhSorGAAbPLOR4g20AKQIqu
 my4gyhN0D9OhP4tPAX6OWBdYGE6+j5zECAsW+jiNfqU4YLNUqoVETBQflONhIwnwi69x
 eHi5Xzpz3GCM7pI6nPlvijC8xexY/QClqjoTr6G6RVwLgck2iVp37CSwlbebBlFetvf1
 DKYw==
X-Gm-Message-State: AA+aEWb1PtQlBZRwrUZCfSD6ka3WdKLr004POfIL2bgo8UNC8HHiR9Do
 3nNvinPvvYARSOqXv/DOkxc=
X-Google-Smtp-Source: AFSGD/VqNmnd7QxMAHgjYqgsVPVR0SfathW41kJZPHSuNDz4Oh6rUjU/2v25yVz+Bc22fhDMHJwtyw==
X-Received: by 2002:a19:982:: with SMTP id 124mr13778240lfj.138.1546013919384; 
 Fri, 28 Dec 2018 08:18:39 -0800 (PST)
Received: from localhost.localdomain
 ([2a02:a315:5445:5300:7146:fd07:48ff:9665])
 by smtp.googlemail.com with ESMTPSA id r4sm8136502lfe.60.2018.12.28.08.18.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 28 Dec 2018 08:18:38 -0800 (PST)
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: krzk@kernel.org
Subject: [PATCH 5/6] ARM: dts: s5pv210: aries: Support for more devices
 present on Aries
Date: Fri, 28 Dec 2018 17:18:18 +0100
Message-Id: <20181228161819.18931-6-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181228161819.18931-1-pawel.mikolaj.chmiel@gmail.com>
References: <20181228161819.18931-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_081848_009016_B3F3D572 
X-CRM114-Status: GOOD (  13.42  )
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

RnJvbTogSm9uYXRoYW4gQmFra2VyIDx4Yy1yYWNlcjJAbGl2ZS5jYT4KClRoaXMgY29tbWl0IGVu
YWJsZXMgZm9sbG93aW5nIGRldmljZXMgcHJlc2VudCBvbiBBcmllcyBiYXNlZCBwaG9uZXM6Ci0g
cHdtLXZpYnJhdG9yIGF0dGFjaGVkIHRvIFBXTSAxCi0gcG93ZXJvZmYgc3VwcG9ydAotIEF0bWVs
IG1hWFRvdWNoIHRvdWNoc2NyZWVuLiBJdCdzIGNvbm5lY3RlZCB0byBpMmMyCi0gQnJvYWRjb20g
QkNNNDMyOSBibHVldG9vdGggb3ZlciB1YXJ0MAoKU2lnbmVkLW9mZi1ieTogSm9uYXRoYW4gQmFr
a2VyIDx4Yy1yYWNlcjJAbGl2ZS5jYT4KU2lnbmVkLW9mZi1ieTogUGF3ZcWCIENobWllbCA8cGF3
ZWwubWlrb2xhai5jaG1pZWxAZ21haWwuY29tPgotLS0KIGFyY2gvYXJtL2Jvb3QvZHRzL3M1cHYy
MTAtYXJpZXMuZHRzaSB8IDY4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBj
aGFuZ2VkLCA2OCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMv
czVwdjIxMC1hcmllcy5kdHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvczVwdjIxMC1hcmllcy5kdHNp
CmluZGV4IDM1YmEwMDlhMWEzMy4uYjcyNDZmODc5NjQ4IDEwMDY0NAotLS0gYS9hcmNoL2FybS9i
b290L2R0cy9zNXB2MjEwLWFyaWVzLmR0c2kKKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvczVwdjIx
MC1hcmllcy5kdHNpCkBAIC00MSw2ICs0MSwxMyBAQAogCQl9OwogCX07CiAKKwl2aWJyYXRvcl9w
d3I6IHJlZ3VsYXRvci1maXhlZC0wIHsKKwkJY29tcGF0aWJsZSA9ICJyZWd1bGF0b3ItZml4ZWQi
OworCQlyZWd1bGF0b3ItbmFtZSA9ICJ2aWJyYXRvci1lbiI7CisJCWVuYWJsZS1hY3RpdmUtaGln
aDsKKwkJZ3BpbyA9IDwmZ3BqMSAxIEdQSU9fQUNUSVZFX0hJR0g+OworCX07CisKIAl3aWZpX3B3
cnNlcTogd2lmaS1wd3JzZXEgewogCQljb21wYXRpYmxlID0gIm1tYy1wd3JzZXEtc2ltcGxlIjsK
IAkJcmVzZXQtZ3Bpb3MgPSA8JmdwZzEgMiBHUElPX0FDVElWRV9MT1c+OwpAQCAtMzE0LDYgKzMy
MSwyMiBAQAogCQkJcmVnID0gPDB4MzY+OwogCQl9OwogCX07CisKKwl2aWJyYXRvcjogcHdtLXZp
YnJhdG9yIHsKKwkJY29tcGF0aWJsZSA9ICJwd20tdmlicmF0b3IiOworCQlwd21zID0gPCZwd20g
MSA0NDY0MiAwPjsKKwkJcHdtLW5hbWVzID0gImVuYWJsZSI7CisJCXZjYy1zdXBwbHkgPSA8JnZp
YnJhdG9yX3B3cj47CisJCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7CisJCXBpbmN0cmwtMCA9
IDwmcHdtMV9vdXQ+OworCX07CisKKwlwb3dlcm9mZjogc3lzY29uLXBvd2Vyb2ZmIHsKKwkJY29t
cGF0aWJsZSA9ICJzeXNjb24tcG93ZXJvZmYiOworCQlyZWdtYXAgPSA8JnBtdV9zeXNjb24+Owor
CQlvZmZzZXQgPSA8MHg2ODFjPjsgLyogUFNfSE9MRF9DT05UUk9MICovCisJCXZhbHVlID0gPDB4
NTIwMD47CisJfTsKIH07CiAKICZmaW1kIHsKQEAgLTM0Nyw2ICszNzAsMjMgQEAKIAlzdGF0dXMg
PSAib2theSI7CiB9OwogCismaTJjMiB7CisJc2Ftc3VuZyxpMmMtc2RhLWRlbGF5ID0gPDEwMD47
CisJc2Ftc3VuZyxpMmMtbWF4LWJ1cy1mcmVxID0gPDQwMDAwMD47CisJc2Ftc3VuZyxpMmMtc2xh
dmUtYWRkciA9IDwweDEwPjsKKwlzdGF0dXMgPSAib2theSI7CisKKwl0b3VjaHNjcmVlbkA0YSB7
CisJCWNvbXBhdGlibGUgPSAiYXRtZWwsbWF4dG91Y2giOworCQlyZWcgPSA8MHg0YT47CisJCWlu
dGVycnVwdC1wYXJlbnQgPSA8JmdwajA+OworCQlpbnRlcnJ1cHRzID0gPDUgSVJRX1RZUEVfTEVW
RUxfTE9XPjsKKwkJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsKKwkJcGluY3RybC0wID0gPCZ0
c19pcnE+OworCQlyZXNldC1ncGlvcyA9IDwmZ3BqMSAzIEdQSU9fQUNUSVZFX0hJR0g+OworCX07
Cit9OworCiAmbWZjIHsKIAltZW1vcnktcmVnaW9uID0gPCZtZmNfbGVmdD4sIDwmbWZjX3JpZ2h0
PjsKIH07CkBAIC0zNzIsNiArNDEyLDEzIEBACiAJCXNhbXN1bmcscGluLWRydiA9IDxFWFlOT1M0
X1BJTl9EUlZfTFYxPjsKIAl9OwogCisJYnRfaG9zdF93YWtlOiBidC1ob3N0LXdha2UgeworCQlz
YW1zdW5nLHBpbnMgPSAiZ3BoMi01IjsKKwkJc2Ftc3VuZyxwaW4tZnVuY3Rpb24gPSA8RVhZTk9T
X1BJTl9GVU5DX0lOUFVUPjsKKwkJc2Ftc3VuZyxwaW4tcHVkID0gPFMzQzY0WFhfUElOX1BVTExf
RE9XTj47CisJCXNhbXN1bmcscGluLWRydiA9IDxFWFlOT1M0X1BJTl9EUlZfTFYxPjsKKwl9Owor
CiAJdGZfZGV0ZWN0OiB0Zi1kZXRlY3QgewogCQlzYW1zdW5nLHBpbnMgPSAiZ3BoMy00IjsKIAkJ
c2Ftc3VuZyxwaW4tZnVuY3Rpb24gPSA8RVhZTk9TX1BJTl9GVU5DX0lOUFVUPjsKQEAgLTM4NCw2
ICs0MzEsMTcgQEAKIAkJc2Ftc3VuZyxwaW4tZnVuY3Rpb24gPSA8RVhZTk9TX1BJTl9GVU5DX09V
VFBVVD47CiAJCXNhbXN1bmcscGluLXB1ZCA9IDxTM0M2NFhYX1BJTl9QVUxMX05PTkU+OwogCX07
CisKKwl0c19pcnE6IHRzLWlycSB7CisJCXNhbXN1bmcscGlucyA9ICJncGowLTUiOworCQlzYW1z
dW5nLHBpbi1mdW5jdGlvbiA9IDxFWFlOT1NfUElOX0ZVTkNfSU5QVVQ+OworCQlzYW1zdW5nLHBp
bi1wdWQgPSA8UzNDNjRYWF9QSU5fUFVMTF9VUD47CisJCXNhbXN1bmcscGluLWRydiA9IDxFWFlO
T1M0X1BJTl9EUlZfTFYxPjsKKwl9OworfTsKKworJnB3bSB7CisJc2Ftc3VuZyxwd20tb3V0cHV0
cyA9IDwxPjsKIH07CiAKICZzZGhjaTEgewpAQCAtNDIxLDYgKzQ3OSwxNiBAQAogCiAmdWFydDAg
ewogCXN0YXR1cyA9ICJva2F5IjsKKworCWJsdWV0b290aCB7CisJCWNvbXBhdGlibGUgPSAiYnJj
bSxiY200MzQzOC1idCI7CisJCW1heC1zcGVlZCA9IDwxMTUyMDA+OworCQlwaW5jdHJsLW5hbWVz
ID0gImRlZmF1bHQiOworCQlwaW5jdHJsLTAgPSA8JnVhcnQwX2RhdGEgJnVhcnQwX2ZjdGwgJmJ0
X2hvc3Rfd2FrZT47CisJCXNodXRkb3duLWdwaW9zID0gPCZncGIgMyBHUElPX0FDVElWRV9ISUdI
PjsKKwkJZGV2aWNlLXdha2V1cC1ncGlvcyA9IDwmZ3BnMyA0IEdQSU9fQUNUSVZFX0hJR0g+Owor
CQlob3N0LXdha2V1cC1ncGlvcyA9IDwmZ3BoMiA1IEdQSU9fQUNUSVZFX0hJR0g+OworCX07CiB9
OwogCiAmdWFydDEgewotLSAKMi4xNy4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
