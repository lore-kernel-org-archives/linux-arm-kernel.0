Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3CEC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:34:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6995120834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tYN450Lh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6995120834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=j3VxoZBJmhn6xu51oDCWGAK7aJC1Tcwza8diHXBxbYo=; b=tYN450LhgWNV9S
	phZpzpvqtz+A1e+mh2XmuTEnAE0Lqpab68DfKzyU9QO4qRfo0cE7uaI3ih7syQtwFMTDxU0QQTJzT
	6SdhDi/JeaVrbhDd0SpmeLaqokkkSwx2g+2iMmZPyYHh6Is6xq+DEfFXt3eHFFC4eXuNJrDp2IjJ9
	XSfOlOI8VgYHQtoVka8OkhQmqD4SK9Qo++5JW2116W/q3ovDKLc4p32bIyw9zKy9qVWUwGOE0bvmE
	bWe+WTxoLYUMUW7g634AM2Xs0QHeqe5oZ6b6MY/ZLcLoMYVB/KPoTnUZBy2mP2lvu1nT8EExdFsGa
	4mi3BxDm2Ze/PJf7pKMA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTZNM-0008Kc-1z; Sun, 02 Dec 2018 21:34:04 +0000
Received: from antares.kleine-koenig.org ([94.130.110.236])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTZNJ-0008Jk-4C
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 21:34:02 +0000
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
 id 434584B7A95; Sun,  2 Dec 2018 22:33:49 +0100 (CET)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Peter Chen <Peter.Chen@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v2 3/3] usb: chipidea: imx: allow to configure oc polarity on
 i.MX25
Date: Sun,  2 Dec 2018 22:33:25 +0100
Message-Id: <20181202213325.26017-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181202213325.26017-1-u.kleine-koenig@pengutronix.de>
References: <20181202213325.26017-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_133401_348119_4987245E 
X-CRM114-Status: UNSURE (   9.27  )
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

VXAgdG8gbm93IHRoZSBwb2xhcml0eSBvZiB0aGUgb3ZlciBjdXJyZW50IHBpbiB3YXMgaGFyZCBj
b2RlZCB0byBhY3RpdmUKaGlnaC4gVXNlIHRoZSBhbHJlYWR5IGRlZmluZWQgZGV2aWNlIHRyZWUg
cHJvcGVydGllcyB0byBjb25maWd1cmUgcG9sYXJpdHkKb24gaS5NWDI1LCB0b28uIEluIGRpZmZl
cmVuY2UgdG8gaS5NWDYvNyB1c2UgYWN0aXZlIGhpZ2ggYmVoYXZpb3IgaWYgdGhlCnBvbGFyaXR5
IGlzIHVuc3BlY2lmaWVkIHRvIGtlZXAgY29tcGF0aWJpbGl0eSB0byBleGlzdGluZyBkZXZpY2Ug
dHJlZXMuCgpTaWduZWQtb2ZmLWJ5OiBVd2UgS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUta29lbmln
QHBlbmd1dHJvbml4LmRlPgotLS0KIGRyaXZlcnMvdXNiL2NoaXBpZGVhL3VzYm1pc2NfaW14LmMg
fCAxNSArKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvY2hpcGlkZWEvdXNibWlzY19pbXguYyBiL2RyaXZlcnMv
dXNiL2NoaXBpZGVhL3VzYm1pc2NfaW14LmMKaW5kZXggNGE4ZGUxYjM3ZjY3Li40N2VlZTVjYWRl
ODQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdXNiL2NoaXBpZGVhL3VzYm1pc2NfaW14LmMKKysrIGIv
ZHJpdmVycy91c2IvY2hpcGlkZWEvdXNibWlzY19pbXguYwpAQCAtMTIwLDYgKzEyMCwxNCBAQCBz
dGF0aWMgaW50IHVzYm1pc2NfaW14MjVfaW5pdChzdHJ1Y3QgaW14X3VzYm1pc2NfZGF0YSAqZGF0
YSkKIAkJdmFsICY9IH4oTVgyNV9PVEdfU0lDX01BU0sgfCBNWDI1X09UR19QUF9CSVQpOwogCQl2
YWwgfD0gKE1YMjVfRUhDSV9JTlRFUkZBQ0VfRElGRl9VTkkgJiBNWDI1X0VIQ0lfSU5URVJGQUNF
X01BU0spIDw8IE1YMjVfT1RHX1NJQ19TSElGVDsKIAkJdmFsIHw9IChNWDI1X09UR19QTV9CSVQg
fCBNWDI1X09UR19PQ1BPTF9CSVQpOworCisJCS8qCisJCSAqIElmIHRoZSBwb2xhcml0eSBpcyBu
b3QgY29uZmlndXJlZCBhc3N1bWUgYWN0aXZlIGhpZ2ggZm9yCisJCSAqIGhpc3RvcmljYWwgcmVh
c29ucy4KKwkJICovCisJCWlmIChkYXRhLT5vY19wb2xfY29uZmlndXJlZCAmJiBkYXRhLT5vY19w
b2xfYWN0aXZlX2xvdykKKwkJCXZhbCAmPSB+TVgyNV9PVEdfT0NQT0xfQklUOworCiAJCXdyaXRl
bCh2YWwsIHVzYm1pc2MtPmJhc2UpOwogCQlicmVhazsKIAljYXNlIDE6CkBAIC0xMjksNiArMTM3
LDEzIEBAIHN0YXRpYyBpbnQgdXNibWlzY19pbXgyNV9pbml0KHN0cnVjdCBpbXhfdXNibWlzY19k
YXRhICpkYXRhKQogCQl2YWwgfD0gKE1YMjVfSDFfUE1fQklUIHwgTVgyNV9IMV9PQ1BPTF9CSVQg
fCBNWDI1X0gxX1RMTF9CSVQgfAogCQkJTVgyNV9IMV9VU0JURV9CSVQgfCBNWDI1X0gxX0lQUFVF
X0RPV05fQklUKTsKIAorCQkvKgorCQkgKiBJZiB0aGUgcG9sYXJpdHkgaXMgbm90IGNvbmZpZ3Vy
ZWQgYXNzdW1lIGFjdGl2ZSBoaWdoIGZvcgorCQkgKiBoaXN0b3JpY2FsIHJlYXNvbnMuCisJCSAq
LworCQlpZiAoZGF0YS0+b2NfcG9sX2NvbmZpZ3VyZWQgJiYgZGF0YS0+b2NfcG9sX2FjdGl2ZV9s
b3cpCisJCQl2YWwgJj0gfk1YMjVfSDFfT0NQT0xfQklUOworCiAJCXdyaXRlbCh2YWwsIHVzYm1p
c2MtPmJhc2UpOwogCiAJCWJyZWFrOwotLSAKMi4xOS4yCgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QK
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
