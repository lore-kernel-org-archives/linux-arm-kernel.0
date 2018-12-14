Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410AFC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:13:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19E5C206E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nNzAwwgR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X/lkoih1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnRyMRjy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19E5C206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=V3AZwSS1uaznsYUYZqpB9pOs6ekTNDfj1rTS8Q3HvVI=; b=nNzAwwgR8tu0yy
	z94Y0PeAK7+iGkpPHNOtqVBNQCqYHqQ7QcRZDu1HzTCwFx8JhD+5YKhjxcTdJ3YgzMJCV14TJNngZ
	B584adly7uuuqAnuRUKRmUz8wLFH4jv/sUawGxEb/ocsucBf+agBNOoWwoeT8NFR90sub/rTui4tM
	7NyQATR7wPzLDGTIcgQXv1yY7qBpQB40Y6ef+U+kozQfdDC/0ImGgDaAAOjzsOHj67x5D2/9N6IY0
	/3Mxafl7E7yFw1PqQWgAd30RdVvXRKmH/2Mk3pH4CGyGzaQrFbZn58ffFeTmTxFxAzkPtVN6tLOMe
	oxmpw09XnvgIq6t7ihUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXp9S-0001i6-NS; Fri, 14 Dec 2018 15:13:18 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXp9A-0001Ul-2V
 for linux-arm-kernel@bombadil.infradead.org; Fri, 14 Dec 2018 15:13:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CDJY0iulsgx7iN3Slcal1yubzfA4l/+2jzl1Lo0q7x8=; b=X/lkoih13NTGzCxk/xADvsDeP/
 GPggq78neHg9b/Danv5HEOhTvNr0sSJ8LY8XRsXv9SZQG6uHRw70CF8ejEsS02dCgwXPQP+E6LhG4
 chEZDol74/Y1PpVxWwsysJsJ5EAOkpCtG8ofKzTPBEZud3/RZtEl4958kP1Z5eDg5FDrvUZG4ONiL
 BFKVXE7YeD9MF7tbsspum2w0m9ZiKihRIawYCsi/QD/Y/bejw6/YX6krZ9QD1ySCUv1Ou/kdNUsyo
 3EIDgKDLTR2jdUqzqNlDaUzNvghuRrYqJt0iNHgNjDyR10g6xkjEX4lSHDTCH+41eaaWTud2ziw06
 XETPMUVA==;
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXp95-00073Y-9a
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 15:12:58 +0000
Received: by mail-lf1-x143.google.com with SMTP id a16so4506619lfg.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 14 Dec 2018 07:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CDJY0iulsgx7iN3Slcal1yubzfA4l/+2jzl1Lo0q7x8=;
 b=YnRyMRjyoYUoa1T/lnyviF6hzTQKfzw8lD7MwA/HobzairVIQZIW07DfpDJextINJf
 hHd3xbR2R5pY95UONlZNkcywcrUyaCJo0YZWl3AASOrF0ZpJfFUK/NvEiGNNCkOdijgV
 DwfC0Zc7cVpA84uTALkBgi9NpD4dox5Vtc0+G702De9lqh/lxl8bMkfyXjDuQPA+HiNW
 1KgRiGC5CxHLEJT8FWPR+iOcoxoZDJX11HZ30AhQyp01NQj5pC1DH45fXsmIZtB2k2ZZ
 LLbC5VreBU9Q3x6uOwuBcZZIwadoDxU+oYEDUmkkJPxEhZeUcH/s0btKNazqfFxXmlkH
 cQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CDJY0iulsgx7iN3Slcal1yubzfA4l/+2jzl1Lo0q7x8=;
 b=Dq9QMV//1SL1OJNwJTumd+m7sWv1badSrvSXN0Fg/kC8GzvesXdjfPrJtipOXwsdAk
 TMeIuGZhb8tmeUtfIHw4owIC0oyCTof2+/6Pek7Hvbq3fjjSs6LoVX3sgKKXyxx+QkLy
 OXNpxtSojDU3Erw0wNqCcufkSZnHzRRUOeMLdBH25JznSQKLFd0lfJ5zyI6JA8VH42Ks
 y07ziUM0rgtgXj3NWY0QzSlNAkCFiTjv4xaNA2o61YxtSvbgRVqTN4HnSFfJnfHZWGr2
 2qsPQ+RR2VJChV4MBgT8O2up0OzPrHLmJCThRMMqlGM72f+zvDboZqXAByrixeEydS6K
 4LMQ==
X-Gm-Message-State: AA+aEWbd/bMXarJTN1D5/yuZxa7xU78zQG3nFLdoz/F4b4Dft4nphn7c
 nINwh46fIllhAyGLNcsJatc=
X-Google-Smtp-Source: AFSGD/VdHqcg0co6kob+PtNe4FXaN8qc1HI3HiQH+J8lppE8KwqwD1UR3Q+Ro19KLWiMhrXHCLUKbg==
X-Received: by 2002:a19:c115:: with SMTP id r21mr2047482lff.144.1544800360099; 
 Fri, 14 Dec 2018 07:12:40 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:976:99fb:a7e3:627c])
 by smtp.googlemail.com with ESMTPSA id o17sm951975lff.77.2018.12.14.07.12.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Dec 2018 07:12:39 -0800 (PST)
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: nick@shmanahar.org
Subject: [PATCH v5 1/3] Input: atmel_mxt_ts: Add support for optional
 regulators
Date: Fri, 14 Dec 2018 16:12:12 +0100
Message-Id: <20181214151214.5391-2-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181214151214.5391-1-pawel.mikolaj.chmiel@gmail.com>
References: <20181214151214.5391-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_101255_357365_3547B74F 
X-CRM114-Status: GOOD (  22.21  )
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

VGhpcyBwYXRjaCBhZGRzIG9wdGlvbmFsIHJlZ3VsYXRvcnMsIHdoaWNoIGNhbiBiZSB1c2VkIHRv
IHBvd2VyCnVwIHRvdWNoc2NyZWVuLiBBZnRlciBlbmFibGluZyByZWd1bGF0b3JzLCB3ZSBuZWVk
IHRvIHdhaXQgMTUwbXNlYy4KVGhpcyB2YWx1ZSBpcyB0YWtlbiBmcm9tIG9mZmljaWFsIGRyaXZl
ci4KCkl0IHdhcyB0ZXN0ZWQgb24gU2Ftc3VuZyBHYWxheHkgaTkwMDAgKGJhc2VkIG9uIFNhbXN1
bmcgUzVQVjIxMCBTT0MpLgoKU2lnbmVkLW9mZi1ieTogUGF3ZcWCIENobWllbCA8cGF3ZWwubWlr
b2xhai5jaG1pZWxAZ21haWwuY29tPgotLS0KQ2hhbmdlcyBmcm9tIHY0OgogIC0gQWRkIG1pc3Np
bmcgcmVndWxhdG9yX2Rpc2FibGUgZm9yIHZkZCBpbiBjYXNlIG9mIGVycm9yLAogICAgd2hlbiBl
bmFibGluZyBhdmRkIHJlZ3VsYXRvcgoKQ2hhbmdlcyBmcm9tIHYzOgogIC0gRml4IGNoZWNrcGF0
Y2ggaXNzdWVzCiAgLSBEcm9wIHNlbnRlbmNlIHB1bmN0dWF0aW9uIGZyb20gcGF0Y2ggc3ViamVj
dAoKQ2hhbmdlcyBmcm9tIHYyOgogIC0gTW92ZSBjb2RlIGVuYWJsaW5nIHJlZ3VsYXRvcnMgaW50
byBzZXBhcmF0ZSBtZXRob2QsCiAgICB0byBtYWtlIGNvZGUgbW9yZSByZWFkYWJsZS4KCkNoYW5n
ZXMgZnJvbSB2MToKICAtIEVuYWJsZSByZWd1bGF0b3JzIG9ubHkgaWYgcmVzZXRfZ3BpbyBpcyBw
cmVzZW50LgogIC0gU3dpdGNoIGZyb20gZGV2bV9yZWd1bGF0b3JfZ2V0X29wdGlvbmFsIHRvIGRl
dm1fcmVndWxhdG9yX2dldAotLS0KIGRyaXZlcnMvaW5wdXQvdG91Y2hzY3JlZW4vYXRtZWxfbXh0
X3RzLmMgfCA2NyArKysrKysrKysrKysrKysrKysrKystLS0KIDEgZmlsZSBjaGFuZ2VkLCA2MSBp
bnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5wdXQv
dG91Y2hzY3JlZW4vYXRtZWxfbXh0X3RzLmMgYi9kcml2ZXJzL2lucHV0L3RvdWNoc2NyZWVuL2F0
bWVsX214dF90cy5jCmluZGV4IGQzYWFjZDUzNGU5Yy4uNTVhMTA3ZmMxYjczIDEwMDY0NAotLS0g
YS9kcml2ZXJzL2lucHV0L3RvdWNoc2NyZWVuL2F0bWVsX214dF90cy5jCisrKyBiL2RyaXZlcnMv
aW5wdXQvdG91Y2hzY3JlZW4vYXRtZWxfbXh0X3RzLmMKQEAgLTI3LDYgKzI3LDcgQEAKICNpbmNs
dWRlIDxsaW51eC9pbnRlcnJ1cHQuaD4KICNpbmNsdWRlIDxsaW51eC9vZi5oPgogI2luY2x1ZGUg
PGxpbnV4L3Byb3BlcnR5Lmg+CisjaW5jbHVkZSA8bGludXgvcmVndWxhdG9yL2NvbnN1bWVyLmg+
CiAjaW5jbHVkZSA8bGludXgvc2xhYi5oPgogI2luY2x1ZGUgPGxpbnV4L2dwaW8vY29uc3VtZXIu
aD4KICNpbmNsdWRlIDxhc20vdW5hbGlnbmVkLmg+CkBAIC0xOTQsMTAgKzE5NSwxMCBAQCBlbnVt
IHQxMDBfdHlwZSB7CiAKIC8qIERlbGF5IHRpbWVzICovCiAjZGVmaW5lIE1YVF9CQUNLVVBfVElN
RQkJNTAJLyogbXNlYyAqLwotI2RlZmluZSBNWFRfUkVTRVRfR1BJT19USU1FCTIwCS8qIG1zZWMg
Ki8KICNkZWZpbmUgTVhUX1JFU0VUX0lOVkFMSURfQ0hHCTEwMAkvKiBtc2VjICovCiAjZGVmaW5l
IE1YVF9SRVNFVF9USU1FCQkyMDAJLyogbXNlYyAqLwogI2RlZmluZSBNWFRfUkVTRVRfVElNRU9V
VAkzMDAwCS8qIG1zZWMgKi8KKyNkZWZpbmUgTVhUX1JFR1VMQVRPUl9ERUxBWQkxNTAJLyogbXNl
YyAqLwogI2RlZmluZSBNWFRfQ1JDX1RJTUVPVVQJCTEwMDAJLyogbXNlYyAqLwogI2RlZmluZSBN
WFRfRldfUkVTRVRfVElNRQkzMDAwCS8qIG1zZWMgKi8KICNkZWZpbmUgTVhUX0ZXX0NIR19USU1F
T1VUCTMwMAkvKiBtc2VjICovCkBAIC0zMjMsNiArMzI0LDggQEAgc3RydWN0IG14dF9kYXRhIHsK
IAlzdHJ1Y3QgdDdfY29uZmlnIHQ3X2NmZzsKIAlzdHJ1Y3QgbXh0X2RiZyBkYmc7CiAJc3RydWN0
IGdwaW9fZGVzYyAqcmVzZXRfZ3BpbzsKKwlzdHJ1Y3QgcmVndWxhdG9yICp2ZGRfcmVnOworCXN0
cnVjdCByZWd1bGF0b3IgKmF2ZGRfcmVnOwogCiAJLyogQ2FjaGVkIHBhcmFtZXRlcnMgZnJvbSBv
YmplY3QgdGFibGUgKi8KIAl1MTYgVDVfYWRkcmVzczsKQEAgLTMwMzgsNiArMzA0MSw0MCBAQCBz
dGF0aWMgY29uc3Qgc3RydWN0IGRtaV9zeXN0ZW1faWQgY2hyb21lYm9va19UOV9zdXNwZW5kX2Rt
aVtdID0gewogCXsgfQogfTsKIAorc3RhdGljIGludCBteHRfcmVndWxhdG9yX2VuYWJsZShzdHJ1
Y3QgbXh0X2RhdGEgKmRhdGEpCit7CisJaW50IGVycm9yOworCisJaWYgKGRhdGEtPnJlc2V0X2dw
aW8pIHsKKwkJZXJyb3IgPSByZWd1bGF0b3JfZW5hYmxlKGRhdGEtPnZkZF9yZWcpOworCQlpZiAo
ZXJyb3IpIHsKKwkJCWRldl9lcnIoJmRhdGEtPmNsaWVudC0+ZGV2LAorCQkJCSJGYWlsZWQgdG8g
ZW5hYmxlIHZkZCByZWd1bGF0b3I6ICVkXG4iLCBlcnJvcik7CisJCQlyZXR1cm4gZXJyb3I7CisJ
CX0KKworCQllcnJvciA9IHJlZ3VsYXRvcl9lbmFibGUoZGF0YS0+YXZkZF9yZWcpOworCQlpZiAo
ZXJyb3IpIHsKKwkJCXJlZ3VsYXRvcl9kaXNhYmxlKGRhdGEtPnZkZF9yZWcpOworCisJCQlkZXZf
ZXJyKCZkYXRhLT5jbGllbnQtPmRldiwKKwkJCQkiRmFpbGVkIHRvIGVuYWJsZSBhdmRkIHJlZ3Vs
YXRvcjogJWRcbiIsIGVycm9yKTsKKwkJCXJldHVybiBlcnJvcjsKKwkJfQorCisJCS8qCisJCSAq
IEFjY29yZGluZyB0byBtYVhUb3VjaCBwb3dlciBzZXF1ZW5jaW5nIHNwZWNpZmljYXRpb24sCisJ
CSAqIFJFU0VUIGxpbmUgbXVzdCBiZSBrZXB0IGxvdyB1bnRpbCBzb21lIHRpbWUKKwkJICogYWZ0
ZXIgcmVndWxhdG9ycyBjb21lIHVwIHRvIHZvbHRhZ2UKKwkJICovCisJCW1zbGVlcChNWFRfUkVH
VUxBVE9SX0RFTEFZKTsKKwkJZ3Bpb2Rfc2V0X3ZhbHVlKGRhdGEtPnJlc2V0X2dwaW8sIDEpOwor
CQltc2xlZXAoTVhUX1JFU0VUX0lOVkFMSURfQ0hHKTsKKwl9CisKKwlyZXR1cm4gMDsKK30KKwog
c3RhdGljIGludCBteHRfcHJvYmUoc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCwgY29uc3Qgc3Ry
dWN0IGkyY19kZXZpY2VfaWQgKmlkKQogewogCXN0cnVjdCBteHRfZGF0YSAqZGF0YTsKQEAgLTMw
OTgsNiArMzEzNSwyMiBAQCBzdGF0aWMgaW50IG14dF9wcm9iZShzdHJ1Y3QgaTJjX2NsaWVudCAq
Y2xpZW50LCBjb25zdCBzdHJ1Y3QgaTJjX2RldmljZV9pZCAqaWQpCiAJCXJldHVybiBlcnJvcjsK
IAl9CiAKKwlkYXRhLT52ZGRfcmVnID0gZGV2bV9yZWd1bGF0b3JfZ2V0KCZjbGllbnQtPmRldiwg
InZkZCIpOworCWlmIChJU19FUlIoZGF0YS0+dmRkX3JlZykpIHsKKwkJZXJyb3IgPSBQVFJfRVJS
KGRhdGEtPnZkZF9yZWcpOworCQlkZXZfZXJyKCZjbGllbnQtPmRldiwgIkZhaWxlZCB0byBnZXQg
dmRkIHJlZ3VsYXRvcjogJWRcbiIsCisJCQllcnJvcik7CisJCXJldHVybiBlcnJvcjsKKwl9CisK
KwlkYXRhLT5hdmRkX3JlZyA9IGRldm1fcmVndWxhdG9yX2dldCgmY2xpZW50LT5kZXYsICJhdmRk
Iik7CisJaWYgKElTX0VSUihkYXRhLT5hdmRkX3JlZykpIHsKKwkJZXJyb3IgPSBQVFJfRVJSKGRh
dGEtPmF2ZGRfcmVnKTsKKwkJZGV2X2VycigmY2xpZW50LT5kZXYsICJGYWlsZWQgdG8gZ2V0IGF2
ZGQgcmVndWxhdG9yOiAlZFxuIiwKKwkJCWVycm9yKTsKKwkJcmV0dXJuIGVycm9yOworCX0KKwog
CWVycm9yID0gZGV2bV9yZXF1ZXN0X3RocmVhZGVkX2lycSgmY2xpZW50LT5kZXYsIGNsaWVudC0+
aXJxLAogCQkJCQkgIE5VTEwsIG14dF9pbnRlcnJ1cHQsIElSUUZfT05FU0hPVCwKIAkJCQkJICBj
bGllbnQtPm5hbWUsIGRhdGEpOwpAQCAtMzEwOCwxMSArMzE2MSw5IEBAIHN0YXRpYyBpbnQgbXh0
X3Byb2JlKHN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQsIGNvbnN0IHN0cnVjdCBpMmNfZGV2aWNl
X2lkICppZCkKIAogCWRpc2FibGVfaXJxKGNsaWVudC0+aXJxKTsKIAotCWlmIChkYXRhLT5yZXNl
dF9ncGlvKSB7Ci0JCW1zbGVlcChNWFRfUkVTRVRfR1BJT19USU1FKTsKLQkJZ3Bpb2Rfc2V0X3Zh
bHVlKGRhdGEtPnJlc2V0X2dwaW8sIDEpOwotCQltc2xlZXAoTVhUX1JFU0VUX0lOVkFMSURfQ0hH
KTsKLQl9CisJZXJyb3IgPSBteHRfcmVndWxhdG9yX2VuYWJsZShkYXRhKTsKKwlpZiAoZXJyb3Ip
CisJCXJldHVybiBlcnJvcjsKIAogCWVycm9yID0gbXh0X2luaXRpYWxpemUoZGF0YSk7CiAJaWYg
KGVycm9yKQpAQCAtMzEzOCw2ICszMTg5LDEwIEBAIHN0YXRpYyBpbnQgbXh0X3JlbW92ZShzdHJ1
Y3QgaTJjX2NsaWVudCAqY2xpZW50KQogCXN0cnVjdCBteHRfZGF0YSAqZGF0YSA9IGkyY19nZXRf
Y2xpZW50ZGF0YShjbGllbnQpOwogCiAJZGlzYWJsZV9pcnEoZGF0YS0+aXJxKTsKKwlpZiAoZGF0
YS0+cmVzZXRfZ3BpbykgeworCQlyZWd1bGF0b3JfZGlzYWJsZShkYXRhLT5hdmRkX3JlZyk7CisJ
CXJlZ3VsYXRvcl9kaXNhYmxlKGRhdGEtPnZkZF9yZWcpOworCX0KIAlzeXNmc19yZW1vdmVfZ3Jv
dXAoJmNsaWVudC0+ZGV2LmtvYmosICZteHRfYXR0cl9ncm91cCk7CiAJbXh0X2ZyZWVfaW5wdXRf
ZGV2aWNlKGRhdGEpOwogCW14dF9mcmVlX29iamVjdF90YWJsZShkYXRhKTsKLS0gCjIuMTcuMQoK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFy
bS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1r
ZXJuZWwK
