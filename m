Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B45AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:34:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53ED62085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jyO79x82";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HHUtGV6B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53ED62085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WVJsvT7Mgz76EqM9ABNoGHOrjZuCTLxfihFFixCAJ64=; b=jyO79x82qV2IYH
	8XvsKmDvadSP/QWZD0poAdWzZdzm6QLwM+Sqn7hYP888JzA8ZVI2x2rrXHaSc3VDh5FX4C54aKSQ/
	4KP9xAhuWu/eco7DsH/zsTYHENN94hucCiT9EXn8eapGO9CXuFRLSk/QiInovHPM6eiEorqom5QJf
	Aomp0xVhsVEXVkxK6imB7zKPElYjXE4YcsiEF/+0LOy4AX8msGLUp7xDneql7IH+WUerl2XNJLxd4
	tiDjGGH652b3WL7dGi2XiP59JqBlSQU7JIvrN5/j82RAwyZM4AP4w45yayDFQhsJFW4fh3xwB/dpg
	nt92ThWsB5hvjH5qv3MQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjFV8-0001It-CY; Tue, 15 Jan 2019 03:34:54 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjFUV-0000ge-Pz
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 03:34:21 +0000
Received: by mail-pl1-x642.google.com with SMTP id 101so615920pld.6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 19:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QzEw+0c7YCMrIJx0PSwB5TjdR5ksSYaunb0Z3JfV66A=;
 b=HHUtGV6Bj0Zj+6v3TzOmsCTcz3nUIF8RYPXUoENgTw83quUwGId8YxiD/vXr4KDxru
 7cwVtubU9A24OMrCre37l5/BsWqQt/E+iOga54NjfzCK957vp8nDoTOdF3fck1pSqqu8
 tUrzUrT+5yNofk77YiSO/OFIh/QyUHAbQJeP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QzEw+0c7YCMrIJx0PSwB5TjdR5ksSYaunb0Z3JfV66A=;
 b=JfcE79wYLzK7kXk9ZVb7QD5Tm2EZZP5D+2J4EzTEsAdhWRbMvbjAC8okp6EzIe0KaH
 sLaCl6rrHFyq+FUzktuCqBbGqTnKQW0cZTVvugGF5MZ0EV5fM1v17/YUkIYqSnxtMnpL
 9hv8KDNS1Bk6anOlEEC74jylBXsuQgwzOa29ZfbwAJgQtrvIvZdmTUsxxkn5KtWnQ7q2
 YVbxU4H/CKEmsWx1zUtITuE7ua/3dsmQnd6eWN3wmpuZe2DD0j2Gw2CFxVVpMZxyb+h+
 t3B9Ix4yP6nwRNnZITWy1WPchHG8ayRFmf7Ge/zuP/jziYiu2ISyY1mlHocdVyjwbrJ+
 zk6A==
X-Gm-Message-State: AJcUukfceXPog9N0VHJud3xEfCSuI2bA2x+Pb0TG7cHZLIRR8824qTy+
 Oy3jBRAJC4tKu5UuZVa4/NVI
X-Google-Smtp-Source: ALg8bN5g5uMXPav02wZj17J108BuRNg5LAOSwAxAHeknYgo8mPBgYSnHviqmY5Fna7SYMv0PBLm2rw==
X-Received: by 2002:a17:902:2868:: with SMTP id
 e95mr1891450plb.317.1547523254819; 
 Mon, 14 Jan 2019 19:34:14 -0800 (PST)
Received: from localhost.localdomain
 ([2409:4072:6084:4813:7cd6:42d1:f14c:3e90])
 by smtp.gmail.com with ESMTPSA id s9sm2137023pgl.88.2019.01.14.19.34.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 14 Jan 2019 19:34:14 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: sboyd@kernel.org, mturquette@baylibre.com, afaerber@suse.de,
 robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-actions@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 3/6] ARM: dts: Add CMU support for Actions Semi Owl S500 SoC
Date: Tue, 15 Jan 2019 09:03:37 +0530
Message-Id: <20190115033340.25016-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190115033340.25016-1-manivannan.sadhasivam@linaro.org>
References: <20190115033340.25016-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_193416_538170_96A0FFEA 
X-CRM114-Status: GOOD (  12.35  )
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
Cc: Edgar Bernardi Righi <edgar.righi@lsitec.org.br>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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
