Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F16C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 06:33:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5040208E4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 06:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b7IF7po1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5040208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ccRo8Mhz1EPYz1n2NzzBy1zv32Rmx7l3tjjZT7AAoq4=; b=b7IF7po1jCYaTV
	yisLsnbh6ZjX+nrH6/5aRorE6k/f9tn1sWiiDlJTO+po5/qDtZEpFrTte6dM+fOCs9tsji8RkWYRh
	VTBtdbpDqFcwJm3xvHd/U0ugawWMcTXoYvWLpIoTXVTT3CmNLzJvEhEzYhHYb9oIoLSX/VgcAt2TE
	lReYmpAPRfxEQwAu5PfHYW+DrXyaah+yUQAofyagdBzI0q1HYfY3Me0wh1p5EGc4suyXx9TgyKbm4
	b0kI8ZuxbPIksJeGpYs3v4MOnTDvRs+RbgrCxIEgJVSLPIyU7UhFXPyqAyVSZPiXzMVc60Uk1Xon1
	oNv6ws02dy5Sgjha4cCA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcliO-0001DN-7q; Fri, 28 Dec 2018 06:33:48 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcliB-0000wx-AE
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 06:33:40 +0000
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 08B401FC4AA0B;
 Fri, 28 Dec 2018 14:33:14 +0800 (CST)
Received: from SIA1000080854.huawei.com (10.180.101.187) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.408.0; Fri, 28 Dec 2018 14:33:05 +0800
From: h00249924 <hutenghui@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>
Subject: [PATCH 1/2] arm64: dts: hi3660: Add i2s & sound device
Date: Fri, 28 Dec 2018 14:30:45 +0800
Message-ID: <1545978646-124051-1-git-send-email-hutenghui@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-Originating-IP: [10.180.101.187]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181227_223335_933027_251C5630 
X-CRM114-Status: UNSURE (   9.08  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Youlin Wang <wwx575822@notesmail.huawei.com>, suzhuangluan@hisilicon.com,
 hantanglei@huawei.com, kongfei@hisilicon.com, Wei
 Xu <xuwei5@hisilicon.com>, ninggaoyu@hisilicon.com,
 Rob Herring <robh+dt@kernel.org>, John Stultz <john.stultz@linaro.org>,
 liyuequan@hisilicon.com, huangli295@hisilicon.com, wangyoulin1@hisilicon.com,
 cash.qianli@hisilicon.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Youlin Wang <wwx575822@notesmail.huawei.com>

Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Youlin Wang <wwx575822@notesmail.huawei.com>
Signed-off-by: Tanglei Han <hantanglei@huawei.com>
Cc: Wei Xu <xuwei5@hisilicon.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index 5223e36..ae535da 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -1136,5 +1136,33 @@
 			interrupt-names = "asp_dma_irq";
 			status = "ok";
 		};
+
+		i2s2: hisi_i2s {
+			compatible = "hisilicon,hisi-i2s";
+			reg = <0x0 0xe804f800 0x0 0x400>,
+			      <0x0 0xe804e000 0x0 0x400>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2s2_pmx_func &i2s2_cfg_func>;
+			dmas = <&asp_dmac 18 &asp_dmac 19>;
+			dma-names = "rx", "tx";
+			#sound-dai-cells = <0>;
+		};
+
+		sound {
+			compatible = "simple-audio-card";
+			simple-audio-card,name = "hikey-hdmi";
+			simple-audio-card,format = "i2s";
+
+			simple-audio-card,bitclock-master = <&sound_master>;
+			simple-audio-card,frame-master = <&sound_master>;
+
+			sound_master: simple-audio-card,cpu {
+				sound-dai = <&i2s2>;
+			};
+
+			simple-audio-card,codec {
+				sound-dai = <&adv7533>;
+			};
+		};
 	};
 };
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
