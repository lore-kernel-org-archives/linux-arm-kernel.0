Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3112FC4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:41:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03911222D4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DvX91ZM9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03911222D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=2lqjdpPdSuqTHPOb8LC3u84mfRd1Bcve6V5CV924QgA=; b=DvX91ZM9g188Sb
	X0Vt3yCoZRdD5HHmJLdLadHfse18hpKz7Bg0o5j/CfSV88Txiu6vWSX239Rzib74nKrk6f7jR0FI/
	iXaeSNS+6wsIBucVzcJP/dYn2YT70llE+cVuk4yIYAsZVwlZavF80uDE43GpXzb7XacE5CIJ6F+9Z
	JHgFpqflgTPhhtVn9Sw4aCjBYwWYuK3cOcKCO3YxZ/jB194CGlqwwx8p0rb4Djwo3ufRMzNnKyuN1
	/P6LMzNL/NS7ng5LQzoJPPZ8Cmh5XxmEhb0DQ1jILYbLEPJMQFaA+UgEp8ura3iEF9XFilzAUDMH6
	1awtnwiubzQ+MPUZrQmg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guESR-0002fJ-I1; Thu, 14 Feb 2019 10:41:31 +0000
Received: from mx08-00178001.pphosted.com ([91.207.212.93]
 helo=mx07-00178001.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guERu-00027s-Cc
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 10:41:01 +0000
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1EAa3EO000645; Thu, 14 Feb 2019 11:40:51 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx08-00178001.pphosted.com with ESMTP id 2qmxr72gn1-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Thu, 14 Feb 2019 11:40:51 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 66AE138;
 Thu, 14 Feb 2019 10:40:50 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag4node2.st.com [10.75.127.11])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1F41F4EB0;
 Thu, 14 Feb 2019 10:40:50 +0000 (GMT)
Received: from localhost (10.75.127.45) by SFHDAG4NODE2.st.com (10.75.127.11)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2;
 Thu, 14 Feb 2019 11:40:49 +0100
From: <gabriel.fernandez@st.com>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@st.com>
Subject: [PATCH v2 0/7] update STM32MP1 clocks
Date: Thu, 14 Feb 2019 11:40:40 +0100
Message-ID: <20190214104047.1173-1-gabriel.fernandez@st.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG4NODE2.st.com
 (10.75.127.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-14_07:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_024058_727178_D9C45A36 
X-CRM114-Status: UNSURE (   6.73  )
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
Cc: Gabriel Fernandez <gabriel.fernandez@st.com>, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

Changes:
v2:
- add more explanation in commit mesages
- add one comment to the code

This patch-set fixes minor corrections (fixes and documentation alignment)
- add missing parent clocks
- don't change parent on set rate for kernel clocks
- set ck_csi clock as critical
- fix divider configuration



Gabriel Fernandez (7):
  clk: stm32mp1: parent clocks update
  clk: stm32mp1: add CLK_SET_RATE_NO_REPARENT to Kernel clocks
  clk: stm32mp1: set ck_csi as critical clock
  clk: stm32mp1: fix mcu divider table
  clk: stm32mp1: fix HSI divider flag
  clk: stm32mp1: remove unnecessary CLK_DIVIDER_ALLOW_ZERO flag
  clk: stm32mp1: fix bit width of hse_rtc divider

 drivers/clk/clk-stm32mp1.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

-- 
2.17.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
