Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC1CC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:38:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 330EF2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PjV9Iqor";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HnWTjtv6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 330EF2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rYWAUV2vC/gOY6G4hnwLFzLU5Yq0RPT2nM0BqQafTaw=; b=PjV9IqorxmaSHu
	iIfKCb3CkF4s5hSKEx629TkiZXG8HQGJ+4vJVc1KvtpxyIIsIPJqd2fhaSAluXoY6hHGNGvlq02eq
	ASd7fTm0W2HpqfSzXk2j1PfvqpGNRpiyT7ISjnmLeBw2QgCfMqkTvOzw0Izxp13Suf27LPZwEz6y5
	1RBU56WXWGYIgL66xUauvuXo3cWPliB4tgzxRoM1T4CzPF8uPPPMprPAkgUp4dGXdyeaXpUR782kF
	BO8/+ggunm8Itdz7V94Cwf7bD52aH09bQ9qeCn2MTNM15cRvguzDPC9SHQItMpI/8uXdl4/gWrCBe
	JkPUY1BbOYEcsqPNpj+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWPVM-00011m-JE; Mon, 10 Dec 2018 17:38:04 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWPUP-0008UG-Ts
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 17:37:35 +0000
Received: by mail-pg1-x544.google.com with SMTP id z10so5282541pgp.7
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 09:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jBeXaJXIkgLTVAea7CD+4QY6FweZRNu6qTHTVAB8x/Y=;
 b=HnWTjtv6Hy7K1s4CYLo0CNcASjpB/ucXs+JDazjHumFysvFqK+VJ8QJWG1urZqaYjt
 Y0afPttIx8MIBlO/YhK5H0I0R0rKCJkRuKDTyP6KaboVBdzD6WwvGny6ncV5PmcmUjnz
 wDw+4l/6qUiEcd1nEANt24gSD+Rqcm5Y1pUQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jBeXaJXIkgLTVAea7CD+4QY6FweZRNu6qTHTVAB8x/Y=;
 b=Ofrk1q9KO+kNDURBLl0SL4a5JPAHQI/9I6q6lTP1VU5NOI7qYlBa97Wk2aUr/mqr7U
 lipSC/LCZEKV1AXruKf2vcULXBnGGoKZ58gGcfn9aK5bCCy6r/v3j0zn3AHksBGlalng
 JeXvX3NWvl1D+rdY4KFVW0o3/hZXbVaBVsYUciT/Wv7xpYdbzUuV8mjyzwln3ThyFCHW
 Mhn4FZjTc607CIIkYy8yyk0XxoMDhbHlpYVhkVoxPanLqs296VW9qkUV4sX6f/6710yr
 ILrE1E9U/smHZw2S6i/iNa8oQMA+fF3kAO3AlM6gkEN3Hs6NaB+3zAQKC68tCGZq6yPM
 tP0w==
X-Gm-Message-State: AA+aEWZ1FvJfsAv0Dwhgi8TWDgZUZ8ISjoedhjzpQ2qh6XFGpRQzXJ6u
 Whn8FUrLDJPjIb+1/HAYZyDE
X-Google-Smtp-Source: AFSGD/VsuZLUgkb5A6az0xNP83jpeir23dDvpTTMoEGwiGnzwSjnc1juBaCDajpNYRCDqe77dbs5Sg==
X-Received: by 2002:a63:6c48:: with SMTP id h69mr11056458pgc.139.1544463415247; 
 Mon, 10 Dec 2018 09:36:55 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:91e:2c01:40e1:a028:b090:9e12])
 by smtp.gmail.com with ESMTPSA id q1sm15998396pfb.96.2018.12.10.09.36.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 09:36:54 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org, tglx@linutronix.de,
 jason@lakedaemon.net, marc.zyngier@arm.com, daniel.lezcano@linaro.org,
 gregkh@linuxfoundation.org, jslaby@suse.com
Subject: [PATCH v4 06/15] ARM: dts: Add devicetree for OrangePi 2G IoT board
Date: Mon, 10 Dec 2018 23:05:41 +0530
Message-Id: <20181210173550.29643-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181210173550.29643-1-manivannan.sadhasivam@linaro.org>
References: <20181210173550.29643-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_093706_654060_37E78231 
X-CRM114-Status: GOOD (  14.84  )
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

QWRkIGluaXRpYWwgZGV2aWNldHJlZSBzdXBwb3J0IGZvciBPcmFuZ2VQaSAyRyBJb1QgYm9hcmQg
ZnJvbSBYdW5sb25nLgoKU2lnbmVkLW9mZi1ieTogQW5kcmVhcyBGw6RyYmVyIDxhZmFlcmJlckBz
dXNlLmRlPgpTaWduZWQtb2ZmLWJ5OiBNYW5pdmFubmFuIFNhZGhhc2l2YW0gPG1hbml2YW5uYW4u
c2FkaGFzaXZhbUBsaW5hcm8ub3JnPgotLS0KIGFyY2gvYXJtL2Jvb3QvZHRzL01ha2VmaWxlICAg
ICAgICAgICAgICAgICAgICB8ICAyICsKIC4uLi9ib290L2R0cy9yZGE4ODEwcGwtb3JhbmdlcGkt
MmctaW90LmR0cyAgICB8IDUwICsrKysrKysrKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwg
NTIgaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtL2Jvb3QvZHRzL3Jk
YTg4MTBwbC1vcmFuZ2VwaS0yZy1pb3QuZHRzCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9k
dHMvTWFrZWZpbGUgYi9hcmNoL2FybS9ib290L2R0cy9NYWtlZmlsZQppbmRleCBiMGU5NjZkNjI1
YjkuLmEwZmRhZDhmMTBkZCAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvTWFrZWZpbGUK
KysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvTWFrZWZpbGUKQEAgLTgwNiw2ICs4MDYsOCBAQCBkdGIt
JChDT05GSUdfQVJDSF9RQ09NKSArPSBcCiAJcWNvbS1tc204OTc0LXNvbnkteHBlcmlhLWNhc3Rv
ci5kdGIgXAogCXFjb20tbXNtODk3NC1zb255LXhwZXJpYS1ob25hbWkuZHRiIFwKIAlxY29tLW1k
bTk2MTUtd3A4NTQ4LW1hbmdvaC1ncmVlbi5kdGIKK2R0Yi0kKENPTkZJR19BUkNIX1JEQSkgKz0g
XAorCXJkYTg4MTBwbC1vcmFuZ2VwaS0yZy1pb3QuZHRiCiBkdGItJChDT05GSUdfQVJDSF9SRUFM
VklFVykgKz0gXAogCWFybS1yZWFsdmlldy1wYjExNzYuZHRiIFwKIAlhcm0tcmVhbHZpZXctcGIx
MW1wLmR0YiBcCmRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9yZGE4ODEwcGwtb3Jhbmdl
cGktMmctaW90LmR0cyBiL2FyY2gvYXJtL2Jvb3QvZHRzL3JkYTg4MTBwbC1vcmFuZ2VwaS0yZy1p
b3QuZHRzCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwMC4uOThlMzQyNDhh
ZTgwCi0tLSAvZGV2L251bGwKKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvcmRhODgxMHBsLW9yYW5n
ZXBpLTJnLWlvdC5kdHMKQEAgLTAsMCArMSw1MCBAQAorLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZp
ZXI6IChHUEwtMi4wKyBPUiBNSVQpCisvKgorICogQ29weXJpZ2h0IChjKSAyMDE3IEFuZHJlYXMg
RsOkcmJlcgorICogQ29weXJpZ2h0IChjKSAyMDE4IE1hbml2YW5uYW4gU2FkaGFzaXZhbQorICov
CisKKy9kdHMtdjEvOworCisjaW5jbHVkZSAicmRhODgxMHBsLmR0c2kiCisKKy8geworCWNvbXBh
dGlibGUgPSAieHVubG9uZyxvcmFuZ2VwaS0yZy1pb3QiLCAicmRhLDg4MTBwbCI7CisJbW9kZWwg
PSAiT3JhbmdlIFBpIDJHLUlvVCI7CisKKwlhbGlhc2VzIHsKKwkJc2VyaWFsMCA9ICZ1YXJ0MTsK
KwkJc2VyaWFsMSA9ICZ1YXJ0MjsKKwkJc2VyaWFsMiA9ICZ1YXJ0MzsKKwl9OworCisJY2hvc2Vu
IHsKKwkJc3Rkb3V0LXBhdGggPSAic2VyaWFsMjo5MjE2MDBuOCI7CisJfTsKKworCW1lbW9yeUA4
MDAwMDAwMCB7CisJCWRldmljZV90eXBlID0gIm1lbW9yeSI7CisJCXJlZyA9IDwweDgwMDAwMDAw
IDB4MTAwMDAwMDA+OworCX07CisKKwl1YXJ0X2NsazogdWFydC1jbGsgeworCQljb21wYXRpYmxl
ID0gImZpeGVkLWNsb2NrIjsKKwkJY2xvY2stZnJlcXVlbmN5ID0gPDkyMTYwMD47CisJCSNjbG9j
ay1jZWxscyA9IDwwPjsKKwl9OworfTsKKworJnVhcnQxIHsKKwlzdGF0dXMgPSAib2theSI7CisJ
Y2xvY2tzID0gPCZ1YXJ0X2Nsaz47Cit9OworCismdWFydDIgeworCXN0YXR1cyA9ICJva2F5IjsK
KwljbG9ja3MgPSA8JnVhcnRfY2xrPjsKK307CisKKyZ1YXJ0MyB7CisJc3RhdHVzID0gIm9rYXki
OworCWNsb2NrcyA9IDwmdWFydF9jbGs+OworfTsKLS0gCjIuMTcuMQoKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGlu
ZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
