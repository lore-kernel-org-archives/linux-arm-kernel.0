Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBA4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:59:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 497F221871
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ppjENFL8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XzKbHqhR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 497F221871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=bQu7QyVXaOK3/uSp6zULIFk/MOCc5+5NkcsUbXIebXM=; b=ppjENFL8OxuWaM
	hkPq0fnblAGR6TxdeQjD7S7TiVAfP2t0mWcaQ1v1XPUyOjk1vqWt4BW8xUOn3WYpIeJW0JgabX6QY
	nwDwN8LmQwEfbcSkLHJB4+ZSHfm5ylriaLrF/TistRycajTCq1nVSutE/oCRGmhURkjfThPx2R2eV
	xZR2lEeBKTB5d939/vcE3PROJkeiFw7aSgS5ap+dam2V5+pqvc36+s7d5nt6h3N105oavnczmkA47
	L2TLCVUZlr8GQB62Dnwm6UwFE4aqMb/eJaBcAP4IYZtiYKrCAXk20hzNF1wL/rBzfdtR45C74dwqR
	a4kdihh2foHfMD9WOb2A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZHmC-0004Vb-KC; Tue, 18 Dec 2018 15:59:20 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZHlN-0003kg-0l
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 15:58:32 +0000
Received: by mail-lj1-x243.google.com with SMTP id k15-v6so14646669ljc.8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 07:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AOxSxA2DTBN1MOMRADhDyHZ9Nkx7f7uCE3hXAzrT1aY=;
 b=XzKbHqhRMtE5i8PxD1Ei1M38nKxCW4rCD3ElaN7GKR4HB6fDPhy3H5ySpWnUfpl77f
 6fDFxvHzvoO3Dw+vc1yFJ1SNhE6JpOBlU8JWjShtiY10/hEFHpEVq8CybQZWoQkWZ5pK
 ltQ0bnBJ3XEI7cBnlUYOV4wlt1tpn4zD9+X6Zwuxogkybrh9U+MbzKGXRwv+j5/yGOY8
 2nzh7f0fdtYJ8Bvt3Pyago90PiwVbqL6zWqS9UsUKYidWy3SRZvKytKKXEQHG8MjR6L0
 9yY+c4tceNOLOgWl8abAsisLfPM35TqVjMBmglw0MBMvUrtkKhAk1wfobdfYykksJg54
 sVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AOxSxA2DTBN1MOMRADhDyHZ9Nkx7f7uCE3hXAzrT1aY=;
 b=FLWkUFFAIIGJnFI6gP6dsJ4Fi/O9+r6yS28jBn/gXelorIIa9Ly23UZvk5gjZo6U1v
 3rK0JjYE6JiTnRHLmhT23l1fhBBfR6H/HlOVhb7QuaJUbAUSYiJsDafc6HKui6wVuQXV
 frOMOHeGQ5bsoJcyG6PnN9cKU/PjOcYwe4MDU7l/Y9d7Ma++MzF813GTGQEZ4I/ik5n4
 +6G9EjXi6tfaQeX0xg2kIYpFOWcrmyy3HaEGXjKPpefEbrCbnV77NMYtiwM/VHnTfNCw
 /lwqOa08Rhc5mM3LxpR321/xoRPQD5ffpaBu/2YEFWAQZVLmWNc0VGdSmaZOi7HvGdRC
 JNpg==
X-Gm-Message-State: AA+aEWag0i9kifnQVXTTwZ8PTMU9Idxwp54Q6l2KjpghSR7L+Ub0QF8g
 9uPHfSuB7zKiAu4LmEj1cN4=
X-Google-Smtp-Source: AFSGD/VIwLXwTX+pZ3dMwEJ7G4hslvVevAQtoGJTf3dyMkv9Cxxeisf9fi7wBMtquP8W5k5kzE/jQw==
X-Received: by 2002:a2e:21a9:: with SMTP id
 h41-v6mr10270735lji.103.1545148696992; 
 Tue, 18 Dec 2018 07:58:16 -0800 (PST)
Received: from linux-veee.lan (ip-194-187-74-233.konfederacka.maverick.com.pl.
 [194.187.74.233])
 by smtp.gmail.com with ESMTPSA id a18-v6sm3022061ljk.86.2018.12.18.07.58.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 18 Dec 2018 07:58:16 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH] pinctrl: bcm: ns: support updated DT binding as syscon subnode
Date: Tue, 18 Dec 2018 16:58:08 +0100
Message-Id: <20181218155808.19517-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.13.7
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_075829_676434_D049A27B 
X-CRM114-Status: GOOD (  18.22  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>,
 Ray Jui <rjui@broadcom.com>, bcm-kernel-feedback-list@broadcom.com,
 =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

RnJvbTogUmFmYcWCIE1pxYJlY2tpIDxyYWZhbEBtaWxlY2tpLnBsPgoKRG9jdW1lbnRhdGlvbiBo
YXMgYmVlbiByZWNlbnRseSB1cGRhdGVkIHNwZWNpZnlpbmcgdGhhdCBwaW5jdHJsIHNob3VsZApi
ZSBzdWJub2RlIG9mIHRoZSBDUlUgInN5c2NvbiIuIFN1cHBvcnQgdGhhdCBieSB1c2luZyBwYXJl
bnQgbm9kZSBmb3IKcmVnbWFwIGFuZCByZWFkaW5nICJvZmZzZXQiIHByb3BlcnR5IGZyb20gdGhl
IERULgoKU2lnbmVkLW9mZi1ieTogUmFmYcWCIE1pxYJlY2tpIDxyYWZhbEBtaWxlY2tpLnBsPgot
LS0KIGRyaXZlcnMvcGluY3RybC9iY20vcGluY3RybC1ucy5jIHwgMjkgKysrKysrKysrKysrKysr
KysrKy0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCAxMCBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3BpbmN0cmwvYmNtL3BpbmN0cmwtbnMuYyBi
L2RyaXZlcnMvcGluY3RybC9iY20vcGluY3RybC1ucy5jCmluZGV4IGQ3ZjgxNzVkMmMxYy4uZTc5
NjkwYmQ4Yjg1IDEwMDY0NAotLS0gYS9kcml2ZXJzL3BpbmN0cmwvYmNtL3BpbmN0cmwtbnMuYwor
KysgYi9kcml2ZXJzL3BpbmN0cmwvYmNtL3BpbmN0cmwtbnMuYwpAQCAtNSw2ICs1LDcgQEAKIAog
I2luY2x1ZGUgPGxpbnV4L2Vyci5oPgogI2luY2x1ZGUgPGxpbnV4L2lvLmg+CisjaW5jbHVkZSA8
bGludXgvbWZkL3N5c2Nvbi5oPgogI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPgogI2luY2x1ZGUg
PGxpbnV4L29mLmg+CiAjaW5jbHVkZSA8bGludXgvb2ZfZGV2aWNlLmg+CkBAIC0xMiw2ICsxMyw3
IEBACiAjaW5jbHVkZSA8bGludXgvcGluY3RybC9waW5jdHJsLmg+CiAjaW5jbHVkZSA8bGludXgv
cGluY3RybC9waW5tdXguaD4KICNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4KKyNp
bmNsdWRlIDxsaW51eC9yZWdtYXAuaD4KICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+CiAKICNkZWZp
bmUgRkxBR19CQ000NzA4CQlCSVQoMSkKQEAgLTIyLDcgKzI0LDggQEAgc3RydWN0IG5zX3BpbmN0
cmwgewogCXN0cnVjdCBkZXZpY2UgKmRldjsKIAl1bnNpZ25lZCBpbnQgY2hpcHNldF9mbGFnOwog
CXN0cnVjdCBwaW5jdHJsX2RldiAqcGN0bGRldjsKLQl2b2lkIF9faW9tZW0gKmJhc2U7CisJc3Ry
dWN0IHJlZ21hcCAqcmVnbWFwOworCXUzMiBvZmZzZXQ7CiAKIAlzdHJ1Y3QgcGluY3RybF9kZXNj
IHBjdGxkZXNjOwogCXN0cnVjdCBuc19waW5jdHJsX2dyb3VwICpncm91cHM7CkBAIC0yMjksOSAr
MjMyLDkgQEAgc3RhdGljIGludCBuc19waW5jdHJsX3NldF9tdXgoc3RydWN0IHBpbmN0cmxfZGV2
ICpwY3RybF9kZXYsCiAJCXVuc2V0IHw9IEJJVChwaW5fbnVtYmVyKTsKIAl9CiAKLQl0bXAgPSBy
ZWFkbChuc19waW5jdHJsLT5iYXNlKTsKKwlyZWdtYXBfcmVhZChuc19waW5jdHJsLT5yZWdtYXAs
IG5zX3BpbmN0cmwtPm9mZnNldCwgJnRtcCk7CiAJdG1wICY9IH51bnNldDsKLQl3cml0ZWwodG1w
LCBuc19waW5jdHJsLT5iYXNlKTsKKwlyZWdtYXBfd3JpdGUobnNfcGluY3RybC0+cmVnbWFwLCBu
c19waW5jdHJsLT5vZmZzZXQsIHRtcCk7CiAKIAlyZXR1cm4gMDsKIH0KQEAgLTI2MywxMyArMjY2
LDEzIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIG5zX3BpbmN0cmxfb2ZfbWF0
Y2hfdGFibGVbXSA9IHsKIHN0YXRpYyBpbnQgbnNfcGluY3RybF9wcm9iZShzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlICpwZGV2KQogewogCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7CisJ
c3RydWN0IGRldmljZV9ub2RlICpucCA9IGRldi0+b2Zfbm9kZTsKIAljb25zdCBzdHJ1Y3Qgb2Zf
ZGV2aWNlX2lkICpvZl9pZDsKIAlzdHJ1Y3QgbnNfcGluY3RybCAqbnNfcGluY3RybDsKIAlzdHJ1
Y3QgcGluY3RybF9kZXNjICpwY3RsZGVzYzsKIAlzdHJ1Y3QgcGluY3RybF9waW5fZGVzYyAqcGlu
OwogCXN0cnVjdCBuc19waW5jdHJsX2dyb3VwICpncm91cDsKIAlzdHJ1Y3QgbnNfcGluY3RybF9m
dW5jdGlvbiAqZnVuY3Rpb247Ci0Jc3RydWN0IHJlc291cmNlICpyZXM7CiAJaW50IGk7CiAKIAlu
c19waW5jdHJsID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCpuc19waW5jdHJsKSwgR0ZQX0tF
Uk5FTCk7CkBAIC0yODcsMTIgKzI5MCwxOCBAQCBzdGF0aWMgaW50IG5zX3BpbmN0cmxfcHJvYmUo
c3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKIAkJcmV0dXJuIC1FSU5WQUw7CiAJbnNfcGlu
Y3RybC0+Y2hpcHNldF9mbGFnID0gKHVpbnRwdHJfdClvZl9pZC0+ZGF0YTsKIAotCXJlcyA9IHBs
YXRmb3JtX2dldF9yZXNvdXJjZV9ieW5hbWUocGRldiwgSU9SRVNPVVJDRV9NRU0sCi0JCQkJCSAg
ICJjcnVfZ3Bpb19jb250cm9sIik7Ci0JbnNfcGluY3RybC0+YmFzZSA9IGRldm1faW9yZW1hcF9y
ZXNvdXJjZShkZXYsIHJlcyk7Ci0JaWYgKElTX0VSUihuc19waW5jdHJsLT5iYXNlKSkgewotCQlk
ZXZfZXJyKGRldiwgIkZhaWxlZCB0byBtYXAgcGluY3RybCByZWdzXG4iKTsKLQkJcmV0dXJuIFBU
Ul9FUlIobnNfcGluY3RybC0+YmFzZSk7CisJbnNfcGluY3RybC0+cmVnbWFwID0gc3lzY29uX25v
ZGVfdG9fcmVnbWFwKG9mX2dldF9wYXJlbnQobnApKTsKKwlpZiAoSVNfRVJSKG5zX3BpbmN0cmwt
PnJlZ21hcCkpIHsKKwkJaW50IGVyciA9IFBUUl9FUlIobnNfcGluY3RybC0+cmVnbWFwKTsKKwor
CQlkZXZfZXJyKGRldiwgIkZhaWxlZCB0byBtYXAgcGluY3RybCByZWdzOiAlZFxuIiwgZXJyKTsK
KworCQlyZXR1cm4gZXJyOworCX0KKworCWlmIChvZl9wcm9wZXJ0eV9yZWFkX3UzMihucCwgIm9m
ZnNldCIsICZuc19waW5jdHJsLT5vZmZzZXQpKSB7CisJCWRldl9lcnIoZGV2LCAiRmFpbGVkIHRv
IGdldCByZWdpc3RlciBvZmZzZXRcbiIpOworCQlyZXR1cm4gLUVOT0VOVDsKIAl9CiAKIAltZW1j
cHkocGN0bGRlc2MsICZuc19waW5jdHJsX2Rlc2MsIHNpemVvZigqcGN0bGRlc2MpKTsKLS0gCjIu
MTMuNwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxp
bnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LWFybS1rZXJuZWwK
