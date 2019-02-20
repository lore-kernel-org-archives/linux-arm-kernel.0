Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9461AC10F01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:09:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 656D72147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ut/wYvxd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 656D72147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=QorLFkDAcakUMD8yg/Xf7VV2Mvq31y3b0wKm57+z4C4=; b=Ut/wYvxdwAlzR4
	et9XJzjjc8OTUskGzAkbpO6JoDEk1M8sO7ywCIkBIsp3f1jxvvSpwEGyriC6OSSaWlWOYi0m/V+af
	oq/Wllc/iWS5HyMSNzmjpGa3RDWJR5Ybcqb+M/7B8jVCBnSp1LxWxk73nfA2Cizz6cUuPKcy5dIhF
	mvVh83VGBnVFSTEHCQIwDHDRMFmuqkN+fZoMPVdUDwmEQGINQjeZh07eJBjfl8bixeOlCK0KVcRzX
	CMtHgR760qyb5CyAcF6kHvriSxJL/9Ik9B3+MdpbxanB0kz5ankjI/oo+SCLXCWhdFVNsx5nXnsYV
	/5CIIOmY5A1ahrrOcivQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwRco-00069V-KH; Wed, 20 Feb 2019 13:09:22 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwRcl-00068O-2c
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 13:09:21 +0000
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1KD6MpZ018722; Wed, 20 Feb 2019 14:09:08 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2qr6x5s9f9-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Wed, 20 Feb 2019 14:09:08 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B744231;
 Wed, 20 Feb 2019 13:09:07 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8AABB2BB4;
 Wed, 20 Feb 2019 13:09:07 +0000 (GMT)
Received: from localhost (10.75.127.45) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2;
 Wed, 20 Feb 2019 14:09:06 +0100
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <thierry.reding@gmail.com>
Subject: [PATCH v5 0/3] Add PM support to STM32 LP Timer drivers
Date: Wed, 20 Feb 2019 14:07:45 +0100
Message-ID: <1550668068-9661-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-20_11:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_050919_429816_4D1EDCC5 
X-CRM114-Status: GOOD (  11.24  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alexandre.torgue@st.com,
 tduszyns@gmail.com, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 robh+dt@kernel.org, mcoquelin.stm32@gmail.com, u.kleine-koenig@pengutronix.de,
 fabrice.gasnier@st.com, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch series adds power management support for STM32 LP Timer:
- PWM driver
- Document the pinctrl states for sleep mode

It also adds device link between the PWM consumer and the PWM provider.
This allows proper sequencing for suspend/resume (e.g. user will likely
do a pwm_disable() before the PWM provider suspend executes), see [1].

[1] https://lkml.org/lkml/2019/2/5/770

---
Changes in v5:
- improve a warning message, fix a style issue.

Changes in v4:
- improve error handling when adding the PWM consumer device link.

Changes in v3:
- Move the device_link_add() call to of_pwm_get() as discussed with Uwe.

Changes in v2:
- Don't disable PWM channel in PWM provider: rather refuse to suspend
  and report an error as suggested by Uwe and Thierry.
- Add patch 3/3 to propose device link addition.
- No updates for STM32 LP Timer IIO driver. Patches can be send separately.

Fabrice Gasnier (3):
  dt-bindings: pwm-stm32-lp: document pinctrl sleep state
  pwm: stm32-lp: Add power management support
  pwm: core: add consumer device link

 .../devicetree/bindings/pwm/pwm-stm32-lp.txt       |  9 ++--
 drivers/pwm/core.c                                 | 50 ++++++++++++++++++++--
 drivers/pwm/pwm-stm32-lp.c                         | 25 +++++++++++
 include/linux/pwm.h                                |  6 ++-
 4 files changed, 82 insertions(+), 8 deletions(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
