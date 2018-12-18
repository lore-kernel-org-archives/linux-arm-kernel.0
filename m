Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E7DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:04:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8670E21852
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pyu3tjVa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eD+V7KxZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8670E21852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UFtcWgEyXRz/H4MRDHuaX/vF2r09RQLpIIvs1as11eo=; b=pyu3tjVarvCvAr
	thtblfzlDfDeIYVJqetNRxVQzdwxTmeITLeycoRRRRjQoaT0D8+UZbutH//M8GBay0eayEm91Be07
	NJk4QaHqTAzq82KExte8e7OE+KFevWE+6924XI4ZeJt5TX0PynD+Dsh/Bejf5k/uzHwH0pNjMEQ72
	zZRpoKadVK9j/4bmO9BD8FpJdIvcDQ23f/XdIqFIfaW9L/2CYoiF75B/J8CN78PH8qHxglY6rcqFv
	S2m6hZNmDbwqiEMUreBW/Nfdcbn+In0LkGmPVAvI5PJEamKb/pICRvmmocBpqAUnmkWl2hFSH0/Fd
	xNaSgSvIx+hupmk7MQ4A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZGvS-0001Vk-Vy; Tue, 18 Dec 2018 15:04:50 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZGuS-0000Yf-3m
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 15:04:06 +0000
Received: by mail-pg1-x543.google.com with SMTP id v28so7926679pgk.10
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 07:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Auk2XhMMEToip2KKbDHncAZfukq8/UgpgNfIt0Pzr7k=;
 b=eD+V7KxZyfplaiikOGHEny17DLB002K4PPJd22DBzjlyRGHLiWc4KzF61xHvSji3zM
 lkEbs2K4r464GiJx9nkp8lydkKTl8UzKwdcXjHPu/+xKzPxYo1ORcdt7QgDbWvQqnCin
 2h7ZgxhFlv336oNVWV+FKF5sEuXTmlykTV/EQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Auk2XhMMEToip2KKbDHncAZfukq8/UgpgNfIt0Pzr7k=;
 b=B/Zbb3QTO3wuU7bly3vek4GZsXxrxd6hfjV2TnX2nZ5+srVe5U6o0t7Z/KosR+F1Z5
 gagB9rkt640zOoHDOS/gMF9fDHBMldiTtX0lN8a/rRyxYBpa0BE5uMrLxU9tzFslVdci
 7zTv5zaXki4ikhsUYCaH6QVHNn6ksXVibyN6Wkxd7mRs9hQUcvG1m3oDdLVgLR7c8YKS
 fiVmlCpCicJtHNNWHKFUW7Nn0WdfSKYyBKixwr2x6oPmBohoukkoWAVpQdEqlULY0s4V
 7MTMEZ4gV8z8yz0HQeeBIdXABszAhuMRubU99WQm+6XhMkAseOOlvSoUA7KXwoTlbjNM
 0krA==
X-Gm-Message-State: AA+aEWb5o4BVChB+CvKXBoTN1M8ns1N+XkNWEY6xlCzmdOuTYQVQW8IW
 63zZ91FrI4dnEKiGxskFCkL5
X-Google-Smtp-Source: AFSGD/V6ZNPnQdNlACM329WNhwzrBru0FdVcxU85XT+R7LEKj0do9AljsFCWmgbIyvPT96vBVl2h0g==
X-Received: by 2002:a62:cd1:: with SMTP id 78mr1804653pfm.219.1545145416963;
 Tue, 18 Dec 2018 07:03:36 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
 by smtp.gmail.com with ESMTPSA id m198sm28798688pga.10.2018.12.18.07.03.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Dec 2018 07:03:36 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: olof@lixom.net, arnd@arndb.de, arm@kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 05/11] ARM: dts: Add devicetree for OrangePi 2G IoT board
Date: Tue, 18 Dec 2018 20:32:32 +0530
Message-Id: <20181218150238.23010-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218150238.23010-1-manivannan.sadhasivam@linaro.org>
References: <20181218150238.23010-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_070348_724767_1A61891B 
X-CRM114-Status: GOOD (  14.56  )
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

QWRkIGluaXRpYWwgZGV2aWNldHJlZSBzdXBwb3J0IGZvciBPcmFuZ2VQaSAyRyBJb1QgYm9hcmQg
ZnJvbSBYdW5sb25nLgoKU2lnbmVkLW9mZi1ieTogQW5kcmVhcyBGw6RyYmVyIDxhZmFlcmJlckBz
dXNlLmRlPgpTaWduZWQtb2ZmLWJ5OiBNYW5pdmFubmFuIFNhZGhhc2l2YW0gPG1hbml2YW5uYW4u
c2FkaGFzaXZhbUBsaW5hcm8ub3JnPgpBY2tlZC1ieTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5k
Yi5kZT4KLS0tCiBhcmNoL2FybS9ib290L2R0cy9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAg
fCAgMiArCiAuLi4vYm9vdC9kdHMvcmRhODgxMHBsLW9yYW5nZXBpLTJnLWlvdC5kdHMgICAgfCA1
MCArKysrKysrKysrKysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDUyIGluc2VydGlvbnMoKykK
IGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybS9ib290L2R0cy9yZGE4ODEwcGwtb3JhbmdlcGkt
MmctaW90LmR0cwoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL01ha2VmaWxlIGIvYXJj
aC9hcm0vYm9vdC9kdHMvTWFrZWZpbGUKaW5kZXggYjBlOTY2ZDYyNWI5Li5hMGZkYWQ4ZjEwZGQg
MTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL01ha2VmaWxlCisrKyBiL2FyY2gvYXJtL2Jv
b3QvZHRzL01ha2VmaWxlCkBAIC04MDYsNiArODA2LDggQEAgZHRiLSQoQ09ORklHX0FSQ0hfUUNP
TSkgKz0gXAogCXFjb20tbXNtODk3NC1zb255LXhwZXJpYS1jYXN0b3IuZHRiIFwKIAlxY29tLW1z
bTg5NzQtc29ueS14cGVyaWEtaG9uYW1pLmR0YiBcCiAJcWNvbS1tZG05NjE1LXdwODU0OC1tYW5n
b2gtZ3JlZW4uZHRiCitkdGItJChDT05GSUdfQVJDSF9SREEpICs9IFwKKwlyZGE4ODEwcGwtb3Jh
bmdlcGktMmctaW90LmR0YgogZHRiLSQoQ09ORklHX0FSQ0hfUkVBTFZJRVcpICs9IFwKIAlhcm0t
cmVhbHZpZXctcGIxMTc2LmR0YiBcCiAJYXJtLXJlYWx2aWV3LXBiMTFtcC5kdGIgXApkaWZmIC0t
Z2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvcmRhODgxMHBsLW9yYW5nZXBpLTJnLWlvdC5kdHMgYi9h
cmNoL2FybS9ib290L2R0cy9yZGE4ODEwcGwtb3JhbmdlcGktMmctaW90LmR0cwpuZXcgZmlsZSBt
b2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMDAuLjk4ZTM0MjQ4YWU4MAotLS0gL2Rldi9udWxs
CisrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL3JkYTg4MTBwbC1vcmFuZ2VwaS0yZy1pb3QuZHRzCkBA
IC0wLDAgKzEsNTAgQEAKKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMCsgT1Ig
TUlUKQorLyoKKyAqIENvcHlyaWdodCAoYykgMjAxNyBBbmRyZWFzIEbDpHJiZXIKKyAqIENvcHly
aWdodCAoYykgMjAxOCBNYW5pdmFubmFuIFNhZGhhc2l2YW0KKyAqLworCisvZHRzLXYxLzsKKwor
I2luY2x1ZGUgInJkYTg4MTBwbC5kdHNpIgorCisvIHsKKwljb21wYXRpYmxlID0gInh1bmxvbmcs
b3JhbmdlcGktMmctaW90IiwgInJkYSw4ODEwcGwiOworCW1vZGVsID0gIk9yYW5nZSBQaSAyRy1J
b1QiOworCisJYWxpYXNlcyB7CisJCXNlcmlhbDAgPSAmdWFydDE7CisJCXNlcmlhbDEgPSAmdWFy
dDI7CisJCXNlcmlhbDIgPSAmdWFydDM7CisJfTsKKworCWNob3NlbiB7CisJCXN0ZG91dC1wYXRo
ID0gInNlcmlhbDI6OTIxNjAwbjgiOworCX07CisKKwltZW1vcnlAODAwMDAwMDAgeworCQlkZXZp
Y2VfdHlwZSA9ICJtZW1vcnkiOworCQlyZWcgPSA8MHg4MDAwMDAwMCAweDEwMDAwMDAwPjsKKwl9
OworCisJdWFydF9jbGs6IHVhcnQtY2xrIHsKKwkJY29tcGF0aWJsZSA9ICJmaXhlZC1jbG9jayI7
CisJCWNsb2NrLWZyZXF1ZW5jeSA9IDw5MjE2MDA+OworCQkjY2xvY2stY2VsbHMgPSA8MD47CisJ
fTsKK307CisKKyZ1YXJ0MSB7CisJc3RhdHVzID0gIm9rYXkiOworCWNsb2NrcyA9IDwmdWFydF9j
bGs+OworfTsKKworJnVhcnQyIHsKKwlzdGF0dXMgPSAib2theSI7CisJY2xvY2tzID0gPCZ1YXJ0
X2Nsaz47Cit9OworCismdWFydDMgeworCXN0YXR1cyA9ICJva2F5IjsKKwljbG9ja3MgPSA8JnVh
cnRfY2xrPjsKK307Ci0tIAoyLjE3LjEKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
