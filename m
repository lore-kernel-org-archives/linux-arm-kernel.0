Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E157C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:15:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 091BF2085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jZXvsA1K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 091BF2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:To:Subject
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=sy0eYOP8MiH1uU6kPb6MrpTqZbFIPg9DOb1nbj98eeM=; b=jZXvsA1KhAvfuG
	u2ljBTGAeVx5n6ELo3tKsC9rb8d0iA6PDzXxUj0F7rutHzYga+rYVXeCCkTdHJRWtjNCqmwdDdOZc
	HlIIlLA3ubV80AwjIrbSpNeiw8d0w4rVsi8S6Z/KtIUUxuxieBH0K4iO1mAGQN0ZHr+5VE0eN1UlH
	DbVQYaqrW6/T8iOI5JwdBIB6Fp7tvICqLbU3CHF4YOUrvvd5r70H618/pLAUnNZRSMl0xIAUbpRTR
	npis5f57qCTszf44/XKgYF1rgkndmOemn/2sOTxPrRRF7KlyMtcoIl9bNkcvwfkUYUyTOagMC5rOp
	aKR1ijVtoFNdyvZACReg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs3Bt-00081Z-E3; Fri, 08 Feb 2019 10:15:25 +0000
Received: from lhrrgout.huawei.com ([185.176.76.210] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs3BT-0006MM-EI
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 10:15:22 +0000
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.107])
 by Forcepoint Email with ESMTP id AA950ACCA15B4E205958;
 Fri,  8 Feb 2019 10:14:54 +0000 (GMT)
Received: from [127.0.0.1] (10.202.226.46) by lhreml702-cah.china.huawei.com
 (10.201.108.43) with Microsoft SMTP Server id 14.3.408.0; Fri, 8 Feb 2019
 10:14:46 +0000
From: Wei Xu <xuwei5@hisilicon.com>
Subject: [GIT PULL] arm64: hisi: SoC driver updates for v5.1
To: <arm@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
 <olof@lixom.net>, <arnd@arndb.de>
Message-ID: <d047bba8-3d2c-7937-78f9-ef5feb0a33be@hisilicon.com>
Date: Fri, 8 Feb 2019 10:14:46 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Language: en-US
X-Originating-IP: [10.202.226.46]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_021459_884278_3B2630A1 
X-CRM114-Status: UNSURE (   9.28  )
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
Cc: Salil Mehta <salil.mehta@huawei.com>, jinying@hisilicon.com, Shameerali
 Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Tangkunshan <tangkunshan@huawei.com>, John Garry <john.garry@huawei.com>,
 linuxarm@huawei.com, xuwei5@hisilicon.com, yezengruan@huawei.com,
 huangdaode <huangdaode@hisilicon.com>, Jonathan.Cameron@huawei.com,
 "Liguozhu \(Kenneth\)" <liguozhu@hisilicon.com>,
 Zhangyi ac <zhangyi.ac@huawei.com>, Shiju Jose <shiju.jose@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi ARM-SoC team,

Please consider to pull the following changes.
Thanks!

Best Regards,
Wei

---

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://github.com/hisilicon/linux-hisi.git tags/hisi-drivers-for-5.1

for you to fetch changes up to 705c0ee8d4a64b072e324f8daa8767e92560a892:

  bus: hisi_lpc: Don't fail probe for unrecognised child devices (2019-02-08 09:18:53 +0000)

----------------------------------------------------------------
ARM64: hisi: SoC driver updates for 5.1

- Add compatibility support for different FWs in the hisi LPC bus driver

----------------------------------------------------------------
John Garry (1):
      bus: hisi_lpc: Don't fail probe for unrecognised child devices

 drivers/bus/hisi_lpc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)





_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
