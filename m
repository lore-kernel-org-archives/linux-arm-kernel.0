Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4225CC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:37:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 172BD2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UrTw2m5x";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BYhxXpgZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 172BD2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HS3QVNIUeE4KZ25u62cgjL/1SLkbGhilfvXCLSGwB4E=; b=UrTw2m5xoq0scO
	708wK17P87YKdOxETM9on2ay7hz4HLepRVXiNEIs81MmrgYWtgJ8xfv0gj69idCDxiJXvFnTvn7xC
	Sdfftk4s7hy7PujOLg57svkc7UYe00lIs3/bBplKrsNOTVspRh9rMNpyZwVd+wJIOl0mZV0pmL/Vd
	rtihxjUqforVApncSdLRvWWWkoQ209ChlAmnexJo2TqGh8B1wzbSHCJ/LyKHkqZzSNQHDHBntHx4u
	NjQd9LSWew8ZvLsS7WtaXrYr18s+C1vNEGjUfcop3hx0otJPKUtTC9j/IhvjkLihWped/gLjJT0DC
	ZX0rn3JvAqjTInTZ13VA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWPUn-0000Xp-34; Mon, 10 Dec 2018 17:37:29 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWPU9-0008Mb-OT
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 17:36:59 +0000
Received: by mail-pg1-x543.google.com with SMTP id 70so5277924pgh.8
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 09:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Wp3BZDgoaFaJmF6UrFqd9p3SyvZQREQyZwNsYyp7Sws=;
 b=BYhxXpgZnvOoilqOg2dayJqLZC1bmtGK3F2m/wNmGOGFtRhrUO1j0+G9GcXeWcGJGw
 +5tIYrt1xyJk1HXfsyRp7GA5/4DMSuqRQ5GqObVoPgRIzlF1IFKeOFegeGNHzckLkDz4
 729cKzaTqTJm0iGqUCr/jC90aHtSEx7YnVO8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Wp3BZDgoaFaJmF6UrFqd9p3SyvZQREQyZwNsYyp7Sws=;
 b=Lt39E3j41InWvn5zTxpY/0nk7vo007sOODeXavhTQuD9mKAgfwUlbbuCJp5R0nnvwr
 pOMDyGb9jGYh0ng9GLJyr6KxAgP8P5usmaBxfUuNZgEZhFTooU1t/gczVozdgIvUG9TW
 BTFsgpsMMDrU72juC4iJsMi47MwjzPFQ3oKyTidciaB3wx+dlt+fLsGrgpcn0/Z/BrZs
 J38sIjcO3dBxY119I46+WCHG3B1RFs/X9DlVRYBueizrfj5ub3vyEr7TtbUJRIebvEEW
 VvzmwUCxu1eVt6JjJtsIcpJ4tY/yVI7D3RLiDYuhHRz3NQZH9wKBWo+nV8eE89LpzuwF
 Gt/Q==
X-Gm-Message-State: AA+aEWZzX7SC0CD5UGWqxPZeD1NxEOdN8hjlwO2d15jLu2JrSTx9zPEI
 n3Nys6hwDIQ3MVStOYIlZbKS
X-Google-Smtp-Source: AFSGD/WLNZUAXvqeDAB3wTMU5f8fRrukAKTws78kvI2XuNeBwS3mLMrsixk9GaOGqWsel1TdnhrDDg==
X-Received: by 2002:a62:ab0d:: with SMTP id p13mr13160505pff.211.1544463407381; 
 Mon, 10 Dec 2018 09:36:47 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:91e:2c01:40e1:a028:b090:9e12])
 by smtp.gmail.com with ESMTPSA id q1sm15998396pfb.96.2018.12.10.09.36.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 09:36:46 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org, tglx@linutronix.de,
 jason@lakedaemon.net, marc.zyngier@arm.com, daniel.lezcano@linaro.org,
 gregkh@linuxfoundation.org, jslaby@suse.com
Subject: [PATCH v4 05/15] ARM: dts: Add devicetree for RDA8810PL SoC
Date: Mon, 10 Dec 2018 23:05:40 +0530
Message-Id: <20181210173550.29643-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181210173550.29643-1-manivannan.sadhasivam@linaro.org>
References: <20181210173550.29643-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_093650_126911_09327110 
X-CRM114-Status: GOOD (  14.15  )
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
