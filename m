Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8DEC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:31:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C7112082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e5o1iyGc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nIDv0Hn7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZRPxyo2z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C7112082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0RvpUw8ZaNZvMqCtlxKo8gohW+WnmqYICkJMWZiDefM=; b=e5o1iyGcBb2Xsh
	UTDT0WyTRZv9ot7UvG5ydXMUS+2E3ma27XWjVN8k2AKRRqIqipJPNWbycVDXVeuhh9h1V367zHZCT
	nsfyzjDVM4xDJDK+Xf5fr7wtjdMDP3D/vev7YoKo0nqUtanjFznTa7cn0NogCumgT2svGfbJp1Tby
	kKHKzJJVl6qGk4AI0cqWfSUxb4sP2Ccm0Q27TaFNtFDxFsu8SniFq+5u3T4dRZLkRz08ogMyjK15C
	FIkKo0y0wiy+pabki/12h74mZTxK67Tegr30eOlN36EcFowliAgMDupDHJ8oCPzCCpKCogsmRl0FT
	gbtJCSVp9JMVNM82L2lg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWQLI-0006Tk-8U; Mon, 10 Dec 2018 18:31:44 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWQL6-0006HR-S3
 for linux-arm-kernel@bombadil.infradead.org; Mon, 10 Dec 2018 18:31:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KIbCrv6kxd+jKuB+Z655EDqVYRNgXku8ohIbZgJ20mM=; b=nIDv0Hn76zfZFtiEV3t7aW+LND
 8L35+Rw/fVeOl7P7FkNfK4JS+uYznrH9V9wuE2LPImT6xEaUlmULEafprZN0YUuV5JPYowYfX9tQG
 QLtXx+I4qtHWOOmwCzQeYXmUTjGr7xfIdN4coxDFu+b6JUXgF/BT59KKUyjjKb71Sot8YnDiL/s8R
 FET2qL398vkDOvmZf6fOWm0BJ3xCivubAx3DTytnJ/lZ54ACgrHbqkOQ+oAzPorgZ0ga0gPm/P9TX
 WstvVovJRrptieH5+/0A+XkQDAWOv772O/8+wFY/d9bQo48SfcEgUzHISZqIXXZ9EkKQUMVjUxwe+
 mUh4lxmg==;
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWPUc-0005mQ-JJ
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 17:37:19 +0000
Received: by mail-pf1-x441.google.com with SMTP id c123so5743045pfb.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 09:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KIbCrv6kxd+jKuB+Z655EDqVYRNgXku8ohIbZgJ20mM=;
 b=ZRPxyo2zGSkOcBSGXrLTPsyinQ6P17sQYCJvUWjiXwmwT74RFHgz7X57daD7YmwgzX
 ZtexgVCNfkVxz82UizIMCUz/1zzmbIC9wGECCFVSwIvAPLwUKhjsFKbWqKkArHL6FgoI
 sYTSI6gLwi8oMawAa4OIfsFh/Jb24VFHbaxAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KIbCrv6kxd+jKuB+Z655EDqVYRNgXku8ohIbZgJ20mM=;
 b=WNygQQ5J36TltctfkVc44a5CGCVq58fW+TeMIHDblzVSrWx+rV8ZMthiDjXbEeqNi7
 IFiTODxevx72I9ruGLnehNVoV70ryucX5xJQG7pQg9ZibHTutffUZAVaeGX/i4iaoraD
 /Ab+PNvzLtU+5jquJO13dwxaS+g2urTb8KpQ1rNE8w0GycrX7xGwy2sOJy01haeq63Wv
 Ixs3pz8SEFLnYMgDg+CR7shWTUn9HSnP7u8F8bbA6moy2K5sTkWf4OLv5lLCaUhn08Qz
 VA6s+K945gTFY9u8xFu/thxMRMzeiZcmgv6Ny3NKEuDKKTAc3cYECqcouVGn8fH/dCFb
 j14Q==
X-Gm-Message-State: AA+aEWYg+a7lIFrRLJjo7IIa/Svq/L2QvTDtSK5Ae1xiI4P04ROeacNZ
 yfgaRJbfge7VEjd+CQHU+NLP
X-Google-Smtp-Source: AFSGD/UDpibuiqyGmYDVZAmSvbl9AYGGt2C+azqUEAanptdoxG9VicS7YbIrgv9QlL1kEXtyuKZ9Og==
X-Received: by 2002:a63:4b60:: with SMTP id k32mr11526285pgl.186.1544463423895; 
 Mon, 10 Dec 2018 09:37:03 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:91e:2c01:40e1:a028:b090:9e12])
 by smtp.gmail.com with ESMTPSA id q1sm15998396pfb.96.2018.12.10.09.36.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 09:37:03 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org, tglx@linutronix.de,
 jason@lakedaemon.net, marc.zyngier@arm.com, daniel.lezcano@linaro.org,
 gregkh@linuxfoundation.org, jslaby@suse.com
Subject: [PATCH v4 07/15] ARM: dts: Add devicetree for OrangePi i96 board
Date: Mon, 10 Dec 2018 23:05:42 +0530
Message-Id: <20181210173550.29643-8-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181210173550.29643-1-manivannan.sadhasivam@linaro.org>
References: <20181210173550.29643-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_123718_660513_E5266589 
X-CRM114-Status: GOOD (  16.42  )
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

QWRkIGluaXRpYWwgZGV2aWNldHJlZSBmb3IgT3JhbmdlIFBpIGk5NiBib2FyZCBmcm9tIFh1bmxv
bmcuIEl0CmlzIG9uZSBvZiB0aGUgOTZCb2FyZHMgSW9UIEVkaXRpb24gYm9hcmQuCgpTaWduZWQt
b2ZmLWJ5OiBBbmRyZWFzIEbDpHJiZXIgPGFmYWVyYmVyQHN1c2UuZGU+ClNpZ25lZC1vZmYtYnk6
IE1hbml2YW5uYW4gU2FkaGFzaXZhbSA8bWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFyby5vcmc+
Ci0tLQogYXJjaC9hcm0vYm9vdC9kdHMvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgfCAgMyAr
LQogYXJjaC9hcm0vYm9vdC9kdHMvcmRhODgxMHBsLW9yYW5nZXBpLWk5Ni5kdHMgfCA1MCArKysr
KysrKysrKysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCA1MiBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pCiBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm0vYm9vdC9kdHMvcmRhODgxMHBs
LW9yYW5nZXBpLWk5Ni5kdHMKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9NYWtlZmls
ZSBiL2FyY2gvYXJtL2Jvb3QvZHRzL01ha2VmaWxlCmluZGV4IGEwZmRhZDhmMTBkZC4uY2ZiMDhl
YTMzODcyIDEwMDY0NAotLS0gYS9hcmNoL2FybS9ib290L2R0cy9NYWtlZmlsZQorKysgYi9hcmNo
L2FybS9ib290L2R0cy9NYWtlZmlsZQpAQCAtODA3LDcgKzgwNyw4IEBAIGR0Yi0kKENPTkZJR19B
UkNIX1FDT00pICs9IFwKIAlxY29tLW1zbTg5NzQtc29ueS14cGVyaWEtaG9uYW1pLmR0YiBcCiAJ
cWNvbS1tZG05NjE1LXdwODU0OC1tYW5nb2gtZ3JlZW4uZHRiCiBkdGItJChDT05GSUdfQVJDSF9S
REEpICs9IFwKLQlyZGE4ODEwcGwtb3JhbmdlcGktMmctaW90LmR0YgorCXJkYTg4MTBwbC1vcmFu
Z2VwaS0yZy1pb3QuZHRiIFwKKwlyZGE4ODEwcGwtb3JhbmdlcGktaTk2LmR0YgogZHRiLSQoQ09O
RklHX0FSQ0hfUkVBTFZJRVcpICs9IFwKIAlhcm0tcmVhbHZpZXctcGIxMTc2LmR0YiBcCiAJYXJt
LXJlYWx2aWV3LXBiMTFtcC5kdGIgXApkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvcmRh
ODgxMHBsLW9yYW5nZXBpLWk5Ni5kdHMgYi9hcmNoL2FybS9ib290L2R0cy9yZGE4ODEwcGwtb3Jh
bmdlcGktaTk2LmR0cwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMDAuLjcy
OGY3NjkzMWI5OQotLS0gL2Rldi9udWxsCisrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL3JkYTg4MTBw
bC1vcmFuZ2VwaS1pOTYuZHRzCkBAIC0wLDAgKzEsNTAgQEAKKy8vIFNQRFgtTGljZW5zZS1JZGVu
dGlmaWVyOiAoR1BMLTIuMCsgT1IgTUlUKQorLyoKKyAqIENvcHlyaWdodCAoYykgMjAxNyBBbmRy
ZWFzIEbDpHJiZXIKKyAqIENvcHlyaWdodCAoYykgMjAxOCBNYW5pdmFubmFuIFNhZGhhc2l2YW0K
KyAqLworCisvZHRzLXYxLzsKKworI2luY2x1ZGUgInJkYTg4MTBwbC5kdHNpIgorCisvIHsKKwlj
b21wYXRpYmxlID0gInh1bmxvbmcsb3JhbmdlcGktaTk2IiwgInJkYSw4ODEwcGwiOworCW1vZGVs
ID0gIk9yYW5nZSBQaSBpOTYiOworCisJYWxpYXNlcyB7CisJCXNlcmlhbDAgPSAmdWFydDI7CisJ
CXNlcmlhbDEgPSAmdWFydDE7CisJCXNlcmlhbDIgPSAmdWFydDM7CisJfTsKKworCWNob3NlbiB7
CisJCXN0ZG91dC1wYXRoID0gInNlcmlhbDI6OTIxNjAwbjgiOworCX07CisKKwltZW1vcnlAODAw
MDAwMDAgeworCQlkZXZpY2VfdHlwZSA9ICJtZW1vcnkiOworCQlyZWcgPSA8MHg4MDAwMDAwMCAw
eDEwMDAwMDAwPjsKKwl9OworCisJdWFydF9jbGs6IHVhcnQtY2xrIHsKKwkJY29tcGF0aWJsZSA9
ICJmaXhlZC1jbG9jayI7CisJCWNsb2NrLWZyZXF1ZW5jeSA9IDw5MjE2MDA+OworCQkjY2xvY2st
Y2VsbHMgPSA8MD47CisJfTsKK307CisKKyZ1YXJ0MSB7CisJc3RhdHVzID0gIm9rYXkiOworCWNs
b2NrcyA9IDwmdWFydF9jbGs+OworfTsKKworJnVhcnQyIHsKKwlzdGF0dXMgPSAib2theSI7CisJ
Y2xvY2tzID0gPCZ1YXJ0X2Nsaz47Cit9OworCismdWFydDMgeworCXN0YXR1cyA9ICJva2F5IjsK
KwljbG9ja3MgPSA8JnVhcnRfY2xrPjsKK307Ci0tIAoyLjE3LjEKCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcg
bGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
