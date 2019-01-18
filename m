Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D53C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:13:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3910F2087E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l2cME5xz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3910F2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=lwGzV82eF+mrKOYjuq1RQ+2fkZwRDycK2Hva4Vxt2ek=; b=l2cME5xzIwhXDO
	iGAojbzH6A/qcj/BMt1fbE3rr0vwLN0hRpXJ74kIGv0GdKmHeGzq0mccRwiEMYJZq6dXGHwVCO3nf
	j7YMggAwTzv4qYs6lYVOOe3GQ8X6b5pyZMdSExGfDUf+pEO6j3jqSkbzOPLKBZqmv4HZmcFQFjEoD
	P9ubKBx/WIBRuDmv88kE6QeNCOVGVi9B8EQhFVId/5D0bcuQRaTnhp4e13iI2wRaZvLTQwcU9Fbn2
	0EpDFtP46cyAMDJnhUI/IcMqmGijSx2j7eipKx0+Ehs6vbJeOfk+GnRF2cUXBSoa74mjiksVwnD8h
	DOmGxq9IW8qkGCA2CJkA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkUtp-0008Ln-VW; Fri, 18 Jan 2019 14:13:33 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkUtm-0008Kc-7K
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 14:13:31 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 9173C207AC; Fri, 18 Jan 2019 15:13:27 +0100 (CET)
Received: from localhost (alyon-652-1-26-46.w109-213.abo.wanadoo.fr
 [109.213.9.46])
 by mail.bootlin.com (Postfix) with ESMTPSA id 342782074A;
 Fri, 18 Jan 2019 15:13:27 +0100 (CET)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
Subject: [PATCH v5 0/2] Add cpufreq support for Armada 8K
Date: Fri, 18 Jan 2019 15:11:38 +0100
Message-Id: <20190118141140.30352-1-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_061330_399473_0A1AE592 
X-CRM114-Status: GOOD (  11.16  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 Antoine Tenart <antoine.tenart@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

this is the fifth version of a the series adding the cpufreq support
for the Marvell Armada 8K SoCs.

Gregory

Changelog:
v4 -> v5:

 - Rebased onto v5.0-rc1

 - Rewrite the clk_get part in armada_8k_get_sharing_cpus()

 - Reverse the call function order in armada_8k_cpufreq_exit()

v3 -> v4:

 - Remove most of the global variable and use the private data of the
   platfrom device to store the freq_tables struct.

 - Remove the clk pointer of the freq_table struct which is no more
   needed with the new way to register the opp

 - Check the get_cpu_device() return.

 - Balance the clk_get() calls.

 - No more use the devm_ function.

 - Base the registration of the opp on the cpu mask updated after each
   iteration to find the shared cpus.

 - Base the free on the NULL or 0 value of the freq_table struct
   members, it allows to remove the global index.

v2 -> v3

 - Make the driver really modular (modprobe;modprobe -r;modprobe; is working)

 - Don't use anymore 100MHz as minimal frequency, but only max frequency/4

 - Fix remaining warning reported by checkpatch

 - Rework the registering of the opp

v1 -> v2:

 - Fix typos in MAINTAINERS (reported by Baruch Siach) and in
   armada-8k-cpufreq.c (reported by Thomas Petazzoni)

 - Fix indentation in Kconfig.arm  (reported by Thomas Petazzoni)

 - Use const for opps_div  (reported by Thomas Petazzoni)

 - Fix memory leak of opps_array  (reported by Thomas Petazzoni)


Gregory CLEMENT (2):
  MAINTAINERS: add new entries for Armada 8K cpufreq driver
  cpufreq: ap806: add cpufreq driver for Armada 8K

 MAINTAINERS                         |   1 +
 drivers/cpufreq/Kconfig.arm         |  11 ++
 drivers/cpufreq/Makefile            |   1 +
 drivers/cpufreq/armada-8k-cpufreq.c | 203 ++++++++++++++++++++++++++++
 4 files changed, 216 insertions(+)
 create mode 100644 drivers/cpufreq/armada-8k-cpufreq.c

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
