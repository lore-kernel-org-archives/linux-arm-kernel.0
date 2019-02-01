Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E60C282DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 19:17:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A3D1218FC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 19:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hGhtFlzh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kG/Bp0NF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A3D1218FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=VGz0mq4HckHCQp6uivvf0IWDdiwrgoWQwNiYqtcjMXM=; b=hGhtFlzhIYA0IK
	v69G9HOVJbFlfHoLx0DpyoiAcRwxrIKfP39xFF1+Q4VXhizTA5bMX4CrdgqAHbVfMCQ6hKZixa/Pt
	wKVdw0ISXBD2NfiDPe+jNobT1+OVKRPkH0c9de64knB0iHMP69YceeYp3U/XjBwbsvxlYpBEPueDK
	8aAF8/GW5mntHenmLex3L4+cEUqPuJAmD74aCSk6NTHObe6+eDgxDW8DjgF9R3np+cm7TkG6x+3u5
	Snc6kx03RzUZoiibygwmjJRS1TTEdEsAan8lFAHWRCXPL858tgRgL3TF4YmIppnfEKslvim7x+iOk
	IZMt+lJxnB/WBU9CJ6VQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpeJi-0001Xh-C4; Fri, 01 Feb 2019 19:17:34 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpeJe-0001X4-7n
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 19:17:31 +0000
Received: from localhost.localdomain (80-123-14-12.adsl.highway.telekom.at
 [80.123.14.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D4755218AF;
 Fri,  1 Feb 2019 19:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549048648;
 bh=75ZLFiPwniMlgo+gqWi2At3BvFJjbUDFyJ5A/S0sIZI=;
 h=From:To:Cc:Subject:Date:From;
 b=kG/Bp0NF1+rSBM9U/p53+1Q1JDA3bPlLoZ/pRM+dqo3JDMwsBxCw1CZrTsgQJvO8Z
 90HM85deqNXwYr6SfQRYtA1r+M5q43BpNtIJBKXNTJL6kx+Hg2ayWyM8MWNx3I1EMe
 bgHPLJ9z7Te//t4Piyc+lOaV4VVXkdpHTRhsc0QQ=
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
 arm@kernel.org
Subject: [GIT PULL 1/2] ARM: defconfig: Samsung for v5.1
Date: Fri,  1 Feb 2019 20:17:19 +0100
Message-Id: <20190201191720.20464-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_111730_299649_96B654FD 
X-CRM114-Status: GOOD (  10.67  )
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
Cc: linux-samsung-soc@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Krzysztof Kozlowski <krzk@kernel.org>,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCBiZmVmZmQxNTUyODM3NzJiYmU3OGM2
YTA1ZGVjN2MwMTI4ZWU1MDBjOgoKICBMaW51eCA1LjAtcmMxICgyMDE5LTAxLTA2IDE3OjA4OjIw
IC0wODAwKQoKYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9zaXRvcnkgYXQ6CgogIGh0dHBz
Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2tyemsvbGludXguZ2l0
IHRhZ3Mvc2Ftc3VuZy1kZWZjb25maWctNS4xCgpmb3IgeW91IHRvIGZldGNoIGNoYW5nZXMgdXAg
dG8gMjVjMzkwZWMyMjE2N2Y4OTZkYmY1ZmI2MWI4NjlhZDA1Y2UyNzNmZjoKCiAgQVJNOiBzNXB2
MjEwX2RlZmNvbmZpZzogRW5hYmxlIGNwdWZyZXEgKDIwMTktMDEtMTMgMTA6MzE6MTcgKzAxMDAp
CgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tClNhbXN1bmcgZGVmY29uZmlnIGNoYW5nZXMgZm9yIHY1LjEKCkVuYWJsZSBtb3Jl
IGRyaXZlcnMgaW4gczVwdjIxMCBkZWZjb25maWcgZm9yIEFyaWVzIGZhbWlseSBvZiBtb2JpbGUK
ZGV2aWNlcyAoZS5nLiBTYW1zdW5nIEdhbGF4eSBTKS4KCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KUGF3ZcWCIENobWllbCAo
Myk6CiAgICAgIEFSTTogczVwdjIxMF9kZWZjb25maWc6IFJ1biBtYWtlIHNhdmVkZWZjb25maWcK
ICAgICAgQVJNOiBzNXB2MjEwX2RlZmNvbmZpZzogRW5hYmxlIG1vcmUgZHJpdmVycyBwcmVzZW50
IG9uIFNhbXN1bmcgQXJpZXMKICAgICAgQVJNOiBzNXB2MjEwX2RlZmNvbmZpZzogRW5hYmxlIGNw
dWZyZXEKCiBhcmNoL2FybS9jb25maWdzL3M1cHYyMTBfZGVmY29uZmlnIHwgNDcgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAzNiBpbnNlcnRp
b25zKCspLCAxMSBkZWxldGlvbnMoLSkKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
