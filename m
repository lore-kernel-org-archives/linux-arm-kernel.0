Return-Path: <SRS0=wPy5=QC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB28C282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 10:38:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5070218A6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 10:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tEcnTDq1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5070218A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OwKfVRiV7/5bcLmOiG0+DxJxf+UA6jYNys+yoH3ToF4=; b=tEcnTDq1JSbfXF
	9ITCRxt+UcldjKfCoDzdogKcm8sXY4414AM76enih19N/5SvbWTsb5S+wdsqNfwNGQ+ndQCitqHyM
	wETMErD/aBxwlP65nkW0sJennKsV1XVYhYhs7GxAjxYaGwLEI36KKi1tdKU2SLohNpVwfy+tsfF0E
	brU62g9nnsYrUaW4nvMb9kooGADkBU6i46FSXQdocP2EmObwr9QxPBj+BSrec60OmvBeOz5aJ1bp+
	x1hYwiEQklymNOqqmSTHPUThNv+0KSDKfMQd5fbb2A9NnK7/vSeNfitFjhKGGjHJOB2dS91ttYxzT
	+qqu4YxEOD8WfACQ82ng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnLMC-00006g-Hm; Sat, 26 Jan 2019 10:38:36 +0000
Received: from bhuna.collabora.co.uk ([46.235.227.227])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnLLW-0007vk-LK; Sat, 26 Jan 2019 10:37:57 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: eballetbo) with ESMTPSA id 7969827958F
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: devicetree@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: rockchip: fix rk3399-sapphire-excavator
 graph_port warning
Date: Sat, 26 Jan 2019 11:37:30 +0100
Message-Id: <20190126103730.3883-3-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190126103730.3883-1-enric.balletbo@collabora.com>
References: <20190126103730.3883-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190126_023754_832610_A3C9EB4F 
X-CRM114-Status: GOOD (  11.52  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <mbrugger@suse.com>,
 Heiko Stuebner <heiko@sntech.de>, Shawn Lin <shawn.lin@rock-chips.com>,
 linux-kernel@vger.kernel.org, Vicente Bergas <vicencb@gmail.com>,
 Douglas Anderson <dianders@chromium.org>, linux-rockchip@lists.infradead.org,
 Rob Herring <robh+dt@kernel.org>,
 Klaus Goger <klaus.goger@theobroma-systems.com>, kernel@collabora.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Ports are described by child 'port' nodes contained in the device node.
'ports' is optional and is used to group all 'port' nodes which is not
the case here.

This patch fixes the following warning:

arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts:94.9-98.5: Warning (graph_port): /edp-panel/ports: graph port node name should be 'port'

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts b/arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts
index 0b8f1edbd746..b48a63c3efc3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts
@@ -91,7 +91,7 @@
 		pinctrl-0 = <&lcd_panel_reset>;
 		power-supply = <&vcc3v3_s0>;
 
-		ports {
+		port {
 			panel_in_edp: endpoint {
 				remote-endpoint = <&edp_out_panel>;
 			};
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
