Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA96C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:08:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6052B2133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hiN40Y0p";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bqRxus8C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6052B2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TFKHCojh1LIr8vOk2JruEzBWzMv5DZc9kbsflF4iFGo=; b=hiN40Y0pFL9LKR
	J44M/XiS++KTfH7J44jq+raPUEbRw0kFEVYXP4ZkwdxhowMVJ2MLklLQTOdlvh3+lchMaURWDVFqk
	5XcuQTiTRb8/g9SPo7pqbNMARfA3jV5LEwSOea1RJBY7RzdgVv7glL6ancECXBoQsCjxLxqoLhsKo
	XzLJRxNnr8BaZOWxmYMkt6FPp7Jo7rUVUMFZAbqfxZPpghWtr6F/mctHptfbNVOLQauUWQZSaUAPe
	cBlQzwnfJpLYf04kImmr4vwlBjpKI6UoqYUm0SYkyh0lAxF0Wm8uPJNWtjf3wtUqAC7ffExW2f8kV
	+P0PEAAuSI368lUOlYvA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZAQX-0001Dx-8I; Tue, 18 Dec 2018 08:08:29 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZAP0-0008Kw-5Q
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 08:07:00 +0000
Received: by mail-pf1-x441.google.com with SMTP id b85so7762826pfc.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 00:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=p8+PRll/69hpVBI8tPhWaAoQEyS3IrjnhvvEZdMVHBc=;
 b=bqRxus8CEVj8x00GEJ6tPZFvSOeSdrZWpqKoGrOd+0VFFM7vST0FdEJg8tUILQR7sy
 xEw5UQsPhlbeZQPwBN6sYCJXLHrvPQ3Q9FhomxCBftgHOuunY/McWy3g1M59/W5ypScq
 tZzBeHz+n8n9mPud0gb81yWTanNJ3hO8J2tY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=p8+PRll/69hpVBI8tPhWaAoQEyS3IrjnhvvEZdMVHBc=;
 b=mcfm/V1+Y0efo2sdmPKQwxs7RIdK1T7UbXCXwKQeYwbud8uGNIuvrlr7sjBfEoyblF
 nRFsyobD5o/E8FPESgJhYG6OivCyeyT4StDx+nI2DviW85ygRgpNFRpzsxX5J/NEvDHo
 nmbievNv547CRXuGSEmdlgE8ict+n4DlSCiv1XYIGfALBY9dKU7ULJYQ+lcWEEymAMPb
 b0ecLsVWVuPE+iD3RUI2GmccyX7TWQDOia/rBPLZrBh4kWzSCzfw2LgFo36uibGsuiAK
 kBFYopPTd+2bhyZLRFycT4yjoKfxAKUJMQsUYIouO4TheG+k396OiXV/ThJGdtdV9Ifh
 7XLg==
X-Gm-Message-State: AA+aEWZvH203L6bowHpi/KVHtfV88CNr0z1YfmuAUDHEwGcAxgi3Uw4j
 qUoj4kSbAjx0vZag/o1nzYiW
X-Google-Smtp-Source: AFSGD/UtudcoBVycPlju1YFvp1c/6GqvVy4RLPUdo5T3hhOqyMghYv8PdFiTLmas8b2lU79LPnHrdQ==
X-Received: by 2002:a63:d547:: with SMTP id v7mr14713880pgi.339.1545120403546; 
 Tue, 18 Dec 2018 00:06:43 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
 by smtp.gmail.com with ESMTPSA id 7sm45596888pfm.8.2018.12.18.00.06.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Dec 2018 00:06:43 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
 gregkh@linuxfoundation.org, jslaby@suse.com
Subject: [PATCH v6 08/11] dt-bindings: serial: Document RDA Micro UART
Date: Tue, 18 Dec 2018 13:35:24 +0530
Message-Id: <20181218080527.10801-9-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218080527.10801-1-manivannan.sadhasivam@linaro.org>
References: <20181218080527.10801-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_000654_322614_B3469823 
X-CRM114-Status: GOOD (  11.80  )
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

RnJvbTogQW5kcmVhcyBGw6RyYmVyIDxhZmFlcmJlckBzdXNlLmRlPgoKQWRkIGFuIGluaXRpYWwg
YmluZGluZyBmb3IgdGhlIFVBUlQgaW4gUkRBIE1pY3JvIFJEQTg4MTBQTCBTb0MuCgpTaWduZWQt
b2ZmLWJ5OiBBbmRyZWFzIEbDpHJiZXIgPGFmYWVyYmVyQHN1c2UuZGU+ClNpZ25lZC1vZmYtYnk6
IE1hbml2YW5uYW4gU2FkaGFzaXZhbSA8bWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFyby5vcmc+
Ci0tLQogLi4uL2JpbmRpbmdzL3NlcmlhbC9yZGEsODgxMHBsLXVhcnQudHh0ICAgICAgICAgfCAx
NyArKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKykKIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc2VyaWFs
L3JkYSw4ODEwcGwtdWFydC50eHQKCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3Mvc2VyaWFsL3JkYSw4ODEwcGwtdWFydC50eHQgYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3Mvc2VyaWFsL3JkYSw4ODEwcGwtdWFydC50eHQKbmV3IGZpbGUgbW9k
ZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwMDAwLi5hMDhkZjk3YTY5ZTYKLS0tIC9kZXYvbnVsbAor
KysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc2VyaWFsL3JkYSw4ODEwcGwt
dWFydC50eHQKQEAgLTAsMCArMSwxNyBAQAorUkRBIE1pY3JvIFVBUlQKKworUmVxdWlyZWQgcHJv
cGVydGllczoKKy0gY29tcGF0aWJsZSA6ICAicmRhLDg4MTBwbC11YXJ0IiBmb3IgUkRBODgxMFBM
IFNvQ3MuCistIHJlZyAgICAgICAgOiAgT2Zmc2V0IGFuZCBsZW5ndGggb2YgdGhlIHJlZ2lzdGVy
IHNldCBmb3IgdGhlIGRldmljZS4KKy0gaW50ZXJydXB0cyA6ICBTaG91bGQgY29udGFpbiBVQVJU
IGludGVycnVwdC4KKy0gY2xvY2tzICAgICA6ICBQaGFuZGxlIHRvIHRoZSBpbnB1dCBjbG9jay4K
KworCitFeGFtcGxlOgorCisJCXVhcnQyOiBzZXJpYWxAMjBhOTAwMDAgeworCQkJY29tcGF0aWJs
ZSA9ICJyZGEsODgxMHBsLXVhcnQiOworCQkJcmVnID0gPDB4MjBhOTAwMDAgMHgxMDAwPjsKKwkJ
CWludGVycnVwdHMgPSA8MTEgSVJRX1RZUEVfTEVWRUxfSElHSD47CisJCQljbG9ja3MgPSA8JnVh
cnRfY2xrPjsKKwkJfTsKLS0gCjIuMTcuMQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
