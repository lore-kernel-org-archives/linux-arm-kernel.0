Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5812DC5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:53:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C1032086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E8lgWNj6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JADwA4aq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aiFQWEIj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C1032086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lXmsnqrEsDrRgHEYqkioE8uRsXYCyMPdtkypC0xwneU=; b=E8lgWNj6XU9e1r
	qvR8m6ZJ3+fHhOnsnqidHiO5VHYQTwsgu4VPTw8jOr3Qg4or23pO59W9meANrAhothDWshEURLFli
	TevjAHyQn/9ORtgMVXoZB34hxtwZjcVl5Ok8fJnOvVY9fLQJ65c9PslCF95hUbnKcsZE7kfY7p7yt
	XtDITg49BtcCwiIMJJr3/e11Wh7AOA3ByuUDFglVuF+yGKdmgovzAFWUrFi9eTvtGOvAhcV6923d0
	5G7832wTZZicS0gBnOwY8WDUc+37tTV5bcsUD/iMDyKFF/qm0SzyxtleZXDFue7Hf/CEqxUI4azWF
	mUUqzwCfLrOVJa8MG0Gg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWPkG-0008NC-6e; Mon, 10 Dec 2018 17:53:28 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWPjs-0007mG-Kh
 for linux-arm-kernel@bombadil.infradead.org; Mon, 10 Dec 2018 17:53:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=M9evsXiKq/f6/hJaxP4dc1I6TBIm55n2snnXtgBmQsE=; b=JADwA4aqgQ0HHE+SAw5fRYTsyT
 NKPiCedwQ1A8FIo2Mllq3h5T3/c8BOG43P87XCO5JYXiwfxPOUBX+99M19YUKs3cdpKo2tfotTB3u
 52tR9OTCt81cSJlcjnU2Z81bVgtWYMSvEXBjvlpTY8CAkEg99SAAAByZnOZ3Vyc2c8F1Tp//NzQyR
 D21UBkofOpfiVIeCZ3CbGY9wAEw6EoVYcJ7DHz6GsGWwEQH1dz6w4Kq1/Jv1dcnum2lC10/vB/yTz
 ixq93le3GhUsl9CXlCtJqtVYFQzoyNTWPWtncItA0fkMcP7Mi/srTa3ZIoYBMNnB2qooGWMBKKOdc
 KFRZayVw==;
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWPUy-0002rU-OB
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 17:37:47 +0000
Received: by mail-pf1-x443.google.com with SMTP id y126so5731002pfb.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 09:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=M9evsXiKq/f6/hJaxP4dc1I6TBIm55n2snnXtgBmQsE=;
 b=aiFQWEIjTJqW5cD7Yifwd/cRFPWpT7tiaTUq+kaUIWFy0HwQMtOX3GpS2TY6QncD83
 xIyp2/KlBjj2fU2RhRTaDkGyXH8y2luxRHobxBqsFr94fCG5abwR0KIzT6MfTa6dCUF4
 8qL0zmJxxdTS2bElMGhenfLNz1A8igc9c2RFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=M9evsXiKq/f6/hJaxP4dc1I6TBIm55n2snnXtgBmQsE=;
 b=W+sjEvQVIf9vXw4eCfY/ybP8xb/ItfEo94JIUXxgQTQjl3ij13VNJUMJTTLyLmmXPo
 2s9BluG3DTfgtI+DTRGmnsHi70WzEQ70O2zu7pk7J5tktoTZjCiYWH+MquL6nCn3UKac
 9tdITDOgPadL02VI8sSNC4yEqBS4BvexdcZUVjX+GgxZpyPa3s4FZ4vMWEsuJ9lFvG4S
 tlHXFEyZVsParL7/okxEHEZ6HPNikxWd3/Fif6qdRWIxwaWd4bA56DYgq1CJ3i9POt30
 ZZ8l6nbjPPq2zdW/tvwmD3OE0/GNtbNui8iSdd6HIp/uwLqdeIzIxT2Fz+a84rvnqLPB
 oqOQ==
X-Gm-Message-State: AA+aEWbig5yINgxMXF1N1+T78/k03LmaIS37hypbq3OJDHc/9PyvfgEP
 vtvVrQXu1WiWdfDMkS30Iftj
X-Google-Smtp-Source: AFSGD/UPhilp6RoQCxzrZ4fn66yfTtsY05W92EFkRCn1VJXgMwOc38i3haqhB0UUU/eE2THEbXf0dg==
X-Received: by 2002:a62:f907:: with SMTP id o7mr12906043pfh.244.1544463449240; 
 Mon, 10 Dec 2018 09:37:29 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:91e:2c01:40e1:a028:b090:9e12])
 by smtp.gmail.com with ESMTPSA id q1sm15998396pfb.96.2018.12.10.09.37.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 09:37:28 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org, tglx@linutronix.de,
 jason@lakedaemon.net, marc.zyngier@arm.com, daniel.lezcano@linaro.org,
 gregkh@linuxfoundation.org, jslaby@suse.com
Subject: [PATCH v4 10/15] ARM: dts: rda8810pl: Add timer support
Date: Mon, 10 Dec 2018 23:05:45 +0530
Message-Id: <20181210173550.29643-11-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181210173550.29643-1-manivannan.sadhasivam@linaro.org>
References: <20181210173550.29643-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_173740_780858_507259B9 
X-CRM114-Status: GOOD (  11.87  )
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
