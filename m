Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53360C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:07:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FA6D2133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cKwYN1jm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dr0EVT+O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FA6D2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0RvpUw8ZaNZvMqCtlxKo8gohW+WnmqYICkJMWZiDefM=; b=cKwYN1jmhoDFfV
	yN5coIShJ4/M79xDC9nVotnrSJUFkodVOg4ZG2qhuVk1KXZcsnLWRyd3ZoI55IAK5a7BTAKYjE+dV
	8axZBQ15kIQgyLxBpmJ3T4QRovEY2Y4olwuYKYLy52Q2vizrb6lQ2SlDP0t9ibhnVr73TTvCIci0o
	eUA++dBszwjf6Sz0SfkpX4Q5P3lRIzHQBrKp7rDZ/JDoaQmOrPDVpVGGEEvf4IYFPSXmVo7sVV++9
	3i6kg1u7mCuUUaW7k/zGP78SUsd3/+xyZ5SGX5dWXMI5fGQOhWCII+i4muOyaCCzaSp2xzh6W/hbG
	6aF4Rqv4VQewKYzOK/aA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZAPj-0000Xe-1V; Tue, 18 Dec 2018 08:07:39 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZAOl-000880-Im
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 08:06:54 +0000
Received: by mail-pl1-x641.google.com with SMTP id e5so7468262plb.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 00:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KIbCrv6kxd+jKuB+Z655EDqVYRNgXku8ohIbZgJ20mM=;
 b=Dr0EVT+OfdgOd3vo+FXI4YpTZNroQuSRFkxLLwUs0bNV53QET8UOOVxhnHCEELmJLi
 FS9dh43kX898kswHwjWnvkJsM63YNgspkEYXi4bAly143zlm69aCuqnyPXQ/VotWZSBg
 UcJbCfxQyh2y9EVoCOpVgrZFbChPvIDmxBbMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KIbCrv6kxd+jKuB+Z655EDqVYRNgXku8ohIbZgJ20mM=;
 b=eJvEn9UF5+yGhvvNZlsDghIaD5TEPRoXqL8P36ebuOGwKAKLOouHVkVt3OGfA5A0d+
 8pwDPQ5jTrbeIeKBcb5wdKWbILPIAmb9kNKHz4igUVE4kFJxvsmE3QyWaAt/oetz5sBY
 Q4hZgZySD2MVBmmOwxIha5P7jQQ1cUFvtZ9hZ9kJbWqg5ZW9rpiNd99rSCbkdH7DXiGW
 O+o/QmE4JJ3WGGZ3I6mf1/IWD5742R2IE7SDtsqXb0RUYAuPSDXMUqUrIAfKCFinhTRa
 aLdlZFdNuLiHON4y3ccZemq0X4Ud/pS2UbnbiIn4nyXgRZf7DmexKKDvnSCQzuD5axwH
 +ZQw==
X-Gm-Message-State: AA+aEWbx/zHkdWijKPBSc/jz0SQx3a+xhFEOs4uo2UsO6fZL5k+Ay3R/
 w2erChVeNNMS6hMzlmAnNjYR
X-Google-Smtp-Source: AFSGD/Xfz1iwkfX41/a4TTcw4HAnrY69fAz2xtFw9u9blKCVecgh9kZRARwZ/u0vciiAotjEz81A7Q==
X-Received: by 2002:a17:902:5a86:: with SMTP id
 r6mr14914715pli.301.1545120388928; 
 Tue, 18 Dec 2018 00:06:28 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
 by smtp.gmail.com with ESMTPSA id 7sm45596888pfm.8.2018.12.18.00.06.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Dec 2018 00:06:28 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
 gregkh@linuxfoundation.org, jslaby@suse.com
Subject: [PATCH v6 06/11] ARM: dts: Add devicetree for OrangePi i96 board
Date: Tue, 18 Dec 2018 13:35:22 +0530
Message-Id: <20181218080527.10801-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218080527.10801-1-manivannan.sadhasivam@linaro.org>
References: <20181218080527.10801-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_000639_876397_2687C0C8 
X-CRM114-Status: GOOD (  14.65  )
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
