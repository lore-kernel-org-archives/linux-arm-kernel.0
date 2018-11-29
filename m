Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862CFC43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:58:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B6B921104
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dlYQ50X3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B6B921104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JngnyiidyuvUFj52+CVeUWbRzMaV5YwmE8aDohS1kFg=; b=dlYQ50X3AKYyQF
	aze94Re86wRnNeJ9w8Se9stOO1FqfptKpPH3Q+fHkasHagurinzvWnTNxzXIlVDYwH/tgmq1pIDNI
	vOSMUWwAnn1BAjFGnULKWteGpvbGPZJtSy4biM35gOX09k/7knX3GculcTlh4fAg7dqj4Vj+Pkujj
	EscH/gIZgVa8LhIhsLUZECChXo2oQrS9qlw6D2NOP1/XqU+TU9lMXFXergnsUxSofiqiw3MQORU0Z
	cTD/9dwbIYTu1IWM3yAj+Z+eoWlE6jQCje0s4W+PA9iF3vvpDyU7l+gaPsC/T7BEtmRsMkak1hGHj
	EAb9L0pB7lTNQXYuD7gA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSSSW-0004Wi-GU; Thu, 29 Nov 2018 19:58:48 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSSRy-0003wx-1A
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 19:58:21 +0000
Received: from hillo.muru.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTP id 15E468181;
 Thu, 29 Nov 2018 19:58:05 +0000 (UTC)
From: Tony Lindgren <tony@atomide.com>
To: arm@kernel.org
Subject: [GIT PULL 4/4] defconfig changes for omaps for v4.21
Date: Thu, 29 Nov 2018 11:57:43 -0800
Message-Id: <pull-1543521343-338334@atomide.com-4>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <pull-1543521343-338334@atomide.com>
References: <pull-1543521343-338334@atomide.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_115814_810858_459762C2 
X-CRM114-Status: GOOD (  10.25  )
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
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.21/defconfig-signed

for you to fetch changes up to f98d45145e6a48b91e0cae12fae7a5367486e91e:

  ARM: multi_v7_defconfig: Enable 8250-omap serial driver and use it by default (2018-11-08 08:54:40 -0800)

----------------------------------------------------------------
Defconfig changes for omaps for v4.21 merge window

We're finally changing omaps to use 8250_OMAP instead of SERIAL_OMAP
for multi_v7_defconfig. This will make things much easier for distros,
and the kernel already warns about the kernel console getting
redirected with CONFIG_SERIAL_8250_OMAP_TTYO_FIXUP defaulting to y.

People using /etc/inittab still need to s/ttyO/ttyS/ if using the
out-of-box multi_v7_defconfig, and that did not seem to be an issue
when we moved omap2plus_defconfig to use 8250_OMAP earlier.

The other change is to enable CONFIG_SND_SOC_TLV320AIC23_I2C as a
loadable module that I forgot to send a pull request for earlier.

----------------------------------------------------------------
Adam Ford (1):
      ARM: omap2plus_defconfig: Add tlv320aic23 as module

Tony Lindgren (2):
      Merge branch 'omap-for-v4.20/defconfig' into omap-for-v4.21/defconfig
      ARM: multi_v7_defconfig: Enable 8250-omap serial driver and use it by default

 arch/arm/configs/multi_v7_defconfig  | 1 +
 arch/arm/configs/omap2plus_defconfig | 1 +
 2 files changed, 2 insertions(+)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
