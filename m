Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1B2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:41:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B236520869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A1N1U/Ty";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wh3uAEM3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B236520869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=joNrKr7yS7Fmjb6U+5jMtdm/yNcQxAzAZW7OYPXRqSg=; b=A1N1U/TyU303uD
	H13zkDuSiVJuxzlvRHAd14nrhKKGmjMXjtfNpFxSCFp+OHc9RbYFIeeQ5wt8KQG4hyQdRyAWAVYDP
	ZrSj4HgazNeX0+cMKthLFPMRD3LpAFUkLSd8rD4W7T1hKuGOFJtPZ0kkYH3/5HEK15bNm3iLxPJ0s
	C8nP0/4HrwFxqhW1y5TgcsU2UDZzBWUWey4oGR3M07Itpjtehpe7aQxGycfx+GN7cW5kZGL9vqMJb
	Nyu6q9C6xHJKgvyW0Re3JCFHQJksozCgFozz5YvmeqaECg2LizS72WWQs+S5xR5qX9pSuf7GdWQ7+
	/B6IJkz4B6fZkgl/BcVA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcuG5-0000uv-IH; Fri, 28 Dec 2018 15:41:09 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcuG2-0000uA-5Q
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 15:41:07 +0000
Received: by mail-lf1-x141.google.com with SMTP id v5so14769850lfe.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 28 Dec 2018 07:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=21bsbvry1odVTcqRpYrqvwkCOSdtbscuZy8+UeBKt40=;
 b=Wh3uAEM3h6DLV6/itgP98cVGx5/oDNCoCbjR+/ajc42ghSWqyi1ygeZp+9/9sH/PJ3
 Uuq5IC4mFuPtb1JQ1loE3PyCq8Kne0N5HjqNQ/SHRDKl9QOe52kDltk76zA91xzOhsnK
 9xHtI1p5yp5v7iFnEvfSWj6rBDFBA4PEQpmdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=21bsbvry1odVTcqRpYrqvwkCOSdtbscuZy8+UeBKt40=;
 b=TDzSRUOx5Fo+dXPndaYSyV8CsjWnmvqRNoTaGfau40t1CJFMln/eDLmUrAEgM6EeWx
 J+JBHB30Kfh+ssKygeWpyjmpAS2fO4f1/TY0BRBGK2Y9NZiBh5rNuLaLZDUaG82IUCed
 Uo6PscCsXoTgifj+iywqQkbDp7JdnzVYj2X2AfMBNam6aX7ba4ck42JrDfOak+jxbG6b
 o9tAM2OAY0MFRzZRkPPdagbk0iTJERwFBW8IH5f5Yh5zSBRSg3oMCY1G97tGBHj5Bdmw
 +a6RgWgvoCyhI1Ic3ETKMJSRisXbz7whpXVbClX0Yp+5D50iKgq3U2aDBSn0jMWsHKN9
 xowQ==
X-Gm-Message-State: AA+aEWYkb4RaKFg10YelQFbkfzIb+/4p0YpdPwz9UDcSHPdW9XbKXKcy
 AMmyocWObMaOEmPHZvWKa2MkUg==
X-Google-Smtp-Source: AFSGD/WKBi04XSTl+h6U02bk/UfDRBm+3Lzw8rB46ZQQ52lsgo+VLRnZ5R/PczXk9OkDpvO9O1uI3w==
X-Received: by 2002:a19:5d42:: with SMTP id p2mr15075250lfj.83.1546011653326; 
 Fri, 28 Dec 2018 07:40:53 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
 by smtp.gmail.com with ESMTPSA id d24-v6sm8599125ljg.2.2018.12.28.07.40.51
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 28 Dec 2018 07:40:52 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: dri-devel@lists.freedesktop.org, Eric Anholt <eric@anholt.net>,
 Daniel Vetter <daniel.vetter@intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Sean Paul <seanpaul@chromium.org>
Subject: [PATCH v2] drm/fb-helper: Scale back depth to supported maximum
Date: Fri, 28 Dec 2018 16:40:44 +0100
Message-Id: <20181228154044.10945-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_074106_207691_7E6C7727 
X-CRM114-Status: GOOD (  19.84  )
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
Cc: Linus Walleij <linus.walleij@linaro.org>,
 =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VGhlIGZvbGxvd2luZyBoYXBwZW5lZCB3aGVuIG1pZ3JhdGluZyBhbiBvbGQgZmJkZXYgZHJpdmVy
IHRvIERSTToKClRoZSBJbnRlZ3JhdG9yL0NQIFBMMTExIHN1cHBvcnRzIDE2QlBQIGJ1dCBvbmx5
IEFSR0IxNTU1L0FCR1IxNTU1Cm9yIFhSR0IxNTU1L1hCR1IxNTU1IGkuZS4gdGhlIG1heGltdW0g
ZGVwdGggaXMgMTUuCgpUaGlzIG1ha2VzIHRoZSBpbml0aWFsaXphdGlvbiBvZiB0aGUgZnJhbWVi
dWZmZXIgZmFpbCBzaW5jZQp0aGUgY29kZSBpbiBkcm1fZmJfaGVscGVyX3NpbmdsZV9mYl9wcm9i
ZSgpIGFzc2lnbnMgdGhlIHNhbWUgdmFsdWUKdG8gc2l6ZXMuc3VyZmFjZV9icHAgYW5kIHNpemVz
LnN1cmZhY2VfZGVwdGguIEkuZS4gaXQgc2ltcGx5IGFzc3VtZXMKYSAxLXRvLTEgbWFwcGluZyBi
ZXR3ZWVuIEJQUCBhbmQgZGVwdGgsIHdoaWNoIGlzIHRydWUgaW4gbW9zdCBjYXNlcwpidXQgbm90
IGZvciB0aGlzIGhhcmR3YXJlIHRoYXQgb25seSBzdXBwb3J0IG9kZCBmb3JtYXRzLgoKVG8gc3Vw
cG9ydCB0aGUgb2RkIGNhc2Ugb2YgYSBkcml2ZXIgc3VwcG9ydGluZyAxNkJQUCB3aXRoIG9ubHkg
MTUKYml0cyBvZiBkZXB0aCwgdGhpcyBwYXRjaCB3aWxsIG1ha2UgdGhlIGNvZGUgbG9vcCBvdmVy
IHRoZSBmb3JtYXRzCnN1cHBvcnRlZCBvbiB0aGUgcHJpbWFyeSBwbGFuZSBvbiBlYWNoIENSVEMg
bWFuYWdlZCBieSB0aGUgRkIKaGVscGVyIGFuZCBjYXAgdGhlIGRlcHRoIHRvIHRoZSBtYXhpbXVt
IHN1cHBvcnRlZCBvbiBhbnkgcHJpbWFyeQpwbGFuZS4KCk9uIHRoZSBQTDExMCBJbnRlZ3JhdG9y
LCB0aGlzIG1ha2VzIGRybV9tb2RlX2xlZ2FjeV9mYl9mb3JtYXQoKQpzZWxlY3QgRFJNX0ZPUk1B
VF9YUkdCMTU1NSB3aGljaCBpcyBhY2NlcHRhYmxlIGZvciB0aGlzIGRyaXZlciwgYW5kCnRodXMg
d2UgZ2V0IGZyYW1lYnVmZmVyLCBwZW5ndWluIGFuZCBjb25zb2xlIG9uIHRoZSBJbnRlZ3JhdG9y
L0NQLgoKQ2M6IE5vcmFsZiBUcsO4bm5lcyA8bm9yYWxmQHRyb25uZXMub3JnPgpDYzogVmlsbGUg
U3lyasOkbMOkIDx2aWxsZS5zeXJqYWxhQGxpbnV4LmludGVsLmNvbT4KU2lnbmVkLW9mZi1ieTog
TGludXMgV2FsbGVpaiA8bGludXMud2FsbGVpakBsaW5hcm8ub3JnPgotLS0KQ2hhbmdlTG9nIHYx
LT52MjoKLSBMb29wIG92ZXIgdGhlIENSVENzIG1hbmFnZWQgYnkgdGhlIGhlbHBlciBhbmQgY2hl
Y2sgdGhlCiAgY3J0Yy0+cHJpbWFyeSBvbiBlYWNoIENSVEMgZm9yIHRoZSBhcHBsaWNhYmxlIGZv
cm1hdHMgYW5kCiAgdGh1cyBkZXB0aHMuCi0gU2tpcCBvdmVyIFlVViBmb3JtYXRzLiBUaGUgZnJh
bWVidWZmZXIgZW11bGF0aW9uIGNhbm5vdAogIGhhbmRsZSB0aGVzZSBmb3JtYXRzLgoKVGhlIHYx
IHdhcyBzZW50IHNvbWUgd2hpbGUgYmFjayBpbiBmZWJydWFyeSBhbmQgSSBvbmx5IHJlY2VudGx5
CmdvdCBiYWNrIHRvIGZpeGluZyB0aGlzIHVwIHRvIHN1cHBvcnQgdGhlIGxhc3QgQ0xDRCBkaXNw
bGF5cy4KSXQgd2FzIGFncmVlZCB0aGF0IGl0IGlzIHByb2JhYmx5IGJlc3QgdG8gYXVnbWVudCB0
aGUgZnJhbWVidWZmZXIKaW5pdGlhbGl6ZXIgdG8gcGFzcyBhIGRlc2lyZWQgcGl4ZWwgZm9ybWF0
IGluc3RlYWQgb2YganVzdApCUFAgYXMgdG9kYXksIGJ1dCB0aGF0IGlzIGEgYml0IGRhdW50aW5n
LCBhbmQgRGFuaWVsIHNhaWQgdGhhdAp3ZSB3b3VsZCBwcm9iYWJseSBhbnl3YXlzIG5lZWQgYSBm
YWxsYmFjayBsaWtlIHRoaXMuCi0tLQogZHJpdmVycy9ncHUvZHJtL2RybV9mYl9oZWxwZXIuYyB8
IDQ3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQogMSBmaWxlIGNoYW5nZWQsIDQ2
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vZHJtX2ZiX2hlbHBlci5jIGIvZHJpdmVycy9ncHUvZHJtL2RybV9mYl9oZWxwZXIuYwppbmRl
eCBkM2FmMDk4YjA5MjIuLjU3YmUwNmQ5MzJlNCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2RybV9mYl9oZWxwZXIuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vZHJtX2ZiX2hlbHBlci5jCkBA
IC0xNzk3LDYgKzE3OTcsNyBAQCBzdGF0aWMgaW50IGRybV9mYl9oZWxwZXJfc2luZ2xlX2ZiX3By
b2JlKHN0cnVjdCBkcm1fZmJfaGVscGVyICpmYl9oZWxwZXIsCiAJaW50IGk7CiAJc3RydWN0IGRy
bV9mYl9oZWxwZXJfc3VyZmFjZV9zaXplIHNpemVzOwogCWludCBnYW1tYV9zaXplID0gMDsKKwlp
bnQgYmVzdF9kZXB0aCA9IDA7CiAKIAltZW1zZXQoJnNpemVzLCAwLCBzaXplb2Yoc3RydWN0IGRy
bV9mYl9oZWxwZXJfc3VyZmFjZV9zaXplKSk7CiAJc2l6ZXMuc3VyZmFjZV9kZXB0aCA9IDI0OwpA
QCAtMTgwNCw3ICsxODA1LDEwIEBAIHN0YXRpYyBpbnQgZHJtX2ZiX2hlbHBlcl9zaW5nbGVfZmJf
cHJvYmUoc3RydWN0IGRybV9mYl9oZWxwZXIgKmZiX2hlbHBlciwKIAlzaXplcy5mYl93aWR0aCA9
ICh1MzIpLTE7CiAJc2l6ZXMuZmJfaGVpZ2h0ID0gKHUzMiktMTsKIAotCS8qIGlmIGRyaXZlciBw
aWNrcyA4IG9yIDE2IGJ5IGRlZmF1bHQgdXNlIHRoYXQgZm9yIGJvdGggZGVwdGgvYnBwICovCisJ
LyoKKwkgKiBJZiBkcml2ZXIgcGlja3MgOCBvciAxNiBieSBkZWZhdWx0IHVzZSB0aGF0IGZvciBi
b3RoIGRlcHRoL2JwcAorCSAqIHRvIGJlZ2luIHdpdGgKKwkgKi8KIAlpZiAocHJlZmVycmVkX2Jw
cCAhPSBzaXplcy5zdXJmYWNlX2JwcCkKIAkJc2l6ZXMuc3VyZmFjZV9kZXB0aCA9IHNpemVzLnN1
cmZhY2VfYnBwID0gcHJlZmVycmVkX2JwcDsKIApAQCAtMTgzOSw2ICsxODQzLDQ3IEBAIHN0YXRp
YyBpbnQgZHJtX2ZiX2hlbHBlcl9zaW5nbGVfZmJfcHJvYmUoc3RydWN0IGRybV9mYl9oZWxwZXIg
KmZiX2hlbHBlciwKIAkJfQogCX0KIAorCS8qCisJICogSWYgd2UgcnVuIGludG8gYSBzaXR1YXRp
b24gd2hlcmUsIGZvciBleGFtcGxlLCB0aGUgcHJpbWFyeSBwbGFuZQorCSAqIHN1cHBvcnRzIFJH
QkE1NTUxICgxNiBicHAsIGRlcHRoIDE1KSBidXQgbm90IFJHQjU2NSAoMTYgYnBwLCBkZXB0aAor
CSAqIDE2KSB3ZSBuZWVkIHRvIHNjYWxlIGRvd24gdGhlIGRlcHRoIG9mIHRoZSBzaXplcyB3ZSBy
ZXF1ZXN0LgorCSAqLworCWZvciAoaSA9IDA7IGkgPCBmYl9oZWxwZXItPmNydGNfY291bnQ7IGkr
KykgeworCQlzdHJ1Y3QgZHJtX21vZGVfc2V0ICptb2RlX3NldCA9ICZmYl9oZWxwZXItPmNydGNf
aW5mb1tpXS5tb2RlX3NldDsKKwkJc3RydWN0IGRybV9jcnRjICpjcnRjID0gbW9kZV9zZXQtPmNy
dGM7CisJCXN0cnVjdCBkcm1fcGxhbmUgKnBsYW5lID0gY3J0Yy0+cHJpbWFyeTsKKwkJaW50IGo7
CisKKwkJRFJNX0RFQlVHKCJ0ZXN0IENSVEMgJWQgcHJpbWFyeSBwbGFuZVxuIiwgaSk7CisKKwkJ
Zm9yIChqID0gMDsgaiA8IHBsYW5lLT5mb3JtYXRfY291bnQ7IGorKykgeworCQkJY29uc3Qgc3Ry
dWN0IGRybV9mb3JtYXRfaW5mbyAqZm10OworCisJCQlmbXQgPSBkcm1fZm9ybWF0X2luZm8ocGxh
bmUtPmZvcm1hdF90eXBlc1tqXSk7CisKKwkJCS8qIERvIG5vdCBjb25zaWRlciBZVVYgZm9ybWF0
cyBmb3IgZnJhbWVidWZmZXJzICovCisJCQlpZiAoZm10LT5pc195dXYpCisJCQkJY29udGludWU7
CisKKwkJCS8qIFdlIGZvdW5kIGEgcGVyZmVjdCBmaXQsIGdyZWF0ICovCisJCQlpZiAoZm10LT5k
ZXB0aCA9PSBzaXplcy5zdXJmYWNlX2RlcHRoKQorCQkJCWJyZWFrOworCisJCQkvKiBTa2lwIGRl
cHRocyBhYm92ZSB3aGF0IHdlJ3JlIGxvb2tpbmcgZm9yICovCisJCQlpZiAoZm10LT5kZXB0aCA+
IHNpemVzLnN1cmZhY2VfZGVwdGgpCisJCQkJY29udGludWU7CisKKwkJCS8qIEJlc3QgZGVwdGgg
Zm91bmQgc28gZmFyICovCisJCQlpZiAoZm10LT5kZXB0aCA+IGJlc3RfZGVwdGgpCisJCQkJYmVz
dF9kZXB0aCA9IGZtdC0+ZGVwdGg7CisJCX0KKwl9CisJaWYgKHNpemVzLnN1cmZhY2VfZGVwdGgg
IT0gYmVzdF9kZXB0aCkgeworCQlEUk1fSU5GTygicmVxdWVzdGVkIGJwcCAlZCwgc2NhbGVkIGRl
cHRoIGRvd24gdG8gJWQiLAorCQkJICBzaXplcy5zdXJmYWNlX2JwcCwgYmVzdF9kZXB0aCk7CisJ
CXNpemVzLnN1cmZhY2VfZGVwdGggPSBiZXN0X2RlcHRoOworCX0KKwogCWNydGNfY291bnQgPSAw
OwogCWZvciAoaSA9IDA7IGkgPCBmYl9oZWxwZXItPmNydGNfY291bnQ7IGkrKykgewogCQlzdHJ1
Y3QgZHJtX2Rpc3BsYXlfbW9kZSAqZGVzaXJlZF9tb2RlOwotLSAKMi4xOS4yCgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBt
YWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
