Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BD7C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:18:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 784CE20645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jy6h03AL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 784CE20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:Subject:From:To:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JD0eUX6szbkC5xMzWz5W62rbUwLQQDnd7q37LGJZUxs=; b=jy6h03ALug9vlMnrHGYxusMspE
	580Asr+3R0ne9xyTilmelJoQYgBfvVHuVF4sWPJGDZ/c7o0fGvMIt4YQ9bMyzm2yGUeaJW/GK+RDk
	YMttfXibujjf35C++/7xUfOCeALtLtEyz+oNmnPwNMxkaLbiajwAKf3BBn6DNcSQG4Cyd0pkxRXbn
	y2StujKGE+yOA/KqEh+O04UzGe/MskXpgnjhjhItTusBAMHm/5QR1YIyt/9MWSNXl7bTC6AU+5WT5
	x20v2GTcFI9hug6Ogz3X1P822NKQN2r7WGF0GSIXbfXIx1Ou82MlpbUO3kuOQUoxWT2hqXrRy4cPJ
	GYus/fHg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTmFK-0005yl-EP; Mon, 03 Dec 2018 11:18:38 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTmFH-0005q2-2B
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 11:18:37 +0000
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 wB3BD0Hl021598; Mon, 3 Dec 2018 12:18:19 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2p3uhmh6rs-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Mon, 03 Dec 2018 12:18:19 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6501B31;
 Mon,  3 Dec 2018 11:18:18 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4497A1665;
 Mon,  3 Dec 2018 11:18:18 +0000 (GMT)
Received: from [10.201.21.58] (10.75.127.47) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 3 Dec
 2018 12:18:17 +0100
To: Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@baylibre.com>,
 arm-soc <arm@kernel.org>, Olof Johansson <olof@lixom.net>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
From: Alexandre Torgue <alexandre.torgue@st.com>
Subject: [GIT PULL] STM32 DT changes for v4.21 #1
Message-ID: <3fb58758-a67f-3a0f-72d2-abbfd71b6ae0@st.com>
Date: Mon, 3 Dec 2018 12:18:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Language: en-US
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-03_06:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_031835_467205_35BC1B34 
X-CRM114-Status: GOOD (  12.60  )
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
Cc: Alexandre TORGUE <alexandre.torgue@st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Arnd, Olof and Kevin,

Please consider this first round of STM32 DT updates for v4.21.

Thanks.
Alex

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git 
stm32-dt-for-v4.21-1

for you to fetch changes up to 8914b63bab3c43a529316ba2858137bc57b74fa1:

   ARM: dts: stm32: add thermal sensor support on STM32MP157c 
(2018-12-03 10:43:26 +0100)

----------------------------------------------------------------
STM32 DT updates for v4.21, round 1

Highlights:
----------

-MPU STM32MP157 platform update:
  -Declare DMAs for timers
  -Add sleep support for CAN
  -Split CAN RAM mapping between the 2 FDCAN instances
  -Add support of thermal sensor (DTS)

----------------------------------------------------------------
Bich HEMON (3):
       ARM: dts: stm32: change CAN RAM mapping on stm32mp157c
       ARM: dts: stm32: add can1 sleep pins muxing
       ARM: dts: stm32: add can1 sleep pins muxing on stm32mp157c-ev1 board

David Hernandez Sanchez (1):
       ARM: dts: stm32: add thermal sensor support on STM32MP157c

Fabrice Gasnier (3):
       ARM: dts: stm32: Add dmas to timer on stm32mp157c
       ARM: dts: stm32: don't use timers dmas on stm32mp157c-ed1
       ARM: dts: stm32: don't use timers dmas on stm32mp157c-ev1

  arch/arm/boot/dts/stm32mp157-pinctrl.dtsi |  7 +++
  arch/arm/boot/dts/stm32mp157c-ed1.dts     |  3 +
  arch/arm/boot/dts/stm32mp157c-ev1.dts     | 10 +++-
  arch/arm/boot/dts/stm32mp157c.dtsi        | 97 
++++++++++++++++++++++++++++++-
  4 files changed, 114 insertions(+), 3 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
