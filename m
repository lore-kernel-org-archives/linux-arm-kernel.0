Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7100EC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:37:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35C092083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XLjTvf3I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35C092083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4LMkLd+C7nYK9HzWy0bgcb1lHREhHIMXWqo8M0MVdh8=; b=XLjTvf3Icu77cw
	nqxXxXYTW5Qf6/diGAevSMngD2a3MGtjNb908eS7vhwUpzAwEyqyCvMIYhvT5xPKGcOrmuo0fL89B
	2oAo+jPYTI02BlC4JpZ0Np0qIZOqph+VuQCE2pJGw2tbDzgmqxHF1nxhKJ2ECO98espxYOHwn0qV9
	cRFL6gQY8t0hyiXJgSXRYo6kATIj7YyJWuX1yVSFDGsAOw9nmNofuXoCFqTmhE3sjCgq/oswzxd7I
	Ssneh/1GnPa2V4BElQMKSnOD7t4mDuPtM9UYZFcvmvLcJl+5f8vMmH8ZPMXvYN99Q0MsveJm8KZgG
	tKTcB1jPfX+wNAHlYqvQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtWN7-00071g-LV; Tue, 12 Feb 2019 11:37:05 +0000
Received: from mail-pf1-f195.google.com ([209.85.210.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtW8h-0000K0-3C
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 11:22:24 +0000
Received: by mail-pf1-f195.google.com with SMTP id g6so1130245pfh.13
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 03:22:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4qJEp/R0AKgirfHfR/NjTBrlQLKCWcKCCIEXzvSzyQ0=;
 b=dFKCFOQ3f0EakjcxJf7tHfs13NG9GNHrWChIOmkedR5I2+6LfYvsUppTVE19SrC3Q2
 i078VdP/1DUA1MTHqgf5SDoOIUqTGuUlxwh/ZF6zXiccZzVBKhNQhGwI33V+ZaUh4P7s
 mBuk/UQpMeMpKg/CWLEyw4hhmCUrnOoeBvlakkMiUfVTMW3Uqxa6XRAwHokBsoXuiRxr
 iXZ9AJ+lpVaTHpCL6u+NOdeELBWnU8JQZ0F2luBlVQjefcPZNymc4MbSnkoQKt2Eaoo/
 D+UHbRjOSh9ryUOIR+oZGoV7ftdrOb4FLCAUCWhu3vfhewMmGpSgCkVkclTuHf2vZb6l
 AEWw==
X-Gm-Message-State: AHQUAuaJfpK691zcpXew1RZuMEKhV4VANDLWUeFwYwioVt89AkQHPjf8
 ngPLFKjfi35g7QlXMKfEbszMqQ==
X-Google-Smtp-Source: AHgI3IZc6PK4P2nog20mBp9OlySK9VUTk/kFGfIWmill1Z1uwI2tCRZKfL0IXNX7m36rroJyb1yNoQ==
X-Received: by 2002:a63:ef47:: with SMTP id c7mr3205931pgk.386.1549970530326; 
 Tue, 12 Feb 2019 03:22:10 -0800 (PST)
Received: from localhost.localdomain (61-216-91-114.HINET-IP.hinet.net.
 [61.216.91.114])
 by smtp.gmail.com with ESMTPSA id s16sm22282264pfk.166.2019.02.12.03.22.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 12 Feb 2019 03:22:09 -0800 (PST)
From: Shawn Guo <shawnguo@kernel.org>
To: arm@kernel.org
Subject: [GIT PULL 7/7] i.MX MAINTAINERS update for 5.1
Date: Tue, 12 Feb 2019 19:21:26 +0800
Message-Id: <20190212112126.572-7-shawnguo@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190212112126.572-1-shawnguo@kernel.org>
References: <20190212112126.572-1-shawnguo@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_032211_571253_E014480F 
X-CRM114-Status: GOOD (  10.77  )
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
Cc: linux-arm-kernel@lists.infradead.org, Shawn Guo <shawnguo@kernel.org>,
 Fabio Estevam <festevam@gmail.com>, linux-imx@nxp.com, kernel@pengutronix.de
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCBiZmVmZmQxNTUyODM3NzJiYmU3OGM2
YTA1ZGVjN2MwMTI4ZWU1MDBjOgoKICBMaW51eCA1LjAtcmMxICgyMDE5LTAxLTA2IDE3OjA4OjIw
IC0wODAwKQoKYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9zaXRvcnkgYXQ6CgogIGdpdDov
L2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9zaGF3bmd1by9saW51eC5n
aXQgdGFncy9pbXgtbWFpbnRhaW5lcnMtNS4xCgpmb3IgeW91IHRvIGZldGNoIGNoYW5nZXMgdXAg
dG8gMTdmZmMxMTkzYTRiNTYxMDQwMGM0MzYyM2E0MzExNWYzZDJlMTVhNjoKCiAgTUFJTlRBSU5F
UlM6IGlteDogQ2hhbmdlIEZhYmlvJ3MgZW1haWwgYWRkcmVzcyAoMjAxOS0wMS0yMiAxNDowMjoz
OCArMDgwMCkKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0KaS5NWCBNQUlOVEFJTkVSUyB1cGRhdGUgZm9yIDUuMToKIC0gQWRk
IGFsbCBmaWxlcyBtYXRjaGluZyAiaW14IiBhbmQgIm14cyIgdG8gdGhlIElNWCBlbnRyeSwgc28g
dGhhdCB3ZQogICBjYW4gZ2V0IGNvcGllZCBvbiBhbGwgSU1YIHJlbGF0ZWQgY2hhbmdlcyB3aXRo
b3V0IGV4cGxpY2l0bHkgbGlzdGluZwogICBzbyBtYW55IGZpbGVzIGFuZCBmb2xkZXJzLgogLSBV
cGRhdGUgRmFiaW8ncyBlbWFpbCBhZGRyZXNzLgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpGYWJpbyBFc3RldmFtICgxKToK
ICAgICAgTUFJTlRBSU5FUlM6IGlteDogQ2hhbmdlIEZhYmlvJ3MgZW1haWwgYWRkcmVzcwoKVXdl
IEtsZWluZS1Lw7ZuaWcgKDEpOgogICAgICBNQUlOVEFJTkVSUzogYWRkIGFsbCBmaWxlcyBtYXRj
aGluZyAiaW14IiBhbmQgIm14cyIgdG8gdGhlIElNWCBlbnRyeQoKIE1BSU5UQUlORVJTIHwgMTUg
KysrKy0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxMSBkZWxl
dGlvbnMoLSkKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LWFybS1rZXJuZWwK
