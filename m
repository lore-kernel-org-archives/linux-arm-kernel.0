Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336D4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 04:32:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5984214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 04:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VXY346QZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gSHbfM69";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OQ25nOtS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5984214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0RvpUw8ZaNZvMqCtlxKo8gohW+WnmqYICkJMWZiDefM=; b=VXY346QZ33Ud4g
	DNosO63vbA5xvY9QhKysDwW65mZV9UyREuhK260eZSd5x1ZlG+EiaUwwNcZ8EpBM8KgkAglyflcZ8
	3obo927CxkC9BFh/nvSCiLblx87g8coE3GBFK2bsYehkFgUFXZmqL6CE5ZLF/+6mJyyB5xOPc3ZCA
	S7tqW2vLXxuUbi7tRqzpt6ZOq24541+vp68ksJncc5OdLN4N1t06VKE4173F34FVw4Ty0oX9HCWZW
	xyPWjI4oLjhTeGSD5K2XfSQYZqej1kvBy+HJtc4hjzNDSs0Zv/tjFAn6pMIdd2kwCelxO7/Uk1M7u
	NeMmGHvhu7sN5imzGjTA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZ73m-0003gS-EO; Tue, 18 Dec 2018 04:32:46 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZ73k-0003gJ-IT
 for linux-arm-kernel@bombadil.infradead.org; Tue, 18 Dec 2018 04:32:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KIbCrv6kxd+jKuB+Z655EDqVYRNgXku8ohIbZgJ20mM=; b=gSHbfM69iHQe19OoBa1u+Pos6q
 MBUVYGftlgqehU4GS1N+i3VgR5PztGbYQx33UKAlEgGLjqxq6RPu0HqYMq3xCPYSdxlOdjUdmniYb
 DcFwmJhVTc1PBr056mVjgdF6WLVsIPVAgD2mYwjX9PlTeGsH5Qcw6/JVCA6Q2w/xmzp0BkvVM6oQ6
 +bdMEDKP5VR4Ik+kFHHgPhbbfUSEQja5E/i15JmjGqN+RPNx/LUdk65fMPpL8SenzJFkHgn5QqKsb
 ch8i1KYPrORwfejMl3tHKXOWcYHjPHdfouh7LhHmZ2KXKOt6SVmQUdklpT2fI5oT8x8F/gzT7yPI3
 Q3K/H1Tw==;
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZ6Hd-0005Qu-OD
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 03:43:03 +0000
Received: by mail-pl1-x643.google.com with SMTP id y1so7133724plp.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 17 Dec 2018 19:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KIbCrv6kxd+jKuB+Z655EDqVYRNgXku8ohIbZgJ20mM=;
 b=OQ25nOtS0UyMunCAlfaR4TZTGa9gwOgUbHU4MJ4kZBfY3aOHyFBK4sz6iHOx2ECeG3
 r95OPHK/J72NNg/xqt5kp9BDVlARfZWSqeyEKt2vZjo3yBeb19gSP7hVtprRuq4s9TBj
 +zGuv9JePi/Y/rISflxHGrymlUx2gund69NQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KIbCrv6kxd+jKuB+Z655EDqVYRNgXku8ohIbZgJ20mM=;
 b=Prb752z7lgSqrPO5Cvxl/g8phZz44iW3S1WBQgKi2jwxQZCLf8qusxUaKtpwXq4drj
 Dofodnk+0eNJqZ0LzMEODd9orWd0qk1dHqveUsxJMihWeiaoW4N/fxVkDUTMdUXEomqp
 ZamdJXaj/dwXK8FAP8V1GIqzL9VzzZNr8XifOuY3yxoicZBsDE60Jal9mMRic77It2rm
 uj5vePWWrEdkvBVTnkKW+Uf8pWcQdrkYqW7veyala84slgnV07SvHHDNyj3Ag4lBVlX/
 gGEkTuX+di8jdlk2f/77ti0g3XZ8LaD5c4DyMJN2AE9jGi/mi01df1suA0Zj1GpRi8/m
 pVAw==
X-Gm-Message-State: AA+aEWbKzaLQKwApZz8nIbYGW15l6t/FgTqGiIbI5X2T3/RTm276QTml
 mNVu1AAWGtjfOWnoLyxrmKOy
X-Google-Smtp-Source: AFSGD/VrZtYb6gKnpDKFBHrzlOi9oDpadFddkPJ0J7KSi4c4sMX4mc3cHrGNXkmwgPFHCZ7OJGja6g==
X-Received: by 2002:a17:902:bf0c:: with SMTP id
 bi12mr15249168plb.0.1545104565617; 
 Mon, 17 Dec 2018 19:42:45 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
 by smtp.gmail.com with ESMTPSA id b202sm25255422pfb.88.2018.12.17.19.42.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Dec 2018 19:42:44 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
 gregkh@linuxfoundation.org, jslaby@suse.com
Subject: [PATCH v5 06/11] ARM: dts: Add devicetree for OrangePi i96 board
Date: Tue, 18 Dec 2018 09:11:27 +0530
Message-Id: <20181218034132.5070-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218034132.5070-1-manivannan.sadhasivam@linaro.org>
References: <20181218034132.5070-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_224301_832392_788FCC06 
X-CRM114-Status: GOOD (  16.60  )
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
