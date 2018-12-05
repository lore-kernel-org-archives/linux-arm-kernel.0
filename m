Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1CDC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 13:03:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46A602054F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 13:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Agw9VWEZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmIVDgvP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46A602054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=JOU/0CZNS4yFzY8z+qozseKAtdJKWRh+Z3xpoHA1ymQ=; b=Agw9VWEZAiqqel
	mnhx0MJsf1EiDIbGkUT4X9e8VxYkgRGo78Pxzv/Yc4gNQYd9dAlub4xVvMx/Lr4zaKq432n/o1u/L
	xynxl1AGr8ydZihWuiXMnTmNAALpGXjOTEmd2O94qpkQxRFzdl6A8J6jYM9kqB3X8wr/z53tNbmwR
	Jcqegcro+sHcEdMpp9txmk9eIg5XovkiCyoHeJ1HhlQ0UZxd+sP1fustTSIkoD9yj74xhbcvnNRfO
	pBJsC+IwYnFN6BUk2bOqguQ9dGldkhdu3wQTRQRGZcWAssrW24ijDXNdrtfeXk1Rkl/OZXv1L+6fX
	GLScMiiwD03G3uZXYvfQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUWpl-0002oO-Ix; Wed, 05 Dec 2018 13:03:21 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUWpi-0002e2-8o; Wed, 05 Dec 2018 13:03:19 +0000
Received: by mail-lf1-x141.google.com with SMTP id a16so14665011lfg.3;
 Wed, 05 Dec 2018 05:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iUtbnnUbK/Q6AFvywUasR5BVnWy2hzFrr7nV15jhZEU=;
 b=nmIVDgvPMnpPfGE7qp0O6ygIVYhKcIucNKzd0UzdyFgxLWn2bLYV71MrT8j3aB6UaH
 RxP7o6ynqCPgVfuYWv7gya3+974QAFr613ACt03ULNoji3dicqxm3RjKXO+5znDwZemX
 0hMrLXGeZvsmAyxfdnC0Zw587K0ODD1Av4j3KFPhncTH9gODPuRTbO+bJBh3ETRFk6Gn
 6yN7XYRqhbSRXnqDzFr5ihDpO56nifsJNw1vNwrwdjO+hgo4ZuvjMzJC3jThOodbPCOr
 JA/r7RlTUydS+VZrtc86HdQ7frUe9mwM5XPsyZJfjDLqA8N+6qjPfA0bNBrDbThYaXZw
 pHvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iUtbnnUbK/Q6AFvywUasR5BVnWy2hzFrr7nV15jhZEU=;
 b=Y+cQzz3Jsle2VZue1YGEa1+i+Yc4r6X1YUqnu+c7TumoOBMnNUYsug8AamrO2VflSw
 YFstzg7wpVALLgCjN9lQKiD4bVbCzN6dnIq/JFFqfsU8ZDbQDs/0M+AvkVRGicfJ+hve
 jBAl+pOFj4GrNDV29tr55oZe1QMYLYwY3R6pNTRWnPabWhNfTE4YFXxUg2wxZOPnezG4
 jLiX7GKtuoZ5hDBJbe0hd6Fi7+Bw36hooLMariYzM7UkqmkmNwe2vjLZvbDts3ozU3SK
 f+YRoeauiDGgK0Nqgs/4joLZv9QO7V7JEqPUqzqF0In06Kh79A2z/Myyb8JSFpGoKwXc
 vSbg==
X-Gm-Message-State: AA+aEWaKONWYd+RLHCkTQToqnTm8hWYUH7oBu3ZQpWr44PBwHMuL68c+
 ooWJ8cEj1KfdyvpweFUTDwPpu6ol
X-Google-Smtp-Source: AFSGD/W+8D9l/IhbulHk0Tb8g73naE8nhGczi9k8gLcKChhncKeMyvrZmuj+QiOjWZdrc7Z7LqFlvQ==
X-Received: by 2002:a19:2395:: with SMTP id
 j143mr13833840lfj.107.1544014985064; 
 Wed, 05 Dec 2018 05:03:05 -0800 (PST)
Received: from xellan.internal.elektron.se ([80.252.208.56])
 by smtp.gmail.com with ESMTPSA id q4-v6sm3688062ljb.4.2018.12.05.05.03.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Dec 2018 05:03:04 -0800 (PST)
From: "=?UTF-8?q?Richard=20R=C3=B6jfors?=" <richard.rojfors@gmail.com>
X-Google-Original-From: =?UTF-8?q?Richard=20R=C3=B6jfors?=
 <richard@puffinpack.se>
To: linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH] drm/rockchip: dw-mipi-dsi: Support MIPI_DSI_DCS_READ
Date: Wed,  5 Dec 2018 14:02:43 +0100
Message-Id: <20181205130243.5810-1-richard@puffinpack.se>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_050318_332298_B2B8C38D 
X-CRM114-Status: GOOD (  12.32  )
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
Cc: Heiko Stuebner <heiko@sntech.de>,
 =?UTF-8?q?Richard=20R=C3=B6jfors?= <richard@puffinpack.se>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VGhlcmUgaXMgc29tZXRpbWVzIGEgbmVlZCB0byBiZSBhYmxlIHRvIHJlYWQgZnJvbSB0aGUgb3Ro
ZXIKZW5kIGZvciBpbnN0YW5jZSB0byBpZGVudGlmeSBwYW5lbHMuCgpTaWduZWQtb2ZmLWJ5OiBS
aWNoYXJkIFLDtmpmb3JzIDxyaWNoYXJkQHB1ZmZpbnBhY2suc2U+Ci0tLQogZHJpdmVycy9ncHUv
ZHJtL3JvY2tjaGlwL2R3LW1pcGktZHNpLmMgfCA1MCArKysrKysrKysrKysrKysrKysrKysrKysr
KwogMSBmaWxlIGNoYW5nZWQsIDUwIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vcm9ja2NoaXAvZHctbWlwaS1kc2kuYyBiL2RyaXZlcnMvZ3B1L2RybS9yb2NrY2hp
cC9kdy1taXBpLWRzaS5jCmluZGV4IDY2MmI2Y2I1ZDNmMC4uODg0MDM5NTRmM2M0IDEwMDY0NAot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vcm9ja2NoaXAvZHctbWlwaS1kc2kuYworKysgYi9kcml2ZXJz
L2dwdS9kcm0vcm9ja2NoaXAvZHctbWlwaS1kc2kuYwpAQCAtNzE5LDYgKzcxOSw1MyBAQCBzdGF0
aWMgaW50IGR3X21pcGlfZHNpX2Rjc19sb25nX3dyaXRlKHN0cnVjdCBkd19taXBpX2RzaSAqZHNp
LAogCXJldHVybiBkd19taXBpX2RzaV9nZW5fcGt0X2hkcl93cml0ZShkc2ksIGhkcl92YWwpOwog
fQogCitzdGF0aWMgaW50IGR3X21pcGlfZHNpX2Rjc19yZWFkKHN0cnVjdCBkd19taXBpX2RzaSAq
ZHNpLAorCQkJCWNvbnN0IHN0cnVjdCBtaXBpX2RzaV9tc2cgKm1zZykKK3sKKwlpbnQgcmV0Owor
CWludCBieXRlc19yZWFkID0gMDsKKwl1MzIgc3RhdHVzOworCisJcmV0ID0gZHdfbWlwaV9kc2lf
ZGNzX3Nob3J0X3dyaXRlKGRzaSwgbXNnKTsKKwlpZiAocmV0IDwgMCkgeworCQlEUk1fREVWX0VS
Uk9SKGRzaS0+ZGV2LCAiZmFpbGVkIHRvIGlzc3VlIHJlYWQgY29tbWFuZFxuIik7CisJCXJldHVy
biByZXQ7CisJfQorCisJLyogTG9vcCBhbmQgZW1wdHkgdGhlIFJYIEZJRk8gKi8KKwlkbyB7CisJ
CXUzMiB2YWw7CisKKwkJLyogV2FpdCBmb3IgZGF0YSB0byByZWFjaCB0aGUgZmlmbyBvciBjb21t
YW5kIHRlcm1pbmF0aW9uICovCisJCXJldCA9IHJlYWRsX3BvbGxfdGltZW91dChkc2ktPmJhc2Ug
KyBEU0lfQ01EX1BLVF9TVEFUVVMsCisJCQkJCSB2YWwsICgodmFsICYgR0VOX1BMRF9SX0VNUFRZ
KSkgPT0gMCB8fAorCQkJCQkgICAgICAoKHZhbCAmIEdFTl9SRF9DTURfQlVTWSkgPT0gMCksCisJ
CQkJCSAxMDAwLCBDTURfUEtUX1NUQVRVU19USU1FT1VUX1VTKTsKKwkJaWYgKHJldCA8IDApIHsK
KwkJCURSTV9ERVZfRVJST1IoZHNpLT5kZXYsCisJCQkJICAgICAgImZhaWxlZCB0byByZWFkIHBh
eWxvYWQgZnJvbSBGSUZPXG4iKTsKKwkJCXJldHVybiByZXQ7CisJCX0KKworCQlzdGF0dXMgPSBk
c2lfcmVhZChkc2ksIERTSV9DTURfUEtUX1NUQVRVUyk7CisKKwkJaWYgKChzdGF0dXMgJiBHRU5f
UExEX1JfRU1QVFkpID09IDApIHsKKwkJCWludCBpOworCQkJdTggKnJ4X2J1ZiA9IG1zZy0+cnhf
YnVmOworCisJCQl2YWwgPSBkc2lfcmVhZChkc2ksIERTSV9HRU5fUExEX0RBVEEpOworCisJCQlm
b3IgKGkgPSAwOyBpIDwgc2l6ZW9mKHUzMikgJiYgYnl0ZXNfcmVhZCA8IG1zZy0+cnhfbGVuOwor
CQkJICAgICBpKyspIHsKKwkJCQlyeF9idWZbYnl0ZXNfcmVhZCsrXSA9IHZhbCAmIDB4ZmY7CisJ
CQkJdmFsID4+PSA4OworCQkJfQorCQl9CisJfSB3aGlsZSAoKHN0YXR1cyAmIEdFTl9QTERfUl9F
TVBUWSkgPT0gMCk7CisKKwlyZXR1cm4gYnl0ZXNfcmVhZDsKK30KKwogc3RhdGljIHNzaXplX3Qg
ZHdfbWlwaV9kc2lfaG9zdF90cmFuc2ZlcihzdHJ1Y3QgbWlwaV9kc2lfaG9zdCAqaG9zdCwKIAkJ
CQkJIGNvbnN0IHN0cnVjdCBtaXBpX2RzaV9tc2cgKm1zZykKIHsKQEAgLTczNiw2ICs3ODMsOSBA
QCBzdGF0aWMgc3NpemVfdCBkd19taXBpX2RzaV9ob3N0X3RyYW5zZmVyKHN0cnVjdCBtaXBpX2Rz
aV9ob3N0ICpob3N0LAogCWNhc2UgTUlQSV9EU0lfRENTX0xPTkdfV1JJVEU6CiAJCXJldCA9IGR3
X21pcGlfZHNpX2Rjc19sb25nX3dyaXRlKGRzaSwgbXNnKTsKIAkJYnJlYWs7CisJY2FzZSBNSVBJ
X0RTSV9EQ1NfUkVBRDoKKwkJcmV0ID0gZHdfbWlwaV9kc2lfZGNzX3JlYWQoZHNpLCBtc2cpOwor
CQlicmVhazsKIAlkZWZhdWx0OgogCQlEUk1fREVWX0VSUk9SKGRzaS0+ZGV2LCAidW5zdXBwb3J0
ZWQgbWVzc2FnZSB0eXBlIDB4JTAyeFxuIiwKIAkJCSAgICAgIG1zZy0+dHlwZSk7Ci0tIAoyLjE5
LjEKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51
eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1h
cm0ta2VybmVsCg==
