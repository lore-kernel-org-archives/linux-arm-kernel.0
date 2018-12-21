Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58124C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:33:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2719121917
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lAwGdvfV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2719121917
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=gk4avoSg7zridkLduCx0P6FNfUvJphYvHxCcv2HVvSA=; b=lAwGdvfVcYKz6W
	xLhyE8ddOjtH+S13VQzzeT2kG/xrGyUIDUuNPIcPxpC5MVMSyv0hAlxlqZT0bkZHUMVJTvj87WgAI
	BEXOZ4S+Iy0lvkmrZh8YGuPnV7y2nPpsm6Pi3BFxJDZX063tN0YrGWA8TeKO/LRUpt5PUSqPzpQsO
	zfGPPYCopzCc6u4s9XeC6VtCbMGg2VFtgaFenD1YU4DQ3BXjXPQvVPEzdIKC5HhbdPyAaMeP6X25n
	KOjBmorFfPMWvkzQYVUCu85ErXz5ICJAzsaygf18//bpSE+UYvcyeqqFvgcAU1GjkzOGVyCU70rJF
	XFUuw3RwgLeXasb3zmTg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaOgA-0007Zo-8E; Fri, 21 Dec 2018 17:33:42 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaOfx-0007Im-IM
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 17:33:31 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 912592072C; Fri, 21 Dec 2018 18:33:15 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
 by mail.bootlin.com (Postfix) with ESMTPSA id 6326720701;
 Fri, 21 Dec 2018 18:33:05 +0100 (CET)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Few fix for pins configuration on Armada 37xx
Date: Fri, 21 Dec 2018 18:32:56 +0100
Message-Id: <20181221173259.8372-1-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_093329_736644_8947D5A0 
X-CRM114-Status: UNSURE (   7.93  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 Antoine Tenart <antoine.tenart@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
 Marcin Wojtas <mw@semihalf.com>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGVsbG8sCgp0aGlzIHNtYWxsIHNlcmllcyBmaXhlcyB3cm9uZyBwaW5zIGNvbmZpZ3VyYXRpb24g
d2UgY3VycmVudGx5IGhhdmUgb24KQXJtYWRhIDM3eHguCgpGb3Igbm93IGl0IGlzIGVzcGVjaWFs
bHkgYW5ub3lpbmcgaXQgd2Ugd2FudCB0byBlbmFibGUgc3VzcGVuZCB0bwpSQU0gZm9yIFBDaWUu
CgpHcmVnb3J5CgpHcmVnb3J5IENMRU1FTlQgKDIpOgogIHBpbmN0cmw6IGFybWFkYS0zN3h4OiBh
ZGQgbWlzc2luZyBwaW46IFBDSWUxIFdha2V1cAogIHBpbmN0cmw6IGR0LWJpbmRpbmdzOiBGaXgg
dGhlIGFybWFkYS0zN3h4IGRvY3VtZW50YXRpb24KCk1hcmVrIEJlaMO6biAoMSk6CiAgcGluY3Ry
bDogYXJtYWRhLTM3eHg6IENvcnJlY3QgbXBwIGRlZmluaXRpb25zCgogLi4uL3BpbmN0cmwvbWFy
dmVsbCxhcm1hZGEtMzd4eC1waW5jdHJsLnR4dCAgIHwgMjQgKysrKysrKysrKysrKystLS0tLQog
ZHJpdmVycy9waW5jdHJsL212ZWJ1L3BpbmN0cmwtYXJtYWRhLTM3eHguYyAgIHwgMTEgKysrKyst
LS0tCiAyIGZpbGVzIGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQoK
LS0gCjIuMTkuMgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LWFybS1rZXJuZWwK
