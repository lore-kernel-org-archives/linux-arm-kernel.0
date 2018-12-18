Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DABC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:43:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 153CE20874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mLUoOLvC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Al3IShOY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 153CE20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HS3QVNIUeE4KZ25u62cgjL/1SLkbGhilfvXCLSGwB4E=; b=mLUoOLvCtcXvQO
	HvlUKTL69/v7X5YF1COpIqNh0ldX4qjUpuoqXkphM3OFECtSmPIoWUmFUkkOd54kHU02dqF3D/fba
	1JPLBx0XETWOFvKWq3hcujUdVlh3rHmA0IydE/SBXfpGtkPdDeq1A0A6vnhkET4EM//PeQsLGL18q
	VgscLFNN6zJ2Rw6yZL3iXgKklMQ9NrswA9j1bGjqjryPQ30RubjYlHS/ZiYPnd3DIDuZUBvon/do8
	LgHnvKXH7KNJ74xfcqKApdHA9U4DrErBEJkuHvkjiZHrYsk3MzgK9lclGiJPRCoEqanl3Y+x0qqtx
	zD6VbDea5nVwjJB544iA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZ6ID-0007nT-R9; Tue, 18 Dec 2018 03:43:37 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZ6HJ-0006iu-Ae
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 03:42:54 +0000
Received: by mail-pf1-x442.google.com with SMTP id i12so7425080pfo.7
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 17 Dec 2018 19:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Wp3BZDgoaFaJmF6UrFqd9p3SyvZQREQyZwNsYyp7Sws=;
 b=Al3IShOYSEOBbrFcPKx6XF/WIM0mMVlKZMwpMPSGfSDTo7h2gNuirVbFiXN9Nzj+JX
 ix6o0Qy9na7XehwtlMFMgBUUle/2M5xVH2SRjBKcCHbsDkp0tbo7itULMt+7syrWxuj7
 jYkbNSupld1RHEJE99VNd8a8PR8ec9zl7bjUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Wp3BZDgoaFaJmF6UrFqd9p3SyvZQREQyZwNsYyp7Sws=;
 b=Vd+BDTC29k3S2X/Xu01U0SkzgNJTmlFnEx7YMoO27az3b+EAC+EXOEUBuMofSsIWvD
 vnvV0aEwJ6kthSuWYVVUqIoHwsl8xtkA+vBsyEGeMLG4HSpjjX6N11U3LhLqOtmBf0r6
 uyhrA8dwjX2ayxqpUJuy97ZL0TwkhjiWdvbpP/w0LwG5Hvly0zxO3I0zyUUn4q6GcKbw
 KubeiOrECULMH50c7gADkT1SkvYX8uhT8lzKUZI6Jkl2BHAzhidnJDP7Bi2MKXi1JQg4
 tk8M4gA/WZg97/DD0lU83Cv10Twjnj7AuAN4EAWYhSMTtW5e15b2RRqtLr51yb3vY1/p
 CT/w==
X-Gm-Message-State: AA+aEWbXxGgbwApgpeYr1YZChljTJtz209/ealK/K4ED3YrzG/RMb7Jo
 FmvvumZAdRitTvHL9/kJ8BYj
X-Google-Smtp-Source: AFSGD/WhwXAt84it0ytvn2rwfCvKtZk1skWtKfy8y/DRyqBYSS2tK9G2YlSulgBfX6NRhvW5XJ0AbQ==
X-Received: by 2002:a63:9712:: with SMTP id n18mr14220503pge.295.1545104550679; 
 Mon, 17 Dec 2018 19:42:30 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
 by smtp.gmail.com with ESMTPSA id b202sm25255422pfb.88.2018.12.17.19.42.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Dec 2018 19:42:30 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
 gregkh@linuxfoundation.org, jslaby@suse.com
Subject: [PATCH v5 04/11] ARM: dts: Add devicetree for RDA8810PL SoC
Date: Tue, 18 Dec 2018 09:11:25 +0530
Message-Id: <20181218034132.5070-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218034132.5070-1-manivannan.sadhasivam@linaro.org>
References: <20181218034132.5070-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_194242_031073_0984C6DF 
X-CRM114-Status: GOOD (  14.09  )
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

QWRkIGluaXRpYWwgZGV2aWNlIHRyZWUgZm9yIFJEQTg4MTBQTCBTb0MgZnJvbSBSREEgTWljcm9l
bGVjdHJvbmljcy4KClNpZ25lZC1vZmYtYnk6IEFuZHJlYXMgRsOkcmJlciA8YWZhZXJiZXJAc3Vz
ZS5kZT4KU2lnbmVkLW9mZi1ieTogTWFuaXZhbm5hbiBTYWRoYXNpdmFtIDxtYW5pdmFubmFuLnNh
ZGhhc2l2YW1AbGluYXJvLm9yZz4KLS0tCiBhcmNoL2FybS9ib290L2R0cy9yZGE4ODEwcGwuZHRz
aSB8IDg2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwg
ODYgaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtL2Jvb3QvZHRzL3Jk
YTg4MTBwbC5kdHNpCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvcmRhODgxMHBsLmR0
c2kgYi9hcmNoL2FybS9ib290L2R0cy9yZGE4ODEwcGwuZHRzaQpuZXcgZmlsZSBtb2RlIDEwMDY0
NAppbmRleCAwMDAwMDAwMDAwMDAuLjE1NTQ3YjEzODk3NwotLS0gL2Rldi9udWxsCisrKyBiL2Fy
Y2gvYXJtL2Jvb3QvZHRzL3JkYTg4MTBwbC5kdHNpCkBAIC0wLDAgKzEsODYgQEAKKy8vIFNQRFgt
TGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMCsgT1IgTUlUKQorLyoKKyAqIFJEQTg4MTBQTCBT
b0MKKyAqCisgKiBDb3B5cmlnaHQgKGMpIDIwMTcgQW5kcmVhcyBGw6RyYmVyCisgKiBDb3B5cmln
aHQgKGMpIDIwMTggTWFuaXZhbm5hbiBTYWRoYXNpdmFtCisgKi8KKworLyB7CisJY29tcGF0aWJs
ZSA9ICJyZGEsODgxMHBsIjsKKwlpbnRlcnJ1cHQtcGFyZW50ID0gPCZpbnRjPjsKKwkjYWRkcmVz
cy1jZWxscyA9IDwxPjsKKwkjc2l6ZS1jZWxscyA9IDwxPjsKKworCWNwdXMgeworCQkjYWRkcmVz
cy1jZWxscyA9IDwxPjsKKwkJI3NpemUtY2VsbHMgPSA8MD47CisKKwkJY3B1QDAgeworCQkJZGV2
aWNlX3R5cGUgPSAiY3B1IjsKKwkJCWNvbXBhdGlibGUgPSAiYXJtLGNvcnRleC1hNSI7CisJCQly
ZWcgPSA8MHgwPjsKKwkJfTsKKwl9OworCisJc3JhbUAxMDAwMDAgeworCQljb21wYXRpYmxlID0g
Im1taW8tc3JhbSI7CisJCXJlZyA9IDwweDEwMDAwMCAweDEwMDAwPjsKKwkJI2FkZHJlc3MtY2Vs
bHMgPSA8MT47CisJCSNzaXplLWNlbGxzID0gPDE+OworCQlyYW5nZXM7CisJfTsKKworCWFwYkAy
MDgwMDAwMCB7CisJCWNvbXBhdGlibGUgPSAic2ltcGxlLWJ1cyI7CisJCSNhZGRyZXNzLWNlbGxz
ID0gPDE+OworCQkjc2l6ZS1jZWxscyA9IDwxPjsKKwkJcmFuZ2VzID0gPDB4MCAweDIwODAwMDAw
IDB4MTAwMDAwPjsKKworCQlpbnRjOiBpbnRlcnJ1cHQtY29udHJvbGxlckAwIHsKKwkJCWNvbXBh
dGlibGUgPSAicmRhLDg4MTBwbC1pbnRjIjsKKwkJCXJlZyA9IDwweDAgMHgxMDAwPjsKKwkJCWlu
dGVycnVwdC1jb250cm9sbGVyOworCQkJI2ludGVycnVwdC1jZWxscyA9IDwyPjsKKwkJfTsKKwl9
OworCisJYXBiQDIwOTAwMDAwIHsKKwkJY29tcGF0aWJsZSA9ICJzaW1wbGUtYnVzIjsKKwkJI2Fk
ZHJlc3MtY2VsbHMgPSA8MT47CisJCSNzaXplLWNlbGxzID0gPDE+OworCQlyYW5nZXMgPSA8MHgw
IDB4MjA5MDAwMDAgMHgxMDAwMDA+OworCX07CisKKwlhcGJAMjBhMDAwMDAgeworCQljb21wYXRp
YmxlID0gInNpbXBsZS1idXMiOworCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsKKwkJI3NpemUtY2Vs
bHMgPSA8MT47CisJCXJhbmdlcyA9IDwweDAgMHgyMGEwMDAwMCAweDEwMDAwMD47CisKKwkJdWFy
dDE6IHNlcmlhbEAwIHsKKwkJCWNvbXBhdGlibGUgPSAicmRhLDg4MTBwbC11YXJ0IjsKKwkJCXJl
ZyA9IDwweDAgMHgxMDAwPjsKKwkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7CisJCX07CisKKwkJdWFy
dDI6IHNlcmlhbEAxMDAwMCB7CisJCQljb21wYXRpYmxlID0gInJkYSw4ODEwcGwtdWFydCI7CisJ
CQlyZWcgPSA8MHgxMDAwMCAweDEwMDA+OworCQkJc3RhdHVzID0gImRpc2FibGVkIjsKKwkJfTsK
KworCQl1YXJ0Mzogc2VyaWFsQDkwMDAwIHsKKwkJCWNvbXBhdGlibGUgPSAicmRhLDg4MTBwbC11
YXJ0IjsKKwkJCXJlZyA9IDwweDkwMDAwIDB4MTAwMD47CisJCQlzdGF0dXMgPSAiZGlzYWJsZWQi
OworCQl9OworCX07CisKKwlsMjogY2FjaGUtY29udHJvbGxlckAyMTEwMDAwMCB7CisJCWNvbXBh
dGlibGUgPSAiYXJtLHBsMzEwLWNhY2hlIjsKKwkJcmVnID0gPDB4MjExMDAwMDAgMHgxMDAwPjsK
KwkJY2FjaGUtdW5pZmllZDsKKwkJY2FjaGUtbGV2ZWwgPSA8Mj47CisJfTsKK307Ci0tIAoyLjE3
LjEKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51
eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1h
cm0ta2VybmVsCg==
