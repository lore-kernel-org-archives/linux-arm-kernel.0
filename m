Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B434C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:11:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38E8D217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CvZQOvlU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38E8D217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=of+jzAZYhIqEYs9WaYxIWzrToc5utNIAE4xIjkKE+rE=; b=CvZ
	QOvlUmyGlqZ6HhmKmV5VmqnTGVyu8pKyZZBmD72SKXVYS2rQS3TQNbCXYcc623eF75uxZw7OkGA0F
	y2X2YsyBITQaPw4pOFxccbKnqqnc6ZHlyKpp2imZ0ou1HopAcgaJl9jVxylO/qjD2F+Fd68pbPMD+
	0dkOvMCSPCE8GLDwPJEc4W3DxjIxjcPgOI9hXs493ku8BXS/HZ2BO1cGJ5bpeiGoYDxa84dC2SOJW
	sWfhX0vKQA8XxgagXn3gtgKM80SgbCv/yF1Fua48YIkIrcmo4F8kOGIxABt23Akz0aM3zn08v9ZaY
	rNEUSL8GqoPKTy9je8a2zKo8MURCCwQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gd0M6-0001lj-DX; Fri, 28 Dec 2018 22:11:46 +0000
Received: from mout.kundenserver.de ([212.227.17.24])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gd0L8-0000zv-RO; Fri, 28 Dec 2018 22:10:50 +0000
Received: from localhost.localdomain ([37.4.249.153]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MwQKp-1hSu071G2H-00sMXc; Fri, 28 Dec 2018 23:10:26 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Eric Anholt <eric@anholt.net>
Subject: [PATCH V5 0/3] ARM: dts: add Raspberry Pi 3 A+
Date: Fri, 28 Dec 2018 23:09:24 +0100
Message-Id: <1546034967-2427-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:DRnDSY2mHlflejBXhCZPvyAtBcRCMsbtFEUs5uhDDnCAZgOOTF+
 XBK65hh6XPRlE/apOI2NiPfkLWFg3M5Uk/009za+uZTd9+/pwUUpQwOfQ1aKw1ka7IEnECh
 pcnOpCnpeIrITg4q7iK/glU/QSKeuJdFEe1bczvIrlpC6WpmAsQryfa2XJOWd6X08YTp6Kh
 hC7hLIjar0UdFXUZO/wqQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:B32VdQiK3MY=:0hMAdKXQX9jplldGCCTsbv
 3vKD6X3+Htw0RHwIfIGSkEbsTctaRfQUTAcnuxmwmxK31x8srmNhPocSc9eboHMW9jVtf2KIQ
 pJqet09UW+ycxt5CRZ+DpeG4kqYu7BwumvdPZEDEmz7SutM7sdyrASYatYvxR1ncFOzDg8zZs
 th3JYpktLZp8Kcx5pkT3gnuq6C5JmFWdB6+7t+H5+ZfJPPCAWfVl8wEnrV4dAlN9REckyRUj/
 jnieMKP5VnlBkKcwxE1964tvhUpHE2nBL5uPv9BEZyqI9C8FHfrWIy14h2O+6gyJzi1PN+kJy
 xyuywnhRmZLsm6BFD2AjeKRl3YoJsrooKdvt0XLGK7RDQAhJgmp8mjMizf2bw+NtgaGMre7PN
 DOLEXGmrxpsUuggkqJ3yK905UqCEeVRXy9FPY7OezCt3kJ653IwhhmGOK0ww3wgvH2KVI+04Z
 OvLLfHSfZnCf515Z/2Kssu/oRouA0TPRtmmKmXAFrLoiNDlx3HwlmsNphLhNBcK4Gsji8d6yS
 IcWfdww7S8xPVg+OjOhA8VSvv5pBU9PNFZ6CI6yHFYucKk5DYyhnjMl3uxYpZXnlKVe1ekTcs
 +UFHwcAXGAxCg0pt+6s69IKSciSNTS4adCDbWTHe6PU/k5fa15EPi4YMflna0FmADOJ+BCW3o
 wIe6XSz8W6a4ydxhGw9bSEibwyQTPXhdO+vZZLKfxvh+sRCdCIiyTcblmJtw5fYAZRbltMZ7B
 fHyfHkLp1abFQSQD/Rav6qi0YTGu+o3yMWkXDbSxkfkEWThoKExJ3DCVK/8=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_141047_285498_74E8DC4E 
X-CRM114-Status: GOOD (  17.02  )
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
 Phil Elwell <phil@raspberrypi.org>, bcm-kernel-feedback-list@broadcom.com,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch series adds support for the brand new Raspberry Pi 3 A+ .
Since there is no official DTS file yet, this one bases on a procfs dump and
the dt-blob of the firmware [1].

[1] - https://github.com/raspberrypi/firmware/blob/master/extra/dt-blob.dts

Changes in V5:
- fix reference order of &gpio and &firmware as commented by Peter Robinson
- change GPIO42 label from "NC" to ""
- use GPIO label for LEDs from RPi 3 B+ schematics 
- add Eric's Acked-by

Changes in V4:
- address Phil's comment by dropping BT_ON and rename WL_ON to BT_WL_ON
- drop Wifi and BT reset control and add explaining comment
- add missing gpio line names
- add Rob's Reviewed-by 

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
 arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts         | 175 +++++++++++++++++++++
 arch/arm64/boot/dts/broadcom/Makefile              |   3 +-
 .../boot/dts/broadcom/bcm2837-rpi-3-a-plus.dts     |   2 +
 5 files changed, 184 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-a-plus.dts

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
