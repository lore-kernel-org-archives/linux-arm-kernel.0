Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EBFDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:06:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59B8E21852
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UF3fd0S9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iIf9pnXA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59B8E21852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SAG8Nv/iOOzHPx17mnna8eXezagtTeECpXDpCuG86jw=; b=UF3fd0S9gfoXkt
	78BLe1gVLO+eyY0WzhoiVBy3O2PjnEhz2Xba1/LoAlVbjQwoszuPKXLcSJD3i3ZUL5ODVRskRSL/7
	f1ec1O0mIU+tWZEpHnxgtqt4xtRiXwd3LVVvUy2zWLidvu8Fzc7NQe/VpyjVIuctLALT5nVt8Aylh
	dGjsQZ0Zi2JZkDhndfiZecZbjgnAMB7LjOLi6cGflbgdtw8ULgzZBRMPaHIGDPsL32obviEPYCXvc
	msfylYx969pRkq+9tl+4wA54Hz21kEktCpx9G2GcYA6oA/NlJN1V+NtZMTXsFoOizgRdVkBfIB1tT
	2hZXfGhAXufkMAmtjyaA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZGwy-0003n9-R2; Tue, 18 Dec 2018 15:06:24 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZGuy-0000wb-J9
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 15:04:30 +0000
Received: by mail-pg1-x543.google.com with SMTP id d72so7929842pga.9
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 07:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/+Wot32dCYbFyz82umg0TGbI9UaJBZsDc3LGBl9ZFTY=;
 b=iIf9pnXABmhVxHctX913lu7LzINrROLekvfBds+7aNxZPg1xaIxxDiFFGd12jsoJ0T
 9DtMJlX+x9E9VOaeEOtxjeHU5q4+8y+5bAYh+a3tlRgYVfNaZ63c2iKqtQycTq4oPkwB
 3ROCT5y+WReR4f54VG00G9aS38STj2V2Ks/Rk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/+Wot32dCYbFyz82umg0TGbI9UaJBZsDc3LGBl9ZFTY=;
 b=XEpTdlEZX5KTOWHWbUc2mqM4D1p/xaJD5fHlKOmwS7RhVe0YRdm6Se24dK82SN15o/
 1IVK7pBgT9Z4vz+9fgGNbN1hKn0Qmus9WV5nk0Na4x1vY+sa4Xyw74GzlyGKhn2S/3mY
 2IuhY2Qj67vuSILiS2M3xRU6rQdEvtf8kpjDojMSBJcP1/t44OD+r3rSCG1gtzYjj4cX
 BsjPx2q85NPYc1m85BucLGjICEank0KlJ4ZZUQ3dgzQ8D+gdnaCfBWbh1Odn1rBH1Vtb
 3VPuurc0QCQkzGM7GHALep6vg2ZleUrVL9R1b0c63F3NV20Ze8UQYi0ndkY6Lq/mVEz+
 R2jw==
X-Gm-Message-State: AA+aEWYRwCwcAmMmtLIyrydFlJpqlL75MwdYaYjjlw8APCx1YxZ4QCkt
 G5NqNM4WFy1ndKIiBIvwzHUD
X-Google-Smtp-Source: AFSGD/W/175emCViIzzUGynsJ1OVpxVqOZ3euiM2JR3hBfSKptrbkxWFnjNyDXCGC2qLaLFI6QLEdA==
X-Received: by 2002:a65:6491:: with SMTP id e17mr15868402pgv.418.1545145449913; 
 Tue, 18 Dec 2018 07:04:09 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
 by smtp.gmail.com with ESMTPSA id m198sm28798688pga.10.2018.12.18.07.04.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Dec 2018 07:04:09 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: olof@lixom.net, arnd@arndb.de, arm@kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 09/11] ARM: dts: rda8810pl: Add interrupt support for UART
Date: Tue, 18 Dec 2018 20:32:36 +0530
Message-Id: <20181218150238.23010-10-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218150238.23010-1-manivannan.sadhasivam@linaro.org>
References: <20181218150238.23010-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_070421_582704_8BB9F764 
X-CRM114-Status: GOOD (  11.23  )
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

QWRkIGludGVycnVwdCBzdXBwb3J0IGZvciBVQVJUIGluIFJEQSBNaWNybyBSREE4ODEwUEwgU29D
LgoKU2lnbmVkLW9mZi1ieTogQW5kcmVhcyBGw6RyYmVyIDxhZmFlcmJlckBzdXNlLmRlPgpTaWdu
ZWQtb2ZmLWJ5OiBNYW5pdmFubmFuIFNhZGhhc2l2YW0gPG1hbml2YW5uYW4uc2FkaGFzaXZhbUBs
aW5hcm8ub3JnPgpBY2tlZC1ieTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4KLS0tCiBh
cmNoL2FybS9ib290L2R0cy9yZGE4ODEwcGwuZHRzaSB8IDMgKysrCiAxIGZpbGUgY2hhbmdlZCwg
MyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvcmRhODgxMHBs
LmR0c2kgYi9hcmNoL2FybS9ib290L2R0cy9yZGE4ODEwcGwuZHRzaQppbmRleCA4NGJhYTRjMGEx
NGMuLjE5Y2RlODk1YmY2NSAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvcmRhODgxMHBs
LmR0c2kKKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvcmRhODgxMHBsLmR0c2kKQEAgLTcxLDE4ICs3
MSwyMSBAQAogCQl1YXJ0MTogc2VyaWFsQDAgewogCQkJY29tcGF0aWJsZSA9ICJyZGEsODgxMHBs
LXVhcnQiOwogCQkJcmVnID0gPDB4MCAweDEwMDA+OworCQkJaW50ZXJydXB0cyA9IDw5IElSUV9U
WVBFX0xFVkVMX0hJR0g+OwogCQkJc3RhdHVzID0gImRpc2FibGVkIjsKIAkJfTsKIAogCQl1YXJ0
Mjogc2VyaWFsQDEwMDAwIHsKIAkJCWNvbXBhdGlibGUgPSAicmRhLDg4MTBwbC11YXJ0IjsKIAkJ
CXJlZyA9IDwweDEwMDAwIDB4MTAwMD47CisJCQlpbnRlcnJ1cHRzID0gPDEwIElSUV9UWVBFX0xF
VkVMX0hJR0g+OwogCQkJc3RhdHVzID0gImRpc2FibGVkIjsKIAkJfTsKIAogCQl1YXJ0Mzogc2Vy
aWFsQDkwMDAwIHsKIAkJCWNvbXBhdGlibGUgPSAicmRhLDg4MTBwbC11YXJ0IjsKIAkJCXJlZyA9
IDwweDkwMDAwIDB4MTAwMD47CisJCQlpbnRlcnJ1cHRzID0gPDExIElSUV9UWVBFX0xFVkVMX0hJ
R0g+OwogCQkJc3RhdHVzID0gImRpc2FibGVkIjsKIAkJfTsKIAl9OwotLSAKMi4xNy4xCgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtl
cm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5l
bAo=
