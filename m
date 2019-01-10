Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1766AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:54:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B16B420685
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EKABhMMO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjrkIM7B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B16B420685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XsxPJz+9aBI+QD+CsLDG6kGjCAZ3j/zNQB4cctlwR+s=; b=EKABhMMO0xLvAl
	46wvpGZlfv+vjCWbGMRY5y9Z2WEahPbfo/hUrE+M1Mu36LH9j+Che+U3Wgn9rm556AadGoU0COua/
	lSIrizs+jMqyMNBXt9MkudcR4YgkX7Yf2LCTZ7nIKgkos0BnVYme+yIbjfZ1AfIQybxkFGf6/2wr1
	Fjz8KbDAmJR+oEFAAC8aqTr2yOPdE8VeOmkieggiLB6rdNCpibvkPT7LwizCEiflS129ctzidnYCM
	r/eqHUs2BNCKfZC1k//QEi6LKgsyxcILBlu9NluPeGOypmlAnETm/ENpsWapD8+00fVOuuI2tjVlg
	4lUsXxnBjpPg8ot0z+eQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghhLG-0002kh-C2; Thu, 10 Jan 2019 20:54:18 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghhKK-0001o0-5u
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 20:53:23 +0000
Received: by mail-lf1-x144.google.com with SMTP id y14so9267131lfg.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 12:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KjuAmgjHlhPWg7vZv/M0TlOMAshH0WF7o8w6mNSkFXw=;
 b=CjrkIM7BBTZSRBJobpknJiZPTJU+pWStblRgDCGvIVSFYmeF8Dnz0JCLPNXYGFBJ2c
 5o+YvOuESHL8dY4RS8c0o1kAfJBaNzYdocDRTiLa/ADvs14oRcmd0AGMp2qJpf0bW0ZE
 trmGj2gXokwcGmxiik/0Y20U1LZIkXI0EvzltO+MVeXJSPKRaeptRxqJ21ZlpWH99ZUv
 f+hRpNmVObSMIbaQHg7ehKLsqrndLkWJSTIPk9n3oNLEx41eZj3qBohamSs6bb5Pi4mL
 ulTRXpuIQ/fJBwFMyutuCklpBALlN3FbTiUwRPH92EX0T6WTNAWuYzLtrJoTL/EPYC5M
 xP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KjuAmgjHlhPWg7vZv/M0TlOMAshH0WF7o8w6mNSkFXw=;
 b=oTbMUQKID8NXvukgu7j/hc91BsXKGimbsgq8DCBpRzAki1W9s9I6SucJhtgsdV5pdk
 vdvScLuyl2OOsaOx2RH/vBUM5+GycFFYrAlqeagwlogIyHacMrNCPtrquLzrTezANXD7
 Eju1MjnL2QU+USqvLAm/h0DgT5Wxq9/PLJtnXKchoFem9kQn5D14GXe9ONJM8PQYDFc9
 Ie8wrpKSbuQCn2A138Exhb65roYY/LhSk1ZePbHTVLY6NforFt7tZUIx5xcDWafxK2Zq
 yX/I44eFXz2TV1aMHzXeWbOj73iEr0JjK3j/LIFR9sWbpJ6xAVWQg0xu4UBWW9XlS4z5
 Rewg==
X-Gm-Message-State: AJcUukfQHxKCwDafTHHwkN7u7sYaySvYcC/S6o+1KXszHdn+KXW2U7IS
 EMvnmblpDOWCWOGoe93zhac=
X-Google-Smtp-Source: ALg8bN7adZ008RPmP0J1BWFEJu9/vRj31EhA6mkS1SlBCjLbIJYaMRKGnl7f69G+9tJtXMhStxu3Mw==
X-Received: by 2002:a19:a9d2:: with SMTP id s201mr6402487lfe.154.1547153598199; 
 Thu, 10 Jan 2019 12:53:18 -0800 (PST)
Received: from localhost.localdomain
 ([2a02:a315:5445:5300:5dc1:592c:c674:2869])
 by smtp.googlemail.com with ESMTPSA id
 z7-v6sm15389690lji.42.2019.01.10.12.53.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 10 Jan 2019 12:53:17 -0800 (PST)
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: kgene@kernel.org
Subject: [PATCH v2 4/4] ARM: defconfig: s5pv210: Add cpufreq support
Date: Thu, 10 Jan 2019 21:52:15 +0100
Message-Id: <20190110205215.22030-5-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190110205215.22030-1-pawel.mikolaj.chmiel@gmail.com>
References: <20190110205215.22030-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_125320_553588_A18A459C 
X-CRM114-Status: GOOD (  11.31  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
 viresh.kumar@linaro.org, rjw@rjwysocki.net, linux@armlinux.org.uk,
 krzk@kernel.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VGhpcyBjb21taXQgZW5hYmxlcyBjcHVmcmVxIHN1cHBvcnQgZm9yIGFsbCBzNXB2MjEwIGRldmlj
ZXMuCgpTaWduZWQtb2ZmLWJ5OiBQYXdlxYIgQ2htaWVsIDxwYXdlbC5taWtvbGFqLmNobWllbEBn
bWFpbC5jb20+Ci0tLQogYXJjaC9hcm0vY29uZmlncy9zNXB2MjEwX2RlZmNvbmZpZyB8IDYgKysr
KysrCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvYXJjaC9h
cm0vY29uZmlncy9zNXB2MjEwX2RlZmNvbmZpZyBiL2FyY2gvYXJtL2NvbmZpZ3MvczVwdjIxMF9k
ZWZjb25maWcKaW5kZXggOTUxMTk2YmRmMDA4Li5mZDRmMjhhYWJkYTYgMTAwNjQ0Ci0tLSBhL2Fy
Y2gvYXJtL2NvbmZpZ3MvczVwdjIxMF9kZWZjb25maWcKKysrIGIvYXJjaC9hcm0vY29uZmlncy9z
NXB2MjEwX2RlZmNvbmZpZwpAQCAtMTEsNiArMTEsMTIgQEAgQ09ORklHX0FSQ0hfUzVQVjIxMD15
CiBDT05GSUdfVk1TUExJVF8yRz15CiBDT05GSUdfQVJNX0FQUEVOREVEX0RUQj15CiBDT05GSUdf
Q01ETElORT0icm9vdD0vZGV2L3JhbTAgcncgcmFtZGlzaz04MTkyIGluaXRyZD0weDIwODAwMDAw
LDhNIGNvbnNvbGU9dHR5U0FDMSwxMTUyMDAgaW5pdD0vbGludXhyYyIKK0NPTkZJR19DUFVfRlJF
UT15CitDT05GSUdfQ1BVX0ZSRVFfU1RBVD15CitDT05GSUdfQ1BVX0ZSRVFfREVGQVVMVF9HT1Zf
T05ERU1BTkQ9eQorQ09ORklHX0NQVV9GUkVRX0dPVl9QT1dFUlNBVkU9bQorQ09ORklHX0NQVV9G
UkVRX0dPVl9VU0VSU1BBQ0U9bQorQ09ORklHX0NQVV9GUkVRX0dPVl9DT05TRVJWQVRJVkU9bQog
Q09ORklHX1ZGUD15CiBDT05GSUdfTkVPTj15CiBDT05GSUdfTU9EVUxFUz15Ci0tIAoyLjE3LjEK
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1h
cm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0t
a2VybmVsCg==
