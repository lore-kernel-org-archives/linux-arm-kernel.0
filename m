Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADEEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:44:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 525E320874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZoSmDggf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sz6MESQF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 525E320874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TFKHCojh1LIr8vOk2JruEzBWzMv5DZc9kbsflF4iFGo=; b=ZoSmDggfwqpckH
	rhMnMy6ttE91Xkr1MAA396DdEpGxBs2U8XL5pZfaLnXkFK+O0XnGI68aFh61zPow7ovPiu9QY1Xm2
	ESmvF/ZRfp05DmcRvIV8b5Lb/G4RjYN2MsNLDF1ls+Hps4iF6fvX3hdzRwmoM5DomMqXglStdDnU5
	3dum7ueiKaLvqFoYlmik3t66WY4CCeHGebN6hIBJzZUoz6xHNW6UhF6nIWM5oOkcsnlWwM+Cjqiee
	zYmi1RvAzdJyCk/ETUVTRCAVn08yDpNKH6wE7VaI2lbSRfxsnUcJPnxzSkSh4dBIHlUqFn62sidAF
	Yy5HTomNXrYT5gYE3o+w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZ6Iu-0008JA-04; Tue, 18 Dec 2018 03:44:20 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZ6Ho-0007F6-89
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 03:43:37 +0000
Received: by mail-pf1-x443.google.com with SMTP id w73so7418593pfk.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 17 Dec 2018 19:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=p8+PRll/69hpVBI8tPhWaAoQEyS3IrjnhvvEZdMVHBc=;
 b=Sz6MESQFeLz7vdepva0/s+KBta4BzPpTYsMOoTThD/2hAW5V+IzXPsDeB2T9gKRRGM
 4EBP8RY/wXHE8/mtugnpRpxaSUrNb2hzhxlnlNnRLKuAuPTOgapfOwurVDS7pF0z7w+K
 cYl4lvL/iSj+JotZctezEu14AoQyaD/d/FEWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=p8+PRll/69hpVBI8tPhWaAoQEyS3IrjnhvvEZdMVHBc=;
 b=uOllOD5yF3UDLBYU2XeqrCj1PS9rTbYRz1hyext/B5zUh68m6uaGEWKL4wHT2HKFK7
 adTZ0fKSBfS5wN70Gb3wF71ffpu4IpmkdGYq88PAzWEFWDbtS8Avo0CQWP3esbBmSHpL
 uDD24o9YVGpBMerJaNWJNBQhRRwNK5YT9eqki6S5BTNtKNCIPazJSQVnbzxaLdr2x9ZQ
 6hEGMauiBqA+V4otwGDDnqLDA/1wvC/5TXEnQFEIL3bLgp5+W7YiXQ2rnqnJyESygt9p
 rIBB5MLlsZVdw0MZEh/j0IfLNizqvK9JZX0Pz7UuRXZVRU9VwEIwqnYN61d2dW9crrOv
 B2hA==
X-Gm-Message-State: AA+aEWZCCiSAio1c4yz3n/Cy4KXv3bDh4NsxyKnwmC6BZroNj5wSvmp0
 jAbNPPi5NsXlw/5mPVkbJxMfBHS9LQ==
X-Google-Smtp-Source: AFSGD/XSCShiBqWsD6aQOj+TE8YBK0+4tdEzHuDa630UDB+/aaLMMUNc6EVPbkJwdub5tT+XwkK/ig==
X-Received: by 2002:a62:1043:: with SMTP id y64mr15467075pfi.78.1545104581361; 
 Mon, 17 Dec 2018 19:43:01 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
 by smtp.gmail.com with ESMTPSA id b202sm25255422pfb.88.2018.12.17.19.42.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Dec 2018 19:43:00 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
 gregkh@linuxfoundation.org, jslaby@suse.com
Subject: [PATCH v5 08/11] dt-bindings: serial: Document RDA Micro UART
Date: Tue, 18 Dec 2018 09:11:29 +0530
Message-Id: <20181218034132.5070-9-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218034132.5070-1-manivannan.sadhasivam@linaro.org>
References: <20181218034132.5070-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_194313_395847_35FE70F3 
X-CRM114-Status: GOOD (  12.54  )
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
