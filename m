Return-Path: <SRS0=jr7z=PG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77239C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 00:09:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44E4820811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 00:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e/uhUQxN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="TNPpcAis"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44E4820811
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nnaiwQpFY6QsILSpYomAoRKxLd8BhrBKLobIbs9WAWc=; b=e/uhUQxN5jA8eA
	ADOI8tSq+Yvjq1ZryEFKgKcFvVoH7b92bFTC6sr/jGh3y9/Duy9XixqWdP2BNGrW5sSU/ldbOupd5
	k5efsz3AQOjDVGXT42BvsgbA442XcYJxU9LaDY7GLQWOIdano63Q6hnyeEuSlW+eM2cGTJeQCvQnI
	2hiaGpdgB4/RLA6Ng39cfcVylS2gKX6diR42oAgn4lm/+aOfPpWzprfDnz8u6iiwNAXIKayMzbnph
	dKem/HJkHKD+XvW/7ZvMPaPJtSKe8i8Kj+Qs/wdilEVImatGbq2032eA4BTc+JNefYix7awsnRjgS
	nbDD7OkgTBSBtYKTbGYw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gd2By-0003tY-Uy; Sat, 29 Dec 2018 00:09:26 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gd2Bc-0003dG-2i; Sat, 29 Dec 2018 00:09:05 +0000
Received: by mail-wm1-x344.google.com with SMTP id f81so20741219wmd.4;
 Fri, 28 Dec 2018 16:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eLt89RDPW1/c/GL7HWxtODqUof3fnCO1oT2ipHADAIw=;
 b=TNPpcAisljoaF4F3qlugllEk2WvgV5OGXGEeycxb1P+mrPVE3+AJAP/z7vm6obsfHQ
 ygMmvTnvuvfI8xKfBKZ0CLO09YDcUgjljxeaTULd1pJD3t0LdwGRs6v4Onp3Mh73qxe2
 4B48YwAF8YJK76QA3Dn6uyC2mrA4OFwf164r0rOApHPVZ8vE2nrnDe9olLEoPbp99Dbd
 vFLK2u90zLxCzmnIMGDPWbhThgPVpypVjOMoZMmA17nG6AwqCw21M3+dkdYOFwRqscOW
 Ie1eIDicANMVpM616WxCMM/O/x3XkeFhTqUfUSNhYtWowITtFoeFP8Hbnpb6y6oBRF8x
 Szvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eLt89RDPW1/c/GL7HWxtODqUof3fnCO1oT2ipHADAIw=;
 b=ICf7xPu2DWMwQ2qaKPxpdGaOHjSCRY9n0Nn/NUucG/Su3lGMfZUbwZA0rn7PrhAQHo
 3jvi9jreZNOHonXicHdYTHy8fxF9CqCSWsiwTLtj6KN48HWvjupkqGuiiQVFZ/UYrbOz
 hK4YCstx368c/fiPnFKqSkYrRyyiscOTI2OxRUPN7kyMfDQr+VEhlygZPi3wA4fcY5/T
 1VNwBndH6HOvB/NDrxCBbiEF6/bEkapzsfyB0QOLhKtH7WG4l4SVw0vWV4Ra1Z0K/dYt
 85Qg0tjjYXAIHA4KOEAY5q93gSgvXZNUBQOgIjq+67LsdqrizQB6EXR2ioPDiGiJjQ3I
 aowQ==
X-Gm-Message-State: AJcUukeuyB8fgcJ3Pgpgk9fWWjT4vaJ2zczZbq5wAIPGzRKolgseWTTg
 PDrJBl085ZLfVPEuFqCQ2so=
X-Google-Smtp-Source: AFSGD/WoLV9HCr3IygGKTJ8+o90JhSkAZyf8/dnlIUXNTLDTooEGBHAFcLjjO2CP34qaw+aLlJUIwQ==
X-Received: by 2002:a1c:1741:: with SMTP id 62mr24307397wmx.25.1546042132222; 
 Fri, 28 Dec 2018 16:08:52 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD7294600658C35E37AF585B6.dip0.t-ipconnect.de.
 [2003:dc:d729:4600:658c:35e3:7af5:85b6])
 by smtp.googlemail.com with ESMTPSA id f18sm24420570wrs.92.2018.12.28.16.08.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 28 Dec 2018 16:08:51 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: jianxin.pan@amlogic.com, linux-amlogic@lists.infradead.org,
 khilman@baylibre.com, ingrassia@epigenesys.com
Subject: [PATCH v2 1/1] ARM: dts: meson8b: drop eth_txd0_1 and eth_txd1_1 from
 eth_rgmii_pins
Date: Sat, 29 Dec 2018 01:08:29 +0100
Message-Id: <20181229000829.16571-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181229000829.16571-1-martin.blumenstingl@googlemail.com>
References: <20181229000829.16571-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_160904_116817_A58865E9 
X-CRM114-Status: GOOD (  13.38  )
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
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linus.luessing@c0d3.blue, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QWNjb3JkaW5nIHRvIHRoZSBPZHJvaWQtQzErIHNjaGVtYXRpY3MgdGhlIEV0aGVybmV0IFRYRDEg
c2lnbmFsIGlzCnJvdXRlZCB0byBHUElPSF81IGFuZCB0aGUgVFhEMCBzaWduYWwgaXMgcm91dGVk
IHRvIEdQSU9IXzYuCgpUaGUgcHVibGljIFM4MDUgZGF0YXNoZWV0IHNob3dzIHRoYXQgVFhEMCBj
YW4gYmUgcm91dGVkIHRvIERJRl8yX1AgYW5kClRYRDEgY2FuIGJlIHJvdXRlZCB0byBESUZfMl9O
IGluc3RlYWQuIEdQSU8gbXV4IHJlZ2lzdGVyIDYgYml0IDQKY29uZmlndXJlcyBESUZfMl9QIGFz
IEVUSF9UWEQwLCByZWdpc3RlciA2IGJpdCA1IGNvbmZpZ3VyZXMgRElGXzJfTiBhcwpFVEhfVFhE
MS4KR1BJTyBtdXggcmVnaXN0ZXIgNyBiaXQgMjEgY29uZmlndXJlcyBHUElPSF81IGFzIEVUSF9U
WEQxLCByZWdpc3RlciA3CmJpdCAyMCBjb25maWd1cmVzIEdQSU9IXzYgYXMgRVRIX1RYRDAuCgpU
aGUgcGluIGdyb3VwcyBldGhfdHhkMF8wIChHUElPSF82KSBhbmQgZXRoX3R4ZDBfMSAoRElGXzJf
UCkgYXJlIGJvdGgKY29uZmlndXJlZCBhcyBFdGhlcm5ldCBUWEQwIGRhdGEgbGluZSBpbiBtZXNv
bjhiLmR0c2kuIEFsc28gZXRoX3R4ZDFfMAooR1BJT0hfNSkgYW5kIGV0aF90eGQxXzEgKERJRl8y
X04pIGFyZSBjb25maWd1cmVkIGFzIFRYRDEgZGF0YSBsaW5lLgoKVGhlIHZlbmRvciB1LWJvb3Qg
c291cmNlcyBmb3IgT2Ryb2lkLUMxIHVzZSB0aGUgZm9sbG93aW5nIEV0aGVybmV0CnBpbm11eCBj
b25maWd1cmF0aW9uOgogIFNFVF9DQlVTX1JFR19NQVNLKFBFUklQSFNfUElOX01VWF82LCAweDNm
NGYpOwogIFNFVF9DQlVTX1JFR19NQVNLKFBFUklQSFNfUElOX01VWF83LCAweGYwMDAwMCk7ClRo
aXMgdHJhbnNsYXRlcyB0byB0aGUgZm9sbG93aW5nIHBpbiBncm91cHMgaW4gdGhlIG1haW5saW5l
IGtlcm5lbDoKLSByZWdpc3RlciA2IGJpdCAgMDogZXRoX3J4ZDEgKERJRl8wX1ApCi0gcmVnaXN0
ZXIgNiBiaXQgIDE6IGV0aF9yeGQwIChESUZfMF9OKQotIHJlZ2lzdGVyIDYgYml0ICAyOiBldGhf
cnhfZHYgKERJRl8xX1ApCi0gcmVnaXN0ZXIgNiBiaXQgIDM6IGV0aF9yeF9jbGsgKERJRl8xX04p
Ci0gcmVnaXN0ZXIgNiBiaXQgIDY6IGV0aF90eF9lbiAoRElGXzNfUCkKLSByZWdpc3RlciA2IGJp
dCAgODogZXRoX3JlZl9jbGsgKERJRl8zX04pCi0gcmVnaXN0ZXIgNiBiaXQgIDk6IGV0aF9tZGMg
KERJRl80X1ApCi0gcmVnaXN0ZXIgNiBiaXQgMTA6IGV0aF9tZGlvX2VuIChESUZfNF9OKQotIHJl
Z2lzdGVyIDYgYml0IDExOiBldGhfdHhfY2xrIChHUElPSF85KQotIHJlZ2lzdGVyIDYgYml0IDEy
OiBldGhfdHhkMiAoR1BJT0hfOCkKLSByZWdpc3RlciA2IGJpdCAxMzogZXRoX3R4ZDMgKEdQSU9I
XzcpCi0gcmVnaXN0ZXIgNyBiaXQgMjA6IGV0aF90eGQwXzAgKEdQSU9IXzYpCi0gcmVnaXN0ZXIg
NyBiaXQgMjE6IGV0aF90eGQxXzAgKEdQSU9IXzUpCi0gcmVnaXN0ZXIgNyBiaXQgMjI6IGN1cnJl
bnRseSB1bmtub3duLCBtaWdodCBiZSBldGhfcnhkMiBvciBldGhfcnhkMwotIHJlZ2lzdGVyIDcg
Yml0IDIzOiBjdXJyZW50bHkgdW5rbm93biwgbWlnaHQgYmUgZXRoX3J4ZDIgb3IgZXRoX3J4ZDMK
CkRyb3BwaW5nIGV0aF90eGQwXzEgYW5kIGV0aF90eGQxXzEgaW1wcm92ZXMgdGhlIHJlY2VpdmUg
cGVyZm9ybWFuY2UuClRoaXMgaXMgcHJvYmFibHkgZHVlIHRvIHRoZSBldGhfdHhkMCBhbmQgZXRo
X3R4ZDEgc2lnbmFsIGJlaW5nIHJvdXRlZCB0bwp0aGUgd3JvbmcgcGlucywgc28gZGF0YSBjYW4g
b25seSBiZSB0cmFuc2ZlcnJlZCBvbiBldGhfdHhkMiBhbmQKZXRoX3R4ZDMuIEhvd2V2ZXIsIEkg
aGF2ZSBubyBzY29wZSB0byBjb25maXJtIHRoaXMgYXNzdW1wdGlvbi4KCmlwZXJmMyBzdGF0aXN0
aWNzIGJlZm9yZSB0aGlzIGNoYW5nZToKLSB0cmFuc21pdHRpbmcgZnJvbSBPZHJvaWQtQzE6IDc0
MSBNYml0cy9zZWMgKDAgcmV0cmllcykKLSByZWNlaXZpbmcgb24gT2Ryb2lkLUMxOiAxOTkgTWJp
dHMvc2VjICgxNzEzIHJldHJpZXMpCgppcGVyZjMgc3RhdGlzdGljcyBhZnRlciB0aGlzIGNoYW5n
ZToKLSB0cmFuc21pdHRpbmcgZnJvbSBPZHJvaWQtQzE6IDY2NyBNYml0cy9zZWMgKDAgcmV0cmll
cykKLSByZWNlaXZpbmcgb24gT2Ryb2lkLUMxOiA3NTAgTWJpdHMvc2VjICgwIHJldHJpZXMpCgpG
aXhlczogYjk2NDQ2NTQxZDgzOTAgKCJBUk06IGR0czogbWVzb244YjogZXh0ZW5kIGV0aGVybmV0
IGNvbnRyb2xsZXIgZGVzY3JpcHRpb24iKQpTaWduZWQtb2ZmLWJ5OiBNYXJ0aW4gQmx1bWVuc3Rp
bmdsIDxtYXJ0aW4uYmx1bWVuc3RpbmdsQGdvb2dsZW1haWwuY29tPgpDYzogRW1pbGlhbm8gSW5n
cmFzc2lhIDxpbmdyYXNzaWFAZXBpZ2VuZXN5cy5jb20+CkNjOiBMaW51cyBMw7xzc2luZyA8bGlu
dXMubHVlc3NpbmdAYzBkMy5ibHVlPgotLS0KIGFyY2gvYXJtL2Jvb3QvZHRzL21lc29uOGIuZHRz
aSB8IDIgLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2Fy
Y2gvYXJtL2Jvb3QvZHRzL21lc29uOGIuZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL21lc29uOGIu
ZHRzaQppbmRleCAyMmQ3NzU0NjA3NjcuLmVjY2EzNmE4Njc4ZCAxMDA2NDQKLS0tIGEvYXJjaC9h
cm0vYm9vdC9kdHMvbWVzb244Yi5kdHNpCisrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL21lc29uOGIu
ZHRzaQpAQCAtMjcwLDkgKzI3MCw3IEBACiAJCQkJZ3JvdXBzID0gImV0aF90eF9jbGsiLAogCQkJ
CQkgImV0aF90eF9lbiIsCiAJCQkJCSAiZXRoX3R4ZDFfMCIsCi0JCQkJCSAiZXRoX3R4ZDFfMSIs
CiAJCQkJCSAiZXRoX3R4ZDBfMCIsCi0JCQkJCSAiZXRoX3R4ZDBfMSIsCiAJCQkJCSAiZXRoX3J4
X2NsayIsCiAJCQkJCSAiZXRoX3J4X2R2IiwKIAkJCQkJICJldGhfcnhkMSIsCi0tIAoyLjIwLjEK
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1h
cm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0t
a2VybmVsCg==
