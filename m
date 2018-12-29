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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F48C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 14:37:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DC252087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 14:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lK5qGVXl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Q730wkm+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DC252087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DBgq9g7mfuMdcUi8n3jqwc1EdfDam+KK7OtG+Yopt/o=; b=lK5qGVXlCzqE+R
	4VQcZ+AMJdrySIlY9gB+cFK2uUn+SvZDv1pZw5hq/GyT2Fcu8eDgvFkuew6wqSWmcTKA+QjIj1VRs
	ATg07pENAuJCSG7E5BkttOAvCGHSbAIO+mgRpLHtDDbk7X1niSL3UxEh3vjUTJ9ucooUQxzL6mL5x
	gLMXnYiUsSKoilyU+HBGysVbR4vGqsom1BAM7zN7gF4f4zwShzDnY3Y2EPY/yWNdHrZ7QfzU/BMIQ
	F/BXqhXYc1uTS7bYnBsBKUnBTe8YMOcW9YJ6gYD+7uhH15L979Eo0VuMreyDJuGw+k67gXme+nLBw
	CcmdNbrqDSZjPnDro5Tg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gdFje-00044I-AJ; Sat, 29 Dec 2018 14:37:06 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gdFj5-0003XZ-Ur; Sat, 29 Dec 2018 14:36:34 +0000
Received: by mail-wr1-x443.google.com with SMTP id q18so23184379wrx.9;
 Sat, 29 Dec 2018 06:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=e3wgQw6VtGUASHsXZNXi3LuOVnjSs4aHkOWDavF1HK4=;
 b=Q730wkm+Vvx3N3zGKhrukZfxR6m/owsdnDEfgbz1uS1yP7XvfG2ilAbYzNQunnBD6d
 AOI3efIwrczLr0Gfw9ztYemj80nQmFhW/pBXHiBYVFz665cFDCrc53cTLrq+Robf6gk8
 lBzF6f89IYIwGWE+diX1n0EM1fntN1rgl5KEf7V2n8w0D/0EqI8711XFh6+Kg5R2tvnB
 JSuGvUaoZq2FvUZ+Ejw2iDp87RdMjeSHxNAHbO1SY3d7E86GYuGNLO58YBI8iCiBdntJ
 jZEMnqTT38exeXmEZW5q/rKmq9Z6lAT5rJOtI4vqfjIGMnMr1hCptGWx7pOZ2UYdrnsP
 J1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=e3wgQw6VtGUASHsXZNXi3LuOVnjSs4aHkOWDavF1HK4=;
 b=q5g/MMGaSpODAwUak/Ki4ku88pFYW1hdbXUpXckMYJqebG9Hf7zvIbRQrpdOxdq1NN
 EBxqid39VyuTgxZ9pTXzdvBlwjDSDuhi2RpDqb0pOp42ncE7XMV64A2TDULKXimo5JrY
 r81wSR+GSRZ9hRU2dFeXMMy+VbjPfzX9jtILDqVDEdw+lZxcXmBTaDWSBRwosyz3/MJj
 N5CCOG2OSdLmUZkCVpjNthGSnTkyMf65pzhxccmvoHvLYZjTJ9M7huH2ApnK3MJgf2Is
 57MlmQzQ6W3OrY2oaHr3h53z9STzCoAjyJ1N9mtCQdXyyUxX1T0Vmb0RZhG9lUAlTptX
 mhgA==
X-Gm-Message-State: AJcUukfMe4d+D5NwpGRLEedveRKVn26mrxCRHJdXiQicMK600cHIL6iA
 Qt+XQV55YhEBMKNIsv65prQ02HcR
X-Google-Smtp-Source: ALg8bN6MUT4VPzo5n6Jh3/XRkqJKJ+MBAULhQZgValKxGUFygdL8QUkKXq51uHu3m/GJ6Busdmw3Wg==
X-Received: by 2002:adf:8506:: with SMTP id 6mr18856219wrh.128.1546094181047; 
 Sat, 29 Dec 2018 06:36:21 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD7294600914F24DE1716D3FC.dip0.t-ipconnect.de.
 [2003:dc:d729:4600:914f:24de:1716:d3fc])
 by smtp.googlemail.com with ESMTPSA id
 k135sm53626412wmd.42.2018.12.29.06.36.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 29 Dec 2018 06:36:20 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org, khilman@baylibre.com,
 ingrassia@epigenesys.com
Subject: [PATCH v3 2/2] ARM: dts: meson8b: fix the Ethernet data line signals
 in eth_rgmii_pins
Date: Sat, 29 Dec 2018 15:35:56 +0100
Message-Id: <20181229143556.27339-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181229143556.27339-1-martin.blumenstingl@googlemail.com>
References: <20181229143556.27339-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181229_063631_993175_AED4EA9B 
X-CRM114-Status: GOOD (  16.63  )
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
 linux-arm-kernel@lists.infradead.org, jianxin.pan@amlogic.com,
 linus.luessing@c0d3.blue
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QWNjb3JkaW5nIHRvIHRoZSBPZHJvaWQtQzErIHNjaGVtYXRpY3MgdGhlIEV0aGVybmV0IFRYRDEg
c2lnbmFsIGlzCnJvdXRlZCB0byBHUElPSF81IGFuZCB0aGUgVFhEMCBzaWduYWwgaXMgcm91dGVk
IHRvIEdQSU9IXzYuClRoZSBwdWJsaWMgUzgwNSBkYXRhc2hlZXQgc2hvd3MgdGhhdCBUWEQwIGNh
biBiZSByb3V0ZWQgdG8gRElGXzJfUCBhbmQKVFhEMSBjYW4gYmUgcm91dGVkIHRvIERJRl8yX04g
aW5zdGVhZC4KClRoZSBwaW4gZ3JvdXBzIGV0aF90eGQwXzAgKEdQSU9IXzYpIGFuZCBldGhfdHhk
MF8xIChESUZfMl9QKSBhcmUgYm90aApjb25maWd1cmVkIGFzIEV0aGVybmV0IFRYRDAgYW5kIFRY
RDEgZGF0YSBsaW5lcyBpbiBtZXNvbjhiLmR0c2kuIEF0IHRoZQpzYW1lIHRpbWUgZXRoX3R4ZDFf
MCAoR1BJT0hfNSkgYW5kIGV0aF90eGQxXzEgKERJRl8yX04pIGFyZSBjb25maWd1cmVkCmFzIFRY
RDAgYW5kIFRYRDEgZGF0YSBsaW5lcyBhcyB3ZWxsLgpUaGlzIHJlc3VsdHMgaW4gYSBiYWQgRXRo
ZXJuZXQgcmVjZWl2ZSBwZXJmb3JtYW5jZS4gUHJlc3VtYWJseSB0aGlzIGlzCmR1ZSB0byB0aGUg
ZXRoX3R4ZDAgYW5kIGV0aF90eGQxIHNpZ25hbCBiZWluZyByb3V0ZWQgdG8gdGhlIHdyb25nIHBp
bnMuCkFzIGEgcmVzdWx0IG9mIHRoYXQgZGF0YSBjYW4gb25seSBiZSB0cmFuc21pdHRlZCBvbiBl
dGhfdHhkMiBhbmQKZXRoX3R4ZDMuIEhvd2V2ZXIsIEkgaGF2ZSBubyBzY29wZSB0byBmdWxseSBj
b25maXJtIHRoaXMgYXNzdW1wdGlvbi4KClRoZSB2ZW5kb3IgdS1ib290IHNvdXJjZXMgZm9yIE9k
cm9pZC1DMSB1c2UgdGhlIGZvbGxvd2luZyBFdGhlcm5ldApwaW5tdXggY29uZmlndXJhdGlvbjoK
ICBTRVRfQ0JVU19SRUdfTUFTSyhQRVJJUEhTX1BJTl9NVVhfNiwgMHgzZjRmKTsKICBTRVRfQ0JV
U19SRUdfTUFTSyhQRVJJUEhTX1BJTl9NVVhfNywgMHhmMDAwMDApOwpUaGlzIHRyYW5zbGF0ZXMg
dG8gdGhlIGZvbGxvd2luZyBwaW4gZ3JvdXBzIGluIHRoZSBtYWlubGluZSBrZXJuZWw6Ci0gcmVn
aXN0ZXIgNiBiaXQgIDA6IGV0aF9yeGQxIChESUZfMF9QKQotIHJlZ2lzdGVyIDYgYml0ICAxOiBl
dGhfcnhkMCAoRElGXzBfTikKLSByZWdpc3RlciA2IGJpdCAgMjogZXRoX3J4X2R2IChESUZfMV9Q
KQotIHJlZ2lzdGVyIDYgYml0ICAzOiBldGhfcnhfY2xrIChESUZfMV9OKQotIHJlZ2lzdGVyIDYg
Yml0ICA2OiBldGhfdHhfZW4gKERJRl8zX1ApCi0gcmVnaXN0ZXIgNiBiaXQgIDg6IGV0aF9yZWZf
Y2xrIChESUZfM19OKQotIHJlZ2lzdGVyIDYgYml0ICA5OiBldGhfbWRjIChESUZfNF9QKQotIHJl
Z2lzdGVyIDYgYml0IDEwOiBldGhfbWRpb19lbiAoRElGXzRfTikKLSByZWdpc3RlciA2IGJpdCAx
MTogZXRoX3R4X2NsayAoR1BJT0hfOSkKLSByZWdpc3RlciA2IGJpdCAxMjogZXRoX3R4ZDIgKEdQ
SU9IXzgpCi0gcmVnaXN0ZXIgNiBiaXQgMTM6IGV0aF90eGQzIChHUElPSF83KQotIHJlZ2lzdGVy
IDcgYml0IDIwOiBldGhfdHhkMF8wIChHUElPSF82KQotIHJlZ2lzdGVyIDcgYml0IDIxOiBldGhf
dHhkMV8wIChHUElPSF81KQotIHJlZ2lzdGVyIDcgYml0IDIyOiBldGhfcnhkMyAoRElGXzJfUCkK
LSByZWdpc3RlciA3IGJpdCAyMzogZXRoX3J4ZDIgKERJRl8yX04pCgpEcm9wIHRoZSBldGhfdHhk
MF8xIGFuZCBldGhfdHhkMV8xIGdyb3VwcyBmcm9tIGV0aF9yZ21paV9waW5zIHRvIGZpeCB0aGUK
RXRoZXJuZXQgdHJhbnNtaXQgcGVyZm9ybWFuY2Ugb24gT2Ryb2lkLUMxLiBBbHNvIGFkZCB0aGUg
ZXRoX3J4ZDIgYW5kCmV0aF9yeGQzIGdyb3VwcyBzbyB3ZSBkb24ndCByZWx5IG9uIHRoZSBib290
bG9hZGVyIHRvIHNldCB0aGVtIHVwLgoKaXBlcmYzIHN0YXRpc3RpY3MgYmVmb3JlIHRoaXMgY2hh
bmdlOgotIHRyYW5zbWl0dGluZyBmcm9tIE9kcm9pZC1DMTogNzQxIE1iaXRzL3NlYyAoMCByZXRy
aWVzKQotIHJlY2VpdmluZyBvbiBPZHJvaWQtQzE6IDE5OSBNYml0cy9zZWMgKDE3MTMgcmV0cmll
cykKCmlwZXJmMyBzdGF0aXN0aWNzIGFmdGVyIHRoaXMgY2hhbmdlOgotIHRyYW5zbWl0dGluZyBm
cm9tIE9kcm9pZC1DMTogNjY3IE1iaXRzL3NlYyAoMCByZXRyaWVzKQotIHJlY2VpdmluZyBvbiBP
ZHJvaWQtQzE6IDc1MCBNYml0cy9zZWMgKDAgcmV0cmllcykKCkZpeGVzOiBiOTY0NDY1NDFkODM5
MCAoIkFSTTogZHRzOiBtZXNvbjhiOiBleHRlbmQgZXRoZXJuZXQgY29udHJvbGxlciBkZXNjcmlw
dGlvbiIpClNpZ25lZC1vZmYtYnk6IE1hcnRpbiBCbHVtZW5zdGluZ2wgPG1hcnRpbi5ibHVtZW5z
dGluZ2xAZ29vZ2xlbWFpbC5jb20+CkNjOiBFbWlsaWFubyBJbmdyYXNzaWEgPGluZ3Jhc3NpYUBl
cGlnZW5lc3lzLmNvbT4KQ2M6IExpbnVzIEzDvHNzaW5nIDxsaW51cy5sdWVzc2luZ0BjMGQzLmJs
dWU+Ci0tLQogYXJjaC9hcm0vYm9vdC9kdHMvbWVzb244Yi5kdHNpIHwgNiArKystLS0KIDEgZmls
ZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
YXJjaC9hcm0vYm9vdC9kdHMvbWVzb244Yi5kdHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvbWVzb244
Yi5kdHNpCmluZGV4IDIyZDc3NTQ2MDc2Ny4uZGMxMjU3NjlmZTg1IDEwMDY0NAotLS0gYS9hcmNo
L2FybS9ib290L2R0cy9tZXNvbjhiLmR0c2kKKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvbWVzb244
Yi5kdHNpCkBAIC0yNzAsOSArMjcwLDcgQEAKIAkJCQlncm91cHMgPSAiZXRoX3R4X2NsayIsCiAJ
CQkJCSAiZXRoX3R4X2VuIiwKIAkJCQkJICJldGhfdHhkMV8wIiwKLQkJCQkJICJldGhfdHhkMV8x
IiwKIAkJCQkJICJldGhfdHhkMF8wIiwKLQkJCQkJICJldGhfdHhkMF8xIiwKIAkJCQkJICJldGhf
cnhfY2xrIiwKIAkJCQkJICJldGhfcnhfZHYiLAogCQkJCQkgImV0aF9yeGQxIiwKQEAgLTI4MSw3
ICsyNzksOSBAQAogCQkJCQkgImV0aF9tZGMiLAogCQkJCQkgImV0aF9yZWZfY2xrIiwKIAkJCQkJ
ICJldGhfdHhkMiIsCi0JCQkJCSAiZXRoX3R4ZDMiOworCQkJCQkgImV0aF90eGQzIiwKKwkJCQkJ
ICJldGhfcnhkMyIsCisJCQkJCSAiZXRoX3J4ZDIiOwogCQkJCWZ1bmN0aW9uID0gImV0aGVybmV0
IjsKIAkJCQliaWFzLWRpc2FibGU7CiAJCQl9OwotLSAKMi4yMC4xCgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5n
IGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
