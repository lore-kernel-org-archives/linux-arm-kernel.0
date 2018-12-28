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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E134BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 16:20:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 882CD20856
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 16:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J8ZnEHQj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwXSDmNZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 882CD20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cHM2oXA801p30uOqbpjaxVX3LO7a/AmPJwc4dY3bIzg=; b=J8ZnEHQjj/0zov
	4Y6oowM40gkyQy1ARlG+HcnL0mAXbcIZ9llR33PltxHrUBdn//90fbr8OdSBTkHhmJU6AM+gSX2kY
	HuE8eDkochcCFuI4jW1Vf6ki+I+8r+Upd3uoMAmI/m9ZgNL96YDc+5Se0jtcmsP7EYnzwNtFb0wJD
	VMxJCXsJ5vTXk9rDmn0YyYT35hIAtBdK3OuxEclRImyK9oYuY1XSC430+79YUi6170g7dcH6L8Ocw
	2o7Euc1VYLkp+obrDjSz46oSYgsXDFh8M0DF0lj5wCcl9t8WA2YdUuz7UI73AIRYr1aC28+sGhzmY
	2XdC7ndkdKBMkBnHybdg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcurY-0005Lj-6U; Fri, 28 Dec 2018 16:19:52 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcuqX-0004Ey-Hw
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 16:18:55 +0000
Received: by mail-lj1-x241.google.com with SMTP id k15-v6so19067857ljc.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 28 Dec 2018 08:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VPTqR/NzmUP1Wul0aNxp78EL3f6kYB4v+Ag3WPPcrKg=;
 b=cwXSDmNZZWiczSKWBk/SCxRIp590NyY+UjX9pdCeYzjJHP4NP3AostVNWWhIr9F1UH
 XhwuV5sbGOR2vlaVczSTSS26T41B80JFjpWTgWbCxsykut9JlBgnXUGnM8Vr8KYv+c0X
 Y8VbVNwjtiXKdsgjPK6oNaUIGdGsJIEmcBfPIVGSsT3LWKQ5LNrE9b9pL7q3wnrCZAne
 XIm30Tgh5qqJMvAsRU+nnra7JgeRc9hgKdy++n+vDuatfwTWGgILUTfo+xiVpDyRRDVD
 k1xMXNojYPO15j4q/btA0u69GQZP/BX1O9hB78cBCDVOX1xxW3OqwYz7Zi7ria1WBX2h
 bgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VPTqR/NzmUP1Wul0aNxp78EL3f6kYB4v+Ag3WPPcrKg=;
 b=BM+87FhExPn9iuNpb4B4ejUwijDgRi83B3JDxbSxfEuWtMHhHbtrQP7WLfUDLClfqv
 Hu/UIVhznFjedTluVhutk2GOtevstg8v3eG6HU21vPTGmkRd6O5zWgMfIW6sQniBdsQ5
 JyPVhlu+7auiXYVzTbi17iKFGI8qCIw16TUZCkjNpTGbsGtePWUxQgzufHLDDPyMgW/o
 fvcrRvCAnkRWa28JhOAF66Rt5gdIK9LjSwaaOsv5bL+dkh7CfM0BDbzDm7mFhFGuogeo
 MLu1FXSluVxcMVYkzVnTBQXEWf9keNK3cB5QlGFcGgKLdNPXDrL7lUslvy4eoxokuWPH
 ZYXw==
X-Gm-Message-State: AJcUukdyQjp5ft0ECwFHLtXWqV7vqJJxYLv8S7IggMT/QJbX85+Chc09
 Q1BpDRaDDTkFKbJYj4dS1mk=
X-Google-Smtp-Source: ALg8bN7vhbcxBxIUfk+PmZCMDZupq1zYbzPLi0ZpXHL7/tBc90xphfD81cJH9cKIDY5cZnRYpgLB3w==
X-Received: by 2002:a2e:5d12:: with SMTP id
 r18-v6mr18419477ljb.89.1546013917644; 
 Fri, 28 Dec 2018 08:18:37 -0800 (PST)
Received: from localhost.localdomain
 ([2a02:a315:5445:5300:7146:fd07:48ff:9665])
 by smtp.googlemail.com with ESMTPSA id r4sm8136502lfe.60.2018.12.28.08.18.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 28 Dec 2018 08:18:37 -0800 (PST)
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: krzk@kernel.org
Subject: [PATCH 4/6] ARM: dts: s5pv210: aries: Add reserved memory for mfc
Date: Fri, 28 Dec 2018 17:18:17 +0100
Message-Id: <20181228161819.18931-5-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181228161819.18931-1-pawel.mikolaj.chmiel@gmail.com>
References: <20181228161819.18931-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_081850_054214_54EFF3A8 
X-CRM114-Status: GOOD (  11.71  )
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

VGhpcyBjb21taXQgYWRkcyBtZW1vcnkgcmVzZXJ2YXRpb24gcmVxdWlyZWQgYnkgTUZDIHRvIHJ1
bi4KT24gUzVQVjIxMCBib3RoIHJlZ2lvbnMgbmVlZHMgdG8gYmUgb24gc2VwYXJhdGUgbWVtb3J5
IGJhbmtzLgpTaXplIG9mIGJvdGggcmVnaW9ucyBpcyB0YWtlbiBmcm9tIHN0b2NrIHNvdXJjZXMu
CgpTaWduZWQtb2ZmLWJ5OiBQYXdlxYIgQ2htaWVsIDxwYXdlbC5taWtvbGFqLmNobWllbEBnbWFp
bC5jb20+Ci0tLQogYXJjaC9hcm0vYm9vdC9kdHMvczVwdjIxMC1hcmllcy5kdHNpIHwgMjIgKysr
KysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKykKCmRp
ZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9zNXB2MjEwLWFyaWVzLmR0c2kgYi9hcmNoL2Fy
bS9ib290L2R0cy9zNXB2MjEwLWFyaWVzLmR0c2kKaW5kZXggNTc1MDk0ZWE3MDI0Li4zNWJhMDA5
YTFhMzMgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL3M1cHYyMTAtYXJpZXMuZHRzaQor
KysgYi9hcmNoL2FybS9ib290L2R0cy9zNXB2MjEwLWFyaWVzLmR0c2kKQEAgLTIzLDYgKzIzLDI0
IEBACiAJCQkweDUwMDAwMDAwIDB4MDgwMDAwMDA+OwogCX07CiAKKwlyZXNlcnZlZC1tZW1vcnkg
eworCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsKKwkJI3NpemUtY2VsbHMgPSA8MT47CisJCXJhbmdl
czsKKworCQltZmNfbGVmdDogcmVnaW9uX21mY19sZWZ0QDQzMDAwMDAwIHsKKwkJCWNvbXBhdGli
bGUgPSAic2hhcmVkLWRtYS1wb29sIjsKKwkJCW5vLW1hcDsKKwkJCXJlZyA9IDwweDQzMDAwMDAw
IDB4MjAwMDAwMD47CisJCX07CisKKwkJbWZjX3JpZ2h0OiByZWdpb25fbWZjX3JpZ2h0QDUxMDAw
MDAwIHsKKwkJCWNvbXBhdGlibGUgPSAic2hhcmVkLWRtYS1wb29sIjsKKwkJCW5vLW1hcDsKKwkJ
CXJlZyA9IDwweDUxMDAwMDAwIDB4MjAwMDAwMD47CisJCX07CisJfTsKKwogCXdpZmlfcHdyc2Vx
OiB3aWZpLXB3cnNlcSB7CiAJCWNvbXBhdGlibGUgPSAibW1jLXB3cnNlcS1zaW1wbGUiOwogCQly
ZXNldC1ncGlvcyA9IDwmZ3BnMSAyIEdQSU9fQUNUSVZFX0xPVz47CkBAIC0zMjksNiArMzQ3LDEw
IEBACiAJc3RhdHVzID0gIm9rYXkiOwogfTsKIAorJm1mYyB7CisJbWVtb3J5LXJlZ2lvbiA9IDwm
bWZjX2xlZnQ+LCA8Jm1mY19yaWdodD47Cit9OworCiAmcGluY3RybDAgewogCXdsYW5fYnRfZW46
IHdsYW4tYnQtZW4gewogCQlzYW1zdW5nLHBpbnMgPSAiZ3BiLTUiOwotLSAKMi4xNy4xCgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtl
cm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5l
bAo=
