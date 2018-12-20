Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FC2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:54:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D9AA21852
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rwvDOpi0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D9AA21852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:Message-ID:Date
	:Subject:To:From:Reply-To:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=YQ8+fHP9ATNziULATfrCyec54mhDUfOrir55jEEch68=; b=rwvDOpi0B8F23A
	ct//oJraiyoCJ9YO50HWlLytr0bN1C8qwNuSFdIF+SSHU2zvB8oYtzYew5M4MaRYzVG2QYzsHMIE+
	oqP7jJCMxlAOM3Z9HZvfQFi+nncycwJ4aeU+8qnYy6uvxvIV66/VGOCF75CcjwN5YGyyVuPEpGn+a
	5Hr8tw6LRYLs1vor3zYKKFZrNipgKqAtfM4vg3eXWTIUS7fb+I0besFB10vGOUBjB1IbYAHpSSzSQ
	7t7wFdVwQ9hu7o9H1ldwNb9wg+Np3G6JNiH/Ru1JO/dGItwVKpcuXJx7UtCjzTIq7PAcmxcE3AJ66
	cuRdea+7j7lvdQ4WZvMg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZymj-0000gQ-0Q; Thu, 20 Dec 2018 13:54:45 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZyme-0000U8-Vh
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 13:54:42 +0000
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 wBKDpOp9013907; Thu, 20 Dec 2018 14:54:23 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2pcqy9mj71-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Thu, 20 Dec 2018 14:54:23 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1448F31;
 Thu, 20 Dec 2018 13:54:21 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node3.st.com [10.75.127.18])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DFCD62CB4;
 Thu, 20 Dec 2018 13:54:20 +0000 (GMT)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG6NODE3.st.com
 (10.75.127.18) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 20 Dec
 2018 14:54:20 +0100
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1347.000; Thu, 20 Dec 2018 14:54:20 +0100
From: Patrice CHOTARD <patrice.chotard@st.com>
To: "arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net" <olof@lixom.net>,
 "khilman@baylibre.com" <khilman@baylibre.com>, "arm@kernel.org"
 <arm@kernel.org>
Subject: [GIT PULL] STi SoC update for v4.21 round 1
Thread-Topic: [GIT PULL] STi SoC update for v4.21 round 1
Thread-Index: AQHUmGuBWkmEGCRrPkOR3xez7m4ltw==
Date: Thu, 20 Dec 2018 13:54:20 +0000
Message-ID: <9459cb9d-aafe-b712-9c95-30b2ff979d34@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.47]
Content-ID: <FC9504401D5D864A8B4750135923E785@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-20_07:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_055441_315525_CB4714CB 
X-CRM114-Status: GOOD (  11.59  )
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
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Arnd, Olof, Kevin

Please find STi SoC update for v4.21 round 1:

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pchotard/sti.git
tags/sti-soc-for-v4.21-round1

for you to fetch changes up to 704cfd7f5f71c6bc6cdfaa63a16ed0f72882b1a1:

  ARM: sti: remove pen_release and boot_lock (2018-12-20 14:32:15 +0100)

----------------------------------------------------------------

Highlights:
-----------
- Following pen_release and boot_lock cleanup initiated by
  Russell King, .smp_prepare_cpus and .smp_boot_secondary STi callbacks
  must be reworked to keep secondary CPU's bringup.

----------------------------------------------------------------
Patrice Chotard (1):
      ARM: sti: remove pen_release and boot_lock

 arch/arm/mach-sti/Makefile  |  2 +-
 arch/arm/mach-sti/headsmp.S | 43 ----------------------
 arch/arm/mach-sti/platsmp.c | 88
++++++++-------------------------------------
 3 files changed, 15 insertions(+), 118 deletions(-)
 delete mode 100644 arch/arm/mach-sti/headsmp.S
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
