Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68CFC282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:07:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85F422075B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VpXkOXZa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85F422075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=TWiq4m5F44FqEmTssFNYw1wPvObtlprNDixlDzRA1QA=; b=VpXkOXZaqm3rqi
	oDfJLrRsUxgM9KG+GdL8mlWIYsdpqpPeJrQ5O1+wTfXxF29G/l3zmpJre2Zps18+aUt/aKRublus5
	a9/hBm6gZxMcDRmFA/cYquA5k/hqFvqQ9qWpP5CwM60xSJjUUJKsbEouqqITCKSGq4KNnnYT0H+lL
	BY/WQ82Itq/ZdhNldHEqZqzz0RxBDJbQfCXI+JGmQOgPBVYk597fkiI5oKXmCjJosYhF+jrTqnJx+
	W3OmHmRtuBiZD4AD6dLxXCrd/wJeF2KQ5l1kvyMOs6/S2OT4b33sQKTNlrX7RhXi41fd9wM4gpKgu
	Mw2AyoXjyMbBFQ9Z1bzA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqwhg-0001Fb-Ic; Tue, 05 Feb 2019 09:07:40 +0000
Received: from mx08-00178001.pphosted.com ([91.207.212.93]
 helo=mx07-00178001.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqwhV-00015p-Dz
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 09:07:31 +0000
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x158uNOc002818; Tue, 5 Feb 2019 10:07:19 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx08-00178001.pphosted.com with ESMTP id 2qd17bp1uh-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Tue, 05 Feb 2019 10:07:19 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9426931;
 Tue,  5 Feb 2019 09:07:17 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6B012247E;
 Tue,  5 Feb 2019 09:07:17 +0000 (GMT)
Received: from localhost (10.75.127.46) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 5 Feb 2019 10:07:16
 +0100
From: Alexandre Torgue <alexandre.torgue@st.com>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>, <arnd@arndb.de>,
 <robh+dt@kernel.org>, <mark.rutland@arm.com>
Subject: [PATCH v2 0/2] Add STM32MP157 discovery boards support
Date: Tue, 5 Feb 2019 10:07:03 +0100
Message-ID: <1549357625-7229-1-git-send-email-alexandre.torgue@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-05_03:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_010729_760371_8D9A06EE 
X-CRM114-Status: UNSURE (   8.86  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alexandre Torgue <alexandre.torgue@st.com>,
 linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch series add support of two new discovery boards based on
STM32MP157 MPU: stm32mp157a-dk1 and stm32mp157c-dk2.

stm32mp157a-dk1 board embeds a STM32MP157a SOC with AC package (TFBGA361,
148 ios) and 512MB of DDR3. Several connections are available on this boards:
4*USB2.0, 1*USB2.0 typeC, SDcard, RJ45, HDMI, Arduino connector, ...

stm32mp157c-dk2 board complements stm32mp157a-dk1 board with a display panel
(otm8009a) and a Murata Wifi/BT combo. It embeds a STM32MP157c SOC with AC
package.

Those patches enable basic support for a kernel boot.

regards
Alex

Alexandre Torgue (2):
  ARM: dts: stm32: add initial support of stm32mp157a-dk1 board
  ARM: dts: stm32: add initial support of stm32mp157c-dk2 board

 arch/arm/boot/dts/Makefile            |  2 +
 arch/arm/boot/dts/stm32mp157a-dk1.dts | 77 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/stm32mp157c-dk2.dts | 75 ++++++++++++++++++++++++++++++++++
 3 files changed, 154 insertions(+)
 create mode 100644 arch/arm/boot/dts/stm32mp157a-dk1.dts
 create mode 100644 arch/arm/boot/dts/stm32mp157c-dk2.dts

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
