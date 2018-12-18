Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B23AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:59:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B57E217D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y9IFZfJF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NQELHiMe";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q6PtR9pA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B57E217D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Apn8zN6CftTK8rZAYTtk9VZu3GyvWUyf4h1HJ5U5AyU=; b=Y9IFZfJFy/1GXY
	nAQaxsSSW14g60VuGMNUi2G9qUzSn7xxUJEmKmFc/0sKuXkVb9BgBccSjq4fKT0Q6uEmzFoViWNpW
	N0H3QSchyODvb3PN7QnAxlZiwePfIXfbgAKIQuJrEPEmCNbZhj/OgnUdUynJMx/UhF96cnkgV/tdI
	sNFH7+HMKHjivO0b+Gg+6Tc80hJ/ey7XT+U4McadUYsEcQQdL3hg8vGyx3/9+Bz4NHMcKvMMfrHej
	Pv7WekZe0gy8GF+Lk6SdyOojxPbvIywYQlOeM9slS5d3mJ9Zf6UUeGGFhaogQF5bs2MesOvtL0rfr
	CuTCfWPkzl1QhPB9ximQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZ6XE-0005Qa-Fq; Tue, 18 Dec 2018 03:59:08 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZ6Wq-0004vb-2s
 for linux-arm-kernel@bombadil.infradead.org; Tue, 18 Dec 2018 03:58:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=D3bKyeo3jAVxlIMumLLKO1Nw9oQMRPP9y6vXm+NkQhc=; b=NQELHiMe0oSylQ7uqKDQugwClJ
 kzn6uWIPPr4c8nqRNDY5bYpTR0hC6G7uOx2WjGjpSdFhm7i6EgGvCZZJ9b9jmEbCEzMQ2wY/L1WEx
 oSh1cTZRug6VZ+A/7U/A2emHBmev8GTnk+piELcsrCmxepDYyS2DljYkVAgMgoq9oumZ1BxskK7Dw
 AFLouglPi6jz3ZwAtxvzMEsn4TvO/wkDNb8h0c3dYKD6J1pssYivbqlKYniHB9RXXMsU3TUDofHBW
 PHUfUJuMhWoAPY8ZYFbjZDM3BOEb9zY7UcdFq5h67ZQrIyYEncn5ILQ7cWe+klcCQ8sFePdbIck85
 TMItL8rg==;
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZ6Hx-000707-Cr
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 03:43:22 +0000
Received: by mail-pf1-x441.google.com with SMTP id c123so7443862pfb.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 17 Dec 2018 19:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=D3bKyeo3jAVxlIMumLLKO1Nw9oQMRPP9y6vXm+NkQhc=;
 b=Q6PtR9pAVXjj423b3NL5eKGkc0ulrDFggfzUPOVNkQHL8XKJTqcEyc4/vuvOy67ctZ
 y5n0fPopTsnoWebqLWbuY44NIcn8BUUyWASsyh6efdFo28r8bX0xaXagAiJ1lEKciVfM
 GacO5TpLBwujee+Wql4l/uwctm6idQzY/KBxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=D3bKyeo3jAVxlIMumLLKO1Nw9oQMRPP9y6vXm+NkQhc=;
 b=L3TB/2kGZ/T5XozApTiGRB8U8jhYEjjxj21vpJVGcZ9mqHzd24k68S3T0XhLUbygrj
 wHrLafTpf0s/2JXf7igkOo2gzpJh+FTMp3TPfbZ/CMBf/yJQ3Z0a07uprw6bh8Ca2BfT
 zkV/PacaD8Uh2NajHXrCyQsmFftY3Hm3zab4rpyX/1CCkDHjQc451qSt+pnDSsD6ESzT
 Nh8FnF9wIKmCWJIuDRzWbn/kz8xfefRNVv9OMeDsB32QXEDqZZG7qAvRcef7cabgvBlX
 V4zn6qNkGNrlpd9mAYGK1IGvkrU5gDmSqapGrghuie9vx+b91yKv4pgaE0IxLNw14/kk
 5+aA==
X-Gm-Message-State: AA+aEWbArwiPV+UykQtWldzyUMDEYjAVdUtBk21CwqJHqLBbubTKKKRz
 ud7B2DU7DjdRIGuqJ0HloreX
X-Google-Smtp-Source: AFSGD/UIi+PMaiuLib0DZL4C0r3MugYkv3oIsNK1WVEkrFGr56dpyzkkhrfqoWnq28RC4gIJ99rCJg==
X-Received: by 2002:a63:6b05:: with SMTP id g5mr13963311pgc.15.1545104589847; 
 Mon, 17 Dec 2018 19:43:09 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
 by smtp.gmail.com with ESMTPSA id b202sm25255422pfb.88.2018.12.17.19.43.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Dec 2018 19:43:09 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
 gregkh@linuxfoundation.org, jslaby@suse.com
Subject: [PATCH v5 09/11] ARM: dts: rda8810pl: Add interrupt support for UART
Date: Tue, 18 Dec 2018 09:11:30 +0530
Message-Id: <20181218034132.5070-10-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218034132.5070-1-manivannan.sadhasivam@linaro.org>
References: <20181218034132.5070-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_034321_463831_284C952A 
X-CRM114-Status: GOOD (  11.44  )
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

QWRkIGludGVycnVwdCBzdXBwb3J0IGZvciBVQVJUIGluIFJEQSBNaWNybyBSREE4ODEwUEwgU29D
LgoKU2lnbmVkLW9mZi1ieTogQW5kcmVhcyBGw6RyYmVyIDxhZmFlcmJlckBzdXNlLmRlPgpTaWdu
ZWQtb2ZmLWJ5OiBNYW5pdmFubmFuIFNhZGhhc2l2YW0gPG1hbml2YW5uYW4uc2FkaGFzaXZhbUBs
aW5hcm8ub3JnPgotLS0KIGFyY2gvYXJtL2Jvb3QvZHRzL3JkYTg4MTBwbC5kdHNpIHwgMyArKysK
IDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9i
b290L2R0cy9yZGE4ODEwcGwuZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL3JkYTg4MTBwbC5kdHNp
CmluZGV4IDg0YmFhNGMwYTE0Yy4uMTljZGU4OTViZjY1IDEwMDY0NAotLS0gYS9hcmNoL2FybS9i
b290L2R0cy9yZGE4ODEwcGwuZHRzaQorKysgYi9hcmNoL2FybS9ib290L2R0cy9yZGE4ODEwcGwu
ZHRzaQpAQCAtNzEsMTggKzcxLDIxIEBACiAJCXVhcnQxOiBzZXJpYWxAMCB7CiAJCQljb21wYXRp
YmxlID0gInJkYSw4ODEwcGwtdWFydCI7CiAJCQlyZWcgPSA8MHgwIDB4MTAwMD47CisJCQlpbnRl
cnJ1cHRzID0gPDkgSVJRX1RZUEVfTEVWRUxfSElHSD47CiAJCQlzdGF0dXMgPSAiZGlzYWJsZWQi
OwogCQl9OwogCiAJCXVhcnQyOiBzZXJpYWxAMTAwMDAgewogCQkJY29tcGF0aWJsZSA9ICJyZGEs
ODgxMHBsLXVhcnQiOwogCQkJcmVnID0gPDB4MTAwMDAgMHgxMDAwPjsKKwkJCWludGVycnVwdHMg
PSA8MTAgSVJRX1RZUEVfTEVWRUxfSElHSD47CiAJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOwogCQl9
OwogCiAJCXVhcnQzOiBzZXJpYWxAOTAwMDAgewogCQkJY29tcGF0aWJsZSA9ICJyZGEsODgxMHBs
LXVhcnQiOwogCQkJcmVnID0gPDB4OTAwMDAgMHgxMDAwPjsKKwkJCWludGVycnVwdHMgPSA8MTEg
SVJRX1RZUEVfTEVWRUxfSElHSD47CiAJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOwogCQl9OwogCX07
Ci0tIAoyLjE3LjEKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1hcm0ta2VybmVsCg==
