Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53E9C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:53:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 894F52081F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qHVUp8vG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Nh0VCKU2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AGlkSDyV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 894F52081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TFKHCojh1LIr8vOk2JruEzBWzMv5DZc9kbsflF4iFGo=; b=qHVUp8vG3iLdjv
	2QZP7rIMrXBC66YUK44c3LSbAmhwThBPvp1QoUOdzXD1+zhT80otX591xkdDshzOb5/d9oDwSF3KL
	+vRU7wcDL0i57z3dhXuzYEeGN4Uv99OHJVC6RloRMw97UoxrQfvPcSJVHxnST2lMX3Ol5D+NW0atG
	WMd7R1+KuJvk7sfW3MCen3SGsUFb2ayZ0EDkxYEMzAumQavsSgOyDSQljToQ3Y9nGlcCs3Aatdkn5
	B8DGBJ/DJsNFS5Q7snxDWN3NTh/mFDjUcOy6+XRp8UI4ITdZv10JZGpe/ecoxiEluYm0IxCOsr02m
	WKQLyuXBALGnj9i/BH7g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWPk4-0008AB-QV; Mon, 10 Dec 2018 17:53:16 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWPjs-0007qR-0V
 for linux-arm-kernel@bombadil.infradead.org; Mon, 10 Dec 2018 17:53:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=p8+PRll/69hpVBI8tPhWaAoQEyS3IrjnhvvEZdMVHBc=; b=Nh0VCKU2krFMIGOmhZGxcsNH/a
 PgdmLIN85iEwxtwSPEGQsI+Mz7DbPtaJYuwGo2T+URYuJ8j2wxZ4GXqbfyXIqYWxkc/QpPWXSYJlF
 98f45SuFgOA62ustOFs/lBrI9TEIWxHlnt2LKhgcF7O3Ee6OMEnlzt9eQBhJXv2oLlauDodjCTjrI
 bhVMC5xyHw4UyX0bkSHfaHiMlhq6rGfgE1SAlYNsXG0pkQ0iZLfsjBAUU0okmKxsYGD81aXXASZ+c
 beZJUf3NeW6ZkYjWoeVskpKCKot+pwpPydgW99dwi3Q9FjZ+ii1bnP+vJZybrf4/xhqQd18HJwqKP
 7YtvKFDA==;
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWPV8-0002tk-P7
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 17:37:52 +0000
Received: by mail-pl1-x642.google.com with SMTP id y1so5560397plp.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 09:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=p8+PRll/69hpVBI8tPhWaAoQEyS3IrjnhvvEZdMVHBc=;
 b=AGlkSDyV4ns2334v1ZYiu7kNpDVrFQ/E4gZNcudTBLEdt/j5qpg80n1QN50gmZCoGT
 6Mhrh3Idbbo8Ejsd0j0YaZPbv/mrJNZEITnTtH4I41xIWXdrs9vTs1J2IvlX/msycokX
 QzVrI3Tq0JI1wEiLhRDaju+cvhKGOHzEC/1kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=p8+PRll/69hpVBI8tPhWaAoQEyS3IrjnhvvEZdMVHBc=;
 b=jO1B6HTa5gz/JVdv6P+5b46CpIFCn2HXwdOb/QMUFqOWtqX2+MQedWtWdy7lTb+SD/
 w/KyxiQY4l7HnVcsviuja2u2bX9s8ufGhBMZJsk8LaTnlmXkxD5rBFJPFT2MpoA+K98R
 mhsvT/IxtvEwWyht0vkf8vDwGcjZnHe1WtjRt7tOxpX3IWWzcchaf+L/95UcqcAyYA8H
 vKfqF83K2fYELxw0X/hv9AEeNambuI4kEI80bR9kleKbtFluUbUBLrFgU7gz1j1Ec74Y
 NwWVBcj/vNvYoiojgZ+/oCKLZQHmXDC5rpQEvEMXa2xSkC2ngD21oCfsGA0P1zFSIreS
 1FZA==
X-Gm-Message-State: AA+aEWbFuYcLI3qhVzK6iZUepSjhHIusWncpEXGn5G4n2oAiA1jIhMUE
 xgEuFBlXUmsJkgf65gGbUTMQ
X-Google-Smtp-Source: AFSGD/WlF+xuJEU1KBWr3sQndFFkB9adKzU2vqd8abhLHX5J88zYdjbHuZ4W8q+Dasn1E5FjFxd9YQ==
X-Received: by 2002:a17:902:bf44:: with SMTP id
 u4mr12940556pls.5.1544463468534; 
 Mon, 10 Dec 2018 09:37:48 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:91e:2c01:40e1:a028:b090:9e12])
 by smtp.gmail.com with ESMTPSA id q1sm15998396pfb.96.2018.12.10.09.37.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 09:37:47 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org, tglx@linutronix.de,
 jason@lakedaemon.net, marc.zyngier@arm.com, daniel.lezcano@linaro.org,
 gregkh@linuxfoundation.org, jslaby@suse.com
Subject: [PATCH v4 12/15] dt-bindings: serial: Document RDA Micro UART
Date: Mon, 10 Dec 2018 23:05:47 +0530
Message-Id: <20181210173550.29643-13-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181210173550.29643-1-manivannan.sadhasivam@linaro.org>
References: <20181210173550.29643-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_173750_803943_51BA7D47 
X-CRM114-Status: GOOD (  14.34  )
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
