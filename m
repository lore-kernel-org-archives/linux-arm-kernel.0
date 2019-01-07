Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A48AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:59:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A1282173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Bwtd3OqM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A1282173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=bi6+7k10HDz51bbBTTAGEuSxIJwVQNNWUA/xo2y1tJU=; b=Bwtd3OqMnjKEIY
	AJkDbrrQyP7aeb5+yREMpSyXWSKF0jua7LQRMsGHmJc/ihtINyBhqOPQJMJXxaGIqtoDY69af6sxM
	leHgNdpUyAgP4yG3RFMfmWMOhySb9MJZXG9E8Hd3nMzzHrYc4SBpHIsrLnSyQs01PbFqS5PVqlVyL
	/7qy15kzezzCql8FcmIte12YJwcjt5th7LTH8UEVVyBLU+xZ5A6In63ZRNfA0PuvgN3sJi1ZO7ff3
	exlNI6UPc1hmakLCBlqG4oxXdpfUZXnguHdHIgK7y3DddVmMTm5loU87fFH5Eavw25yxNSl+E8C0n
	CKiwwB/Lh4326fUuwcqQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggb3P-0001YV-Nl; Mon, 07 Jan 2019 19:59:19 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggb3N-0001Y7-Dq
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 19:59:18 +0000
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1ggb3H-0003Df-Uv; Mon, 07 Jan 2019 20:59:11 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1ggb3H-0006cA-GH; Mon, 07 Jan 2019 20:59:11 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v2] MAINTAINERS: add all files matching "imx" and "mxs" to the
 IMX entry
Date: Mon,  7 Jan 2019 20:59:08 +0100
Message-Id: <20190107195908.3298-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_115917_622591_983CD4DF 
X-CRM114-Status: GOOD (  12.11  )
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Robin Gong <yibin.gong@nxp.com>,
 NXP Linux Team <linux-imx@nxp.com>, kernel@pengutronix.de,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VGhpcyB3YXkgYWxzbyB0aGUgc3BpLCBpMmMgYW5kIG90aGVyIGRyaXZlcnMgYXJlIGNvdmVyZWQu
IFRoZXJlIGFyZSBzb21lCng4NiBzcGVjaWZpYyBjaGlwcyBpbiBtZWRpYS9pMmMgdGhhdCBpbmNs
dWRlIGlteCBpbiB0aGVpciBuYW1lIHdoaWNoCmRvbid0IGhhdmUgYW55dGhpbmcgdG8gZG8gd2l0
aCB0aGUgTlhQIHBsYXRmb3JtcyBhbmQgc28gYXJlIGV4cGxpY2l0bHkKZXhjbHVkZWQuCgpTaWdu
ZWQtb2ZmLWJ5OiBVd2UgS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4
LmRlPgotLS0KSGVsbG8sCgpTaGF3biByZXF1ZXN0ZWQgZm9yIHRoZSAoaW1wbGljaXQpIHYxIHRv
IHJlc2VuZCBvbiB0b3Agb2YgNC4yMS1yYzEuCldlbGwsIHRoZXJlIGlzIG5vIDQuMjEtcmMxLCBi
dXQgSSB0aGluayA1LjAtcmMxIGlzIGp1c3QgYXMgZ29vZCA6LSkKCk5ldyBzaW5jZSB0aGlzIHYx
IGlzIHRoZSBleGNsdXNpb24gb2YgZHJpdmVycy9tZWRpYS9pMmMvIHBvaW50ZWQgb3V0IHRvCmJl
IG5lY2Vzc2FyeSBieSBSb2JlcnQgU2Nod2ViZWwuCgpCZXN0IHJlZ2FyZHMKVXdlCgogTUFJTlRB
SU5FUlMgfCAxMyArKystLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCsp
LCAxMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJT
CmluZGV4IDMyZDQ0NDQ3NmE5MC4uZTM3MTU4Mzg4Njc3IDEwMDY0NAotLS0gYS9NQUlOVEFJTkVS
UworKysgYi9NQUlOVEFJTkVSUwpAQCAtMTUzNiwxNiArMTUzNiw5IEBAIFI6CU5YUCBMaW51eCBU
ZWFtIDxsaW51eC1pbXhAbnhwLmNvbT4KIEw6CWxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZyAobW9kZXJhdGVkIGZvciBub24tc3Vic2NyaWJlcnMpCiBTOglNYWludGFpbmVkCiBU
OglnaXQgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3NoYXdu
Z3VvL2xpbnV4LmdpdAotRjoJYXJjaC9hcm0vbWFjaC1pbXgvCi1GOglhcmNoL2FybS9tYWNoLW14
cy8KLUY6CWFyY2gvYXJtL2Jvb3QvZHRzL2lteCoKLUY6CWFyY2gvYXJtL2NvbmZpZ3MvaW14Kl9k
ZWZjb25maWcKLUY6CWFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteCoKLUY6CWRyaXZl
cnMvY2xrL2lteC8KLUY6CWRyaXZlcnMvZmlybXdhcmUvaW14LwotRjoJZHJpdmVycy9zb2MvaW14
LwotRjoJaW5jbHVkZS9saW51eC9maXJtd2FyZS9pbXgvCi1GOglpbmNsdWRlL3NvYy9pbXgvCitO
OglpbXgKK046CW14cworWDoJZHJpdmVycy9tZWRpYS9pMmMvCiAKIEFSTS9GUkVFU0NBTEUgVllC
UklEIEFSTSBBUkNISVRFQ1RVUkUKIE06CVNoYXduIEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz4K
LS0gCjIuMjAuMQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LWFybS1rZXJuZWwK
