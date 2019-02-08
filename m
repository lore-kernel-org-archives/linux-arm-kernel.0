Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083ABC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:16:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB3DF20863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ENLumhg8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="Q/5e+TYd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB3DF20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=n8BY2JoCvtobsrQFP5pOw9vAdW571tAOU++jOe5IrNM=; b=ENLumhg81ZhPYF
	Si/SPGHs7G34fEK6bagidYVxbwTKkwhB3TaVV9eAnTHkDSnRF4Fm38N6B+iDmrwYg29smxQIdevsW
	Bwr84PYLRdVth+Y1LZz/TSP1IOx7tmouffr1YJmo3yWQkrR865Ot2NnPMHP+DMzYCsRHPSx/XmzO+
	yanCbOmYLJJBfmDl8F263fz+QX5KhA0UMsfwN5oPbJ0aAK5T3mY0+9Z6bJClYpgA5MElzQn6pZxRN
	7RHqI7LApW5YEVho1xHWOCxp6LkATdtOuq1kmbuRD93lXYCpON+G2ooLS3A+lnvgCOPAN6gg6yx3x
	yYWLV6ND071UJt7TtIqQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs48p-0003AM-6G; Fri, 08 Feb 2019 11:16:19 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs48O-00084G-Uw
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 11:16:17 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id BF7AD25BEE5;
 Fri,  8 Feb 2019 22:13:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1549624405; bh=KUHGYtxHBEvIH8Zd7ou3MbriCbWtAkahIegOXad3L4c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Q/5e+TYd+Al+eEgXjNyYTYVaKc375cbC4exwuSHVMWFP1ZdieBm1yQgKEes7nRkgP
 pbFn4C6IhYgg5iHe7WRbXySj4MUCCP560Hb9IYvVNC5LnF1fioBiAxF3tGNxa+tgxw
 ta3xL0L/nuV3MD93X3CSIlJBzzU4kQE1KeqAxZwI=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 10186940954; Fri,  8 Feb 2019 12:13:23 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 06/12] arm64: dts: renesas: enable HS400 on R-Car Gen3
Date: Fri,  8 Feb 2019 12:13:15 +0100
Message-Id: <e536d27e923c090e492b7e83e3f1267f7b74ebb7.1549623801.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1549623801.git.horms+renesas@verge.net.au>
References: <cover.1549623801.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_031553_287170_F831F5DC 
X-CRM114-Status: GOOD (  10.22  )
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
Cc: Simon Horman <horms+renesas@verge.net.au>,
 =?UTF-8?q?Niklas=20S=C3=B6derlund?=
 <niklas.soderlund+renesas@ragnatech.se>, Magnus Damm <magnus.damm@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

RnJvbTogTmlrbGFzIFPDtmRlcmx1bmQgPG5pa2xhcy5zb2Rlcmx1bmQrcmVuZXNhc0ByYWduYXRl
Y2guc2U+CgpTdWNjZXNzZnVsbHkgdGVzdGVkIG9uIEgzIEVTMi4wIGFuZCBNMy1OIEVTMS4wLgpU
cmFuc2ZlciByYXRlcyB3aGVyZSA+MTYwTUIvcyBmb3IgSDMgYW5kID4yMDBNQi9zIGZvciBNMy1O
LgoKU2lnbmVkLW9mZi1ieTogTmlrbGFzIFPDtmRlcmx1bmQgPG5pa2xhcy5zb2Rlcmx1bmQrcmVu
ZXNhc0ByYWduYXRlY2guc2U+ClJldmlld2VkLWJ5OiBXb2xmcmFtIFNhbmcgPHdzYStyZW5lc2Fz
QHNhbmctZW5naW5lZXJpbmcuY29tPgpUZXN0ZWQtYnk6IFdvbGZyYW0gU2FuZyA8d3NhK3JlbmVz
YXNAc2FuZy1lbmdpbmVlcmluZy5jb20+ClNpZ25lZC1vZmYtYnk6IFNpbW9uIEhvcm1hbiA8aG9y
bXMrcmVuZXNhc0B2ZXJnZS5uZXQuYXU+Ci0tLQogYXJjaC9hcm02NC9ib290L2R0cy9yZW5lc2Fz
L3NhbHZhdG9yLWNvbW1vbi5kdHNpIHwgMSArCiBhcmNoL2FybTY0L2Jvb3QvZHRzL3JlbmVzYXMv
dWxjYi5kdHNpICAgICAgICAgICAgfCAxICsKIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9yZW5lc2FzL3NhbHZhdG9yLWNv
bW1vbi5kdHNpIGIvYXJjaC9hcm02NC9ib290L2R0cy9yZW5lc2FzL3NhbHZhdG9yLWNvbW1vbi5k
dHNpCmluZGV4IGY2NmQ5OTBiOTJmMS4uYTIyNWMyNDU3Mjc0IDEwMDY0NAotLS0gYS9hcmNoL2Fy
bTY0L2Jvb3QvZHRzL3JlbmVzYXMvc2FsdmF0b3ItY29tbW9uLmR0c2kKKysrIGIvYXJjaC9hcm02
NC9ib290L2R0cy9yZW5lc2FzL3NhbHZhdG9yLWNvbW1vbi5kdHNpCkBAIC03NjQsNiArNzY0LDcg
QEAKIAl2cW1tYy1zdXBwbHkgPSA8JnJlZ18xcDh2PjsKIAlidXMtd2lkdGggPSA8OD47CiAJbW1j
LWhzMjAwLTFfOHY7CisJbW1jLWhzNDAwLTFfOHY7CiAJbm9uLXJlbW92YWJsZTsKIAlmaXhlZC1l
bW1jLWRyaXZlci10eXBlID0gPDE+OwogCXN0YXR1cyA9ICJva2F5IjsKZGlmZiAtLWdpdCBhL2Fy
Y2gvYXJtNjQvYm9vdC9kdHMvcmVuZXNhcy91bGNiLmR0c2kgYi9hcmNoL2FybTY0L2Jvb3QvZHRz
L3JlbmVzYXMvdWxjYi5kdHNpCmluZGV4IGEzODc4ZmIzYzNmMS4uZTcwZTFiYWMyYmU0IDEwMDY0
NAotLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL3JlbmVzYXMvdWxjYi5kdHNpCisrKyBiL2FyY2gv
YXJtNjQvYm9vdC9kdHMvcmVuZXNhcy91bGNiLmR0c2kKQEAgLTQ2Myw2ICs0NjMsNyBAQAogCXZx
bW1jLXN1cHBseSA9IDwmcmVnXzFwOHY+OwogCWJ1cy13aWR0aCA9IDw4PjsKIAltbWMtaHMyMDAt
MV84djsKKwltbWMtaHM0MDAtMV84djsKIAlub24tcmVtb3ZhYmxlOwogCXN0YXR1cyA9ICJva2F5
IjsKIH07Ci0tIAoyLjExLjAKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
