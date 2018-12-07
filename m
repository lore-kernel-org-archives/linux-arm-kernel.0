Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18525C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:29:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB48520837
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HMBDYv3p";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wx9N47JX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB48520837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+kIarU8sjMQQTkVCis/tV9jZRdcDOHCEHN+PjlFHvog=; b=HMBDYv3p76hT+N
	r/dK+2XqTTDLK7WxyWc9hUGQ8zWz0pAWSK8fPiWDNp59ROTJstuFyH8/gOjLpyjNPbMfiJsfyalZa
	fYNyph5qqpsPLR+YDU/HgmoKdpGxs0JK0WFTSlFWOpFRE2GvhQE9PwlqpioLVb12ysDEPrLwpkNMl
	5QelBSj3nTTxRzr9kOHKpoNwtjIVkJjMsJis09TuKBU3nBImmtZHaDPlrjqhNiYX1G3gt6+fokzIx
	Ixp8HrdfEtCbi18IEGHbrTvEasbMJqY28RsCJCAC7KUg7Skv3QKZvN+URWEdCjyO8Vh28wuiFYbBa
	3peuqFh+pu0F85aG1ibw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVH8C-0007hy-Lx; Fri, 07 Dec 2018 14:29:28 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVH7z-0007Vg-28
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 14:29:16 +0000
Received: by mail-lf1-x142.google.com with SMTP id u18so3150248lff.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 06:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=S+OENI6YtzSczLSuymPnFLAriTDDg6DPhxH59mLlxng=;
 b=Wx9N47JXA0kxNsiHKrumv040W7czuEfj/tQSCfblQxXVckW73b2Z5wN2DcD7Ig9y63
 0JwoRZDcFjcV3E+42WvSntm3HZnYAzYsMMJyoCe1oy9ALzbJraLdfH75MohITf8jcXZm
 +4EGkgFxEOedNHjlSM033SO1Dw+tVZrTdONNCchri5jahpXrn4ZHNs1cjA6txoCVyKFk
 PENspGs45go8eoOtO1zQFKVZKk6Zucc9YeYtmqgtzp8VN6nKVjGkKrIuwBRHKyt0P5rN
 NJcIWpu8tJn45jmpe1YL8ggeJGbHF5HfvLwjvKWKLgTKRMzyV1hawSpRtDcHS9xr8f4X
 3kJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=S+OENI6YtzSczLSuymPnFLAriTDDg6DPhxH59mLlxng=;
 b=Cs2miu6S5e3pnIoqtvQnYh1MqPF/ATKDlousct2I9IZItlflO2YkdgmjDZK92+QlHk
 1/tUpBdqeg79+8xwRpvKpY3glG6nX3t1lDXNEFI5SbJSx0FwDdMcf9iX/2EGAVtL62i0
 gVbtKySCktiRnvQjkzRZWQEgzAaeuWBxAeZsGw3si0hhpTHvrviKwA61zoOqZogH9y0s
 DsJuWeyd7XjMdWd4HKW3MP+CB0DNGy8er7ohlbnBlpQh6Lu37cE+4/LhSx5pcw7wQIyJ
 I7K8nssJFcqqALeSSyKH0KdEo5ZtHjw5LYsS56PN09YhFTkSvLMe2NdBks2vn/PU21/+
 4dig==
X-Gm-Message-State: AA+aEWbWAJ6p2ea9n8wOH6w2qgKxWmeqFvFrHptIU6JBRqGzopdh0Znm
 0J/R2y/MvJCSZyXtH1ikeqmurr/mgao=
X-Google-Smtp-Source: AFSGD/Xel2TAfxU/X85KmS2yoOaa1eMH70+7GtbBT3zSR22gSbGsDe46di7TQVf6SYoJPVUlKA0YMw==
X-Received: by 2002:a19:280f:: with SMTP id o15mr1461603lfo.0.1544192943060;
 Fri, 07 Dec 2018 06:29:03 -0800 (PST)
Received: from localhost.localdomain
 ([2a02:a315:5445:5300:74d5:51ba:2673:f3f4])
 by smtp.googlemail.com with ESMTPSA id v64sm630504lfa.48.2018.12.07.06.29.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Dec 2018 06:29:02 -0800 (PST)
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: nick@shmanahar.org
Subject: [PATCH v4 1/3] Input: atmel_mxt_ts: Add support for optional
 regulators
Date: Fri,  7 Dec 2018 15:28:55 +0100
Message-Id: <20181207142857.15818-2-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181207142857.15818-1-pawel.mikolaj.chmiel@gmail.com>
References: <20181207142857.15818-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_062915_107341_59B3E393 
X-CRM114-Status: GOOD (  19.86  )
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
b2xhai5jaG1pZWxAZ21haWwuY29tPgotLS0KQ2hhbmdlcyBmcm9tIHYzOgogIC0gRml4IGNoZWNr
cGF0Y2ggaXNzdWVzCiAgLSBEcm9wIHNlbnRlbmNlIHB1bmN0dWF0aW9uIGZyb20gc3ViamVjdCBv
ZiBvbmUgb2YgcGF0Y2hlcwoKQ2hhbmdlcyBmcm9tIHYyOgogIC0gTW92ZSBjb2RlIGVuYWJsaW5n
IHJlZ3VsYXRvcnMgaW50byBzZXBhcmF0ZSBtZXRob2QsCiAgICB0byBtYWtlIGNvZGUgbW9yZSBy
ZWFkYWJsZS4KCkNoYW5nZXMgZnJvbSB2MToKICAtIEVuYWJsZSByZWd1bGF0b3JzIG9ubHkgaWYg
cmVzZXRfZ3BpbyBpcyBwcmVzZW50LgogIC0gU3dpdGNoIGZyb20gZGV2bV9yZWd1bGF0b3JfZ2V0
X29wdGlvbmFsIHRvIGRldm1fcmVndWxhdG9yX2dldAotLS0KIGRyaXZlcnMvaW5wdXQvdG91Y2hz
Y3JlZW4vYXRtZWxfbXh0X3RzLmMgfCA2NSArKysrKysrKysrKysrKysrKysrKystLS0KIDEgZmls
ZSBjaGFuZ2VkLCA1OSBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvaW5wdXQvdG91Y2hzY3JlZW4vYXRtZWxfbXh0X3RzLmMgYi9kcml2ZXJzL2lucHV0
L3RvdWNoc2NyZWVuL2F0bWVsX214dF90cy5jCmluZGV4IGQzYWFjZDUzNGU5Yy4uMWRjOGFkMGRh
NWFmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2lucHV0L3RvdWNoc2NyZWVuL2F0bWVsX214dF90cy5j
CisrKyBiL2RyaXZlcnMvaW5wdXQvdG91Y2hzY3JlZW4vYXRtZWxfbXh0X3RzLmMKQEAgLTI3LDYg
KzI3LDcgQEAKICNpbmNsdWRlIDxsaW51eC9pbnRlcnJ1cHQuaD4KICNpbmNsdWRlIDxsaW51eC9v
Zi5oPgogI2luY2x1ZGUgPGxpbnV4L3Byb3BlcnR5Lmg+CisjaW5jbHVkZSA8bGludXgvcmVndWxh
dG9yL2NvbnN1bWVyLmg+CiAjaW5jbHVkZSA8bGludXgvc2xhYi5oPgogI2luY2x1ZGUgPGxpbnV4
L2dwaW8vY29uc3VtZXIuaD4KICNpbmNsdWRlIDxhc20vdW5hbGlnbmVkLmg+CkBAIC0xOTQsMTAg
KzE5NSwxMCBAQCBlbnVtIHQxMDBfdHlwZSB7CiAKIC8qIERlbGF5IHRpbWVzICovCiAjZGVmaW5l
IE1YVF9CQUNLVVBfVElNRQkJNTAJLyogbXNlYyAqLwotI2RlZmluZSBNWFRfUkVTRVRfR1BJT19U
SU1FCTIwCS8qIG1zZWMgKi8KICNkZWZpbmUgTVhUX1JFU0VUX0lOVkFMSURfQ0hHCTEwMAkvKiBt
c2VjICovCiAjZGVmaW5lIE1YVF9SRVNFVF9USU1FCQkyMDAJLyogbXNlYyAqLwogI2RlZmluZSBN
WFRfUkVTRVRfVElNRU9VVAkzMDAwCS8qIG1zZWMgKi8KKyNkZWZpbmUgTVhUX1JFR1VMQVRPUl9E
RUxBWQkxNTAJLyogbXNlYyAqLwogI2RlZmluZSBNWFRfQ1JDX1RJTUVPVVQJCTEwMDAJLyogbXNl
YyAqLwogI2RlZmluZSBNWFRfRldfUkVTRVRfVElNRQkzMDAwCS8qIG1zZWMgKi8KICNkZWZpbmUg
TVhUX0ZXX0NIR19USU1FT1VUCTMwMAkvKiBtc2VjICovCkBAIC0zMjMsNiArMzI0LDggQEAgc3Ry
dWN0IG14dF9kYXRhIHsKIAlzdHJ1Y3QgdDdfY29uZmlnIHQ3X2NmZzsKIAlzdHJ1Y3QgbXh0X2Ri
ZyBkYmc7CiAJc3RydWN0IGdwaW9fZGVzYyAqcmVzZXRfZ3BpbzsKKwlzdHJ1Y3QgcmVndWxhdG9y
ICp2ZGRfcmVnOworCXN0cnVjdCByZWd1bGF0b3IgKmF2ZGRfcmVnOwogCiAJLyogQ2FjaGVkIHBh
cmFtZXRlcnMgZnJvbSBvYmplY3QgdGFibGUgKi8KIAl1MTYgVDVfYWRkcmVzczsKQEAgLTMwMzgs
NiArMzA0MSwzOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGRtaV9zeXN0ZW1faWQgY2hyb21lYm9v
a19UOV9zdXNwZW5kX2RtaVtdID0gewogCXsgfQogfTsKIAorc3RhdGljIGludCBteHRfcmVndWxh
dG9yX2VuYWJsZShzdHJ1Y3QgbXh0X2RhdGEgKmRhdGEpCit7CisJaW50IGVycm9yOworCisJaWYg
KGRhdGEtPnJlc2V0X2dwaW8pIHsKKwkJZXJyb3IgPSByZWd1bGF0b3JfZW5hYmxlKGRhdGEtPnZk
ZF9yZWcpOworCQlpZiAoZXJyb3IpIHsKKwkJCWRldl9lcnIoJmRhdGEtPmNsaWVudC0+ZGV2LAor
CQkJCSJGYWlsZWQgdG8gZW5hYmxlIHZkZCByZWd1bGF0b3I6ICVkXG4iLCBlcnJvcik7CisJCQly
ZXR1cm4gZXJyb3I7CisJCX0KKworCQllcnJvciA9IHJlZ3VsYXRvcl9lbmFibGUoZGF0YS0+YXZk
ZF9yZWcpOworCQlpZiAoZXJyb3IpIHsKKwkJCWRldl9lcnIoJmRhdGEtPmNsaWVudC0+ZGV2LAor
CQkJCSJGYWlsZWQgdG8gZW5hYmxlIGF2ZGQgcmVndWxhdG9yOiAlZFxuIiwgZXJyb3IpOworCQkJ
cmV0dXJuIGVycm9yOworCQl9CisKKwkJLyoKKwkJICogQWNjb3JkaW5nIHRvIG1hWFRvdWNoIHBv
d2VyIHNlcXVlbmNpbmcgc3BlY2lmaWNhdGlvbiwKKwkJICogUkVTRVQgbGluZSBtdXN0IGJlIGtl
cHQgbG93IHVudGlsIHNvbWUgdGltZQorCQkgKiBhZnRlciByZWd1bGF0b3JzIGNvbWUgdXAgdG8g
dm9sdGFnZQorCQkgKi8KKwkJbXNsZWVwKE1YVF9SRUdVTEFUT1JfREVMQVkpOworCQlncGlvZF9z
ZXRfdmFsdWUoZGF0YS0+cmVzZXRfZ3BpbywgMSk7CisJCW1zbGVlcChNWFRfUkVTRVRfSU5WQUxJ
RF9DSEcpOworCX0KKworCXJldHVybiAwOworfQorCiBzdGF0aWMgaW50IG14dF9wcm9iZShzdHJ1
Y3QgaTJjX2NsaWVudCAqY2xpZW50LCBjb25zdCBzdHJ1Y3QgaTJjX2RldmljZV9pZCAqaWQpCiB7
CiAJc3RydWN0IG14dF9kYXRhICpkYXRhOwpAQCAtMzA5OCw2ICszMTMzLDIyIEBAIHN0YXRpYyBp
bnQgbXh0X3Byb2JlKHN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQsIGNvbnN0IHN0cnVjdCBpMmNf
ZGV2aWNlX2lkICppZCkKIAkJcmV0dXJuIGVycm9yOwogCX0KIAorCWRhdGEtPnZkZF9yZWcgPSBk
ZXZtX3JlZ3VsYXRvcl9nZXQoJmNsaWVudC0+ZGV2LCAidmRkIik7CisJaWYgKElTX0VSUihkYXRh
LT52ZGRfcmVnKSkgeworCQllcnJvciA9IFBUUl9FUlIoZGF0YS0+dmRkX3JlZyk7CisJCWRldl9l
cnIoJmNsaWVudC0+ZGV2LCAiRmFpbGVkIHRvIGdldCB2ZGQgcmVndWxhdG9yOiAlZFxuIiwKKwkJ
CWVycm9yKTsKKwkJcmV0dXJuIGVycm9yOworCX0KKworCWRhdGEtPmF2ZGRfcmVnID0gZGV2bV9y
ZWd1bGF0b3JfZ2V0KCZjbGllbnQtPmRldiwgImF2ZGQiKTsKKwlpZiAoSVNfRVJSKGRhdGEtPmF2
ZGRfcmVnKSkgeworCQllcnJvciA9IFBUUl9FUlIoZGF0YS0+YXZkZF9yZWcpOworCQlkZXZfZXJy
KCZjbGllbnQtPmRldiwgIkZhaWxlZCB0byBnZXQgYXZkZCByZWd1bGF0b3I6ICVkXG4iLAorCQkJ
ZXJyb3IpOworCQlyZXR1cm4gZXJyb3I7CisJfQorCiAJZXJyb3IgPSBkZXZtX3JlcXVlc3RfdGhy
ZWFkZWRfaXJxKCZjbGllbnQtPmRldiwgY2xpZW50LT5pcnEsCiAJCQkJCSAgTlVMTCwgbXh0X2lu
dGVycnVwdCwgSVJRRl9PTkVTSE9ULAogCQkJCQkgIGNsaWVudC0+bmFtZSwgZGF0YSk7CkBAIC0z
MTA4LDExICszMTU5LDkgQEAgc3RhdGljIGludCBteHRfcHJvYmUoc3RydWN0IGkyY19jbGllbnQg
KmNsaWVudCwgY29uc3Qgc3RydWN0IGkyY19kZXZpY2VfaWQgKmlkKQogCiAJZGlzYWJsZV9pcnEo
Y2xpZW50LT5pcnEpOwogCi0JaWYgKGRhdGEtPnJlc2V0X2dwaW8pIHsKLQkJbXNsZWVwKE1YVF9S
RVNFVF9HUElPX1RJTUUpOwotCQlncGlvZF9zZXRfdmFsdWUoZGF0YS0+cmVzZXRfZ3BpbywgMSk7
Ci0JCW1zbGVlcChNWFRfUkVTRVRfSU5WQUxJRF9DSEcpOwotCX0KKwllcnJvciA9IG14dF9yZWd1
bGF0b3JfZW5hYmxlKGRhdGEpOworCWlmIChlcnJvcikKKwkJcmV0dXJuIGVycm9yOwogCiAJZXJy
b3IgPSBteHRfaW5pdGlhbGl6ZShkYXRhKTsKIAlpZiAoZXJyb3IpCkBAIC0zMTM4LDYgKzMxODcs
MTAgQEAgc3RhdGljIGludCBteHRfcmVtb3ZlKHN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQpCiAJ
c3RydWN0IG14dF9kYXRhICpkYXRhID0gaTJjX2dldF9jbGllbnRkYXRhKGNsaWVudCk7CiAKIAlk
aXNhYmxlX2lycShkYXRhLT5pcnEpOworCWlmIChkYXRhLT5yZXNldF9ncGlvKSB7CisJCXJlZ3Vs
YXRvcl9kaXNhYmxlKGRhdGEtPmF2ZGRfcmVnKTsKKwkJcmVndWxhdG9yX2Rpc2FibGUoZGF0YS0+
dmRkX3JlZyk7CisJfQogCXN5c2ZzX3JlbW92ZV9ncm91cCgmY2xpZW50LT5kZXYua29iaiwgJm14
dF9hdHRyX2dyb3VwKTsKIAlteHRfZnJlZV9pbnB1dF9kZXZpY2UoZGF0YSk7CiAJbXh0X2ZyZWVf
b2JqZWN0X3RhYmxlKGRhdGEpOwotLSAKMi4xNy4xCgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
