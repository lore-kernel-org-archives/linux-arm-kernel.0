Return-Path: <SRS0=qjmB=PN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9104C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 07:30:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FA5E208E3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 07:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JdKPdqwy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VHuOaFBs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FA5E208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=peMd1KJdQmn+sMX4duoZ4Qk5oPdf/Thnh92I6vcLR7k=; b=JdKPdqwyR4DD+YtA0TL92lS2in
	zvdFyR3eoSYHYZ1bweTZh29cyyrSHvcGdCqE7ti18tHhuy0SYcxv4ysxFByG/PlLN5lQ4K6/Q39oB
	N7Y9yY7xn9SMpMUDve7Mgy+c4l780c1qYBRtnc08vIUwHhX7HW6uwRqqw7nIIMBBvBJ6FtEAS9vwF
	LBQ4wKVOV8h9yIWg1sCrQZ3l+8+5lHdAtdR6KSjIvY3NhTu3zbqsGdxwKuD3yDEIsahSRts51SEFZ
	RzGMVjpwXlEP9vNL8wTTD6gWYLwNVfKRrlOTlTh+V1Y4DUftgBYvokJaKa05KWvi8t3ENim0mQ0cB
	ivb2pUEQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfgPR-0006MJ-GV; Sat, 05 Jan 2019 07:30:17 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfgOo-00053P-5u
 for linux-arm-kernel@lists.infradead.org; Sat, 05 Jan 2019 07:29:49 +0000
Received: by mail-pl1-x643.google.com with SMTP id 101so18437376pld.6
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 23:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=jxq8DubluUc6WyBU2XbyE9/uiwXvqfVs8mJ2HYI7f2c=;
 b=VHuOaFBs6m56MPsVgJoQH34fibOL3Zi3mGtkpVTbS17Pa8mkMUWi5egWWl+72Mu+xp
 pWR3cg3Z2rW4LrmMxHwlf4onnNEvIFpnQXoMIj9M2muqHGEaEUf+hPR10vcXxwXf7MIy
 WIaCk3bd2zbje3P1ytAw1MHxgtUsqkyaBIrD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=jxq8DubluUc6WyBU2XbyE9/uiwXvqfVs8mJ2HYI7f2c=;
 b=plwZxK+ySV/HGXaeZ/XvQiaGSM1m+ii9WKAQ8R5vKdliQvmmUPlbdYyQerNUJVXvdp
 vwD4uRmSZ9I3KlomJj0bzibZgwDHzq/vFrqvtap0IN/C58qQuPuCX3IDuV93m/bBV0jE
 9p8G9yjpf0iyIXSUlrkDfXEqV3MYpupJ6SCbimCD6gGcDcHAJEONu4Eq64kwezz01eKl
 IUHVvhsjUoH5LJ1nXij/HDXAqQEqWqpHRSLVAoRQBQ0jxL6njyg1Wa5hEdbng/8YQUwc
 KKWAI5g7k5n9roUyy6+Z/2N5ybnP913kT+6wjGJIEPFlhJ6j66I33NXYBrt8FJXQTZJh
 yaGA==
X-Gm-Message-State: AJcUukdy3LSJqLbnmPQPcHbcKIsBwgAIJHBdUYVqoNTFzeA5JIQMT3UX
 /8SuahP5/RHKtFOBJcnbACYM
X-Google-Smtp-Source: ALg8bN730/Kx7GMd6qrv8SI3exT0EqpbGMIc8Byq2ZtoR7ezU9tNjR+f9shWEDBiQumRMNDA80+Abw==
X-Received: by 2002:a17:902:2868:: with SMTP id
 e95mr53921755plb.317.1546673377136; 
 Fri, 04 Jan 2019 23:29:37 -0800 (PST)
Received: from localhost.localdomain ([2405:204:72cb:a88d:406c:3ac8:e78f:4779])
 by smtp.gmail.com with ESMTPSA id k24sm90677367pfj.13.2019.01.04.23.29.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 04 Jan 2019 23:29:36 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
 martin.petersen@oracle.com, liwei213@huawei.com, robh+dt@kernel.org
Subject: [PATCH v2 3/3] scsi: ufs: Add HI3670 SoC UFS driver support
Date: Sat,  5 Jan 2019 12:58:59 +0530
Message-Id: <20190105072859.9134-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190105072859.9134-1-manivannan.sadhasivam@linaro.org>
References: <20190105072859.9134-1-manivannan.sadhasivam@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_232939_048913_115262C7 
X-CRM114-Status: GOOD (  18.30  )
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
Cc: devicetree@vger.kernel.org, guodong.xu@linaro.org,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, john.stultz@linaro.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add HI3670 SoC UFS driver support by extending the common ufs-hisi
driver. One major difference between HI3660 ad HI3670 SoCs interms of
UFS is the PHY. HI3670 has a 10nm variant PHY and hence this parameter is
used to distinguish the configuration.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/scsi/ufs/ufs-hisi.c | 127 +++++++++++++++++++++++++++++-------
 drivers/scsi/ufs/ufs-hisi.h |   4 ++
 2 files changed, 109 insertions(+), 22 deletions(-)

diff --git a/drivers/scsi/ufs/ufs-hisi.c b/drivers/scsi/ufs/ufs-hisi.c
index 452e19f8fb47..f2d3df357a97 100644
--- a/drivers/scsi/ufs/ufs-hisi.c
+++ b/drivers/scsi/ufs/ufs-hisi.c
@@ -66,7 +66,7 @@ static int ufs_hisi_check_hibern8(struct ufs_hba *hba)
 	return err;
 }
 
-static void ufs_hi3660_clk_init(struct ufs_hba *hba)
+static void ufs_hisi_clk_init(struct ufs_hba *hba)
 {
 	struct ufs_hisi_host *host = ufshcd_get_variant(hba);
 
@@ -80,7 +80,7 @@ static void ufs_hi3660_clk_init(struct ufs_hba *hba)
 	ufs_sys_ctrl_set_bits(host, BIT_SYSCTRL_REF_CLOCK_EN, PHY_CLK_CTRL);
 }
 
-static void ufs_hi3660_soc_init(struct ufs_hba *hba)
+static void ufs_hisi_soc_init(struct ufs_hba *hba)
 {
 	struct ufs_hisi_host *host = ufshcd_get_variant(hba);
 	u32 reg;
@@ -139,6 +139,7 @@ static void ufs_hi3660_soc_init(struct ufs_hba *hba)
 
 static int ufs_hisi_link_startup_pre_change(struct ufs_hba *hba)
 {
+	struct ufs_hisi_host *host = ufshcd_get_variant(hba);
 	int err;
 	uint32_t value;
 	uint32_t reg;
@@ -153,6 +154,14 @@ static int ufs_hisi_link_startup_pre_change(struct ufs_hba *hba)
 	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x8121, 0x0), 0x2D);
 	/* MPHY CBOVRCTRL3 */
 	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x8122, 0x0), 0x1);
+
+	if (host->caps & UFS_HISI_CAP_PHY10nm) {
+		/* MPHY CBOVRCTRL4 */
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x8127, 0x0), 0x98);
+		/* MPHY CBOVRCTRL5 */
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x8128, 0x0), 0x1);
+	}
+
 	/* Unipro VS_MphyCfgUpdt */
 	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0xD085, 0x0), 0x1);
 	/* MPHY RXOVRCTRL4 rx0 */
@@ -173,10 +182,21 @@ static int ufs_hisi_link_startup_pre_change(struct ufs_hba *hba)
 	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x8113, 0x0), 0x1);
 	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0xD085, 0x0), 0x1);
 
-	/* Tactive RX */
-	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x008F, 0x4), 0x7);
-	/* Tactive RX */
-	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x008F, 0x5), 0x7);
+	if (host->caps & UFS_HISI_CAP_PHY10nm) {
+		/* RX_Hibern8Time_Capability*/
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x0092, 0x4), 0xA);
+		/* RX_Hibern8Time_Capability*/
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x0092, 0x5), 0xA);
+		/* RX_Min_ActivateTime */
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x008f, 0x4), 0xA);
+		/* RX_Min_ActivateTime*/
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x008f, 0x5), 0xA);
+	} else {
+		/* Tactive RX */
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x008F, 0x4), 0x7);
+		/* Tactive RX */
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x008F, 0x5), 0x7);
+	}
 
 	/* Gear3 Synclength */
 	ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x0095, 0x4), 0x4F);
@@ -208,7 +228,8 @@ static int ufs_hisi_link_startup_pre_change(struct ufs_hba *hba)
 	if (err)
 		dev_err(hba->dev, "ufs_hisi_check_hibern8 error\n");
 
-	ufshcd_writel(hba, UFS_HCLKDIV_NORMAL_VALUE, UFS_REG_HCLKDIV);
+	if (!(host->caps & UFS_HISI_CAP_PHY10nm))
+		ufshcd_writel(hba, UFS_HCLKDIV_NORMAL_VALUE, UFS_REG_HCLKDIV);
 
 	/* disable auto H8 */
 	reg = ufshcd_readl(hba, REG_AUTO_HIBERNATE_IDLE_TIMER);
@@ -253,7 +274,7 @@ static int ufs_hisi_link_startup_post_change(struct ufs_hba *hba)
 	return 0;
 }
 
-static int ufs_hi3660_link_startup_notify(struct ufs_hba *hba,
+static int ufs_hisi_link_startup_notify(struct ufs_hba *hba,
 					  enum ufs_notify_change_status status)
 {
 	int err = 0;
@@ -391,6 +412,28 @@ static void ufs_hisi_set_dev_cap(struct ufs_hisi_dev_params *hisi_param)
 
 static void ufs_hisi_pwr_change_pre_change(struct ufs_hba *hba)
 {
+	struct ufs_hisi_host *host = ufshcd_get_variant(hba);
+
+	if (host->caps & UFS_HISI_CAP_PHY10nm) {
+		/*
+		 * Boston platform need to set SaveConfigTime to 0x13,
+		 * and change sync length to maximum value
+		 */
+		/* VS_DebugSaveConfigTime */
+		ufshcd_dme_set(hba, UIC_ARG_MIB((u32)0xD0A0), 0x13);
+		/* g1 sync length */
+		ufshcd_dme_set(hba, UIC_ARG_MIB((u32)0x1552), 0x4f);
+		/* g2 sync length */
+		ufshcd_dme_set(hba, UIC_ARG_MIB((u32)0x1554), 0x4f);
+		/* g3 sync length */
+		ufshcd_dme_set(hba, UIC_ARG_MIB((u32)0x1556), 0x4f);
+		/* PA_Hibern8Time */
+		ufshcd_dme_set(hba, UIC_ARG_MIB((u32)0x15a7), 0xA);
+		/* PA_Tactivate */
+		ufshcd_dme_set(hba, UIC_ARG_MIB((u32)0x15a8), 0xA);
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0xd085, 0x0), 0x01);
+	}
+
 	if (hba->dev_quirks & UFS_DEVICE_QUIRK_HOST_VS_DEBUGSAVECONFIGTIME) {
 		pr_info("ufs flash device must set VS_DebugSaveConfigTime 0x10\n");
 		/* VS_DebugSaveConfigTime */
@@ -429,7 +472,7 @@ static void ufs_hisi_pwr_change_pre_change(struct ufs_hba *hba)
 	ufshcd_dme_set(hba, UIC_ARG_MIB(0xd046), 32767);
 }
 
-static int ufs_hi3660_pwr_change_notify(struct ufs_hba *hba,
+static int ufs_hisi_pwr_change_notify(struct ufs_hba *hba,
 				       enum ufs_notify_change_status status,
 				       struct ufs_pa_layer_attr *dev_max_params,
 				       struct ufs_pa_layer_attr *dev_req_params)
@@ -567,25 +610,72 @@ static int ufs_hi3660_init(struct ufs_hba *hba)
 		return ret;
 	}
 
-	ufs_hi3660_clk_init(hba);
+	ufs_hisi_clk_init(hba);
+
+	ufs_hisi_soc_init(hba);
+
+	return 0;
+}
+
+static int ufs_hi3670_init(struct ufs_hba *hba)
+{
+	int ret = 0;
+	struct device *dev = hba->dev;
+	struct ufs_hisi_host *host;
+
+	ret = ufs_hisi_init_common(hba);
+	if (ret) {
+		dev_err(dev, "%s: ufs common init fail\n", __func__);
+		return ret;
+	}
+
+	ufs_hisi_clk_init(hba);
+
+	ufs_hisi_soc_init(hba);
 
-	ufs_hi3660_soc_init(hba);
+	/* Add cap for 10nm PHY variant on HI3670 SoC */
+	host = ufshcd_get_variant(hba);
+	host->caps |= UFS_HISI_CAP_PHY10nm;
 
 	return 0;
 }
 
-static struct ufs_hba_variant_ops ufs_hba_hisi_vops = {
+static struct ufs_hba_variant_ops ufs_hba_hi3660_vops = {
 	.name = "hi3660",
 	.init = ufs_hi3660_init,
-	.link_startup_notify = ufs_hi3660_link_startup_notify,
-	.pwr_change_notify = ufs_hi3660_pwr_change_notify,
+	.link_startup_notify = ufs_hisi_link_startup_notify,
+	.pwr_change_notify = ufs_hisi_pwr_change_notify,
 	.suspend = ufs_hisi_suspend,
 	.resume = ufs_hisi_resume,
 };
 
+static struct ufs_hba_variant_ops ufs_hba_hi3670_vops = {
+	.name = "hi3670",
+	.init = ufs_hi3670_init,
+	.link_startup_notify = ufs_hisi_link_startup_notify,
+	.pwr_change_notify = ufs_hisi_pwr_change_notify,
+	.suspend = ufs_hisi_suspend,
+	.resume = ufs_hisi_resume,
+};
+
+static const struct of_device_id ufs_hisi_of_match[] = {
+	{ .compatible = "hisilicon,hi3660-ufs", .data = &ufs_hba_hi3660_vops },
+	{ .compatible = "hisilicon,hi3670-ufs", .data = &ufs_hba_hi3670_vops },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, ufs_hisi_of_match);
+
 static int ufs_hisi_probe(struct platform_device *pdev)
 {
-	return ufshcd_pltfrm_init(pdev, &ufs_hba_hisi_vops);
+	const struct of_device_id *of_id;
+	struct ufs_hba_variant_ops *vops;
+	struct device *dev = &pdev->dev;
+
+	of_id = of_match_node(ufs_hisi_of_match, dev->of_node);
+	vops = (struct ufs_hba_variant_ops *)of_id->data;
+
+	return ufshcd_pltfrm_init(pdev, vops);
 }
 
 static int ufs_hisi_remove(struct platform_device *pdev)
@@ -596,13 +686,6 @@ static int ufs_hisi_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id ufs_hisi_of_match[] = {
-	{ .compatible = "hisilicon,hi3660-ufs" },
-	{},
-};
-
-MODULE_DEVICE_TABLE(of, ufs_hisi_of_match);
-
 static const struct dev_pm_ops ufs_hisi_pm_ops = {
 	.suspend	= ufshcd_pltfrm_suspend,
 	.resume		= ufshcd_pltfrm_resume,
diff --git a/drivers/scsi/ufs/ufs-hisi.h b/drivers/scsi/ufs/ufs-hisi.h
index 3df9cd7acc29..667dfe39b57e 100644
--- a/drivers/scsi/ufs/ufs-hisi.h
+++ b/drivers/scsi/ufs/ufs-hisi.h
@@ -91,6 +91,9 @@ enum {
 #define UFS_HISI_LIMIT_HS_RATE	PA_HS_MODE_B
 #define UFS_HISI_LIMIT_DESIRED_MODE	FAST
 
+#define UFS_HISI_CAP_RESERVED		BIT(0)
+#define UFS_HISI_CAP_PHY10nm		BIT(1)
+
 struct ufs_hisi_host {
 	struct ufs_hba *hba;
 	void __iomem *ufs_sys_ctrl;
@@ -112,4 +115,5 @@ struct ufs_hisi_host {
 	ufs_sys_ctrl_writel((host),                                            \
 			    ((~(mask)) & (ufs_sys_ctrl_readl((host), (reg)))), \
 			    (reg))
+
 #endif /* UFS_HISI_H_ */
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
