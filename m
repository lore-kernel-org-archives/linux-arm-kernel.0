Return-Path: <SRS0=kGow=PH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D756C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 05:12:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 363D5213F2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 05:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nsSZlHhd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 363D5213F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gBfKSL7Dh7iYDIF7hTUZYITM3x1XB9W/TLbx8xF3/OY=; b=nsSZlHhddrnyHB
	ObHdzYeKDT6TYW9UbWYnwIvYQiv3ImSIZGeEr4K+1Yy2yLyd4hHiopdoMY2hJqW6dMAWzveM9Wn4D
	2c/TwJaOGDWd+v8xaXCjS8dx16Ipfz3tgQ5taus+1GqRH6FEBjZpH3sXxJEF05xkH2+sRvkFE98lt
	PNAuuevW1ue3QvKBcdQYdMpa8qiDrapzybWg2Q+B7AeBHIphuA6+WFTy4xYrWfGdEpmfJ0XI2PmFM
	8mjoRZExaEWstRdKBdEMiS7yMTc5O6TdnC6rH8LsQRSl1SESuT1HE4O8QPA/K1UE1gdbi+vVU2NJW
	QdgND3DU8QqE6GNskz/w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gdTOy-0004Wu-UZ; Sun, 30 Dec 2018 05:12:40 +0000
Received: from mga11.intel.com ([192.55.52.93])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gdTOv-0004Vj-2Z
 for linux-arm-kernel@lists.infradead.org; Sun, 30 Dec 2018 05:12:38 +0000
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 Dec 2018 21:12:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,416,1539673200"; d="scan'208";a="131616454"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
 by fmsmga004.fm.intel.com with ESMTP; 29 Dec 2018 21:12:23 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
 (envelope-from <lkp@intel.com>)
 id 1gdTOh-000AhL-FL; Sun, 30 Dec 2018 13:12:23 +0800
Date: Sun, 30 Dec 2018 13:10:38 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] fix platform_no_drv_owner.cocci warnings
Message-ID: <20181230051038.GA14972@ivb43.lkp.intel.com>
References: <201812301340.cMEhlK1Z%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201812301340.cMEhlK1Z%fengguang.wu@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181229_211237_124663_6EB06AD1 
X-CRM114-Status: GOOD (  12.34  )
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
Cc: kbuild-all@01.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: kbuild test robot <fengguang.wu@intel.com>

drivers/gpio/gw_i2c_pld.c:351:3-8: No need to set .owner here. The core will do it.

 Remove .owner field if calls are used which set it automatically

Generated by: scripts/coccinelle/api/platform_no_drv_owner.cocci

Fixes: 443f1c782cc7 ("GW i2c PLF GPIO")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git ixp4
head:   fd04bd59327ab42cfa79c1a5aaa3160fc4821402
commit: 443f1c782cc742e40a1ef4cb2bca0afa2fea9baf [4/9] GW i2c PLF GPIO

 gw_i2c_pld.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/gpio/gw_i2c_pld.c
+++ b/drivers/gpio/gw_i2c_pld.c
@@ -348,7 +348,6 @@ static int gw_i2c_pld_remove(struct i2c_
 static struct i2c_driver gw_i2c_pld_driver = {
 	.driver = {
 		.name	= "gw_i2c_pld",
-		.owner	= THIS_MODULE,
 	},
 	.probe	= gw_i2c_pld_probe,
 	.remove	= gw_i2c_pld_remove,

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
