Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83150C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 10:43:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 504FE20842
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 10:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Wfla3qtY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 504FE20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yZ7kXCXYwoEWtvCiBTBfJbxRdHKnlMpLHWmuhr6awCw=; b=Wfla3qtYyEYLD/
	xE/CXcHcliePvsV9kG+5ImfeidvB7YZtfAOEguX/OiEKpHcG2us6ElgaeDWBtF1AfNJ/ib5ftCFyw
	wn5wGJjRmkB9gvGlJcnbDcOu0IQ9pdmhyQdv3lVMNytH6u6DsEqEtqmEILK+UxKUhCJcstYSQL9Dx
	00WMWZI5dHQqSTRE4OLJ5ik07TVkhRFTnvPP9BqA8W7+wAM7nZy84OuoBcgdvNa0dYVgiwZhXxyeT
	mJjz/53zv6N5HNbsiFJDl/Skq3+uiWOR9ZOXp7FR1EQboqrsdcVpx1U9qJwchsr+MF0kiadyqjYPt
	1v9RUVCkPt05stnZtvmg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyDjd-0002kL-Ga; Mon, 25 Feb 2019 10:43:45 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyDjL-0002Tn-2p
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 10:43:28 +0000
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1PAZwDO012315; Mon, 25 Feb 2019 11:43:15 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2qtvh39fx5-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Mon, 25 Feb 2019 11:43:14 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 11A5538;
 Mon, 25 Feb 2019 10:43:12 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E40452843;
 Mon, 25 Feb 2019 10:43:11 +0000 (GMT)
Received: from localhost (10.75.127.44) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2;
 Mon, 25 Feb 2019 11:43:10 +0100
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>, <robh+dt@kernel.org>, <alexandre.torgue@st.com>
Subject: [PATCH 1/2] dt-bindings: iio: stm32-lptimer-counter: document pinctrl
 sleep state
Date: Mon, 25 Feb 2019 11:42:46 +0100
Message-ID: <1551091367-21718-2-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551091367-21718-1-git-send-email-fabrice.gasnier@st.com>
References: <1551091367-21718-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-25_06:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_024327_412620_4B799095 
X-CRM114-Status: GOOD (  10.56  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 benjamin.gaignard@linaro.org, lars@metafoo.de, mcoquelin.stm32@gmail.com,
 linux-iio@vger.kernel.org, arnaud.pouliquen@st.com,
 linux-kernel@vger.kernel.org, pmeerw@pmeerw.net, knaack.h@gmx.de,
 fabrice.gasnier@st.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add documentation for optional pinctrl sleep state that can be used by
STM32 LPTimer encoder/counter.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 .../devicetree/bindings/iio/counter/stm32-lptimer-cnt.txt         | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/counter/stm32-lptimer-cnt.txt b/Documentation/devicetree/bindings/iio/counter/stm32-lptimer-cnt.txt
index a04aa5c..e90bc47 100644
--- a/Documentation/devicetree/bindings/iio/counter/stm32-lptimer-cnt.txt
+++ b/Documentation/devicetree/bindings/iio/counter/stm32-lptimer-cnt.txt
@@ -10,8 +10,9 @@ See ../mfd/stm32-lptimer.txt for details about the parent node.
 
 Required properties:
 - compatible:		Must be "st,stm32-lptimer-counter".
-- pinctrl-names: 	Set to "default".
-- pinctrl-0: 		List of phandles pointing to pin configuration nodes,
+- pinctrl-names: 	Set to "default". An additional "sleep" state can be
+			defined to set pins in sleep state.
+- pinctrl-n: 		List of phandles pointing to pin configuration nodes,
 			to set IN1/IN2 pins in mode of operation for Low-Power
 			Timer input on external pin.
 
@@ -21,7 +22,8 @@ Example:
 		...
 		counter {
 			compatible = "st,stm32-lptimer-counter";
-			pinctrl-names = "default";
+			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&lptim1_in_pins>;
+			pinctrl-1 = <&lptim1_sleep_in_pins>;
 		};
 	};
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
