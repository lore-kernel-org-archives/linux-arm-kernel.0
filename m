Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F27C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:00:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8F382081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H7ra1rqT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8F382081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=vMptaJwbf+42rmOw9zmj+Ql/GrXCFp7vO+rh7Yy9iao=; b=H7r
	a1rqTbYpZ+Yzq87aNJgxGbJtT9hyXDcw5LiLS4YWu1INwQhRlbE2Kpcok63Tlv2RO3T55uHfs8sbV
	Z3SY/AIDtXAckZlEq16yAtYEOFSq1A2MH/ptl40ljSneqzqOiKIZxmq44uf6uHLHBQmqFpOBPgSUb
	82HslqR/qgPbPM4HCSTNsXwxizCvVVBZ+XlNuwtagbZXqWxSoXTm9oGtH4oMNmB7giJJCLLWlRcWS
	LNfpJyjcHQhYa1oLuiv2RKWc9wYWd8+gavn84p7lrNNp4uwwr2Xlmke8bmD57KXd9QI+UVxVaVNkG
	elmtOrahEvNrgrFl5ACM6xTnUrDfbGA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUFvN-0007qf-Eb; Tue, 04 Dec 2018 19:00:01 +0000
Received: from mout.kundenserver.de ([212.227.126.134])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUFud-00073K-Sf; Tue, 04 Dec 2018 18:59:17 +0000
Received: from localhost.localdomain ([37.4.249.153]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MSZDt-1gx5Pw2M0X-00SsVL; Tue, 04 Dec 2018 19:58:53 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Eric Anholt <eric@anholt.net>,
 Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH V3 0/3] ARM: dts: add Raspberry Pi 3 A+
Date: Tue,  4 Dec 2018 19:58:16 +0100
Message-Id: <1543949899-13380-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:HwPJU7QTZpYifoBn3xJf0c/DpnWAaa+uP3YgVN8fAbyA/5T/ZgM
 8oWSWk4LgC4z18RYFZr/Sd+1elW+4JOXhBLygyof81WRlfqjK0fYqyn3ng9a91oksvFuLQ2
 eMx8L0vO2BerBbtWVUSR9vKsWhds8h0KOFh7/eMYIJIrZoIxIpXMYMVNqzXVOBf9eiXHizd
 cqktN9lWZydnj+y0JU+Ow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:k+A9rqo1LjE=:6N+qlos1iQxKZcSDEDwZGS
 cAP3eSJUhXkJGSNF+ESfU/DgUFrwP1+v1yYi4R5ueILaNF6e9ju7YiR42P8BlbXCLeOWtwuJL
 ayFvKNHDB5eL5avhw2xzRIfskzgeKWNv0QPX87PkUK/+Z9sNGcKqaLg5QMV6sR5l156Hxr9rL
 2+p62s2LgZrw8HwC1Fcbfelub9wM5hKJ9T4aTG4E6bAY5/X9SCXZ4L9CnTr19aWcUHBYZLmAp
 qm7z4/pyzfGmgY+6E/mGIaikaJiCiVgGrnK7RMAwzK5WRZAg8mX/1gSt36wMiLxhEizyVnrvU
 uiIY5bOluVWK6JGnzKv5HAD/uv+XWJPH7JdO1oioMlhzuaHZWaDNDZb2RwdIV9kc5ILGv/5mA
 YqT3x6xbd/uuG+bOY37Yvy8S74LdguiZCnPSNMnq5St/bzvXA8/XxEma2SdGTJ8W3+LL/cg2U
 Py7QOKexlQbiQJEpU/XmgnZM9xGS4w9iktrxW2CQSybQ88OybXcHXB2toXSbVoBWIfebVryC3
 xk9S67EA49EIaGYiqYocR4qVWjmo7ygyElu/LQk2zoe7OlEJNFviR6GK+BEDl+FEEs1C6ElJl
 kT5Lbsh1QzF/ls8gCo55IhtAmI47y8vjNKaoKs1Fn7b8tU6d+D+RWWbyhP/BGFdTD4aRyTP3s
 W9mL+rIkg2VsZBmS9au//kzTXk4yFFhVpX5VttCD3R8Qr7Mq14HlQwJAjSjz0M6EVa7sv48dS
 LacD1/pxTnqY+lwCC4L1HwBPHaf0vqFva0VIpfmwHzg4nFlRePauRuCLkKg=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_105916_479330_CC022A04 
X-CRM114-Status: GOOD (  16.18  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, devicetree@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch series adds support for the brand new Raspberry Pi 3 A+ .
Since there is no official DTS file yet, this one bases on a procfs dump. 

Changes in V3:
- add Eric's Reviewed-by
- fix wifi reset GPIO polarity

Changes in V2:
- add missing Makefile change for arm64

Stefan Wahren (3):
  dt-bindings: bcm: Add Raspberry Pi 3 A+
  ARM: dts: add Raspberry Pi 3 A+
  arm64: dts: broadcom: Add reference to RPi 3 A+

 .../devicetree/bindings/arm/bcm/brcm,bcm2835.txt   |   4 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts         | 107 +++++++++++++++++++++
 arch/arm64/boot/dts/broadcom/Makefile              |   3 +-
 .../boot/dts/broadcom/bcm2837-rpi-3-a-plus.dts     |   2 +
 5 files changed, 116 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-a-plus.dts

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
