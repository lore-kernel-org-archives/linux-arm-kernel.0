Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9242DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:08:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5751A21841
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iEiL0Ear";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MffBEizv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5751A21841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lXmsnqrEsDrRgHEYqkioE8uRsXYCyMPdtkypC0xwneU=; b=iEiL0EarWX9Otk
	TaykaBXV6R8OFseMnS/wDB0Atz2c9HcmPUugY+AN8a84Sz2HFLgDYt5yYj9Tv3dNSfWW62SqgFXHz
	jBBBcuWFexELY2PU1rb3uMc18gGc4lQrcB2I7kIpM1yK+4yLOneF2To2NVdUQi2iqtuizSMwKxUb/
	e60GzdVczZV6/2xBQbnGYupsdtRGDMQLXmN0S1uwk8J7VWUDX5HQ63sm39gK++Ra5QzyBUTBjp5FL
	HZSjxGLyqlnKRy5bT8lrAmK4iBkI1nkcXk4XnxmIAM1QtQKVhYMh4B3sFB42L2V5UI3OYYUa+X+YU
	kxQloHzD1KHSSn8jdATA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZAQG-0000yu-Kp; Tue, 18 Dec 2018 08:08:12 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZAOs-0008DV-2s
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 08:06:55 +0000
Received: by mail-pf1-x442.google.com with SMTP id r136so700208pfc.6
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 00:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=M9evsXiKq/f6/hJaxP4dc1I6TBIm55n2snnXtgBmQsE=;
 b=MffBEizv6QiHPXKM+e83ZEZYoA1KC9gItgx0iSi6G9oDgRiYQnnfjrzgN318hsMC6Q
 IAT/Dh47Ks5pu8Svd/hK5ftpbrerRHcw0Yx0c+gkDdMnFaaC+zlFJhVyyYxmS+pLFsFS
 C0G6pDISGRxdKXI33oemt2XsNEqhF2assGZ5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=M9evsXiKq/f6/hJaxP4dc1I6TBIm55n2snnXtgBmQsE=;
 b=kBqZDaF75+7g483wbEooxehB35E8sFWK+ebdMj4+cwG59YLsdM89wXO2BRAi6uf20Y
 nW0q5lGsSlTS89U5/vxLZ6wSflUmu609p4DsgSZhav4xQqCiIJkmNuIzYi4t6mGN1+ZU
 cFQl8pQP31A6RDA21VVtci2RVv5MJjlU7sbG8yLImXIjiaXcQpi7nRPAZ4FC2KY56WSk
 oLDQLjTGDJwvlOyPCqF7fwayWta7YrBpKDn0qQafK14+oS+xQWp3dJWlO9regZNONeV9
 vcbDqzfObmJZfi7Ay+q+qnEgb1UBklTn/Sds8wFkqQNIfi6tzM/KbjfwWPg7VqtadLc1
 rYDg==
X-Gm-Message-State: AA+aEWbZ9sBtbvMm9A/Mgdlk7ON3sgiYE9SmSxnNCfkP7eoTtmxqTzc0
 E3amAcD9NlNbF2Sn33LeNSMC
X-Google-Smtp-Source: AFSGD/V6n1jxQwzQiBjKKv+Wv2LUsskRd42kelksznlZGgsorN8iYDlrqQsF1sr29BaKb2nkjlvvMw==
X-Received: by 2002:a62:1e45:: with SMTP id e66mr15627883pfe.152.1545120395371; 
 Tue, 18 Dec 2018 00:06:35 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
 by smtp.gmail.com with ESMTPSA id 7sm45596888pfm.8.2018.12.18.00.06.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Dec 2018 00:06:34 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
 gregkh@linuxfoundation.org, jslaby@suse.com
Subject: [PATCH v6 07/11] ARM: dts: rda8810pl: Add timer support
Date: Tue, 18 Dec 2018 13:35:23 +0530
Message-Id: <20181218080527.10801-8-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218080527.10801-1-manivannan.sadhasivam@linaro.org>
References: <20181218080527.10801-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_000646_432532_657A5C8E 
X-CRM114-Status: GOOD (  12.06  )
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

QWRkIHRpbWVyIHN1cHBvcnQgZm9yIFJEQSBNaWNybyBSREE4ODEwUEwgU29DLgoKU2lnbmVkLW9m
Zi1ieTogQW5kcmVhcyBGw6RyYmVyIDxhZmFlcmJlckBzdXNlLmRlPgpTaWduZWQtb2ZmLWJ5OiBN
YW5pdmFubmFuIFNhZGhhc2l2YW0gPG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnPgot
LS0KIGFyY2gvYXJtL2Jvb3QvZHRzL3JkYTg4MTBwbC5kdHNpIHwgMTAgKysrKysrKysrKwogMSBm
aWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290
L2R0cy9yZGE4ODEwcGwuZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL3JkYTg4MTBwbC5kdHNpCmlu
ZGV4IDE1NTQ3YjEzODk3Ny4uODRiYWE0YzBhMTRjIDEwMDY0NAotLS0gYS9hcmNoL2FybS9ib290
L2R0cy9yZGE4ODEwcGwuZHRzaQorKysgYi9hcmNoL2FybS9ib290L2R0cy9yZGE4ODEwcGwuZHRz
aQpAQCAtNiw2ICs2LDggQEAKICAqIENvcHlyaWdodCAoYykgMjAxOCBNYW5pdmFubmFuIFNhZGhh
c2l2YW0KICAqLwogCisjaW5jbHVkZSA8ZHQtYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIv
aXJxLmg+CisKIC8gewogCWNvbXBhdGlibGUgPSAicmRhLDg4MTBwbCI7CiAJaW50ZXJydXB0LXBh
cmVudCA9IDwmaW50Yz47CkBAIC01MCw2ICs1MiwxNCBAQAogCQkjYWRkcmVzcy1jZWxscyA9IDwx
PjsKIAkJI3NpemUtY2VsbHMgPSA8MT47CiAJCXJhbmdlcyA9IDwweDAgMHgyMDkwMDAwMCAweDEw
MDAwMD47CisKKwkJdGltZXJAMTAwMDAgeworCQkJY29tcGF0aWJsZSA9ICJyZGEsODgxMHBsLXRp
bWVyIjsKKwkJCXJlZyA9IDwweDEwMDAwIDB4MTAwMD47CisJCQlpbnRlcnJ1cHRzID0gPDE2IElS
UV9UWVBFX0xFVkVMX0hJR0g+LAorCQkJCSAgICAgPDE3IElSUV9UWVBFX0xFVkVMX0hJR0g+Owor
CQkJaW50ZXJydXB0LW5hbWVzID0gImh3dGltZXIiLCAib3N0aW1lciI7CisJCX07CiAJfTsKIAog
CWFwYkAyMGEwMDAwMCB7Ci0tIAoyLjE3LjEKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
