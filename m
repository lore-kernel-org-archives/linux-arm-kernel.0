Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2093C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:04:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C7E621852
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Oyc6NX7p";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HxFWH4zm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C7E621852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1WdNz0dzaHatWqQgCxKBw3RZbEmaZv6MV9PdpDl4r6s=; b=Oyc6NX7pSwIjfa
	F7lL1TagVmG3AXgev5XzBdizlWEXIoMktjx4haY+ick3UTWoVMfBF++pPvLztcF78DwX4WxQZ7ap0
	b4kL/QtwY3W6jGL+6v/UiWn0v8MpBQT2IcQMa8/fIdJSMZeM5cAKhneYbA1GinzxC9SuS/0QGedYM
	r6ENOwA0FlnJQ5mL8qm4TByz4E2mgDlyuM0UtSWCcSNnxdAKHkrefLH47zj14sTpZT9JBEC0l7a1D
	hG0IVk1lJVh4CDUdyXmyjYdT2gbdbVfMyU8eKa6cUqYAy0HVlq30Vo3Z2/k3ySBc5oLDpT/b/DNzz
	aW8SV8ey+GB3nteJG/8A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZGuy-00013Q-FW; Tue, 18 Dec 2018 15:04:20 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZGuI-0000NF-0R
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 15:03:52 +0000
Received: by mail-pg1-x544.google.com with SMTP id m1so6302873pgq.8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 07:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=v4xtujsTt51xjeBlCqtpiwVFI+MMIJI2gQm9S+Vb5IU=;
 b=HxFWH4zm9VyHcUeDTZblNdLNCFIFYBvQP8phho0YEoV5uUBZEwyn5+5UpHrA4BGx3v
 HIJ7xsbJfRAJCjM3EBpkpVyiAe9jvDGR93r709LHS3Vz94eC8Gcyd7HDu4dpiaUFHlc6
 C50+uBYf8TfYjB+jOhBR45/RZmhBtTF17wpqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=v4xtujsTt51xjeBlCqtpiwVFI+MMIJI2gQm9S+Vb5IU=;
 b=eLFNw6RTzwta1lpk+G1hoCWJGxcnXch5OUtQykHKsShNCrjWJUtTfRWcQKdyc6dXf+
 3pYDB1UQr5T3hfKEPHA+EOBTcVAK0jnv5oYUJx0nGZh0K9jXOHCjkFTKPli3Nc2oCEHv
 94tBl/ghZCuQ1+mT09EbwDZ2I89nwa+7GgTWHd7qcPYKsMyAZa/UDfsO/7A0pDc1pULP
 iNQsBK1dvl6GVwlaXd9ogevcFVA4/b1XE3r6ERJhA4L1eU4CgOl3VvDme4ZtwICnfowh
 JbLDTJyrIJJLH3hcMv4WqbjMlcrbWVLOBTjEcz/j63B7oFK8B4ExhJDHui+/BflPDkoC
 Xa4g==
X-Gm-Message-State: AA+aEWYYTwEFnYHWVZwCsaTOKD1arfVmO5OS90ZYCLQFP/8MCcz3x/dy
 wWLjaQn9Nipie1qdBG2Gj0ly
X-Google-Smtp-Source: AFSGD/UAt/kBd75XrEij9wrxXhvukgdaTY0LbjlzDw7TVjbsxIgsotbZ65cNJ7Q/G55S+0PxajBOzQ==
X-Received: by 2002:a63:7c41:: with SMTP id l1mr15797012pgn.45.1545145407166; 
 Tue, 18 Dec 2018 07:03:27 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
 by smtp.gmail.com with ESMTPSA id m198sm28798688pga.10.2018.12.18.07.03.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Dec 2018 07:03:26 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: olof@lixom.net, arnd@arndb.de, arm@kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 04/11] ARM: dts: Add devicetree for RDA8810PL SoC
Date: Tue, 18 Dec 2018 20:32:31 +0530
Message-Id: <20181218150238.23010-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218150238.23010-1-manivannan.sadhasivam@linaro.org>
References: <20181218150238.23010-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_070338_411941_B51FAF31 
X-CRM114-Status: GOOD (  13.65  )
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
Cc: devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
 linus.walleij@linaro.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-kernel@vger.kernel.org, amit.kucheria@linaro.org,
 linux-unisoc@lists.infradead.org, robh+dt@kernel.org,
 linux-serial@vger.kernel.org, jslaby@suse.com, afaerber@suse.de,
 zhao_steven@263.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QWRkIGluaXRpYWwgZGV2aWNlIHRyZWUgZm9yIFJEQTg4MTBQTCBTb0MgZnJvbSBSREEgTWljcm9l
bGVjdHJvbmljcy4KClNpZ25lZC1vZmYtYnk6IEFuZHJlYXMgRsOkcmJlciA8YWZhZXJiZXJAc3Vz
ZS5kZT4KU2lnbmVkLW9mZi1ieTogTWFuaXZhbm5hbiBTYWRoYXNpdmFtIDxtYW5pdmFubmFuLnNh
ZGhhc2l2YW1AbGluYXJvLm9yZz4KQWNrZWQtYnk6IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIu
ZGU+Ci0tLQogYXJjaC9hcm0vYm9vdC9kdHMvcmRhODgxMHBsLmR0c2kgfCA4NiArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDg2IGluc2VydGlvbnMoKykK
IGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybS9ib290L2R0cy9yZGE4ODEwcGwuZHRzaQoKZGlm
ZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL3JkYTg4MTBwbC5kdHNpIGIvYXJjaC9hcm0vYm9v
dC9kdHMvcmRhODgxMHBsLmR0c2kKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAw
MDAwLi4xNTU0N2IxMzg5NzcKLS0tIC9kZXYvbnVsbAorKysgYi9hcmNoL2FybS9ib290L2R0cy9y
ZGE4ODEwcGwuZHRzaQpAQCAtMCwwICsxLDg2IEBACisvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmll
cjogKEdQTC0yLjArIE9SIE1JVCkKKy8qCisgKiBSREE4ODEwUEwgU29DCisgKgorICogQ29weXJp
Z2h0IChjKSAyMDE3IEFuZHJlYXMgRsOkcmJlcgorICogQ29weXJpZ2h0IChjKSAyMDE4IE1hbml2
YW5uYW4gU2FkaGFzaXZhbQorICovCisKKy8geworCWNvbXBhdGlibGUgPSAicmRhLDg4MTBwbCI7
CisJaW50ZXJydXB0LXBhcmVudCA9IDwmaW50Yz47CisJI2FkZHJlc3MtY2VsbHMgPSA8MT47CisJ
I3NpemUtY2VsbHMgPSA8MT47CisKKwljcHVzIHsKKwkJI2FkZHJlc3MtY2VsbHMgPSA8MT47CisJ
CSNzaXplLWNlbGxzID0gPDA+OworCisJCWNwdUAwIHsKKwkJCWRldmljZV90eXBlID0gImNwdSI7
CisJCQljb21wYXRpYmxlID0gImFybSxjb3J0ZXgtYTUiOworCQkJcmVnID0gPDB4MD47CisJCX07
CisJfTsKKworCXNyYW1AMTAwMDAwIHsKKwkJY29tcGF0aWJsZSA9ICJtbWlvLXNyYW0iOworCQly
ZWcgPSA8MHgxMDAwMDAgMHgxMDAwMD47CisJCSNhZGRyZXNzLWNlbGxzID0gPDE+OworCQkjc2l6
ZS1jZWxscyA9IDwxPjsKKwkJcmFuZ2VzOworCX07CisKKwlhcGJAMjA4MDAwMDAgeworCQljb21w
YXRpYmxlID0gInNpbXBsZS1idXMiOworCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsKKwkJI3NpemUt
Y2VsbHMgPSA8MT47CisJCXJhbmdlcyA9IDwweDAgMHgyMDgwMDAwMCAweDEwMDAwMD47CisKKwkJ
aW50YzogaW50ZXJydXB0LWNvbnRyb2xsZXJAMCB7CisJCQljb21wYXRpYmxlID0gInJkYSw4ODEw
cGwtaW50YyI7CisJCQlyZWcgPSA8MHgwIDB4MTAwMD47CisJCQlpbnRlcnJ1cHQtY29udHJvbGxl
cjsKKwkJCSNpbnRlcnJ1cHQtY2VsbHMgPSA8Mj47CisJCX07CisJfTsKKworCWFwYkAyMDkwMDAw
MCB7CisJCWNvbXBhdGlibGUgPSAic2ltcGxlLWJ1cyI7CisJCSNhZGRyZXNzLWNlbGxzID0gPDE+
OworCQkjc2l6ZS1jZWxscyA9IDwxPjsKKwkJcmFuZ2VzID0gPDB4MCAweDIwOTAwMDAwIDB4MTAw
MDAwPjsKKwl9OworCisJYXBiQDIwYTAwMDAwIHsKKwkJY29tcGF0aWJsZSA9ICJzaW1wbGUtYnVz
IjsKKwkJI2FkZHJlc3MtY2VsbHMgPSA8MT47CisJCSNzaXplLWNlbGxzID0gPDE+OworCQlyYW5n
ZXMgPSA8MHgwIDB4MjBhMDAwMDAgMHgxMDAwMDA+OworCisJCXVhcnQxOiBzZXJpYWxAMCB7CisJ
CQljb21wYXRpYmxlID0gInJkYSw4ODEwcGwtdWFydCI7CisJCQlyZWcgPSA8MHgwIDB4MTAwMD47
CisJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOworCQl9OworCisJCXVhcnQyOiBzZXJpYWxAMTAwMDAg
eworCQkJY29tcGF0aWJsZSA9ICJyZGEsODgxMHBsLXVhcnQiOworCQkJcmVnID0gPDB4MTAwMDAg
MHgxMDAwPjsKKwkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7CisJCX07CisKKwkJdWFydDM6IHNlcmlh
bEA5MDAwMCB7CisJCQljb21wYXRpYmxlID0gInJkYSw4ODEwcGwtdWFydCI7CisJCQlyZWcgPSA8
MHg5MDAwMCAweDEwMDA+OworCQkJc3RhdHVzID0gImRpc2FibGVkIjsKKwkJfTsKKwl9OworCisJ
bDI6IGNhY2hlLWNvbnRyb2xsZXJAMjExMDAwMDAgeworCQljb21wYXRpYmxlID0gImFybSxwbDMx
MC1jYWNoZSI7CisJCXJlZyA9IDwweDIxMTAwMDAwIDB4MTAwMD47CisJCWNhY2hlLXVuaWZpZWQ7
CisJCWNhY2hlLWxldmVsID0gPDI+OworCX07Cit9OwotLSAKMi4xNy4xCgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWls
aW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
