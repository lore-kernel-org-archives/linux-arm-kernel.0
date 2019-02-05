Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977F5C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:41:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D9EC2083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e2RTP/cy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D9EC2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ZO88oPt7sgt4/cGho4L4/YgmKEoOS3eG8jAsCwetd/U=; b=e2RTP/cyNFz4/z
	X31XlaJfp9U3tLUtlULRdPVmBFqZyy3uGK9Sm3bronj+baIOdg06QBi5hEDWUOSEFmhGTiOjVX7FU
	KL/7Y3CNsTCIoMvtqUx4xOW/gTJXUz7hkTwlv2AIjpuoI6GwCbSe7M4x2Hv+S3+osPIQcsjT7EruD
	ViFl6DoHTsLaoZQVl47hn6fI3aDBtncRJmdUzXcid+43GnRuYli/aj1HqLzCnkTs2mMiCzzWQ+K5/
	NUxFIAiW01vt5kROKwfuhiZYrL8atLT2XxfLBimzfhh+Rqi54jfHPpsewj0jYppdj3JHpDzSxAt2R
	2mraU+iGHFuuNJdPjRAw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr02T-0002Yx-7T; Tue, 05 Feb 2019 12:41:21 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr01z-00026n-DN
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 12:40:54 +0000
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x15CaEJP002718; Tue, 5 Feb 2019 13:40:41 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2qd1v06pqm-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Tue, 05 Feb 2019 13:40:41 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C627231;
 Tue,  5 Feb 2019 12:40:40 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 74D3529AC;
 Tue,  5 Feb 2019 12:40:40 +0000 (GMT)
Received: from localhost (10.75.127.44) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2;
 Tue, 5 Feb 2019 13:40:40 +0100
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>, <thierry.reding@gmail.com>, <robh+dt@kernel.org>
Subject: [PATCH 0/4] Add PM support to STM32 LP Timer drivers
Date: Tue, 5 Feb 2019 13:40:25 +0100
Message-ID: <1549370429-19116-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-05_05:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_044051_781780_A2DA6C58 
X-CRM114-Status: UNSURE (   8.26  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alexandre.torgue@st.com,
 linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, vilhelm.gray@gmail.com,
 mcoquelin.stm32@gmail.com, fabrice.gasnier@st.com,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch series adds power management support for STM32 LP Timer
drivers:
- PWM driver
- IIO counter driver
- Document the pinctrl states for sleep mode

Fabrice Gasnier (4):
  dt-bindings: pwm-stm32-lp: document pinctrl sleep state
  pwm: stm32-lp: Add power management support
  dt-bindings: iio: stm32-lptimer-counter: document pinctrl sleep state
  iio: counter: stm32-lptimer: Add power management support

 .../bindings/iio/counter/stm32-lptimer-cnt.txt     |  8 ++--
 .../devicetree/bindings/pwm/pwm-stm32-lp.txt       |  9 ++--
 drivers/iio/counter/stm32-lptimer-cnt.c            | 55 ++++++++++++++++++++++
 drivers/pwm/pwm-stm32-lp.c                         | 38 +++++++++++++++
 4 files changed, 104 insertions(+), 6 deletions(-)

-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
