Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3D5C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:53:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 011CB20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RfGyWpv7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DuGvpnLi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iZpnl14W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 011CB20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XcFmzd1+lvxzsoyf39mOM950wXjF3HyJGHtvob3vLrQ=; b=RfGyWpv78gLGxd
	b1UNWITtc6S3VdwqEsJGtvkTAWnG1HlrWzdv6ul+wmtOow4xOMIIkyh+UL3b8CmOuf05wNXsr7j0K
	klWstg58XfkbBpg6LGbOYZA9cYhMkdqJaSOPsrD1BA++h9L53gn5be1+Y14dqADz/S/XQsjA8ZsZk
	BYl12cgCi9ahD8D+jRsgFFDfpgXoc9/XbH/vQ6XM0NgWhrIxiIOyVLNUhRHlP9CbrDPBhhQLHXW2N
	yETR70FqAcnCvl20K9Qw4wKOhtTnRwfmEilgiq+H3ImcI78JwZNtdqHfJC8drWvKhnI87bO7qHo4J
	FeycIzzW2xVCer1R4scQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWPkU-0000C0-Gf; Mon, 10 Dec 2018 17:53:42 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWPju-0007mG-Ra
 for linux-arm-kernel@bombadil.infradead.org; Mon, 10 Dec 2018 17:53:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=paserLSWvruKGRH0unlQrwzFxeUOtATxgj85HiPjRLo=; b=DuGvpnLiGt/x3VxsDuVWMn526G
 1oYL32tyUUjK390/91IArd9qYWoKUiRS0SjbyboSk/r2JNRLxAb87dlzUj0m73dO8N8wXcGosh9YJ
 EKO0X/5ykC38SHssao+L0rMQ1jRQC72vQ4WqA5289aMNS2ezNvyhOMSgn8ZveDTlNP7+BTqJrJgJn
 M+KYCPhkbYsBTb92l2OhGyX3LS/CboL09lvU175Om/pnXdG6MUhk1kyYnWzOXYi+iDN1/56SWLiPI
 borEndquuAQVdMc7XjkLfhBR/tGeezfPDVlrGNWsvbwHBXsgh73ULcTvbBqtm8T8e3wzfBcMuNgOB
 LTRT0W8Q==;
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWPUi-0002pF-Mo
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 17:37:27 +0000
Received: by mail-pf1-x443.google.com with SMTP id i12so5720046pfo.7
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 09:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=paserLSWvruKGRH0unlQrwzFxeUOtATxgj85HiPjRLo=;
 b=iZpnl14WwP9SdRZH4erTHT7deFkt2RjnMbDpJ7WRsJGa7rMQkb+o/6r/P5nMTerDzC
 bIwCSSHOQ8gbZz16ld5veLJRKT/8bA5cKyHQRKt0FV8E0YtEqSw0ESufDCNPiv7sReCO
 Z+m5eurMsOQzdDc/+/7R/tzFThc/fhDfspPwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=paserLSWvruKGRH0unlQrwzFxeUOtATxgj85HiPjRLo=;
 b=FVZmXuQ79h5TL3A5BDFtvr65q1YsgB8XerPZit6l40kJyxVL5s2ITtEK5+MinVd7ii
 mvbo0IycfdTds/SkrTuuKA9bWvzYv6flT2aP0okNkMUsYB9TFPGHyLifBsPVBS7slQrI
 oGUsR/XypvI9WAFBAkwYIt9HOTa2N2a7vjRTfSsCJfEAzr0XzRqHliNVMdJpujALHyaK
 uYvxij2gUeVoTC3HmwpiH/Gc4u/WgI6UjfRxAtTLziT/SaGXp46fSTSXPVzrRfex3BBr
 cQtOeURye98QL6xkfNjAzri/mQKI00k6FYGAuC1M57BwepgJ6v0X8e2Sd4d4tMNGek1U
 hwyQ==
X-Gm-Message-State: AA+aEWbYt5oczG/8VgJ2C5dAxnj0dryYTtQjUJJ5Z/6lgiwhn5Kk8TuS
 NfOIC9GuASgPsnlX+nIjZaUg
X-Google-Smtp-Source: AFSGD/UROBxdoupf/IuJWOaFU1FsAxKl3uAkVSiSR5qVY3DTkEXCRUtUZu4cFWjdPlkkSAwLEbrTsw==
X-Received: by 2002:a62:435a:: with SMTP id q87mr12968140pfa.109.1544463432829; 
 Mon, 10 Dec 2018 09:37:12 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:91e:2c01:40e1:a028:b090:9e12])
 by smtp.gmail.com with ESMTPSA id q1sm15998396pfb.96.2018.12.10.09.37.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 09:37:12 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org, tglx@linutronix.de,
 jason@lakedaemon.net, marc.zyngier@arm.com, daniel.lezcano@linaro.org,
 gregkh@linuxfoundation.org, jslaby@suse.com
Subject: [PATCH v4 08/15] irqchip: Add RDA8810PL interrupt driver
Date: Mon, 10 Dec 2018 23:05:43 +0530
Message-Id: <20181210173550.29643-9-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181210173550.29643-1-manivannan.sadhasivam@linaro.org>
References: <20181210173550.29643-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_173724_735186_EDBA72B6 
X-CRM114-Status: GOOD (  20.26  )
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

QWRkIGludGVycnVwdCBkcml2ZXIgZm9yIFJEQSBNaWNybyBSREE4ODEwUEwgU29DLgoKU2lnbmVk
LW9mZi1ieTogQW5kcmVhcyBGw6RyYmVyIDxhZmFlcmJlckBzdXNlLmRlPgpTaWduZWQtb2ZmLWJ5
OiBNYW5pdmFubmFuIFNhZGhhc2l2YW0gPG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3Jn
PgpSZXZpZXdlZC1ieTogTWFyYyBaeW5naWVyIDxtYXJjLnp5bmdpZXJAYXJtLmNvbT4KLS0tCiBk
cml2ZXJzL2lycWNoaXAvS2NvbmZpZyAgICAgICAgfCAgIDQgKysKIGRyaXZlcnMvaXJxY2hpcC9N
YWtlZmlsZSAgICAgICB8ICAgMSArCiBkcml2ZXJzL2lycWNoaXAvaXJxLXJkYS1pbnRjLmMgfCAx
MDcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiAzIGZpbGVzIGNoYW5nZWQsIDEx
MiBpbnNlcnRpb25zKCspCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9pcnFjaGlwL2lycS1y
ZGEtaW50Yy5jCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pcnFjaGlwL0tjb25maWcgYi9kcml2ZXJz
L2lycWNoaXAvS2NvbmZpZwppbmRleCA1MWE1ZWYwZTk2ZWQuLjlkNTQ2NDU4NzBhZCAxMDA2NDQK
LS0tIGEvZHJpdmVycy9pcnFjaGlwL0tjb25maWcKKysrIGIvZHJpdmVycy9pcnFjaGlwL0tjb25m
aWcKQEAgLTE5NSw2ICsxOTUsMTAgQEAgY29uZmlnIEpDT1JFX0FJQwogCWhlbHAKIAkgIFN1cHBv
cnQgZm9yIHRoZSBKLUNvcmUgaW50ZWdyYXRlZCBBSUMuCiAKK2NvbmZpZyBSREFfSU5UQworCWJv
b2wKKwlzZWxlY3QgSVJRX0RPTUFJTgorCiBjb25maWcgUkVORVNBU19JTlRDX0lSUVBJTgogCWJv
b2wKIAlzZWxlY3QgSVJRX0RPTUFJTgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pcnFjaGlwL01ha2Vm
aWxlIGIvZHJpdmVycy9pcnFjaGlwL01ha2VmaWxlCmluZGV4IDc5NGMxM2QzYWMzZC4uNDE3MTA4
MDI3ZTQwIDEwMDY0NAotLS0gYS9kcml2ZXJzL2lycWNoaXAvTWFrZWZpbGUKKysrIGIvZHJpdmVy
cy9pcnFjaGlwL01ha2VmaWxlCkBAIC00Myw2ICs0Myw3IEBAIG9iai0kKENPTkZJR19JTUdQRENf
SVJRKQkJKz0gaXJxLWltZ3BkYy5vCiBvYmotJChDT05GSUdfSVJRX01JUFNfQ1BVKQkJKz0gaXJx
LW1pcHMtY3B1Lm8KIG9iai0kKENPTkZJR19TSVJGX0lSUSkJCQkrPSBpcnEtc2lyZnNvYy5vCiBv
YmotJChDT05GSUdfSkNPUkVfQUlDKQkJCSs9IGlycS1qY29yZS1haWMubworb2JqLSQoQ09ORklH
X1JEQV9JTlRDKQkJCSs9IGlycS1yZGEtaW50Yy5vCiBvYmotJChDT05GSUdfUkVORVNBU19JTlRD
X0lSUVBJTikJKz0gaXJxLXJlbmVzYXMtaW50Yy1pcnFwaW4ubwogb2JqLSQoQ09ORklHX1JFTkVT
QVNfSVJRQykJCSs9IGlycS1yZW5lc2FzLWlycWMubwogb2JqLSQoQ09ORklHX1ZFUlNBVElMRV9G
UEdBX0lSUSkJKz0gaXJxLXZlcnNhdGlsZS1mcGdhLm8KZGlmZiAtLWdpdCBhL2RyaXZlcnMvaXJx
Y2hpcC9pcnEtcmRhLWludGMuYyBiL2RyaXZlcnMvaXJxY2hpcC9pcnEtcmRhLWludGMuYwpuZXcg
ZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMDAuLjExNzYyOTFmZGVmOAotLS0gL2Rl
di9udWxsCisrKyBiL2RyaXZlcnMvaXJxY2hpcC9pcnEtcmRhLWludGMuYwpAQCAtMCwwICsxLDEw
NyBAQAorLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjArCisvKgorICogUkRBODgx
MFBMIFNvQyBpcnFjaGlwIGRyaXZlcgorICoKKyAqIENvcHlyaWdodCBSREEgTWljcm9lbGVjdHJv
bmljcyBDb21wYW55IExpbWl0ZWQKKyAqIENvcHlyaWdodCAoYykgMjAxNyBBbmRyZWFzIEbDpHJi
ZXIKKyAqIENvcHlyaWdodCAoYykgMjAxOCBNYW5pdmFubmFuIFNhZGhhc2l2YW0KKyAqLworCisj
aW5jbHVkZSA8bGludXgvaW5pdC5oPgorI2luY2x1ZGUgPGxpbnV4L2ludGVycnVwdC5oPgorI2lu
Y2x1ZGUgPGxpbnV4L2lycS5oPgorI2luY2x1ZGUgPGxpbnV4L2lycWNoaXAuaD4KKyNpbmNsdWRl
IDxsaW51eC9pcnFkb21haW4uaD4KKyNpbmNsdWRlIDxsaW51eC9vZl9hZGRyZXNzLmg+CisKKyNp
bmNsdWRlIDxhc20vZXhjZXB0aW9uLmg+CisKKyNkZWZpbmUgUkRBX0lOVENfRklOQUxTVEFUVVMJ
MHgwMAorI2RlZmluZSBSREFfSU5UQ19NQVNLX1NFVAkweDA4CisjZGVmaW5lIFJEQV9JTlRDX01B
U0tfQ0xSCTB4MGMKKworI2RlZmluZSBSREFfSVJRX01BU0tfQUxMCTB4RkZGRkZGRkYKKworI2Rl
ZmluZSBSREFfTlJfSVJRUyAzMgorCitzdGF0aWMgdm9pZCBfX2lvbWVtICpyZGFfaW50Y19iYXNl
Oworc3RhdGljIHN0cnVjdCBpcnFfZG9tYWluICpyZGFfaXJxX2RvbWFpbjsKKworc3RhdGljIHZv
aWQgcmRhX2ludGNfbWFza19pcnEoc3RydWN0IGlycV9kYXRhICpkKQoreworCXdyaXRlbF9yZWxh
eGVkKEJJVChkLT5od2lycSksIHJkYV9pbnRjX2Jhc2UgKyBSREFfSU5UQ19NQVNLX0NMUik7Cit9
CisKK3N0YXRpYyB2b2lkIHJkYV9pbnRjX3VubWFza19pcnEoc3RydWN0IGlycV9kYXRhICpkKQor
eworCXdyaXRlbF9yZWxheGVkKEJJVChkLT5od2lycSksIHJkYV9pbnRjX2Jhc2UgKyBSREFfSU5U
Q19NQVNLX1NFVCk7Cit9CisKK3N0YXRpYyBpbnQgcmRhX2ludGNfc2V0X3R5cGUoc3RydWN0IGly
cV9kYXRhICpkYXRhLCB1bnNpZ25lZCBpbnQgZmxvd190eXBlKQoreworCS8qIEhhcmR3YXJlIHN1
cHBvcnRzIG9ubHkgbGV2ZWwgdHJpZ2dlcmVkIGludGVycnVwdHMgKi8KKwlpZiAoKGZsb3dfdHlw
ZSAmIChJUlFGX1RSSUdHRVJfSElHSCB8IElSUUZfVFJJR0dFUl9MT1cpKSA9PSBmbG93X3R5cGUp
CisJCXJldHVybiAwOworCisJcmV0dXJuIC1FSU5WQUw7Cit9CisKK3N0YXRpYyB2b2lkIF9fZXhj
ZXB0aW9uX2lycV9lbnRyeSByZGFfaGFuZGxlX2lycShzdHJ1Y3QgcHRfcmVncyAqcmVncykKK3sK
Kwl1MzIgc3RhdCA9IHJlYWRsX3JlbGF4ZWQocmRhX2ludGNfYmFzZSArIFJEQV9JTlRDX0ZJTkFM
U1RBVFVTKTsKKwl1MzIgaHdpcnE7CisKKwl3aGlsZSAoc3RhdCkgeworCQlod2lycSA9IF9fZmxz
KHN0YXQpOworCQloYW5kbGVfZG9tYWluX2lycShyZGFfaXJxX2RvbWFpbiwgaHdpcnEsIHJlZ3Mp
OworCQlzdGF0ICY9IH5CSVQoaHdpcnEpOworCX0KK30KKworc3RhdGljIHN0cnVjdCBpcnFfY2hp
cCByZGFfaXJxX2NoaXAgPSB7CisJLm5hbWUJCT0gInJkYS1pbnRjIiwKKwkuaXJxX21hc2sJPSBy
ZGFfaW50Y19tYXNrX2lycSwKKwkuaXJxX3VubWFzawk9IHJkYV9pbnRjX3VubWFza19pcnEsCisJ
LmlycV9zZXRfdHlwZQk9IHJkYV9pbnRjX3NldF90eXBlLAorfTsKKworc3RhdGljIGludCByZGFf
aXJxX21hcChzdHJ1Y3QgaXJxX2RvbWFpbiAqZCwKKwkJICAgICAgIHVuc2lnbmVkIGludCB2aXJx
LCBpcnFfaHdfbnVtYmVyX3QgaHcpCit7CisJaXJxX3NldF9zdGF0dXNfZmxhZ3ModmlycSwgSVJR
X0xFVkVMKTsKKwlpcnFfc2V0X2NoaXBfYW5kX2hhbmRsZXIodmlycSwgJnJkYV9pcnFfY2hpcCwg
aGFuZGxlX2xldmVsX2lycSk7CisJaXJxX3NldF9jaGlwX2RhdGEodmlycSwgZC0+aG9zdF9kYXRh
KTsKKwlpcnFfc2V0X3Byb2JlKHZpcnEpOworCisJcmV0dXJuIDA7Cit9CisKK3N0YXRpYyBjb25z
dCBzdHJ1Y3QgaXJxX2RvbWFpbl9vcHMgcmRhX2lycV9kb21haW5fb3BzID0geworCS5tYXAgPSBy
ZGFfaXJxX21hcCwKKwkueGxhdGUgPSBpcnFfZG9tYWluX3hsYXRlX29uZWNlbGwsCit9OworCitz
dGF0aWMgaW50IF9faW5pdCByZGE4ODEwX2ludGNfaW5pdChzdHJ1Y3QgZGV2aWNlX25vZGUgKm5v
ZGUsCisJCQkJICAgIHN0cnVjdCBkZXZpY2Vfbm9kZSAqcGFyZW50KQoreworCXJkYV9pbnRjX2Jh
c2UgPSBvZl9pb19yZXF1ZXN0X2FuZF9tYXAobm9kZSwgMCwgInJkYS1pbnRjIik7CisJaWYgKCFy
ZGFfaW50Y19iYXNlKQorCQlyZXR1cm4gLUVOWElPOworCisJLyogTWFzayBhbGwgaW50ZXJydXB0
IHNvdXJjZXMgKi8KKwl3cml0ZWxfcmVsYXhlZChSREFfSVJRX01BU0tfQUxMLCByZGFfaW50Y19i
YXNlICsgUkRBX0lOVENfTUFTS19DTFIpOworCisJcmRhX2lycV9kb21haW4gPSBpcnFfZG9tYWlu
X2NyZWF0ZV9saW5lYXIoJm5vZGUtPmZ3bm9kZSwgUkRBX05SX0lSUVMsCisJCQkJCQkgICZyZGFf
aXJxX2RvbWFpbl9vcHMsCisJCQkJCQkgIHJkYV9pbnRjX2Jhc2UpOworCWlmICghcmRhX2lycV9k
b21haW4pIHsKKwkJaW91bm1hcChyZGFfaW50Y19iYXNlKTsKKwkJcmV0dXJuIC1FTk9NRU07CisJ
fQorCisJc2V0X2hhbmRsZV9pcnEocmRhX2hhbmRsZV9pcnEpOworCisJcmV0dXJuIDA7Cit9CisK
K0lSUUNISVBfREVDTEFSRShyZGFfaW50YywgInJkYSw4ODEwcGwtaW50YyIsIHJkYTg4MTBfaW50
Y19pbml0KTsKLS0gCjIuMTcuMQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
