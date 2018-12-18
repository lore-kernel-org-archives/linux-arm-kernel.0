Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE9FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:07:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C6DC2133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jNBprjhz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WPg+M1fH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C6DC2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OH7gHtOaz1b8Lvb0uAR5cDm2RWN4Iu/BhQpA7CezRM8=; b=jNBprjhzsE6vMR
	lT6FP2RsZIxS8kKrJAEPRsxWFh7GioPiWiAjQV3vB689ZXq7/9epFC1bqnT/nE4Xq65wgi0qWI2Cd
	QjZkLTXhrVwJL7+0TPqThBNf5cRGRheHojfdKZu6OYP3Iyp+4ScJSrjBhcJnbASPblD9Hk/2SA3wS
	kxhEDroo1b/9eJYGox5pKu65oEI/dUEJU2fM6bbXVA8x8eT+Yg0qHsEDYRG+jPVFm/kuF4qnR1E9R
	P6VrguZbT16Hp0pW7OSGKKSV4eTLZq0KsybRahNHmMvG+uQzSSG0qtcktoTKE73YbXFTQn8zmYIXF
	BUf5uYmjLncaOuS48nkA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZAP5-0008Sf-7e; Tue, 18 Dec 2018 08:06:59 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZAOP-0007oo-65
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 08:06:34 +0000
Received: by mail-pl1-x642.google.com with SMTP id u18so7456577plq.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 00:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UfYvMyUASU0SktOneqY893l+ivwuHLJC4IjYGuuzrdU=;
 b=WPg+M1fHlkW3flIMrdiDhlhfZpjvGLb7X/Ub63au01MaDQdufdVMWB9oZvSdP9+hML
 3OL2FzqCGJQq4KTMOiS/hGusBjqVxBDfuaTdJ0pX6VyrD8jdFd3VNiCk/VMjcUqUv9F8
 EZXRcoNkFCF9QUysdAcDh6AHXV4pvod/3JqpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UfYvMyUASU0SktOneqY893l+ivwuHLJC4IjYGuuzrdU=;
 b=Osx0vma/RcD4zCxMlET2lqIzJXavl6ZA7TXlbDgi+yqM0aG8k7y3hw/Z0rJBeFR6ge
 liwjZ5TksAxpQq+G3xNuX6Zx9rmA0qZ1EK11ANTsk2M4M5lUq9AqH/BDfS7NIeWSinv7
 uSPzo0MRB4EtK9plvhxhmaRFo+HJak3agJHVKXXIIcv54GzN8l7x31RP4xxnBajJA1jn
 xQowfTQCAJz/Tj58Qh7rQf6NMSb+je3m7dmwyqzTULq+jPxN+CzeZ052Fq/5ofXAsyLi
 QjChp2XkcdAmrg490VORg3++auO7OUDSA1cQac3Ea5Ci2nVnO1eRittHAJmJ9HhdqnJA
 VZ8w==
X-Gm-Message-State: AA+aEWamsbJ39GxCZv9fLekrU40hq1JOf6uZX5piDUn6fyEvBi+pcXKT
 FCDSXuUzPlgGEcCa+7c+TVpH
X-Google-Smtp-Source: AFSGD/XvlZH7KkcB0shb83eb7e9NODL+0bPIiJR+Z9m8+H5jy/5wLXaQNzpZkAbLuLWEl7VpbYj1LQ==
X-Received: by 2002:a17:902:bd0a:: with SMTP id
 p10mr15074983pls.322.1545120366410; 
 Tue, 18 Dec 2018 00:06:06 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
 by smtp.gmail.com with ESMTPSA id 7sm45596888pfm.8.2018.12.18.00.05.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Dec 2018 00:06:05 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
 gregkh@linuxfoundation.org, jslaby@suse.com
Subject: [PATCH v6 03/11] ARM: Prepare RDA8810PL SoC
Date: Tue, 18 Dec 2018 13:35:19 +0530
Message-Id: <20181218080527.10801-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218080527.10801-1-manivannan.sadhasivam@linaro.org>
References: <20181218080527.10801-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_000617_914934_22C86FE5 
X-CRM114-Status: GOOD (  13.90  )
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
Cc: devicetree@vger.kernel.org, linus.walleij@linaro.org,
 linux-kernel@vger.kernel.org, amit.kucheria@linaro.org,
 linux-unisoc@lists.infradead.org, linux-serial@vger.kernel.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, afaerber@suse.de,
 linux-arm-kernel@lists.infradead.org, zhao_steven@263.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

RnJvbTogQW5kcmVhcyBGw6RyYmVyIDxhZmFlcmJlckBzdXNlLmRlPgoKSW50cm9kdWNlIEFSQ0hf
UkRBIGFuZCBtYWNoLXJkYSBmb3IgUkRBIE1pY3JvIFNvQ3MuCgpTaWduZWQtb2ZmLWJ5OiBBbmRy
ZWFzIEbDpHJiZXIgPGFmYWVyYmVyQHN1c2UuZGU+ClNpZ25lZC1vZmYtYnk6IE1hbml2YW5uYW4g
U2FkaGFzaXZhbSA8bWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFyby5vcmc+Ci0tLQogYXJjaC9h
cm0vS2NvbmZpZyAgICAgICAgICAgfCAyICsrCiBhcmNoL2FybS9NYWtlZmlsZSAgICAgICAgICB8
IDEgKwogYXJjaC9hcm0vbWFjaC1yZGEvS2NvbmZpZyAgfCA5ICsrKysrKysrKwogYXJjaC9hcm0v
bWFjaC1yZGEvTWFrZWZpbGUgfCAxICsKIDQgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygr
KQogY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtL21hY2gtcmRhL0tjb25maWcKIGNyZWF0ZSBt
b2RlIDEwMDY0NCBhcmNoL2FybS9tYWNoLXJkYS9NYWtlZmlsZQoKZGlmZiAtLWdpdCBhL2FyY2gv
YXJtL0tjb25maWcgYi9hcmNoL2FybS9LY29uZmlnCmluZGV4IDkxYmU3NGQ4ZGY2NS4uMDg0ZjA5
ODNlNmIyIDEwMDY0NAotLS0gYS9hcmNoL2FybS9LY29uZmlnCisrKyBiL2FyY2gvYXJtL0tjb25m
aWcKQEAgLTgwNCw2ICs4MDQsOCBAQCBzb3VyY2UgImFyY2gvYXJtL3BsYXQtcHhhL0tjb25maWci
CiAKIHNvdXJjZSAiYXJjaC9hcm0vbWFjaC1xY29tL0tjb25maWciCiAKK3NvdXJjZSAiYXJjaC9h
cm0vbWFjaC1yZGEvS2NvbmZpZyIKKwogc291cmNlICJhcmNoL2FybS9tYWNoLXJlYWx2aWV3L0tj
b25maWciCiAKIHNvdXJjZSAiYXJjaC9hcm0vbWFjaC1yb2NrY2hpcC9LY29uZmlnIgpkaWZmIC0t
Z2l0IGEvYXJjaC9hcm0vTWFrZWZpbGUgYi9hcmNoL2FybS9NYWtlZmlsZQppbmRleCAwNWE5MWQ4
Yjg5ZjMuLjEwMDU2Y2NkYjhiZSAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vTWFrZWZpbGUKKysrIGIv
YXJjaC9hcm0vTWFrZWZpbGUKQEAgLTIwMiw2ICsyMDIsNyBAQCBtYWNoaW5lLSQoQ09ORklHX0FS
Q0hfT1JJT041WCkJCSs9IG9yaW9uNXgKIG1hY2hpbmUtJChDT05GSUdfQVJDSF9QSUNPWENFTEwp
CSs9IHBpY294Y2VsbAogbWFjaGluZS0kKENPTkZJR19BUkNIX1BYQSkJCSs9IHB4YQogbWFjaGlu
ZS0kKENPTkZJR19BUkNIX1FDT00pCQkrPSBxY29tCittYWNoaW5lLSQoQ09ORklHX0FSQ0hfUkRB
KQkJKz0gcmRhCiBtYWNoaW5lLSQoQ09ORklHX0FSQ0hfUkVBTFZJRVcpCQkrPSByZWFsdmlldwog
bWFjaGluZS0kKENPTkZJR19BUkNIX1JPQ0tDSElQKQkJKz0gcm9ja2NoaXAKIG1hY2hpbmUtJChD
T05GSUdfQVJDSF9SUEMpCQkrPSBycGMKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtcmRhL0tj
b25maWcgYi9hcmNoL2FybS9tYWNoLXJkYS9LY29uZmlnCm5ldyBmaWxlIG1vZGUgMTAwNjQ0Cmlu
ZGV4IDAwMDAwMDAwMDAwMC4uMWVhNzUzZjU3YjJkCi0tLSAvZGV2L251bGwKKysrIGIvYXJjaC9h
cm0vbWFjaC1yZGEvS2NvbmZpZwpAQCAtMCwwICsxLDkgQEAKK21lbnVjb25maWcgQVJDSF9SREEK
Kwlib29sICJSREEgTWljcm8gU29DcyIKKwlkZXBlbmRzIG9uIEFSQ0hfTVVMVElfVjcKKwlzZWxl
Y3QgQ09NTU9OX0NMSworCXNlbGVjdCBHRU5FUklDX0lSUV9DSElQCisJc2VsZWN0IFJEQV9JTlRD
CisJc2VsZWN0IFJEQV9USU1FUgorCWhlbHAKKwkgIFRoaXMgZW5hYmxlcyBzdXBwb3J0IGZvciB0
aGUgUkRBIE1pY3JvIDg4MTBQTCBTb0MgZmFtaWx5LgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFj
aC1yZGEvTWFrZWZpbGUgYi9hcmNoL2FybS9tYWNoLXJkYS9NYWtlZmlsZQpuZXcgZmlsZSBtb2Rl
IDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMDAuLjZiZWEzZDNhMmRkNwotLS0gL2Rldi9udWxsCisr
KyBiL2FyY2gvYXJtL21hY2gtcmRhL01ha2VmaWxlCkBAIC0wLDAgKzEgQEAKK29iai0gKz0gZHVt
bXkubwotLSAKMi4xNy4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtYXJtLWtlcm5lbAo=
