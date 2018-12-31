Return-Path: <SRS0=D6bT=PI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C399DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 18:56:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91B072073F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 18:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W3oHBiHB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="drYNuZs/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91B072073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WVJsvT7Mgz76EqM9ABNoGHOrjZuCTLxfihFFixCAJ64=; b=W3oHBiHBRTFQ4O
	hja2UyX92MMIjHyybViT7p/DsZbSUB7LaSCQKsGNS+QmLm12O32+hunBtP1fyZ509e3wQHs6MORHg
	r5bGl5sh4+3sVGIxXZbk+DhkbI9KtVCSLlcbsc4RBua+EWKdMY99qzx0ZMSWp2mMMqEmjxxY5yYIJ
	8gS1mLvv1lLueiDoDFcCb/g2j2OAboJb4Fcf0nf7N1XV/mRHah6j84GcHirnw2/Bp+orx1qdgHrih
	wb2Nlw14dZ1FPg2NeWpodpBFG/K0eT8hQvoSG/Eph1k9W4m3UOi+7WYBeG7TuQL33I3FFJzOpvsrP
	d2kAOVOfCbavk5U5Crnw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ge2jj-0003fk-Ig; Mon, 31 Dec 2018 18:56:27 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ge2jG-0003Bz-DE
 for linux-arm-kernel@lists.infradead.org; Mon, 31 Dec 2018 18:56:00 +0000
Received: by mail-pg1-x541.google.com with SMTP id n2so12952623pgm.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 31 Dec 2018 10:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QzEw+0c7YCMrIJx0PSwB5TjdR5ksSYaunb0Z3JfV66A=;
 b=drYNuZs/jBj1/vLtblqax09zFggcbQ8stoB/0bqktqAbJghWOyVWDjfuk6tmVg1J2s
 X+Q7MfHl/fcPYdKUIpFFLoKrvYDrFbt2gNFfphH1op8jnamf/0s/e0gTPomNVNeegLz8
 KRmQy+IdMAPJ2LgDEdt5zhl71aALwwOXHnzZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QzEw+0c7YCMrIJx0PSwB5TjdR5ksSYaunb0Z3JfV66A=;
 b=pHuUmlCrH8LJ9BJKuDBvB50b0c9pYy8OazWO56k/vLQPvhtM5hnlJmvB8wmukKR1CB
 V3TnPlOOPWCe2Ddsaf7yo2Ob8YjNGg8801pf2WJTn3vNr4biQ82gadA+T0wNHR9iqj8P
 Kf51yTwmMS12N2uzImVgrdl0Ge42cTCHWEW7gRJn9ajj8SQdqiws5gbaUhDtwoYLNo3H
 gQ6amW6HQ+Vps1cGzQ1vUl8rcSCHklSHPA7K+5LTvQHqL8BmcXPaH0A6p4dnHuIm/Kdl
 fzS6wNTH1bHCS9knOmd12tnmrSBXYZ6gmP1ZkyIgXAPUXmSMyv//spfT+sCXvikCLpBh
 OjQg==
X-Gm-Message-State: AJcUukew7Cm649qIB/P3L9IBzaHBm5rHZlWOPAwYnixNL8xd15HRe/1C
 7p2ljfJUyMU0PS+D4Jm2CBnqLbIVbg==
X-Google-Smtp-Source: ALg8bN7mtIXE8I7yk96Gm9/UfW9HxwDGQfysbrCNRvLvROQm4a8TxSmr+sF28gQnZCXYQkolA20awA==
X-Received: by 2002:a63:9749:: with SMTP id d9mr8237520pgo.415.1546282557427; 
 Mon, 31 Dec 2018 10:55:57 -0800 (PST)
Received: from localhost.localdomain ([2405:204:7440:b882:8d58:e15f:9ff4:efc2])
 by smtp.gmail.com with ESMTPSA id s9sm66146224pgl.88.2018.12.31.10.55.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 31 Dec 2018 10:55:56 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: sboyd@kernel.org, mturquette@baylibre.com, afaerber@suse.de,
 robh+dt@kernel.org
Subject: [PATCH 3/6] ARM: dts: Add CMU support for Actions Semi Owl S500 SoC
Date: Tue,  1 Jan 2019 00:25:14 +0530
Message-Id: <20181231185517.18517-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181231185517.18517-1-manivannan.sadhasivam@linaro.org>
References: <20181231185517.18517-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181231_105558_633205_1D2C3F89 
X-CRM114-Status: GOOD (  12.50  )
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
Cc: devicetree@vger.kernel.org, linux-actions@lists.infradead.org,
 linux-kernel@vger.kernel.org, Edgar Bernardi Righi <edgar.righi@lsitec.org.br>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QWRkIENsb2NrIE1hbmFnZW1lbnQgVW5pdCAoQ01VKSBzdXBwb3J0IGZvciBBY3Rpb25zIFNlbWkg
T3dsIGZhbWlseQpTNTAwIFNvQy4KClNpZ25lZC1vZmYtYnk6IEVkZ2FyIEJlcm5hcmRpIFJpZ2hp
IDxlZGdhci5yaWdoaUBsc2l0ZWMub3JnLmJyPgpbTWFuaTogRml4ZWQgY29tbWl0IG1lc3NhZ2Ug
YW5kIERUU10KU2lnbmVkLW9mZi1ieTogTWFuaXZhbm5hbiBTYWRoYXNpdmFtIDxtYW5pdmFubmFu
LnNhZGhhc2l2YW1AbGluYXJvLm9yZz4KLS0tCiBhcmNoL2FybS9ib290L2R0cy9vd2wtczUwMC5k
dHNpIHwgMjIgKysrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDIyIGluc2Vy
dGlvbnMoKykKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9vd2wtczUwMC5kdHNpIGIv
YXJjaC9hcm0vYm9vdC9kdHMvb3dsLXM1MDAuZHRzaQppbmRleCA1Y2ViNmNjNDQ1MWQuLmFhNzU4
NTM4ZGU4YyAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvb3dsLXM1MDAuZHRzaQorKysg
Yi9hcmNoL2FybS9ib290L2R0cy9vd2wtczUwMC5kdHNpCkBAIC0zLDggKzMsMTAgQEAKICAqIEFj
dGlvbnMgU2VtaSBTNTAwIFNvQwogICoKICAqIENvcHlyaWdodCAoYykgMjAxNi0yMDE3IEFuZHJl
YXMgRsOkcmJlcgorICogQ29weXJpZ2h0IChjKSAyMDE4IEVkZ2FyIEJlcm5hcmRpIFJpZ2hpCiAg
Ki8KIAorI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2Nsb2NrL2FjdGlvbnMsczUwMC1jbXUuaD4KICNp
bmNsdWRlIDxkdC1iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9hcm0tZ2ljLmg+CiAjaW5j
bHVkZSA8ZHQtYmluZGluZ3MvcG93ZXIvb3dsLXM1MDAtcG93ZXJnYXRlLmg+CiAKQEAgLTcwLDYg
KzcyLDEyIEBACiAJCSNjbG9jay1jZWxscyA9IDwwPjsKIAl9OwogCisJbG9zYzogbG9zYyB7CisJ
CWNvbXBhdGlibGUgPSAiZml4ZWQtY2xvY2siOworCQljbG9jay1mcmVxdWVuY3kgPSA8MzI3Njg+
OworCQkjY2xvY2stY2VsbHMgPSA8MD47CisJfTsKKwogCXNvYyB7CiAJCWNvbXBhdGlibGUgPSAi
c2ltcGxlLWJ1cyI7CiAJCSNhZGRyZXNzLWNlbGxzID0gPDE+OwpAQCAtMTI0LDYgKzEzMiw3IEBA
CiAJCQljb21wYXRpYmxlID0gImFjdGlvbnMsczUwMC11YXJ0IiwgImFjdGlvbnMsb3dsLXVhcnQi
OwogCQkJcmVnID0gPDB4YjAxMjAwMDAgMHgyMDAwPjsKIAkJCWludGVycnVwdHMgPSA8R0lDX1NQ
SSAyOSBJUlFfVFlQRV9MRVZFTF9ISUdIPjsKKwkJCWNsb2NrcyA9IDwmY211IENMS19VQVJUMD47
CiAJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOwogCQl9OwogCkBAIC0xMzEsNiArMTQwLDcgQEAKIAkJ
CWNvbXBhdGlibGUgPSAiYWN0aW9ucyxzNTAwLXVhcnQiLCAiYWN0aW9ucyxvd2wtdWFydCI7CiAJ
CQlyZWcgPSA8MHhiMDEyMjAwMCAweDIwMDA+OwogCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDMw
IElSUV9UWVBFX0xFVkVMX0hJR0g+OworCQkJY2xvY2tzID0gPCZjbXUgQ0xLX1VBUlQxPjsKIAkJ
CXN0YXR1cyA9ICJkaXNhYmxlZCI7CiAJCX07CiAKQEAgLTEzOCw2ICsxNDgsNyBAQAogCQkJY29t
cGF0aWJsZSA9ICJhY3Rpb25zLHM1MDAtdWFydCIsICJhY3Rpb25zLG93bC11YXJ0IjsKIAkJCXJl
ZyA9IDwweGIwMTI0MDAwIDB4MjAwMD47CiAJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMzEgSVJR
X1RZUEVfTEVWRUxfSElHSD47CisJCQljbG9ja3MgPSA8JmNtdSBDTEtfVUFSVDI+OwogCQkJc3Rh
dHVzID0gImRpc2FibGVkIjsKIAkJfTsKIApAQCAtMTQ1LDYgKzE1Niw3IEBACiAJCQljb21wYXRp
YmxlID0gImFjdGlvbnMsczUwMC11YXJ0IiwgImFjdGlvbnMsb3dsLXVhcnQiOwogCQkJcmVnID0g
PDB4YjAxMjYwMDAgMHgyMDAwPjsKIAkJCWludGVycnVwdHMgPSA8R0lDX1NQSSAzMiBJUlFfVFlQ
RV9MRVZFTF9ISUdIPjsKKwkJCWNsb2NrcyA9IDwmY211IENMS19VQVJUMz47CiAJCQlzdGF0dXMg
PSAiZGlzYWJsZWQiOwogCQl9OwogCkBAIC0xNTIsNiArMTY0LDcgQEAKIAkJCWNvbXBhdGlibGUg
PSAiYWN0aW9ucyxzNTAwLXVhcnQiLCAiYWN0aW9ucyxvd2wtdWFydCI7CiAJCQlyZWcgPSA8MHhi
MDEyODAwMCAweDIwMDA+OwogCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDMzIElSUV9UWVBFX0xF
VkVMX0hJR0g+OworCQkJY2xvY2tzID0gPCZjbXUgQ0xLX1VBUlQ0PjsKIAkJCXN0YXR1cyA9ICJk
aXNhYmxlZCI7CiAJCX07CiAKQEAgLTE1OSw2ICsxNzIsNyBAQAogCQkJY29tcGF0aWJsZSA9ICJh
Y3Rpb25zLHM1MDAtdWFydCIsICJhY3Rpb25zLG93bC11YXJ0IjsKIAkJCXJlZyA9IDwweGIwMTJh
MDAwIDB4MjAwMD47CiAJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMzQgSVJRX1RZUEVfTEVWRUxf
SElHSD47CisJCQljbG9ja3MgPSA8JmNtdSBDTEtfVUFSVDU+OwogCQkJc3RhdHVzID0gImRpc2Fi
bGVkIjsKIAkJfTsKIApAQCAtMTY2LDkgKzE4MCwxNyBAQAogCQkJY29tcGF0aWJsZSA9ICJhY3Rp
b25zLHM1MDAtdWFydCIsICJhY3Rpb25zLG93bC11YXJ0IjsKIAkJCXJlZyA9IDwweGIwMTJjMDAw
IDB4MjAwMD47CiAJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMzUgSVJRX1RZUEVfTEVWRUxfSElH
SD47CisJCQljbG9ja3MgPSA8JmNtdSBDTEtfVUFSVDY+OwogCQkJc3RhdHVzID0gImRpc2FibGVk
IjsKIAkJfTsKIAorCQljbXU6IGNsb2NrLWNvbnRyb2xsZXJAYjAxNjAwMDAgeworCQkJY29tcGF0
aWJsZSA9ICJhY3Rpb25zLHM1MDAtY211IjsKKwkJCXJlZyA9IDwweGIwMTYwMDAwIDB4ODAwMD47
CisJCQljbG9ja3MgPSA8Jmhvc2M+LCA8Jmxvc2M+OworCQkJI2Nsb2NrLWNlbGxzID0gPDE+Owor
CQl9OworCiAJCXRpbWVyOiB0aW1lckBiMDE2ODAwMCB7CiAJCQljb21wYXRpYmxlID0gImFjdGlv
bnMsczUwMC10aW1lciI7CiAJCQlyZWcgPSA8MHhiMDE2ODAwMCAweDgwMDA+OwotLSAKMi4xNy4x
CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgt
YXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJt
LWtlcm5lbAo=
