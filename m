Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2636BC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 00:29:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E809B2084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 00:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="isvcVUWf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=stikonas.eu header.i=@stikonas.eu header.b="XWy3tpkf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E809B2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=stikonas.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=5f20wDqzicIdJIP97mQu65eQh4BO1hrKxv6hplaPS0s=; b=isvcVUWfLW2rhI
	IZkrWqpxNTOSOveMNZa7Cz9SU831Nf585xGuYEj7xIWqg6U5H8amU/HyhKzESi4fm6fl012nlr1zw
	X9Z5pgMY9Gd6URRb2lym76wIueXtkCeA8uM0YqYp3SOGCpf5Z5DqGzqowo6RFdpMo2MQ4+d4GQTuw
	KGzUmIcN7cGwF2+fUPLrEOWnxCkS2xBh33JldaZepxGROC645GR9oCYTsQJUJVnk6dZtwZ3HTScuS
	Nykti3AfWvGSwAejcUQ0pNUHMbiWFAYgqK8ZeQBV7PmepxUGqcE/pDOXwqvjfgtJPxZzvqV4NWlqd
	mWmTR5h6iiAT+DXkY5zQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpMiI-00057F-QT; Fri, 01 Feb 2019 00:29:46 +0000
Received: from 0543543c.skybroadband.com ([5.67.84.60] helo=pine.stikonas.eu)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat
 Linux)) id 1gpMiE-00056u-AI
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 00:29:45 +0000
Received: from pine.stikonas.eu (localhost [127.0.0.1])
 by pine.stikonas.eu (Postfix) with ESMTP id 73C2DA05AD9;
 Fri,  1 Feb 2019 00:29:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.10.3 pine.stikonas.eu 73C2DA05AD9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stikonas.eu; s=mail;
 t=1548980974; bh=cs6KWewR97AIEVJKJ9QJT6LoCPlpTDS6WHSa2srpStk=;
 h=From:To:Cc:Subject:Date;
 b=XWy3tpkfSrEVOFJL/F6g2ZX0aVi5xF4240dVW6rhsd3ko9WzCWjZbVN/D9WPKcDq/
 G3e37ViegiObORXxnfrnz1qvzd/cv4VRZDhv48fAdUhQyqpq1jY4YN+TUjIPsDIvNs
 JajsTyen+FdhyYtsSvAoIZZbpKHAxJD4qiOWdqHE=
Received: from localhost.localdomain ([2a02:c7f:1e5d:1600:9da9:cd4c:90a4:3c77])
 by pine.stikonas.eu with ESMTPSA id cbunGu6SU1zLHgAAtWO0jw
 (envelope-from <andrius@stikonas.eu>); Fri, 01 Feb 2019 00:29:34 +0000
From: =?UTF-8?q?Andrius=20=C5=A0tikonas?= <andrius@stikonas.eu>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: dts: rockchip: enable mali power supply on
 rk3399-rockpro64
Date: Fri,  1 Feb 2019 00:29:18 +0000
Message-Id: <20190201002918.30944-1-andrius@stikonas.eu>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_162942_646631_59E0E4BE 
X-CRM114-Status: UNSURE (   8.34  )
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
Cc: =?UTF-8?q?Andrius=20=C5=A0tikonas?= <andrius@stikonas.eu>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

U2lnbmVkLW9mZi1ieTogQW5kcml1cyDFoHRpa29uYXMgPGFuZHJpdXNAc3Rpa29uYXMuZXU+Ci0t
LQogYXJjaC9hcm02NC9ib290L2R0cy9yb2NrY2hpcC9yazMzOTktcm9ja3BybzY0LmR0cyB8IDUg
KysrKysKIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9hcmNo
L2FybTY0L2Jvb3QvZHRzL3JvY2tjaGlwL3JrMzM5OS1yb2NrcHJvNjQuZHRzIGIvYXJjaC9hcm02
NC9ib290L2R0cy9yb2NrY2hpcC9yazMzOTktcm9ja3BybzY0LmR0cwppbmRleCBiZTc4MTcyYWJj
MDkuLmFlODdhODQzMjdmMiAxMDA2NDQKLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9yb2NrY2hp
cC9yazMzOTktcm9ja3BybzY0LmR0cworKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL3JvY2tjaGlw
L3JrMzM5OS1yb2NrcHJvNjQuZHRzCkBAIC0yMTIsNiArMjEyLDExIEBACiAJc3RhdHVzID0gIm9r
YXkiOwogfTsKIAorJmdwdSB7CisJbWFsaS1zdXBwbHkgPSA8JnZkZF9ncHU+OworCXN0YXR1cyA9
ICJva2F5IjsKK307CisKICZpMmMwIHsKIAljbG9jay1mcmVxdWVuY3kgPSA8NDAwMDAwPjsKIAlp
MmMtc2NsLXJpc2luZy10aW1lLW5zID0gPDE2OD47Ci0tIAoyLjE5LjIKCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxp
bmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
