Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA6FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:05:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9960120660
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bPXgqyK7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiw5KuHK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9960120660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=GJwI7ksp3e8E+QoZJAqa4//tlEim/OOItxnX+Lm/lWE=; b=bPXgqyK7AoSKRd
	asI9zT207Oxea1i4Dsw/5XaC7sxfRUvKhSNODho0qQ6fxcoUmyqc7tjn2QflAyLXeVYdB0EzfWJ3Y
	WHD3MqoTaF5s2XRLpXOTI2zZ945UNCCEnmq8jS19RZbkSCcgCO+mlDK3SosyY9AFVxHLcGeKIlSmk
	gt076mTlMnhACXWZ++rVa4mHCLBnpg5pOWZjSDjX+dH6axp6UAOVlzy7IODRzJ3bbEVLRcwkHA5TR
	H/GLpfV6Hbmo+t4AWVdcjMnf92yI4lTwOgLQ2aF3XoU7TO5cTgP25josHUbO4WRw2CZcwHdVh3kMy
	cb/bLscWiiYfYoTm+C3w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggxcs-0000Nr-PF; Tue, 08 Jan 2019 20:05:26 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggxcp-0000MX-GR
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 20:05:24 +0000
Received: by mail-lf1-x143.google.com with SMTP id l10so3870372lfh.9
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 08 Jan 2019 12:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SJBrkvQYfWOzoaWTTYjdTw7rzq10zKkZT5MK8UrU/IU=;
 b=fiw5KuHKyyeVAPm/A/5GyeW05jMOybQc/EdvDw9m69+fnmlovM8+iDvQHB9z+Z8Kqb
 ROYNY6gPBpcagApXBd8S21nHUStCJGUSaMJOUUQXx5YMXDe7C/uAy9wFaUbcwuor27og
 QzrbJqJ3WS3IoH+3ixfJL7djeO1iHD7J+o46oTrwpKLCzI4cyhrhgI+Ls/D6gwGda2km
 ni3ImA0Zj0aV65QywyGohA3FbID9T/5WEijK4roR09J81XUW6KLRWcLxbd6cDkCyr1FN
 Waw5nMb7Sal35izZZBRMJOKuUb2NYBO6IBJsFZoILfXVdwHiV969v+FQeVDmZ0/6/Fi0
 IQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SJBrkvQYfWOzoaWTTYjdTw7rzq10zKkZT5MK8UrU/IU=;
 b=OTzTVO8U/GIGe+yQOnJee1wDIY/Qdp3I3ro1IUn1xaVYeTPHXdvT9cr4UyPSup5mgK
 CJcCVmD134gkSOiyjHHWj6R+EGAxuLIRtpOX5qqsu1k/bz93t7a5v0wb5+ddXuxijzdp
 HvG04xTGpLPxH5HffaEjPj0jMYpNqnSPGWz4A92GjLuXAsH08FgFrpA5AzLSN9ApACDt
 8t+WulaMMgpvmdw0Q6RWEavOfsaqSG2344nn9+PAqUdlF+ub7uTM1tgF701Li2pKxhE1
 4ou0+8f2ei9ckywd1dv1qKst0F4doozjkHXlrImDYtCkkIe22Uydm8n7swrOAaiRzRBa
 M9bw==
X-Gm-Message-State: AJcUukeb7dSpEdaWEEUxrRjnKCOvUTzNnQiHEQIjBoXGySYi67m+/2MF
 nsSqf6LWdMC6pfjrQGKjPpE=
X-Google-Smtp-Source: ALg8bN5syWz6qOlfHuQJsIssj/34FsoXEDQ+ynEG9KcCWM4a6yhNGwBXde77cF54JsBiC8KQYpHfbA==
X-Received: by 2002:a19:5394:: with SMTP id h20mr1909869lfl.75.1546977921665; 
 Tue, 08 Jan 2019 12:05:21 -0800 (PST)
Received: from localhost.localdomain
 ([2a02:a315:5445:5300:d033:e708:8ec7:810d])
 by smtp.googlemail.com with ESMTPSA id
 y23-v6sm14486768ljk.95.2019.01.08.12.05.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Jan 2019 12:05:20 -0800 (PST)
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: kgene@kernel.org
Subject: [PATCH 0/4] ARM: dts: s5pv210: Enable cpufreq support
Date: Tue,  8 Jan 2019 21:05:05 +0100
Message-Id: <20190108200509.30494-1-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_120523_576138_FE2E554E 
X-CRM114-Status: GOOD (  11.09  )
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

VGhpcyBwYXRjaHNldCBlbmFibGVzIGNwdWZyZXEgc3VwcG9ydCB1c2luZyBzNXB2MjEwLWNwdWZy
ZXEgZHJpdmVyLgoKRmlyc3QgcGF0Y2ggYWRkcyBtaXNzaW5nIGRtYyBub2Rlcywgd2hpY2ggYXJl
IHJlcXVpcmVkIGJ5IGRyaXZlci4KClNlY29uZCBwYXRjaCBpcyBjb3NtZXRpYywgaXQgc3RvcHMg
ZHJpdmVyIGZyb20gZmxvb2Rpbmcga2VybmVsIGxvZyB3aXRoCiBtZXNzYWdlcywgYWZ0ZXIgZXZl
cnkgY2hhbmdlIG9mIGZyZXEuCgpUaGlyZCBwYXRjaCBhZGRzIGRlZmVyIHByb2JlIHN1cHBvcnQg
Zm9yIHJlZ3VsYXRvcnMsIG5lZWRlZCBieSBkcml2ZXIuCkl0IHdhcyBvYnNlcnZlZCwgdGhhdCB0
aG9zZSByZWd1bGF0b3JzIGNhbiBiZSBubyB5ZXQgaW5pdGlhbGl6ZWQsIHdoZW4KIGRyaXZlciBp
cyBwcm9iZWQsIHNvIHdlIHNob3VsZCB3YWl0IHRpbGwgd2UgY2FuIGdldCB0aGVtLgoKTGFzdCBw
YXRjaCBlbmFibGVzIHJlcXVpcmVkIGtlcm5lbCBjb25maWcgb3B0aW9ucy4KClBhd2XFgiBDaG1p
ZWwgKDQpOgogIEFSTTogZHRzOiBzNXB2MjEwOiBBZGQgZG1jIG5vZGVzCiAgY3B1ZnJlcTogczVw
djIxMDogRG9uJ3QgZmxvb2Qga2VybmVsIGxvZyBhZnRlciBjcHVmcmVxIGNoYW5nZQogIGNwdWZy
ZXE6IHM1cHYyMTA6IERlZmVyIHByb2JlIGlmIGdldHRpbmcgcmVndWxhdG9ycyBmYWlsCiAgQVJN
OiBkZWZjb25maWc6IHM1cHYyMTA6IEFkZCBjcHVmcmVxIHN1cHBvcnQKCiBhcmNoL2FybS9ib290
L2R0cy9zNXB2MjEwLmR0c2kgICAgIHwgMTIgKysrKysrKysrKwogYXJjaC9hcm0vY29uZmlncy9z
NXB2MjEwX2RlZmNvbmZpZyB8ICA2ICsrKysrCiBkcml2ZXJzL2NwdWZyZXEvczVwdjIxMC1jcHVm
cmVxLmMgIHwgMzUgKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tCiAzIGZpbGVzIGNoYW5n
ZWQsIDM5IGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQoKLS0gCjIuMTcuMQoKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJu
ZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
