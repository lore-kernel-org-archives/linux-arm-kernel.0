Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF681C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:24:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F9FF20989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fBO1WjhM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G6Uoq3YK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F9FF20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:Message-ID:Date
	:Subject:To:From:Reply-To:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=lxyqav+28VqIAxm4bITWxB/4vWO5uiGYy+XhBB9H5OE=; b=fBO1WjhM61ARpY
	2RE5S7G9S4dInXfDPwuRn2GJnCUKqSIXAJlcs8XCI2p/vlycDaQJgMBrswd3wseOhqbm9nwPRZNpI
	KOB0jB6bnj38hin5AQ6Uh3ukAl4elggkeqBquS3mtmjR1VfB/5lfO3ojC1bTb60XxHcZmWy2s8tOv
	nE6RoRUztYx0OgOo8PdTrN7ojCYl7+TkF/ThP/llqhoGeUdUzZo4C8H3ayQ6i+85hJRL+RJ1R9ic8
	DoLdIDeikci7ax7smKgttlgR5AKbS3sRrTTNFJu2gh0q+zFjgkH19oyqz9uqhHRtwDtHjTdkbl0/Z
	Ur7i3K//2+cx1q1UO63A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUtdw-0005LB-Dm; Thu, 06 Dec 2018 13:24:40 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUtdM-0004kU-9f
 for linux-arm-kernel@bombadil.infradead.org; Thu, 06 Dec 2018 13:24:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=MIME-Version:Content-Transfer-Encoding:
 Content-ID:Content-Type:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dKuMiq61Ah+kKZswaAeFMxYXhs05FmiH/eTZSLvD2D4=; b=G6Uoq3YKSEltxiwny38W9Sqqe0
 zNQNqunTrFnjSmQHLDE6x0Ixvwo0CZGfo6KLcpg5eVBTUkGg+NcMNNA1HogRNBViSOKY3BfeVSfTi
 xjuEPQ1PfQlcIxM+rFG9esAAEcXsmP1W0qkZ1uX5aSByM9ajHkMB+lsUDr2CNYP9pTOsMwQxfM2I9
 tjAwDSaw3D/HJigkkKnkYBdf3ycGAva8wCd4TIepB+RSz1ET2iSjCJGgW0TZFAVoxQkuCe+6qqQ+x
 F0Nitq320Snfdb9O7RI5RLyDWfKxm34eRcfxUJo3sCAYqtsGOOP2ocIDiMjSAn5Wa8H++cVECdW4U
 vS4xOlyg==;
Received: from mx08-00178001.pphosted.com ([91.207.212.93]
 helo=mx07-00178001.pphosted.com)
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUtdE-0007JW-Fs
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 13:24:00 +0000
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 wB6DL1TU022355; Thu, 6 Dec 2018 14:23:33 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx08-00178001.pphosted.com with ESMTP id 2p3wt6vg1q-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Thu, 06 Dec 2018 14:23:33 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CD2CD3F;
 Thu,  6 Dec 2018 13:23:32 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 73EC72AAC;
 Thu,  6 Dec 2018 13:23:32 +0000 (GMT)
Received: from SFHDAG3NODE2.st.com (10.75.127.8) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 6 Dec
 2018 14:23:32 +0100
Received: from SFHDAG3NODE2.st.com ([fe80::b82f:1ce:8854:5b96]) by
 SFHDAG3NODE2.st.com ([fe80::b82f:1ce:8854:5b96%20]) with mapi id
 15.00.1347.000; Thu, 6 Dec 2018 14:23:32 +0100
From: David HERNANDEZ SANCHEZ <david.hernandezsanchez@st.com>
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre TORGUE <alexandre.torgue@st.com>
Subject: [PATCH] thermal: stm32: Fix stm_thermal_read_factory_settings
Thread-Topic: [PATCH] thermal: stm32: Fix stm_thermal_read_factory_settings
Thread-Index: AQHUjWbiMRW0Xlrdek2MWEX1owVk4w==
Date: Thu, 6 Dec 2018 13:23:32 +0000
Message-ID: <1544102603-14899-1-git-send-email-david.hernandezsanchez@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.48]
Content-ID: <902B145001845D4A86B32CFF0A0C3EEE@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-06_04:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_082356_957534_5B495271 
X-CRM114-Status: GOOD (  13.35  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-stm32@st-md-mailman.stormreply.com"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Adding brackets allows to multiply the register value,
masked by TS1_RAMP_COEFF_MASK, by an ADJUST value
properly and not to multiply ADJUST by register value and
then mask the whole.

Signed-off-by: David Hernandez Sanchez <david.hernandezsanchez@st.com>
Fixes: 1d693155 ("thermal: add stm32 thermal driver")

diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
index daa1257..bbd73c5 100644
--- a/drivers/thermal/st/stm_thermal.c
+++ b/drivers/thermal/st/stm_thermal.c
@@ -241,8 +241,8 @@ static int stm_thermal_read_factory_settings(struct stm_thermal_sensor *sensor)
 		sensor->t0 = TS1_T0_VAL1;
 
 	/* Retrieve fmt0 and put it on Hz */
-	sensor->fmt0 = ADJUST * readl_relaxed(sensor->base + DTS_T0VALR1_OFFSET)
-					      & TS1_FMT0_MASK;
+	sensor->fmt0 = ADJUST * (readl_relaxed(sensor->base +
+				 DTS_T0VALR1_OFFSET) & TS1_FMT0_MASK);
 
 	/* Retrieve ramp coefficient */
 	sensor->ramp_coeff = readl_relaxed(sensor->base + DTS_RAMPVALR_OFFSET) &
-- 
2.7.4
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
