Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D3DC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:05:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 580CB20868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sR6xxP4q";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IYtMXcvP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 580CB20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=jkECi9u6NdN93kTQzw4lJgW8CzJZk5RRyHcAnFIPCdA=; b=sR6xxP4qMS3lFi
	Y1lBJitVtvTve38occq81Ng43n2lCtaczzjyzPtyXFzPPRmqMeCv0/m2KAAEyXd+znQclXSfVLKws
	lu8HRhea1I9bvLOKMG/d9gcFF6adpg4jvQXHJtvvEaE6y8YR+QREcaxrVlHSrdUzEsJN9juGpVw9R
	AAPOCRHqgDBogEsan6zujGLBAJQxhKaRNezM7ZeqhtJWyFeE+iLzoOwm4Fciu6o7pR+HZkQaYfSAW
	3ofPMfz37ZD/a6/G1hSMdSFz9vv+59zjZYhKVhBxnczmn0aOir8AH2raT2qDGDzk99j3nQFVKTAZJ
	dExyXnrU3jUR/iaSaA9Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSlIH-0005Vl-5L; Fri, 30 Nov 2018 16:05:29 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSlIE-0005UU-3k
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 16:05:27 +0000
Received: by mail-lj1-x243.google.com with SMTP id v15-v6so5420850ljh.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 08:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1Q6OpVlKGi2rNqRFLuocPd3nAs+AvtLdb1mSVpc1EnA=;
 b=IYtMXcvPk8+BDvFq2Q2tdfg9Rwd44S3kfp4mU1Z7O5P4HmDpKH50HnwftrxRChC9gr
 mcU1/XKs8lU+B9cy8BpheN343aEDbGBg/tacXx6uGRLOseXTUuY0b7lYcS0Fx+gVGlwL
 d/cW/S16Pw9BcKsfNY65nlIt7i8S53wbk7zoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1Q6OpVlKGi2rNqRFLuocPd3nAs+AvtLdb1mSVpc1EnA=;
 b=nyRoiLir62UBB1Bg4o2vG89A2JUcdaCgtlVm6QuHZ4iPPyVn78eEk7/0JiGHh2/ppm
 MvOpK/cpTHcGt+4xalUY24S7ah1u09yyOU0DYCEJ17P877vLrjkm4vrr+LR9LtFnnwBe
 +fvUxEpXpaKR9D5nt8sW6H9T7Jv9gVDL2qXZp449iWLIOJ2gJi+dV9rDligjwiJ782km
 cWpIjYnNCtjBd2ienq7RUTcRzIJc/WioX4VLxFbatg1ZJz6PWjwpuTiEj7JMAEGwkRN5
 f9AiXLTiiexXAtbJ5fdP2jJOxgC9LveHw5NpeWxOFdekae1zK/2jyV6rrB82VNJaAJGN
 yzTQ==
X-Gm-Message-State: AA+aEWb0eWlSsD/rc1JNX5RiOx+tTBOEOcyX4MIaRsjVFG3WKjPBJrFT
 jTQNOMmUa8s/HTqDaMalPShfYwnc8zmUMg==
X-Google-Smtp-Source: AFSGD/X6Lm1WS5hC8lqISP4G+FznzWxMvIBnP2h2EOCLz3/i4IaSqq3+7YUOt1dFf9VbYgX8c4dB4Q==
X-Received: by 2002:a2e:5418:: with SMTP id
 i24-v6mr4603769ljb.51.1543593913761; 
 Fri, 30 Nov 2018 08:05:13 -0800 (PST)
Received: from localhost (c-732171d5.07-21-73746f28.bbcust.telenor.se.
 [213.113.33.115])
 by smtp.gmail.com with ESMTPSA id d82sm889847lfd.82.2018.11.30.08.05.12
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 30 Nov 2018 08:05:13 -0800 (PST)
From: Anders Roxell <anders.roxell@linaro.org>
To: airlied@linux.ie,
	wens@csie.org
Subject: [PATCH] drm/sun4i: tcon: fix false-positive uninitialized build
 warning
Date: Fri, 30 Nov 2018 17:05:08 +0100
Message-Id: <20181130160508.28230-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_080526_152826_78336AB4 
X-CRM114-Status: GOOD (  14.89  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>,
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

V2l0aCBHQ0MgdmVyc2lvbiA1IGFuZCA2LCB0aGlzIHVuaW5pdGlhbGl6ZWQgd2FybmluZyBjYW4g
YmUgc2Vlbi4KR0NDIGhhdmUgYmVlbiBmaXhlZCBpbiBuZXdlciB2ZXJzaW9ucy4KCmRyaXZlcnMv
Z3B1L2RybS9zdW40aS9zdW40aV90Y29uLmM6IEluIGZ1bmN0aW9uIOKAmHN1bjRpX3Rjb25fYmlu
ZOKAmToKZHJpdmVycy9ncHUvZHJtL3N1bjRpL3N1bjRpX3Rjb24uYzoxMDkxOjIxOiB3YXJuaW5n
OiDigJhoYXNfbHZkc19hbHTigJkgbWF5IGJlIHVzZWQgdW5pbml0aWFsaXplZCBpbiB0aGlzIGZ1
bmN0aW9uIFstV21heWJlLXVuaW5pdGlhbGl6ZWRdCiAgYm9vbCBoYXNfbHZkc19yc3QsIGhhc19s
dmRzX2FsdCwgY2FuX2x2ZHM7CiAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fgoKUmV3
b3JrZWQgdGhlIGNvZGUgc28gaXQgY292ZXJzIHRoYXQgZmFsc2UgcG9zaXRpdmUgYWxzby4KCkNv
LWRldmVsb3BlZC1ieTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4KU2lnbmVkLW9mZi1i
eTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4KU2lnbmVkLW9mZi1ieTogQW5kZXJzIFJv
eGVsbCA8YW5kZXJzLnJveGVsbEBsaW5hcm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9zdW40
aS9zdW40aV90Y29uLmMgfCAxOCArKysrKysrKystLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA5
IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL3N1bjRpL3N1bjRpX3Rjb24uYyBiL2RyaXZlcnMvZ3B1L2RybS9zdW40aS9zdW40aV90Y29u
LmMKaW5kZXggMDQyMGY1Yzk3OGI5Li4zMTdkNGZhMzQyOWMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9zdW40aS9zdW40aV90Y29uLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL3N1bjRpL3N1
bjRpX3Rjb24uYwpAQCAtMTE2MSwyMCArMTE2MSwyMCBAQCBzdGF0aWMgaW50IHN1bjRpX3Rjb25f
YmluZChzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZpY2UgKm1hc3RlciwKIAkJICovCiAJ
CWlmICh0Y29uLT5xdWlya3MtPmhhc19sdmRzX2FsdCkgewogCQkJdGNvbi0+bHZkc19wbGwgPSBk
ZXZtX2Nsa19nZXQoZGV2LCAibHZkcy1hbHQiKTsKLQkJCWlmIChJU19FUlIodGNvbi0+bHZkc19w
bGwpKSB7Ci0JCQkJaWYgKFBUUl9FUlIodGNvbi0+bHZkc19wbGwpID09IC1FTk9FTlQpIHsKLQkJ
CQkJaGFzX2x2ZHNfYWx0ID0gZmFsc2U7Ci0JCQkJfSBlbHNlIHsKLQkJCQkJZGV2X2VycihkZXYs
ICJDb3VsZG4ndCBnZXQgdGhlIExWRFMgUExMXG4iKTsKLQkJCQkJcmV0dXJuIFBUUl9FUlIodGNv
bi0+bHZkc19wbGwpOwotCQkJCX0KKwkJCXJldCA9IFBUUl9FUlJfT1JfWkVSTyh0Y29uLT5sdmRz
X3BsbCk7CisJCQlpZiAocmV0ID09IC1FTk9FTlQpIHsKKwkJCQloYXNfbHZkc19hbHQgPSBmYWxz
ZTsKKwkJCX0gZWxzZSBpZiAocmV0KSB7CisJCQkJZGV2X2VycihkZXYsICJDb3VsZG4ndCBnZXQg
dGhlIExWRFMgUExMXG4iKTsKKwkJCQlyZXR1cm4gcmV0OwogCQkJfSBlbHNlIHsKIAkJCQloYXNf
bHZkc19hbHQgPSB0cnVlOwogCQkJfQorCQl9IGVsc2UgIHsKKwkJCWhhc19sdmRzX2FsdCA9IGZh
bHNlOwogCQl9CiAKLQkJaWYgKCFoYXNfbHZkc19yc3QgfHwKLQkJICAgICh0Y29uLT5xdWlya3Mt
Pmhhc19sdmRzX2FsdCAmJiAhaGFzX2x2ZHNfYWx0KSkgeworCQlpZiAoIWhhc19sdmRzX3JzdCB8
fCAhaGFzX2x2ZHNfYWx0KSB7CiAJCQlkZXZfd2FybihkZXYsICJNaXNzaW5nIExWRFMgcHJvcGVy
dGllcywgUGxlYXNlIHVwZ3JhZGUgeW91ciBEVFxuIik7CiAJCQlkZXZfd2FybihkZXYsICJMVkRT
IG91dHB1dCBkaXNhYmxlZFxuIik7CiAJCQljYW5fbHZkcyA9IGZhbHNlOwotLSAKMi4xOS4xCgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJt
LWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtl
cm5lbAo=
