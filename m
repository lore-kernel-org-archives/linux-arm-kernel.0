Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65E8C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:34:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A37EB20834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QdvteaQG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A37EB20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jM/VLXS7yaCu6A0qSFGKERoFxL4mzrRyFrpIMQeWfFk=; b=QdvteaQG8s3PSX
	oxmG9XfiMhjc5usAI/w/V08D/Ua4XPf89G0sWZizhmrjw/LNRstFPXPKG3k48s1LO5tLrdE+0BW6C
	3bI0ZMbQiZIrqnBygk0P5Bug/IG3GhQV+beAmszjMXX0P2CA+f8WNuM2AGJaFAEIS3JP9O3hdWqEN
	lCv+Drtfi1UqDBQrhlsYS5FyHmB+gDuqgnUEj9bf2QpDvJNdDW+Pv7k2qdaHqMMefm9Vv8VWNpZ3u
	Qu6abDJt4+cfkyk63oaJwk8yq4sQSvovb/qL6Xl9INJ/jFmev93eD5uqoC5ZU78A2/x74PUGauN9g
	MOH4Zju8fHhoQTwN+NVg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTZNh-0000GR-EN; Sun, 02 Dec 2018 21:34:25 +0000
Received: from antares.kleine-koenig.org ([94.130.110.236])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTZNJ-0008Jg-60
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 21:34:04 +0000
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
 id D8BB04B7A93; Sun,  2 Dec 2018 22:33:47 +0100 (CET)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Peter Chen <Peter.Chen@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v2 2/3] usb: chipidea: imx: Warn if oc polarity isn't specified
Date: Sun,  2 Dec 2018 22:33:24 +0100
Message-Id: <20181202213325.26017-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181202213325.26017-1-u.kleine-koenig@pengutronix.de>
References: <20181202213325.26017-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_133401_379831_26ED5134 
X-CRM114-Status: UNSURE (   9.46  )
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, linux-usb@vger.kernel.org,
 Matthew Starr <mstarr@hedonline.com>, kernel@pengutronix.de,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VGhlIHBvbGFyaXR5IG9mIHRoZSBvdmVyIGN1cnJlbnQgZGV0ZWN0aW9uIHBpbiBpc24ndCBjb25m
aWd1cmVkIG9uIGkuTVg2LzcKaWYgaXQncyB1bnNwZWNpZmllZCBpbiB0aGUgZGV2aWNlIHRyZWUu
IFNvIHRoZSBhY3R1YWwgY29uZmlndXJhdGlvbiBkZXBlbmRzCm9uIGJvb3Rsb2FkZXIgYmVoYXZp
b3Igd2hpY2ggaXMgYmFkLgoKU28gZW5jb3VyYWdlIHVzZXJzIHRvIGZpeCB0aGVpciBkZXZpY2Ug
dHJlZSBieSBpc3N1aW5nIGEgd2FybmluZyBpbiB0aGlzCmNhc2UuCgpTaWduZWQtb2ZmLWJ5OiBV
d2UgS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRlPgotLS0KIGRy
aXZlcnMvdXNiL2NoaXBpZGVhL2NpX2hkcmNfaW14LmMgfCAyICsrCiAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvY2hpcGlkZWEvY2lfaGRy
Y19pbXguYyBiL2RyaXZlcnMvdXNiL2NoaXBpZGVhL2NpX2hkcmNfaW14LmMKaW5kZXggODBiNGU0
ZWY5YjY4Li4zZGNmZDBkOTdmOTQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdXNiL2NoaXBpZGVhL2Np
X2hkcmNfaW14LmMKKysrIGIvZHJpdmVycy91c2IvY2hpcGlkZWEvY2lfaGRyY19pbXguYwpAQCAt
MTQxLDYgKzE0MSw4IEBAIHN0YXRpYyBzdHJ1Y3QgaW14X3VzYm1pc2NfZGF0YSAqdXNibWlzY19n
ZXRfaW5pdF9kYXRhKHN0cnVjdCBkZXZpY2UgKmRldikKIAl9IGVsc2UgaWYgKG9mX2ZpbmRfcHJv
cGVydHkobnAsICJvdmVyLWN1cnJlbnQtYWN0aXZlLWxvdyIsIE5VTEwpKSB7CiAJCWRhdGEtPm9j
X3BvbF9hY3RpdmVfbG93ID0gMTsKIAkJZGF0YS0+b2NfcG9sX2NvbmZpZ3VyZWQgPSAxOworCX0g
ZWxzZSB7CisJCWRldl93YXJuKGRldiwgIk5vIG92ZXIgY3VycmVudCBwb2xhcml0eSBkZWZpbmVk
XG4iKTsKIAl9CiAKIAlpZiAob2ZfZmluZF9wcm9wZXJ0eShucCwgImV4dGVybmFsLXZidXMtZGl2
aWRlciIsIE5VTEwpKQotLSAKMi4xOS4yCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
