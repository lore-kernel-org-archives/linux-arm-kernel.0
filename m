Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6979C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:09:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 755892133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NXxyrZkn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AlJdw/uG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 755892133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eOhHdk1XemnNWVMxYnZzuujZKhjmKFPHu9dFNspo8Ew=; b=NXxyrZkn09Uoxl
	zOtsKND9zxXJTZu1DCvh8UGznXcLAWRsJXCgBnmJJiLxH0xdBefmkFMS76/rHKDSc2tf3OL+Gj7/M
	y8ovYpXxFO07dV0Jyf2qo4GGaiTeGo2v+0npqYps+IGfOoE5laGF829kHuQWqv49pht+KPfv7oRD+
	ICRJM6BPH4u5rXSdnSX5lnbjgEkwTloEogIUpWx1Xj15DU3lfqYDl+3tmBwofi5BtPRFp1jgWjV0D
	Dn/B2hoaLTFLZk3xzWcLM6M736/oTJnI5FNdmuSzUZPlcNTbRAuyBNOEHfdRxwoNf1XyLmS57IWQW
	1v7nX46OURbw1khRJb6w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZARK-0001wC-7m; Tue, 18 Dec 2018 08:09:18 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZAPQ-0000B7-Ar
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 08:07:35 +0000
Received: by mail-pg1-x544.google.com with SMTP id n2so7454038pgm.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 00:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=k96hsxZolu1sa/Mqv9NhVh1bJBzRAtxF7fEifhZ67Nk=;
 b=AlJdw/uGz7czICwip0ZrTr6cytQi+WuqGoK8Q4UAWR1xoSCWyM01f4JHZQfZVAh8V3
 28eRju5jVt+QgYmhyV04LXH19DGed8R3Aas1MlVsV/pxHq5wkHPKo76/muGeO+BpnJ0y
 3SFc7WmmnDpKoLk7oEvrOHrHSMKld7/ss6VJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=k96hsxZolu1sa/Mqv9NhVh1bJBzRAtxF7fEifhZ67Nk=;
 b=pp+wvZ9MUF3z67Fbd7PxAc6nB1akWfBKVshTIp9qCn+kM87yMqHz2qLHDvEqePUfsw
 naSqFEUHE1o5WFS/rVvLGfdc+4Z6Tba6CWyd4BgjArZKverlflxob6+z1MYQ83Ur35Ws
 wZO741RGDRxyiIQdx+xeClXtO0udVnz9du7hXJl65ivDfrVheE7+Oh1CahHT+Ic2zFi6
 +nEcFtogJE5ES3By4mskSUhCxXYGc/jKI27dbw/HeansEwQ2mqhg3lZ30emCDNw4mljG
 CaEePvD3hCc9KIB8T+viQqSSEvrT5Ge3hzGuFSaZtLmf+TMhNEZpny4CqIn6n7OAZNKw
 zoJA==
X-Gm-Message-State: AA+aEWZiggj9woMdRw0IXVvytyR17QnVvTaw2BUXx2SsBLajQVD+Qdcs
 mHdB+LaVmBNHzxRF/iFMbXQ6
X-Google-Smtp-Source: AFSGD/WnNDgfAlNIocxOUgnw+OlEO21Ineonsurmn17j12sYazsxrWIyyCVy3D6ufwJHJ+fho0nnaA==
X-Received: by 2002:a63:2054:: with SMTP id r20mr14819276pgm.328.1545120429504; 
 Tue, 18 Dec 2018 00:07:09 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
 by smtp.gmail.com with ESMTPSA id 7sm45596888pfm.8.2018.12.18.00.07.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Dec 2018 00:07:08 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
 gregkh@linuxfoundation.org, jslaby@suse.com
Subject: [PATCH v6 11/11] MAINTAINERS: Add entry for RDA Micro SoC architecture
Date: Tue, 18 Dec 2018 13:35:27 +0530
Message-Id: <20181218080527.10801-12-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218080527.10801-1-manivannan.sadhasivam@linaro.org>
References: <20181218080527.10801-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_000720_818066_81B59E90 
X-CRM114-Status: UNSURE (   9.32  )
X-CRM114-Notice: Please train this message.
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

QWRkIE1BSU5UQUlORVJTIGVudHJ5IGZvciBSREEgTWljcm8gU29DIGFyY2hpdGVjdHVyZSB3aXRo
IG15c2VsZgphcyB0aGUgbWFpbnRhaW5lci4KClNpZ25lZC1vZmYtYnk6IE1hbml2YW5uYW4gU2Fk
aGFzaXZhbSA8bWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFyby5vcmc+Ci0tLQogTUFJTlRBSU5F
UlMgfCAxNCArKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJTCmluZGV4IDZjM2ZiYmIzNjFm
OC4uN2YyYWUyZWQ1M2Y0IDEwMDY0NAotLS0gYS9NQUlOVEFJTkVSUworKysgYi9NQUlOVEFJTkVS
UwpAQCAtMTk0NSw2ICsxOTQ1LDIwIEBAIE06CUxlbm5lcnQgQnV5dGVuaGVrIDxrZXJuZWxAd2Fu
dHN0b2ZseS5vcmc+CiBMOglsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcgKG1v
ZGVyYXRlZCBmb3Igbm9uLXN1YnNjcmliZXJzKQogUzoJTWFpbnRhaW5lZAogCitBUk0vUkRBIE1J
Q1JPIEFSQ0hJVEVDVFVSRQorTToJTWFuaXZhbm5hbiBTYWRoYXNpdmFtIDxtYW5pdmFubmFuLnNh
ZGhhc2l2YW1AbGluYXJvLm9yZz4KK0w6CWxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZyAobW9kZXJhdGVkIGZvciBub24tc3Vic2NyaWJlcnMpCitMOglsaW51eC11bmlzb2NAbGlz
dHMuaW5mcmFkZWFkLm9yZyAobW9kZXJhdGVkIGZvciBub24tc3Vic2NyaWJlcnMpCitTOglNYWlu
dGFpbmVkCitGOglhcmNoL2FybS9ib290L2R0cy9yZGE4ODEwcGwtKgorRjoJZHJpdmVycy9jbG9j
a3NvdXJjZS90aW1lci1yZGEuYworRjoJZHJpdmVycy9pcnFjaGlwL2lycS1yZGEtaW50Yy5jCitG
Oglkcml2ZXJzL3R0eS9zZXJpYWwvcmRhLXVhcnQuYworRjoJRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2FybS9yZGEudHh0CitGOglEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvcmRhLDg4MTBwbC1pbnRjLnR4dAorRjoJRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NlcmlhbC9yZGEsODgxMHBsLXVhcnQudHh0CitG
OglEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdGltZXIvcmRhLDg4MTBwbC10aW1l
ci50eHQKKwogQVJNL1JFQUxURUsgQVJDSElURUNUVVJFCiBNOglBbmRyZWFzIEbDpHJiZXIgPGFm
YWVyYmVyQHN1c2UuZGU+CiBMOglsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcg
KG1vZGVyYXRlZCBmb3Igbm9uLXN1YnNjcmliZXJzKQotLSAKMi4xNy4xCgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWls
aW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
