Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03A5C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:51:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F55E208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QocUr/vn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F55E208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=qiPyNOWkh22h/dMTNhZxKjh8DC9mmIgfvwdi0VCg5JM=; b=QocUr/vnJL+Nju
	4i50gHAA/62aQyb7PBdrZ5mAqx2R/9Xw2YibWKJ8XvcyA+HvfKdDqtLfZ3DsSMY7LbCoha7am2YxT
	qC+abZ4/K0LXR1gNSgQcPEaE+hcmK4e8ypH0sPyWit/wZWs71Q/BQkqTeV7svqpIl44QYKRqxVCbL
	tWz28fMVDnH2ULWMyjpmT7PSabhdgt8KtgxhVemvgKGw0SLeNG+M5SJr0tUHr1aWG1iicdTwDnTxk
	7KHBAQu2VP/W8DDvXoXW7nk5zv/0BK6x3r5fQ4DoMifCuBbR9IGiDL/TLZeW5I3IGYeA3qWCEna9Y
	a51zAdM4tWYdqo2A96VA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUdD5-0001ky-En; Wed, 05 Dec 2018 19:51:51 +0000
Received: from mail-oi1-f194.google.com ([209.85.167.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUdCd-00013n-MF; Wed, 05 Dec 2018 19:51:31 +0000
Received: by mail-oi1-f194.google.com with SMTP id y23so18657732oia.4;
 Wed, 05 Dec 2018 11:51:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kV+bfkiFbMBXJunTBXrEXEZOatnnsr69uBsZeOB6vV8=;
 b=FUUg0bVzcjH0J0+PCrAorZe0KZQ/fs68qJnr7TzpDYCp4P3KcM5fS86NuC9VP3wJ9y
 ZtDShwgq3PV9YOpf0oqyZypxfaWOzSdWlc3dmmsTC5KNVSo7qTKbr8XR41NUxCo4102w
 xZhdrdkx9cNoP6kIY0ezySCx1RwoTMoeI1ATQ3kOLYTrUybg5B2/w4bbtF9yKtdtPn5W
 olkGoYw02Q1okHb8MYgaHP1yzzbwKm124Y/u9ahq1oD0GWXi6iYpjqmyHfQjwxBN/vp9
 gCOUg3J9IprhSq1SfvQHnPNTTUGnMsLf00zdFkKYcVNOFwI+3KLCy9QAdGFOdUaNgEYT
 xSng==
X-Gm-Message-State: AA+aEWbDUS/6gxkpB5d61HGZ6GY0Rsb6HEuadh5YqpNfkDoYphUfEE+9
 8DgOehVOc+10JNfWm0izQ/nESS4=
X-Google-Smtp-Source: AFSGD/Vw2xyPBuMfRWc6LCcAZLtIZgBj6fkHey+JeMWTTALy+VvNSUAe0KUClEvAfXtfSq5Ir78asw==
X-Received: by 2002:a54:468b:: with SMTP id k11mr14909094oic.27.1544039472473; 
 Wed, 05 Dec 2018 11:51:12 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id k13sm25759879otj.19.2018.12.05.11.51.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Dec 2018 11:51:11 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] phy: Use of_node_name_eq for node name comparisons
Date: Wed,  5 Dec 2018 13:50:35 -0600
Message-Id: <20181205195050.4759-19-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_115124_868830_D27F2E5E 
X-CRM114-Status: GOOD (  12.67  )
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
Cc: linux-rockchip@lists.infradead.org, Heiko Stuebner <heiko@sntech.de>,
 linux-arm-kernel@lists.infradead.org, Kishon Vijay Abraham I <kishon@ti.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

For instances using of_node_cmp, this has the side effect of now using
case sensitive comparisons. This should not matter for any FDT based
system which all of these are.

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 6 +++---
 drivers/phy/rockchip/phy-rockchip-typec.c     | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 24bd2717abdb..91fba60267a0 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -1168,8 +1168,8 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 		struct phy *phy;
 
 		/* This driver aims to support both otg-port and host-port */
-		if (of_node_cmp(child_np->name, "host-port") &&
-		    of_node_cmp(child_np->name, "otg-port"))
+		if (!of_node_name_eq(child_np, "host-port") &&
+		    !of_node_name_eq(child_np, "otg-port"))
 			goto next_child;
 
 		phy = devm_phy_create(dev, child_np, &rockchip_usb2phy_ops);
@@ -1183,7 +1183,7 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 		phy_set_drvdata(rport->phy, rport);
 
 		/* initialize otg/host port separately */
-		if (!of_node_cmp(child_np->name, "host-port")) {
+		if (of_node_name_eq(child_np, "host-port")) {
 			ret = rockchip_usb2phy_host_port_init(rphy, rport,
 							      child_np);
 			if (ret)
diff --git a/drivers/phy/rockchip/phy-rockchip-typec.c b/drivers/phy/rockchip/phy-rockchip-typec.c
index c57e496f0b0c..e32edeebcd63 100644
--- a/drivers/phy/rockchip/phy-rockchip-typec.c
+++ b/drivers/phy/rockchip/phy-rockchip-typec.c
@@ -1176,10 +1176,10 @@ static int rockchip_typec_phy_probe(struct platform_device *pdev)
 	for_each_available_child_of_node(np, child_np) {
 		struct phy *phy;
 
-		if (!of_node_cmp(child_np->name, "dp-port"))
+		if (of_node_name_eq(child_np, "dp-port"))
 			phy = devm_phy_create(dev, child_np,
 					      &rockchip_dp_phy_ops);
-		else if (!of_node_cmp(child_np->name, "usb3-port"))
+		else if (of_node_name_eq(child_np, "usb3-port"))
 			phy = devm_phy_create(dev, child_np,
 					      &rockchip_usb3_phy_ops);
 		else
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
