Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9834DC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:11:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C3AA218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hUFP26PM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJlbedL1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C3AA218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=y9GIoWk5ZuzFiXmWFugMzx/zpZ4p4DsP8fKNaq6Fddo=; b=hUFP26PMPeHqN4
	QkYvjHuxeO065wsZZ+ANhsMbKfALu9zMYM6Lp4KafRGqSk3y5ew1ZFcchBXkTs2QQ3Sd7rmU4ASTR
	1L+f0JdmidfBB6UIfqYQvUq2F36zqOJAZeD79hEkipBBpyPdh6X8uD7k2byQYwyaWWWr4UCoGGdO+
	oGwpefhdMeR86Y/CkNRNg4eXTY/nZa8azWiBkMWy9JvSH3OvXIGgOUel/QHPGJi6+Cz2SX6N3YUUG
	f/4sJyh/eOYX+yIs86K1DwnscdnCAfN9cKPjNDNhlVE76FE6KgeE2w1W5SyYU3e+wslKALQU3oU6C
	WJqYs1AGK5NBgrvZ9M4A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs7oB-00031H-Iw; Fri, 08 Feb 2019 15:11:15 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs7mn-0000L7-Rz
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 15:09:55 +0000
Received: by mail-wm1-x344.google.com with SMTP id g67so3693911wmd.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 07:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ybdYND/tMGv7yWRugKtUjkInLcGbO9ljC2cM4HV3n1c=;
 b=CJlbedL1LqDCJePzZNo2hcOBq/VQlCpojckhAqYKmSvDMkCvlCeu1hlBY/2omtnJ8H
 qoAEC99AafK13wb4x2EKtM59kJtdtyjvyrgqqqNh+LSmiS03yLvl8M1SQQVKeRCgBTSg
 xyktl96sxnm81x2ajDzDlysSkz+NrS4jQCcpj6rvXbnD5fMQSn3186MgT2KPjAnEd9x1
 cnBNjpGTVp8rLaMD0TO1om5dkejqcrJbwinlBYsbTJzjkCLNcpoIj4o4Id9drUQIfJlK
 2VMQytnSqHtSKW/o7Kmu0honb6wFplSRUsLONBS03I+BqMTneUsoqaJjTsLae+a+Dd0X
 rKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ybdYND/tMGv7yWRugKtUjkInLcGbO9ljC2cM4HV3n1c=;
 b=gmATBqsMHpLAOSNcL5N3C+kzBpw+Q3YtC1XIc65w9zeWSnTLMLskOrheyuC7pG+h5I
 6bCr7tRfWUTm/J/h+4W+d1V86RKYFGHSrXfA2TW1A5ww2SjhXMl7a5FH0EqAH+6+5Ruv
 KLt2BMPD6PuamNwQIBM8GYxetxQyBhWmAkBzscFMkARGhkPNGYaxkect2UyNuM4MA0P+
 DEJPBz+RkB/4Rz79xhVpL0ONLS8D5BMw+pIyOZGThD7WC1sWV0uquUxe5V8/Mc/L6Yah
 ohDuMfQsdnyap2yXNKV5n1ufyZySglQt6v1HUdWvjDFzdlRAshsklCYq9EpXcqpkQCll
 7Nqg==
X-Gm-Message-State: AHQUAuatgQE9qfhXfZinvZ9KxNbF/cooC8mhT137YtqpWF0XxZ35uyzl
 AiP5pZJN4rDtSvADv4upSTLAhpJIVj4=
X-Google-Smtp-Source: AHgI3IYYsAQGKB33iuFd9jCW6sq96WcxpdXbWBVIMH0fTpLAuLuK383+2Gy6i0DQKo2Ua80HVgpsmg==
X-Received: by 2002:a1c:4346:: with SMTP id q67mr12587848wma.114.1549638587933; 
 Fri, 08 Feb 2019 07:09:47 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id m4sm24092443wmi.3.2019.02.08.07.09.47
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 08 Feb 2019 07:09:47 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: arm@kernel.org
Subject: [GIT PULL 7/9] ARM: tegra: Device tree changes for v5.1-rc1
Date: Fri,  8 Feb 2019 16:09:33 +0100
Message-Id: <20190208150935.32108-8-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190208150935.32108-1-thierry.reding@gmail.com>
References: <20190208150935.32108-1-thierry.reding@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_070950_868931_0CC594E3 
X-CRM114-Status: GOOD (  11.78  )
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
Cc: linux-tegra@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 linux-arm-kernel@lists.infradead.org, Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgQVJNIFNvQyBtYWludGFpbmVycywKClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21t
aXQgYmZlZmZkMTU1MjgzNzcyYmJlNzhjNmEwNWRlYzdjMDEyOGVlNTAwYzoKCiAgTGludXggNS4w
LXJjMSAoMjAxOS0wMS0wNiAxNzowODoyMCAtMDgwMCkKCmFyZSBhdmFpbGFibGUgaW4gdGhlIEdp
dCByZXBvc2l0b3J5IGF0OgoKICBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tl
cm5lbC9naXQvdGVncmEvbGludXguZ2l0IHRhZ3MvdGVncmEtZm9yLTUuMS1hcm0tZHQKCmZvciB5
b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0byBkZTQ1Yjc4N2RhYjU2M2Q0ZDYyYjA0NTdlODk1MjVi
ZTk0NWRhZTk2OgoKICBBUk06IHRlZ3JhOiBhZGQgImplZGVjLHNwaS1ub3IiIGZsYXNoIGNvbXBh
dGlibGUgYmluZGluZyAoMjAxOS0wMi0wNiAxNDoxNToxOSArMDEwMCkKClRoYW5rcywKVGhpZXJy
eQoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQpBUk06IHRlZ3JhOiBEZXZpY2UgdHJlZSBjaGFuZ2VzIGZvciB2NS4xLXJjMQoK
Q29udGFpbnMgYSBzaW5nbGUgcGF0Y2ggdGhhdCBhZGRzIHRoZSAiamVkZWMsc3BpLW5vciIgY29t
cGF0aWJsZSBzdHJpbmcKd2hlcmUgYXBwcm9wcmlhdGUuCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tClJhZmHFgiBNacWCZWNr
aSAoMSk6CiAgICAgIEFSTTogdGVncmE6IGFkZCAiamVkZWMsc3BpLW5vciIgZmxhc2ggY29tcGF0
aWJsZSBiaW5kaW5nCgogYXJjaC9hcm0vYm9vdC9kdHMvdGVncmExMTQtZGFsbW9yZS5kdHMgICAg
fCAyICstCiBhcmNoL2FybS9ib290L2R0cy90ZWdyYTEyNC1qZXRzb24tdGsxLmR0cyB8IDIgKy0K
IGFyY2gvYXJtL2Jvb3QvZHRzL3RlZ3JhMTI0LW55YW4uZHRzaSAgICAgIHwgMiArLQogYXJjaC9h
cm0vYm9vdC9kdHMvdGVncmExMjQtdmVuaWNlMi5kdHMgICAgfCAyICstCiBhcmNoL2FybS9ib290
L2R0cy90ZWdyYTIwLXRyaW1zbGljZS5kdHMgICB8IDIgKy0KIGFyY2gvYXJtL2Jvb3QvZHRzL3Rl
Z3JhMzAtYmVhdmVyLmR0cyAgICAgIHwgMiArLQogYXJjaC9hcm0vYm9vdC9kdHMvdGVncmEzMC1j
YXJkaHUuZHRzaSAgICAgfCAyICstCiA3IGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwg
NyBkZWxldGlvbnMoLSkKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LWFybS1rZXJuZWwK
