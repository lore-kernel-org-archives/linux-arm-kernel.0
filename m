Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60922C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:23:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 303F020874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cHQIQTFC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 303F020874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Q/rmaDgqzbhVjomZcZJ1CzuiBUBFJ+I0w4Z+0kMX3H0=; b=cHQIQTFCEY9J/K
	Is9xmBa8kw52x/lMQyDgZ/lytW7vRmRivnQO/JmO/hnBxKEUOyMIxe3X8tvpsrMnoNTrg5n5mv0EL
	WSXOD8dr4cxxSC36rEyrQzKSzeaRXIbOZzwPLl9wTV6E1xc3l6b3VK+eHy0QPN0vHg8x0PBwfJWzt
	VZMURUEflQO5S/am+30d6xuUv/EKcGDFdNNFelCswXhdz27kKJFpkXAMHjWfty7MpGcKD4RaKOJMn
	JdJEkIi0zj/wr6Pb5D+cfhQ1pX49UDQDgC1wre5Zm+EiCdoAIMAyr3RFBCiPFV6Vwujk4TWrFOB0V
	wSbtF+FKTz7qwTzBhR1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYtns-0005Zx-80; Mon, 17 Dec 2018 14:23:28 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYtnN-00055g-L6
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 14:23:00 +0000
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 wBHELmjt018492; Mon, 17 Dec 2018 15:22:34 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2pcr8xjc8r-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Mon, 17 Dec 2018 15:22:33 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CE5DC31;
 Mon, 17 Dec 2018 14:22:32 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A26022424;
 Mon, 17 Dec 2018 14:22:32 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 17 Dec
 2018 15:22:32 +0100
Received: from localhost (10.201.20.122) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 17 Dec 2018 15:22:31
 +0100
From: Benjamin Gaignard <benjamin.gaignard@st.com>
To: <tglx@linutronix.de>, <jason@lakedaemon.net>, <marc.zyngier@arm.com>,
 <robh+dt@kernel.org>, <mark.rutland@arm.com>, <alexandre.torgue@st.com>
Subject: [PATCH v3 0/3] Make STM32 interrupt controller use hwspinlock
Date: Mon, 17 Dec 2018 15:22:12 +0100
Message-ID: <20181217142215.17493-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
X-Originating-IP: [10.201.20.122]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-17_05:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_062257_987208_CEF92BFA 
X-CRM114-Status: UNSURE (   8.73  )
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
Cc: Benjamin Gaignard <benjamin.gaignard@st.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This series allow to protect STM32 interrupt controller configuration registers
with a hwspinlock to avoid conflicting accesses between processors. 

version 3:
- with bindings patch

version 2:
- rework hwspinlock locking sequence in stm32 irqchip to take care of the
  cases where hwspinlock node is disabled or not yet probed

Benjamin Gaignard (3):
  dt-bindings: interrupt-controller: stm32: Document hwlock properties
  irqchip: stm32: protect configuration registers with hwspinlock
  ARM: dts: stm32: Add hwlock for irqchip on stm32mp157

 .../interrupt-controller/st,stm32-exti.txt         |   4 +
 arch/arm/boot/dts/stm32mp157c.dtsi                 |   1 +
 drivers/irqchip/irq-stm32-exti.c                   | 116 ++++++++++++++++++---
 3 files changed, 105 insertions(+), 16 deletions(-)

-- 
2.15.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
