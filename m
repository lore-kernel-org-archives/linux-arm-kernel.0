Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A37C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:22:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECE4720834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SCyJH6qa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECE4720834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=DHQqUh+QAHUCKkKIGOYN4aW5ox9O+KVwpU3/FtFjTRk=; b=SCyJH6qaPCieGI
	ktrU8doUBAXlobCLceTfWKZ1vQlIujtPdIRwyM7ng6PoZ039S3VBt8nB90lFahcXnXJif6B3Wbige
	oxj0hXcNDqKmpgNwrEihlSqq8nPJz+5TMtsH5KUv1uO0Y+C9LSO9cvmmfYPCNhXvULwegoX46MJp7
	/L50NszcwnKEIYL4cgT23iLAZwAK58Bmg7HygHzv3bZAYsw5as8ZMM4PElcj6WoEaTJcX9/Zlfrrw
	2VKd1GNfOka0C0NV/sdjIVxtWHbpD5Ggvr3yeyi6DMMkCXgZrDl7X79vogsDbkml0L4WqXQTlm1cy
	6yeCbeUL/JrojUu0t8QQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTmIv-0008NH-Dz; Mon, 03 Dec 2018 11:22:21 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTmIr-0008CB-Rz
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 11:22:19 +0000
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 wB3BKhEC027083; Mon, 3 Dec 2018 12:22:02 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2p3uhmh78w-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Mon, 03 Dec 2018 12:22:02 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0BBA431;
 Mon,  3 Dec 2018 11:22:02 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E4E441606;
 Mon,  3 Dec 2018 11:22:01 +0000 (GMT)
Received: from localhost (10.75.127.48) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 3 Dec 2018 12:22:01
 +0100
From: Alexandre Torgue <alexandre.torgue@st.com>
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Kevin
 Hilman <khilman@baylibre.com>, <arm@kernel.org>,
 <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] ARM: multi_v7_defconfig: enable STM32 analog & timer drivers
Date: Mon, 3 Dec 2018 12:22:01 +0100
Message-ID: <1543836121-18799-1-git-send-email-alexandre.torgue@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-03_06:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_032218_285176_CD2F8DA5 
X-CRM114-Status: UNSURE (   8.63  )
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
Cc: Alexandre Torgue <alexandre.torgue@st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Fabrice Gasnier <fabrice.gasnier@st.com>

This enables drivers for STM32 timer, low power timer and analog hardware
that can be used on STM32MP1 SoC:
- Timer & LP Timer MFD core, PWM, trigger & encoder drivers
- IIO ADC/DAC/DFSDM
- vrefbuf regu driver (voltage reference buffer).

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>

---

Hi Arnd, Olof and Kevin,

Can you please merge this patch for v4.21?

Thanks in advance
Alex

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 1c76168..b2d1f18 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -522,6 +522,7 @@ CONFIG_MFD_TPS65217=y
 CONFIG_MFD_TPS65218=y
 CONFIG_MFD_TPS6586X=y
 CONFIG_MFD_TPS65910=y
+CONFIG_MFD_STM32_LPTIMER=m
 CONFIG_REGULATOR_ACT8865=y
 CONFIG_REGULATOR_ACT8945A=y
 CONFIG_REGULATOR_ANATOP=y
@@ -552,6 +553,7 @@ CONFIG_REGULATOR_RK808=y
 CONFIG_REGULATOR_RN5T618=y
 CONFIG_REGULATOR_S2MPS11=y
 CONFIG_REGULATOR_S5M8767=y
+CONFIG_REGULATOR_STM32_VREFBUF=m
 CONFIG_REGULATOR_TI_ABB=y
 CONFIG_REGULATOR_TPS51632=y
 CONFIG_REGULATOR_TPS62360=y
@@ -914,14 +916,20 @@ CONFIG_AT91_SAMA5D2_ADC=m
 CONFIG_BERLIN2_ADC=m
 CONFIG_CPCAP_ADC=m
 CONFIG_EXYNOS_ADC=m
+CONFIG_STM32_ADC_CORE=m
+CONFIG_STM32_ADC=m
+CONFIG_STM32_DFSDM_ADC=m
 CONFIG_VF610_ADC=m
 CONFIG_XILINX_XADC=y
+CONFIG_STM32_LPTIMER_CNT=m
+CONFIG_STM32_DAC=m
 CONFIG_MPU3050_I2C=y
 CONFIG_CM36651=m
 CONFIG_SENSORS_ISL29018=y
 CONFIG_SENSORS_ISL29028=y
 CONFIG_AK8975=y
 CONFIG_IIO_HRTIMER_TRIGGER=y
+CONFIG_IIO_STM32_LPTIMER_TRIGGER=m
 CONFIG_PWM=y
 CONFIG_PWM_ATMEL=m
 CONFIG_PWM_ATMEL_HLCDC_PWM=m
@@ -935,6 +943,8 @@ CONFIG_PWM_RENESAS_TPU=y
 CONFIG_PWM_ROCKCHIP=m
 CONFIG_PWM_SAMSUNG=m
 CONFIG_PWM_STI=y
+CONFIG_PWM_STM32=m
+CONFIG_PWM_STM32_LP=m
 CONFIG_PWM_SUN4I=y
 CONFIG_PWM_TEGRA=y
 CONFIG_PWM_VT8500=y
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
