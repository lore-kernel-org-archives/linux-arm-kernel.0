Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29075C282DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:28:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED5B0218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WjOyLk5z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED5B0218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:To:Subject:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YjjFkkWx5zGTzTHTma1PPIV+fBaSMJd0esDTpKtGlCk=; b=WjOyLk5zO8fiC0iHTsH4xqPllr
	g6Nb50vgagmh/1e7OxIUHC2FmYHM7dkxstSxqPdOEVkXdTgj5qEUf/xhoeLAtPsL3YytHF5/RmjnO
	C868ZrrcOlCtDo+3VU7zg2YTaVTYXtGXJBBbZ+FU6yGg8ru8rpZNHr/COtDVjnQ8+4FZweKx/fqq3
	31BNdg3EDHYrbcCmrf1Z3oV06Up2FboGW30e9tEnFO6I8dPqfxF10SnXSxNNWBuR2du+c013btT4D
	bMNkoAg0NxLPq44idUNTtd3s/OhSC8Hp/Bnmej7ozrLrN1kPwPVua4nPhq0cw7R1PFwb14KIPCf5j
	vRHBxDQw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpZo9-0007pT-Gm; Fri, 01 Feb 2019 14:28:41 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpZo6-0007oy-9g
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 14:28:40 +0000
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x11EKnom023707; Fri, 1 Feb 2019 15:28:29 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2qcnvqgmfy-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Fri, 01 Feb 2019 15:28:29 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9ADA334;
 Fri,  1 Feb 2019 14:28:28 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 754914EDF;
 Fri,  1 Feb 2019 14:28:28 +0000 (GMT)
Received: from [10.201.21.58] (10.75.127.48) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 1 Feb
 2019 15:28:27 +0100
From: Alexandre Torgue <alexandre.torgue@st.com>
Subject: [GIT PULL] STM32 DT changes for v5.1 #1
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Kevin
 Hilman <khilman@baylibre.com>, arm-soc <arm@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Message-ID: <917791d1-d789-897c-460d-89883d46ff60@st.com>
Date: Fri, 1 Feb 2019 15:28:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Language: en-US
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-01_10:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_062838_630174_F084A225 
X-CRM114-Status: GOOD (  11.38  )
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

Please consider this first (small) round of STM32 DT updates for v5.1. 
Note that this PR is based on stm32-dt-for-v4.21 which has been pulled 
into arm/dt for v5.1 recently by Arnd.

Thanks.
Alex

The following changes since commit 8914b63bab3c43a529316ba2858137bc57b74fa1:

   ARM: dts: stm32: add thermal sensor support on STM32MP157c 
(2018-12-03 10:43:26 +0100)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git 
tags/stm32-dt-for-v5.1-1

for you to fetch changes up to 38576a320578392d8ba7aaf4ca723450dc2430c3:

   ARM: dts: stm32: Enable thermal sensor support on STM32MP157c-ed1 
(2019-02-01 11:48:42 +0100)

----------------------------------------------------------------
STM32 DT updates for v5.1, round 1

Highlights:
----------

MPU part:
  -Enable Digital Thermal Sensor (dts) on stm32mp157c-ed1 (and so ev1).

MCU part:
  -Add SPI support on stm32f429 SOC (4 SPIs instances).

----------------------------------------------------------------
Cezary Gapinski (1):
       ARM: dts: stm32: add SPI support on STM32F429 SoC

David Hernandez Sanchez (1):
       ARM: dts: stm32: Enable thermal sensor support on STM32MP157c-ed1

  arch/arm/boot/dts/stm32f429.dtsi      | 60 
+++++++++++++++++++++++++++++++++++
  arch/arm/boot/dts/stm32mp157c-ed1.dts |  4 +++
  2 files changed, 64 insertions(+)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
