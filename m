Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B985BC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:34:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0201206C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DKVN/n2h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0201206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=+AmXfy6ixYSUyBPPHDp1sQnRl/GsDhtQDc60UvZC3WQ=; b=DKVN/n2h4IQktb
	vMyX/5XgRuxVwZqW0w1Nac30JiLrzJcU7+tnCS5zyA5CJxDrLqa5/qCyAjPEWE+fOsscXNbRxkfMW
	cMjpkBJDntGG4HiJML5upEmxug4pvtIfY+MzTPsftZb0EelGgzWXHl0mh75EhWgH964ZGvy2EadO0
	G1/0Pla8PS1v9lE8gpGAtlWsKOd6Pk9LPyIFo1opR6mCqLt1cTRvgHqwHisMTdMlhI/uEVBjJ6CbE
	S4mfgPgRfcxWEyQNwPioD9DFgsXHwd2OZUDsdWK2PEL9zryeAv149uKbTSAvXRzbF5nV5RLb38Igm
	cf8PJRWiNbc1d4s5hqFA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXoY8-0008SO-9G; Fri, 14 Dec 2018 14:34:44 +0000
Received: from mx08-00178001.pphosted.com ([91.207.212.93]
 helo=mx07-00178001.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXoY3-0008I0-7V
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 14:34:41 +0000
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 wBEEVJek030825; Fri, 14 Dec 2018 15:34:22 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx08-00178001.pphosted.com with ESMTP id 2p85qkm06b-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Fri, 14 Dec 2018 15:34:22 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9EB9331;
 Fri, 14 Dec 2018 14:34:21 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8003752EC;
 Fri, 14 Dec 2018 14:34:21 +0000 (GMT)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 14 Dec
 2018 15:34:21 +0100
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Fri, 14 Dec 2018 15:34:21 +0100
From: Pascal PAILLET-LME <p.paillet@st.com>
To: "broonie@kernel.org" <broonie@kernel.org>, "lgirdwood@gmail.com"
 <lgirdwood@gmail.com>
Subject: [PATCH v8 0/6] Introduce STPMIC1 PMIC Driver
Thread-Topic: [PATCH v8 0/6] Introduce STPMIC1 PMIC Driver
Thread-Index: AQHUk7oZLTLjPB4M6kim7T/m8A4m2A==
Date: Fri, 14 Dec 2018 14:34:20 +0000
Message-ID: <1544798057-1499-1-git-send-email-p.paillet@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-14_07:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_063439_553122_F1582957 
X-CRM114-Status: UNSURE (   9.05  )
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
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Pascal PAILLET-LME <p.paillet@st.com>,
 Alexandre TORGUE <alexandre.torgue@st.com>,
 "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The goal of this patch-set is to propose a driver for the STPMIC1 PMIC from 
STMicroelectronics. 
The STPMIC1 regulators supply power to an application processor as well as 
to external system peripherals such as DDR, Flash memories and system
devices. It also features onkey button input and an hardware watchdog.
The STPMIC1 is controlled via I2C. 

Main driver is drivers/mfd/stpmic1 that handle I2C regmap configuration and
irqchip. stpmic1_regulator, stpmic1_onkey and stpmic1_wdt need stpmic1 mfd
as parent.

STPMIC1 MFD and regulator drivers maybe mandatory at boot time.

Pascal Paillet (6):
  dt-bindings: mfd: document stpmic1
  mfd: stpmic1: add stpmic1 driver
  dt-bindings: input: document stpmic1 pmic onkey
  input: stpmic1: add stpmic1 onkey driver
  dt-bindings: watchdog: document stpmic1 pmic watchdog
  watchdog: stpmic1: add stpmic1 watchdog driver

 .../devicetree/bindings/input/st,stpmic1-onkey.txt |  28 +++
 .../devicetree/bindings/mfd/st,stpmic1.txt         |  61 ++++++
 .../bindings/watchdog/st,stpmic1-wdt.txt           |  11 ++
 drivers/input/misc/Kconfig                         |  11 ++
 drivers/input/misc/Makefile                        |   2 +
 drivers/input/misc/stpmic1_onkey.c                 | 198 +++++++++++++++++++
 drivers/mfd/Kconfig                                |  16 ++
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/stpmic1.c                              | 213 +++++++++++++++++++++
 drivers/watchdog/Kconfig                           |  12 ++
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/stpmic1_wdt.c                     | 139 ++++++++++++++
 include/dt-bindings/mfd/st,stpmic1.h               |  50 +++++
 include/linux/mfd/stpmic1.h                        | 212 ++++++++++++++++++++
 14 files changed, 955 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/st,stpmic1-onkey.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/st,stpmic1.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/st,stpmic1-wdt.txt
 create mode 100644 drivers/input/misc/stpmic1_onkey.c
 create mode 100644 drivers/mfd/stpmic1.c
 create mode 100644 drivers/watchdog/stpmic1_wdt.c
 create mode 100644 include/dt-bindings/mfd/st,stpmic1.h
 create mode 100644 include/linux/mfd/stpmic1.h

-- 
1.9.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
