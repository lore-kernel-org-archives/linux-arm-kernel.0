Return-Path: <SRS0=lfWu=P4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24E8C282DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 22:36:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AB5D2087B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 22:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jIzDvWdD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSaz4g+G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AB5D2087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=gS2kkvlqwa5FCOkfWN3MUoygocSsOEjLJpCXfsQu75I=; b=jIzDvWdDEfdgRx
	LLG+80zUf9zZfvwG1aDeYtN9GPyhE2LhHW+R3LLGZtUzxO4UiunIQ0ghOpx5GN2brYyyHUyBzRhFG
	tN3p7aF2u1I6t3Dod+/X0y2+Siz/YLRZqbxrCNZ1HF0nKd7ieDMV8QwMPtGCRjLggzoGioTbO1wSC
	FzZUkGSjATMaiDMxRMwP0zpaREd2rb0BkKkILncHJFNSE189LmiU417bLhQP606OaFgPsPZZ1/k3e
	CijIjswBd5C+s1MeZhFLA+Pm9xREKllQShytqfDZNX6M82ASo+fbaT+BDPoaj/+8oQtGtmW/fZTE7
	Rzya0JIGTsON63wZfkaw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glLhQ-0006Ks-4q; Sun, 20 Jan 2019 22:36:16 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glLhK-0006IQ-0c
 for linux-arm-kernel@lists.infradead.org; Sun, 20 Jan 2019 22:36:14 +0000
Received: by mail-lj1-x244.google.com with SMTP id k15-v6so15912008ljc.8
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 20 Jan 2019 14:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2PNfJqZnuqYyuSsQxJa8/apCAvbAqst6HFn4GQprEEc=;
 b=kSaz4g+GOWD3WOIelL/FnLaFF80fkv0Wlzu4QPk0aromyLFYcNzhQAYQBLa7iRWqvf
 UBIW/gJCPwcoRpFEYXvfb9lm+8qq7HD7f7rbSN+F66GEBpp+YxefMLjDQjhOqK4BksaG
 0VuYGKdEkcYh3y9Yj5XWsjJGHXQig9MR5BYtWMkpXxeGJ4P7Cw+IKE62+txSye+ov8iJ
 OmH7j/++Hk85huuUiVXaltwngV4Zeg1KrvoMJYln8eI9YPNItg8MZ0m0BXnJ9UPePOc+
 vW9iTGTe8KCOapeoFfdEp7d+fP962S6WtPjF3DxH3Xhvf02uQbKJFGpp/2J0eXw4dUBp
 eqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2PNfJqZnuqYyuSsQxJa8/apCAvbAqst6HFn4GQprEEc=;
 b=RHeaDhCTNflu5NHfMOU+/F1cSWgc5TlmYleq/AVYPHuqo3zXzI2zBZcdsCdyslDZ0w
 t+VMH8Z71TddpGBK0rakklWUr68WncOBLDa8YeDyD0+Nb4XYniGDQrGHguwsau0QTteS
 H10o3S0QzP8yOnOpwMeuUdEMV9iQUgTQdWtfIorAh5aH7Tzb1FkkIYVpHktOZesq/HbU
 deQsmtC+7PE+kJogpxYBflFcz/RVxzIdSRmoMi41WQTJk7vZ52vka+tqhwXT0tnxULA8
 AbBI9yGwtmNBwNd+ng5mcCFHGM7QryrQQAatyqyuygklDvlMjdcH8BkzPprsu4/MbNDA
 RueQ==
X-Gm-Message-State: AJcUukfLIAI9qFKDIj1Vdz5i757skxG7IjAW/zL+qv9N3tk+Q9eOh9Yj
 cTKvssqvbB+YV77XkOGzabs=
X-Google-Smtp-Source: ALg8bN7BQyNfAptH/3nqk6efc3EbBaM9L/w+fcUZA6dAwocFPF9d8/srsoprvTjAZrVM1ke0Vay7YA==
X-Received: by 2002:a2e:5303:: with SMTP id
 h3-v6mr17481259ljb.35.1548023767365; 
 Sun, 20 Jan 2019 14:36:07 -0800 (PST)
Received: from elitebook.lan (ip-194-187-74-233.konfederacka.maverick.com.pl.
 [194.187.74.233])
 by smtp.gmail.com with ESMTPSA id h203sm1972555lfe.44.2019.01.20.14.36.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 20 Jan 2019 14:36:06 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH] ARM: dts: BCM5301X: Add basic DT for Phicomm K3
Date: Sun, 20 Jan 2019 23:33:27 +0100
Message-Id: <20190120223327.14999-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190120_143610_084446_3109892D 
X-CRM114-Status: GOOD (  14.78  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Hao Dong <halbertdong@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>,
 Rob Herring <robh+dt@kernel.org>, bcm-kernel-feedback-list@broadcom.com,
 =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
 Hamster Tian <haotia@gmail.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

RnJvbTogSGFvIERvbmcgPGhhbGJlcnRkb25nQGdtYWlsLmNvbT4KClRoaXMgcm91dGVyIGhhcyBC
Q000NzA5QzAgU29DLCAxMjggTWlCIE5BTkQgZmxhc2ggKE1YMzBMRjFHMThBQy1USSksCjUxMiBN
aUIgbWVtb3J5IGFuZCAzIHggTEFOIGFuZCAxIHggV0FOIHBvcnRzLiBXaUZpIGNoaXBzIGFyZQpC
Q000MzY2QzAgeCAyLiBUaGUgcm91dGVyIGhhcyBhIHNtYWxsIExDRCBhbmQgMyBjYXBhY3RpdmUg
a2V5cyBkcml2ZW4gYnkKYSBQSUMgbWljcm9jb250cm9sbGVyLCB3aGljaCBpcyBpbiB0dXJuIHdp
cmVkIHRvIFVBUlQxIG9mIG1haW4gYm9hcmQuCgpTaWduZWQtb2ZmLWJ5OiBIYW8gRG9uZyA8aGFs
YmVydGRvbmdAZ21haWwuY29tPgpbcm1pbGVja2k6IGRyb3AgY2hvc2VuIHsgfSwgZml4IHdoaXRl
c3BhY2VzLCB1cGRhdGUgY29tbWl0IG1lc3NhZ2VdClNpZ25lZC1vZmYtYnk6IFJhZmHFgiBNacWC
ZWNraSA8cmFmYWxAbWlsZWNraS5wbD4KLS0tCkkndmUgdGFrZW4gT3BlbldydCBzdWJtaXR0ZWQg
RFRTIGFuZCB1cGRhdGVkIGl0IHRvIGZpdCB1cHN0cmVhbQpzdGFuZGFyZHM6CjEpIERyb3BwZWQg
Y2hvc2VuIHsgfSB3aXRoIGR1cGxpY2F0ZWQgY29uc29sZSBpbmZvCjIpIEZpeGVkIHdoaXRlc3Bh
Y2VzCjMpIERyb3BwZWQgT3BlbldydCBzcGVjaWZpYyBpbmZvIGZyb20gdGhlIGNvbW1pdCBtZXNz
YWdlOgogICAqIExDRCBzb2Z0d2FyZSBwYWNrYWdlCiAgICogb3BlbndydC5vcmcgJiA0MzY2YzAg
ZmlybXdhcmUKLS0tCiBhcmNoL2FybS9ib290L2R0cy9NYWtlZmlsZSAgICAgICAgICAgICAgICB8
ICAxICsKIGFyY2gvYXJtL2Jvb3QvZHRzL2JjbTQ3MDk0LXBoaWNvbW0tazMuZHRzIHwgNzEgKysr
KysrKysrKysrKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgNzIgaW5zZXJ0aW9ucygrKQog
Y3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtL2Jvb3QvZHRzL2JjbTQ3MDk0LXBoaWNvbW0tazMu
ZHRzCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvTWFrZWZpbGUgYi9hcmNoL2FybS9i
b290L2R0cy9NYWtlZmlsZQppbmRleCBiZDQwMTQ4YTE1YjIuLmJiYzBmNDUyN2MzOSAxMDA2NDQK
LS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvTWFrZWZpbGUKKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMv
TWFrZWZpbGUKQEAgLTExNSw2ICsxMTUsNyBAQCBkdGItJChDT05GSUdfQVJDSF9CQ01fNTMwMVgp
ICs9IFwKIAliY200NzA5NC1sdXh1bC14d3ItMzEwMC5kdGIgXAogCWJjbTQ3MDk0LWx1eHVsLXh3
ci0zMTUwLXYxLmR0YiBcCiAJYmNtNDcwOTQtbmV0Z2Vhci1yODUwMC5kdGIgXAorCWJjbTQ3MDk0
LXBoaWNvbW0tazMuZHRiIFwKIAliY205NDcwOC5kdGIgXAogCWJjbTk0NzA5LmR0YiBcCiAJYmNt
OTUzMDEyZXIuZHRiIFwKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2JjbTQ3MDk0LXBo
aWNvbW0tazMuZHRzIGIvYXJjaC9hcm0vYm9vdC9kdHMvYmNtNDcwOTQtcGhpY29tbS1rMy5kdHMK
bmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwMDAwLi5lYzA5YzA0MjZkMTYKLS0t
IC9kZXYvbnVsbAorKysgYi9hcmNoL2FybS9ib290L2R0cy9iY200NzA5NC1waGljb21tLWszLmR0
cwpAQCAtMCwwICsxLDcxIEBACisvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1v
ci1sYXRlciBPUiBNSVQKKy8qCisgKiBDb3B5cmlnaHQgKEMpIDIwMTcgSGFtc3RlciBUaWFuIDxo
YW90aWFAZ21haWwuY29tPgorICogQ29weXJpZ2h0IChDKSAyMDE5IEhhbyBEb25nIDxoYWxiZXJ0
ZG9uZ0BnbWFpbC5jb20+CisgKi8KKworL2R0cy12MS87CisKKyNpbmNsdWRlICJiY200NzA5NC5k
dHNpIgorI2luY2x1ZGUgImJjbTUzMDF4LW5hbmQtY3MwLWJjaDQuZHRzaSIKKworLyB7CisJY29t
cGF0aWJsZSA9ICJwaGljb21tLGszIiwgImJyY20sYmNtNDcwOTQiLCAiYnJjbSxiY200NzA4IjsK
Kwltb2RlbCA9ICJQaGljb21tIEszIjsKKworCW1lbW9yeSB7CisJCXJlZyA9IDwweDAwMDAwMDAw
IDB4MDgwMDAwMDAKKwkJICAgICAgIDB4ODgwMDAwMDAgMHgxODAwMDAwMD47CisJfTsKKworCWdw
aW8ta2V5cyB7CisJCWNvbXBhdGlibGUgPSAiZ3Bpby1rZXlzIjsKKwkJI2FkZHJlc3MtY2VsbHMg
PSA8MT47CisJCSNzaXplLWNlbGxzID0gPDA+OworCisJCXJlc3RhcnQgeworCQkJbGFiZWwgPSAi
UmVzZXQiOworCQkJbGludXgsY29kZSA9IDxLRVlfUkVTVEFSVD47CisJCQlncGlvcyA9IDwmY2hp
cGNvbW1vbiAxNyBHUElPX0FDVElWRV9MT1c+OworCQl9OworCX07Cit9OworCismdWFydDEgewor
CXN0YXR1cyA9ICJva2F5IjsKK307CisKKyZ1c2IzX3BoeSB7CisJc3RhdHVzID0gIm9rYXkiOwor
fTsKKworJm5hbmRjcyB7CisJcGFydGl0aW9ucyB7CisJCWNvbXBhdGlibGUgPSAiZml4ZWQtcGFy
dGl0aW9ucyI7CisJCSNhZGRyZXNzLWNlbGxzID0gPDE+OworCQkjc2l6ZS1jZWxscyA9IDwxPjsK
KworCQlwYXJ0aXRpb25AMCB7CisJCQlsYWJlbCA9ICJib290IjsKKwkJCXJlZyA9IDwweDAwMDAw
MDAgMHgwMDgwMDAwPjsKKwkJCXJlYWQtb25seTsKKwkJfTsKKworCQlwYXJ0aXRpb25AODAwMDAg
eworCQkJbGFiZWwgPSAibnZyYW0iOworCQkJcmVnID0gPDB4MDA4MDAwMCAweDAxMDAwMDA+Owor
CQl9OworCisJCXBhcnRpdGlvbkAxODAwMDB7CisJCQlsYWJlbCA9ICJwaGljb21tIjsKKwkJCXJl
ZyA9IDwweDAxODAwMDAgMHgwMjgwMDAwPjsKKwkJCXJlYWQtb25seTsKKwkJfTsKKworCQlwYXJ0
aXRpb25ANDAwMDAwIHsKKwkJCWxhYmVsID0gImZpcm13YXJlIjsKKwkJCXJlZyA9IDwweDA0MDAw
MDAgMHg3QzAwMDAwPjsKKwkJCWNvbXBhdGlibGUgPSAiYnJjbSx0cngiOworCQl9OworCX07Cit9
OwotLSAKMi4yMC4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtYXJtLWtlcm5lbAo=
