Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9D7C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 17:34:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3FE02089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 17:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KPXFdn8L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3FE02089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=katsuster.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=PzGJ6HyZdFIUSFT1/do5gBv+e2GtXcittDLTcWJLdAA=; b=KPXFdn8LOL5jR5
	dAZXese4URmOhCs4WLxwgYLqp7gv4WiYtlQJxg9jEscTkSJeNmFhm3Zh94reTCTAL4mJrTm56l0nD
	fW/e5/gU04/I/F7BYB/zFp7VR8yHjoJvn2hjBj2lXxE00+5vLs9uTPnsjju4ZXR3eRPG2w+B0UBJo
	nmGmaZ9gUtLedSbt/oK34pYnVhvrC9Zq8IBY85qGVEzDAfAaiC0OFDur1nQj8PLI7iGhIzvqZCWMr
	3X3uBUXqaYAQtjbZnTAMFfzzKWocZXNxW1NXMTiIRqPxw+qUpclaT48TTWfiJ5SRr0KcRstNrq9sE
	LqRHKeNdvlJg+LyduUuw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvQKa-0007Ql-Tr; Sun, 17 Feb 2019 17:34:20 +0000
Received: from www1102.sakura.ne.jp ([219.94.129.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvQKV-0007OE-10; Sun, 17 Feb 2019 17:34:16 +0000
Received: from fsav109.sakura.ne.jp (fsav109.sakura.ne.jp [27.133.134.236])
 by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x1HHYBkB095901;
 Mon, 18 Feb 2019 02:34:11 +0900 (JST)
 (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav109.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav109.sakura.ne.jp);
 Mon, 18 Feb 2019 02:34:11 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav109.sakura.ne.jp)
Received: from localhost.localdomain (119.104.232.153.ap.dti.ne.jp
 [153.232.104.119]) (authenticated bits=0)
 by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x1HHY8YD095893
 (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
 Mon, 18 Feb 2019 02:34:11 +0900 (JST)
 (envelope-from katsuhiro@katsuster.net)
From: Katsuhiro Suzuki <katsuhiro@katsuster.net>
To: Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org
Subject: [PATCH v3 1/2] arm64: dts: rockchip: add #sound-dai-cells to HDMI of
 rk3328
Date: Mon, 18 Feb 2019 02:34:06 +0900
Message-Id: <20190217173407.29189-1-katsuhiro@katsuster.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_093415_317456_D91000C9 
X-CRM114-Status: GOOD (  12.26  )
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
Cc: Katsuhiro Suzuki <katsuhiro@katsuster.net>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch adds #sound-dai-cells to use HDMI node as audio
codec from device tree of rk3328 boards.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 84f14b132e8f..374b5da93a35 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -665,6 +665,7 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&hdmi_cec &hdmii2c_xfer &hdmi_hpd>;
 		rockchip,grf = <&grf>;
+		#sound-dai-cells = <0>;
 		status = "disabled";
 
 		ports {
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
