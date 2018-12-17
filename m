Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB22C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:37:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 598F220578
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sMJ3SNOv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="p5owKd9/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 598F220578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nic.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GARPW23Mv2it3D7xWlz9+pnzf2ipR+PjIkCb6JWMZsg=; b=sMJ3SNOv7AAsbx
	6n0nyj8fMlGgEkOpUFkpc8NlkRIo4GUbSNtlM72dr9C8xfjbl8VY7pDB+ja0kyJ3YphQNRUrXlcAR
	l9Ls9zDmlU/N84q0g4+QhdjldRTBLFqcHRGNhOytz9oZEhkTBjkuQjz/hMjhcPrtpqqSMCdIUgRXu
	WPZTkOPUIXef7yns+Gs6nqcm11P24xYfQmUa2SFt9vydqvxX7i4eRJLb5HYbiCFXgs+oNxNnPvqcG
	y4b/NWGD0Mx2uZsYOwc+rHttm6Nl+GABfpaoYpSLilBfK6VgAC2N4foP+wTIrcKWOtew+LpW7ii+k
	SKPO2jj1GLWUDbftcL0w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYuxW-0006bB-NT; Mon, 17 Dec 2018 15:37:30 +0000
Received: from mail.nic.cz ([217.31.204.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYuxS-0006Yr-UF
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 15:37:28 +0000
Received: from dellmb.labs.office.nic.cz (unknown
 [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
 by mail.nic.cz (Postfix) with ESMTP id 5EEBF62E78;
 Mon, 17 Dec 2018 16:37:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
 t=1545061031; bh=brS6IceeqdnjRv78pNjHmb1qn7jgmR7GRLBxofocQXY=;
 h=From:To:Date;
 b=p5owKd9/Ty8XXQzBhNOyRzP1Ko/zXpEUcJBrM5BFyAVeWopEarOQFTLGPDBvOGqY2
 K1edaj+pBFWykXYxUIWINXkM2q4NvJ8BTrEpKSI30oLYGY3fQ0aLZa1iEnUNQ/+e8G
 QlnhVtpIOyLexlCYO93DBBq0MUCfuvXmlrvOorVo=
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To: Jassi Brar <jassisinghbrar@gmail.com>
Subject: [PATCH v1 3/3] arm64: dts: marvell: armada-37xx: add mailbox node
Date: Mon, 17 Dec 2018 16:37:06 +0100
Message-Id: <20181217153706.25873-3-marek.behun@nic.cz>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181217153706.25873-1-marek.behun@nic.cz>
References: <20181217153706.25873-1-marek.behun@nic.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_073727_135563_F1E33B74 
X-CRM114-Status: UNSURE (   8.13  )
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
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VGhpcyBhZGRzIHRoZSByV1RNIEJJVSBtYWlsYm94IG5vZGUgZm9yIGNvbW11bmljYXRpb24gd2l0
aCB0aGUgc2VjdXJlCnByb2Nlc3Nvci4KClNpZ25lZC1vZmYtYnk6IE1hcmVrIEJlaMO6biA8bWFy
ZWsuYmVodW5AbmljLmN6PgotLS0KIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9hcm1hZGEt
Mzd4eC5kdHNpIHwgNyArKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspCgpk
aWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2FybWFkYS0zN3h4LmR0c2kg
Yi9hcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvYXJtYWRhLTM3eHguZHRzaQppbmRleCA0NDcy
YmNkOGY5ZmIuLmM0YzU3OGY3ZDVlMSAxMDA2NDQKLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9t
YXJ2ZWxsL2FybWFkYS0zN3h4LmR0c2kKKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxs
L2FybWFkYS0zN3h4LmR0c2kKQEAgLTMzNCw2ICszMzQsMTMgQEAKIAkJCQljbG9ja3MgPSA8Jm5i
X3BlcmlwaF9jbGsgMTU+OwogCQkJfTsKIAorCQkJcnd0bTogbWFpbGJveEBiMDAwMCB7CisJCQkJ
Y29tcGF0aWJsZSA9ICJtYXJ2ZWxsLGFybWFkYS0zN3h4LXJ3dG0tbWFpbGJveCI7CisJCQkJcmVn
ID0gPDB4YjAwMDAgMHgxMDA+OworCQkJCWludGVycnVwdHMgPSA8R0lDX1NQSSAxOCBJUlFfVFlQ
RV9MRVZFTF9ISUdIPjsKKwkJCQkjbWJveC1jZWxscyA9IDwxPjsKKwkJCX07CisKIAkJCXNkaGNp
MTogc2RoY2lAZDAwMDAgewogCQkJCWNvbXBhdGlibGUgPSAibWFydmVsbCxhcm1hZGEtMzcwMC1z
ZGhjaSIsCiAJCQkJCSAgICAgIm1hcnZlbGwsc2RoY2kteGVub24iOwotLSAKMi4xOC4xCgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtl
cm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5l
bAo=
