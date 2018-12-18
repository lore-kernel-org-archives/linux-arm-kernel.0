Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47E8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:20:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B113121850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pD+jl4EE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HvIXUpID";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DFFe5goN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B113121850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dXNN7cEOr/D6QEFQJ+5ROF0onBF0PB6AcN/us8lC6kQ=; b=pD+jl4EEUCMkNz
	S3UWFBNFONWjAx6Mxgl6vlJrJ6rPZKSqlfVHZIJBGIzunkToH1ZzRCBYf/fC0sRqRuD/ekamKoCK9
	b0P9pRc6ZJ2m/rrvEZ6NBKdQ7sIS8+HiT4Uf2KGTRSCCq/NwRPJfXYmj+WG8wKyxpyQAd0ndVtcGs
	PgT5Gs9OKxOOH0b78b2iF29nVV3iQOVEhjDpLECHhFfsNEUopgW/qwESMoiIYt/2MeltrDkoVL3Rm
	o1N2lGZRVr6+9cC3ws08vuJA5bRF7s6nH8S28tOCHDkbDSvznUxVE06G7VSd95KLWkFn96e+24fif
	x2RFK+JOHTnAPxgo3WSA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZHAb-0002hT-I5; Tue, 18 Dec 2018 15:20:29 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZHAC-0000ux-N4
 for linux-arm-kernel@bombadil.infradead.org; Tue, 18 Dec 2018 15:20:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HM6vGHLEYTQ34K9d+Cku5qQedHbZ76UdlqZjiEC2yYI=; b=HvIXUpIDS+wayiyGsaXSTxDjd0
 pBIXmg0/zDYpDqYuXsGupccq6erkQuOLguDLsceFW4s81xM1TxaOgnau+TEvGEF6cs/Q0mKMfXaJg
 BvZGC/bK5kQRi3yT5bUK5AryAQ4Btskx3k4IaYqHuYVHgzo8Jg7CcfwEb60GdWKVtz3ScixXJPSNm
 c5prsn2f/H2cExfViuWoRTpAcdNIXvbEFOAiV+KJjIxzIhs4eDPOPKmZ2oFJ9ptq+MncDLHi+bKTO
 xk1/3cjyvpCep7/uqpTLXUzYPDiNSC391huoF0eQMoLgzGAi3ZbjClYShg7Ihs7Lnrf5aT+ZOJvVj
 KX+E3YIw==;
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZGub-00058T-EA
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 15:03:59 +0000
Received: by mail-pl1-x643.google.com with SMTP id e5so7952580plb.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 07:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HM6vGHLEYTQ34K9d+Cku5qQedHbZ76UdlqZjiEC2yYI=;
 b=DFFe5goNJ8sL3mG1QL4BIapBIANcH2+8O3WOryVR7vnKWC/Ldpfg6UnIfIa7MBhDrL
 KNASmNqDLUPuxi/0dVrx4rvAqJ+ZLhtTQIcbpy8ekVH7jfP/YzbyhRibR4iAOwAh+kAY
 3MMucGr6nYYJzyr19GhReRznyqp4qrU6vM988=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HM6vGHLEYTQ34K9d+Cku5qQedHbZ76UdlqZjiEC2yYI=;
 b=ZgwBsPOxBjPceGCKZ2mnXec+9uiNW3PlDWmbjH49Wtyv6PktdeFushFkKB7aF2PlGQ
 KoUmOiG3Ty/ztoby4T+OQ/dQ4TDL02vLKsW7GsOGz6YkrM5NbGCC+d8DK/imKZIq2R0+
 E5WYtYjlxSwjqVz9UHbWH86PhD12l40xlcvvEbA0/ebnafoPyeFfwot4MNQQCYd+xTCv
 OtfJnOMR6Narl1V0kaGFdZXGwjIAqUsPDc5COXSb5j4dpmOJaZbfHNJvwui2JDATBGdA
 Xv7k1gUw0z+AzAmUwLtZh2NqwWfWDmuHiLRZbSvT4/+dg/psfd1l7sRepMlxCWuDJZ2w
 Do5g==
X-Gm-Message-State: AA+aEWYwxvWaZ52M8S7FdZFEXm2KFz89i4/D0z35qVjtVR9LTxELyDuq
 aQIPj4SJLdvrClQlnFB+VuOA
X-Google-Smtp-Source: AFSGD/W3FUXjOO3QZhHB/6lIBHHQPo9D7ENM/Sq4ljq3u2v/P6Oh1BEhCBqtGVfbZn6QaRpO9utmDw==
X-Received: by 2002:a17:902:59c8:: with SMTP id
 d8mr16783365plj.116.1545145425629; 
 Tue, 18 Dec 2018 07:03:45 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
 by smtp.gmail.com with ESMTPSA id m198sm28798688pga.10.2018.12.18.07.03.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Dec 2018 07:03:44 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: olof@lixom.net, arnd@arndb.de, arm@kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 06/11] ARM: dts: Add devicetree for OrangePi i96 board
Date: Tue, 18 Dec 2018 20:32:33 +0530
Message-Id: <20181218150238.23010-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218150238.23010-1-manivannan.sadhasivam@linaro.org>
References: <20181218150238.23010-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_150357_484100_904C1D41 
X-CRM114-Status: GOOD (  15.98  )
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

QWRkIGluaXRpYWwgZGV2aWNldHJlZSBmb3IgT3JhbmdlIFBpIGk5NiBib2FyZCBmcm9tIFh1bmxv
bmcuIEl0CmlzIG9uZSBvZiB0aGUgOTZCb2FyZHMgSW9UIEVkaXRpb24gYm9hcmQuCgpTaWduZWQt
b2ZmLWJ5OiBBbmRyZWFzIEbDpHJiZXIgPGFmYWVyYmVyQHN1c2UuZGU+ClNpZ25lZC1vZmYtYnk6
IE1hbml2YW5uYW4gU2FkaGFzaXZhbSA8bWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFyby5vcmc+
CkFja2VkLWJ5OiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPgotLS0KIGFyY2gvYXJtL2Jv
b3QvZHRzL01ha2VmaWxlICAgICAgICAgICAgICAgICAgIHwgIDMgKy0KIGFyY2gvYXJtL2Jvb3Qv
ZHRzL3JkYTg4MTBwbC1vcmFuZ2VwaS1pOTYuZHRzIHwgNTAgKysrKysrKysrKysrKysrKysrKysK
IDIgZmlsZXMgY2hhbmdlZCwgNTIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQogY3JlYXRl
IG1vZGUgMTAwNjQ0IGFyY2gvYXJtL2Jvb3QvZHRzL3JkYTg4MTBwbC1vcmFuZ2VwaS1pOTYuZHRz
CgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvTWFrZWZpbGUgYi9hcmNoL2FybS9ib290
L2R0cy9NYWtlZmlsZQppbmRleCBhMGZkYWQ4ZjEwZGQuLmNmYjA4ZWEzMzg3MiAxMDA2NDQKLS0t
IGEvYXJjaC9hcm0vYm9vdC9kdHMvTWFrZWZpbGUKKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvTWFr
ZWZpbGUKQEAgLTgwNyw3ICs4MDcsOCBAQCBkdGItJChDT05GSUdfQVJDSF9RQ09NKSArPSBcCiAJ
cWNvbS1tc204OTc0LXNvbnkteHBlcmlhLWhvbmFtaS5kdGIgXAogCXFjb20tbWRtOTYxNS13cDg1
NDgtbWFuZ29oLWdyZWVuLmR0YgogZHRiLSQoQ09ORklHX0FSQ0hfUkRBKSArPSBcCi0JcmRhODgx
MHBsLW9yYW5nZXBpLTJnLWlvdC5kdGIKKwlyZGE4ODEwcGwtb3JhbmdlcGktMmctaW90LmR0YiBc
CisJcmRhODgxMHBsLW9yYW5nZXBpLWk5Ni5kdGIKIGR0Yi0kKENPTkZJR19BUkNIX1JFQUxWSUVX
KSArPSBcCiAJYXJtLXJlYWx2aWV3LXBiMTE3Ni5kdGIgXAogCWFybS1yZWFsdmlldy1wYjExbXAu
ZHRiIFwKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL3JkYTg4MTBwbC1vcmFuZ2VwaS1p
OTYuZHRzIGIvYXJjaC9hcm0vYm9vdC9kdHMvcmRhODgxMHBsLW9yYW5nZXBpLWk5Ni5kdHMKbmV3
IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwMDAwLi43MjhmNzY5MzFiOTkKLS0tIC9k
ZXYvbnVsbAorKysgYi9hcmNoL2FybS9ib290L2R0cy9yZGE4ODEwcGwtb3JhbmdlcGktaTk2LmR0
cwpAQCAtMCwwICsxLDUwIEBACisvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAr
IE9SIE1JVCkKKy8qCisgKiBDb3B5cmlnaHQgKGMpIDIwMTcgQW5kcmVhcyBGw6RyYmVyCisgKiBD
b3B5cmlnaHQgKGMpIDIwMTggTWFuaXZhbm5hbiBTYWRoYXNpdmFtCisgKi8KKworL2R0cy12MS87
CisKKyNpbmNsdWRlICJyZGE4ODEwcGwuZHRzaSIKKworLyB7CisJY29tcGF0aWJsZSA9ICJ4dW5s
b25nLG9yYW5nZXBpLWk5NiIsICJyZGEsODgxMHBsIjsKKwltb2RlbCA9ICJPcmFuZ2UgUGkgaTk2
IjsKKworCWFsaWFzZXMgeworCQlzZXJpYWwwID0gJnVhcnQyOworCQlzZXJpYWwxID0gJnVhcnQx
OworCQlzZXJpYWwyID0gJnVhcnQzOworCX07CisKKwljaG9zZW4geworCQlzdGRvdXQtcGF0aCA9
ICJzZXJpYWwyOjkyMTYwMG44IjsKKwl9OworCisJbWVtb3J5QDgwMDAwMDAwIHsKKwkJZGV2aWNl
X3R5cGUgPSAibWVtb3J5IjsKKwkJcmVnID0gPDB4ODAwMDAwMDAgMHgxMDAwMDAwMD47CisJfTsK
KworCXVhcnRfY2xrOiB1YXJ0LWNsayB7CisJCWNvbXBhdGlibGUgPSAiZml4ZWQtY2xvY2siOwor
CQljbG9jay1mcmVxdWVuY3kgPSA8OTIxNjAwPjsKKwkJI2Nsb2NrLWNlbGxzID0gPDA+OworCX07
Cit9OworCismdWFydDEgeworCXN0YXR1cyA9ICJva2F5IjsKKwljbG9ja3MgPSA8JnVhcnRfY2xr
PjsKK307CisKKyZ1YXJ0MiB7CisJc3RhdHVzID0gIm9rYXkiOworCWNsb2NrcyA9IDwmdWFydF9j
bGs+OworfTsKKworJnVhcnQzIHsKKwlzdGF0dXMgPSAib2theSI7CisJY2xvY2tzID0gPCZ1YXJ0
X2Nsaz47Cit9OwotLSAKMi4xNy4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
