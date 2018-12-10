Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B901C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:48:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 250D82081F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z/u8eKPi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 250D82081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rI0OIHiLZl1Zztj0cpCl0Pttp71myLLFly1hy5OB/d0=; b=Z/u8eKPi2BkWrT
	GmZ9D5SkJeCVO8St9MEK8jONb3MTFoCCb1SMMKUK6tSOiSzrL4qp7EXC17nEVSqdJOwwub37OTMb/
	x8CZjsGc4NZkutHP2qSDyYnbBq7D+9pUNcdxhHjB1ngU5f8aGRkbcy2Jot1IChm+aTPZFsdGzegkF
	dPRNE//jB9jgFcVgAbrhd63jdkaR7+CZgLMjyvpvuxHR1E1EYUWLs3Cxu2e4RbJCp8yWRGO+ny+dV
	pOjcvOy1K6oaRMPnjnnGll0wcBWuXZz0octtGlA3s6gmCHRHjJrSKCClJv6oWxjK7jNP15wXJtmze
	b2grmY/rxU6tH8xiMrCQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWGIQ-0003wE-L5; Mon, 10 Dec 2018 07:48:06 +0000
Received: from mail-pf1-f175.google.com ([209.85.210.175])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWGIB-0003iu-4G
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 07:47:52 +0000
Received: by mail-pf1-f175.google.com with SMTP id b7so4981046pfi.8
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 09 Dec 2018 23:47:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UhRgpVquec8XdncR9zxvGOTgW94zuTWFGIjVTosf9/k=;
 b=DvJc8SFKcmCn3WuVGNxkANfKssvn2HMdkqc8oZCTsTijXY2zsRNB3D5nInsYuGBQXo
 wpXYTuZT/VPdZs6/cb1BmwHvzd4IaGODOkUmAJVjJwhKTGjLCLcm2HPsOGZNJ+afftf6
 2RvGPOXFaAswfgp7HfClQxrSJjI6k5iTjsDPcvzjzqJ+3dL05zSoihrBy2buq6ZraOxf
 I4xEXEPLKkGQ53palRmzQXXwYbcKDUbvms1CIhoA6N0DxiD1NnLxDK273uS/+yDi9Hr5
 fUah9FpkCGQ8soS6Nh5yS8pq6zWnTkNevEldQJPK9K/vFc/sXzKQ1Ec4PiaPlD7o8mTo
 yvoA==
X-Gm-Message-State: AA+aEWaN1XBlSbPlsvbQNezrQQizNDIb3gS83NF/6bQwuDYPfvL/CyUC
 yUcjl21W3ryqKutMZhdw4yEMxlE5EZbvGw==
X-Google-Smtp-Source: AFSGD/VZS8Uk3W+rJy/B6ySdmYeOYqDc4wisGzxcPs5NICZkySuPMT/5pglL90fQwhzkgATumbPXnA==
X-Received: by 2002:a62:d74d:: with SMTP id v13mr11213931pfl.34.1544428060309; 
 Sun, 09 Dec 2018 23:47:40 -0800 (PST)
Received: from localhost.localdomain (61-216-91-114.HINET-IP.hinet.net.
 [61.216.91.114])
 by smtp.gmail.com with ESMTPSA id c13sm14363809pfo.121.2018.12.09.23.47.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 09 Dec 2018 23:47:39 -0800 (PST)
From: Shawn Guo <shawnguo@kernel.org>
To: arm@kernel.org
Subject: [GIT PULL 2/7] i.MX SoC changes for 4.21
Date: Mon, 10 Dec 2018 15:46:33 +0800
Message-Id: <20181210074638.27873-2-shawnguo@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181210074638.27873-1-shawnguo@kernel.org>
References: <20181210074638.27873-1-shawnguo@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_234751_179435_972CC02D 
X-CRM114-Status: GOOD (  14.99  )
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 linux-imx@nxp.com, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCA2NTEwMjIzODJjN2Y4ZGE0NmNiNDg3
MmE1NDVlZTFkYTZkMDk3ZDJhOgoKICBMaW51eCA0LjIwLXJjMSAoMjAxOC0xMS0wNCAxNTozNzo1
MiAtMDgwMCkKCmFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0OgoKICBnaXQ6
Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvc2hhd25ndW8vbGludXgu
Z2l0IHRhZ3MvaW14LXNvYy00LjIxCgpmb3IgeW91IHRvIGZldGNoIGNoYW5nZXMgdXAgdG8gZGU3
MGQwZTlkNDNkZDVmYTg5OWNlM2ExNTYwYTRkMjUzNmI2YjcxZToKCiAgQVJNOiBpbXg6IGFkZCBp
bml0aWFsIHN1cHBvcnQgZm9yIGlteDd1bHAgKDIwMTgtMTItMTAgMDg6NTY6MzAgKzA4MDApCgot
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tCmkuTVggU29DIGNoYW5nZXMgZm9yIDQuMjE6CiAtIEFuIGltcHJvdmVtZW50IG9uIGku
TVggZGVidWdnaW5nIG9wdGlvbnMgdGhhdCBvbmx5IGRlZmluZXMKICAgREVCVUdfSU1YX1VBUlRf
UE9SVCBpZiBuZWVkZWQsIHNvIHRoYXQgdGhlIG9wdGlvbiB3aWxsIG5vdCBiZSBwcmVzZW50CiAg
IGluIHRoZSBrZXJuZWwgY29uZmlnIHdoZW4gREVCVUdfTEwgaXMgZGlzYWJsZWQuCiAtIEFkZHMg
dGhlIG5lY2Vzc2FyeSBwbGF0Zm9ybSBzdXBwb3J0IGZvciBpLk1YN1VMUCBTb0MgYW5kIGNvbmZp
Z3VyZXMKICAgcG93ZXIgbW9kZSB0byBQYXJ0aWFsIFN0b3AgbW9kZSAzIHdpdGggc3lzdGVtL2J1
cyBjbG9jayBlbmFibGVkLgogICBPdGhlcndpc2UgdGhlIGRlZmF1bHQgU1RPUCBtb2RlIHdpbGwg
Z2F0ZSBvZmYgc3lzdGVtL2J1cyBjbG9jayB3aGVuCiAgIFdGSSBnZXRzIGV4ZWN1dGVkIG9uIGku
TVg3VUxQLgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQpBLnMuIERvbmcgKDEpOgogICAgICBBUk06IGlteDogYWRkIGluaXRp
YWwgc3VwcG9ydCBmb3IgaW14N3VscAoKVXdlIEtsZWluZS1Lw7ZuaWcgKDEpOgogICAgICBBUk06
IGRlYnVnLWlteDogb25seSBkZWZpbmUgREVCVUdfSU1YX1VBUlRfUE9SVCBpZiBuZWVkZWQKCiBh
cmNoL2FybS9LY29uZmlnLmRlYnVnICAgICAgICAgICB8IDI4ICsrKysrKysrKysrKysrLS0tLS0t
LS0tLS0tLS0KIGFyY2gvYXJtL21hY2gtaW14L0tjb25maWcgICAgICAgIHwgIDkgKysrKysrKysr
CiBhcmNoL2FybS9tYWNoLWlteC9NYWtlZmlsZSAgICAgICB8ICAxICsKIGFyY2gvYXJtL21hY2gt
aW14L2NvbW1vbi5oICAgICAgIHwgIDEgKwogYXJjaC9hcm0vbWFjaC1pbXgvY3B1LmMgICAgICAg
ICAgfCAgMyArKysKIGFyY2gvYXJtL21hY2gtaW14L21hY2gtaW14N3VscC5jIHwgMzEgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKwogYXJjaC9hcm0vbWFjaC1pbXgvbXhjLmggICAgICAg
ICAgfCAgMSArCiBhcmNoL2FybS9tYWNoLWlteC9wbS1pbXg3dWxwLmMgICB8IDI5ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrCiA4IGZpbGVzIGNoYW5nZWQsIDg5IGluc2VydGlvbnMoKyks
IDE0IGRlbGV0aW9ucygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtL21hY2gtaW14L21h
Y2gtaW14N3VscC5jCiBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm0vbWFjaC1pbXgvcG0taW14
N3VscC5jCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
aW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC1hcm0ta2VybmVsCg==
