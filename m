Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42324C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 02:39:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13BC82081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 02:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ocBc46HL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13BC82081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6dwhmGvBrBr7hScbtOTYWPmVyWXw+VRcnPqGuA7Lq5s=; b=ocBc46HLbn1Xen
	K5vPbfxTpo49Wlf69XkLmbVl6Kq5FgEeOQRN4K8hSdE1ZL8p3zqkgOoykQ6r0SzgW4jg3Hw3zsDxy
	U2wB/wk+EzeBS/KNvgAyLVIz8js/lozUZ9uRiDXOdA016iaEda1QlHdARcsXJlYKEwlRdoZkVLsQf
	yv6ubJON0klzIbI1R6dWYPCW31udFW7yMQi0AlHZzsl5ZCkZXVzL5vutJmQ4PuZVAnR4IfN4uGvJ5
	Q1pd/HdSTPoiMCdK3Xyhl2tj4fcW9v4WE93gMeBYRXygYbFx7HAvPAw2n24Zs+OCpCxAL1ENJNc+r
	m5r1HlfRyddlPgmC7WUw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU0cc-0005gw-6Z; Tue, 04 Dec 2018 02:39:38 +0000
Received: from mail-sh2.amlogic.com ([58.32.228.45])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU0cY-0005fu-Jk; Tue, 04 Dec 2018 02:39:35 +0000
Received: from [10.18.29.207] (10.18.29.207) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Tue, 4 Dec 2018
 10:39:34 +0800
Subject: Re: [PATCH v7 2/4] clk: meson: add DT documentation for emmc clock
 controller
To: Stephen Boyd <sboyd@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>,
 Neil Armstrong <narmstrong@baylibre.com>
References: <1542284312-55418-1-git-send-email-jianxin.pan@amlogic.com>
 <1542284312-55418-3-git-send-email-jianxin.pan@amlogic.com>
 <154387713374.88331.16436869339024592009@swboyd.mtv.corp.google.com>
From: Jianxin Pan <jianxin.pan@amlogic.com>
Message-ID: <b401f5bc-32e7-1693-0839-87ffa3dd5767@amlogic.com>
Date: Tue, 4 Dec 2018 10:39:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <154387713374.88331.16436869339024592009@swboyd.mtv.corp.google.com>
Content-Language: en-US
X-Originating-IP: [10.18.29.207]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_183934_649974_CF68E698 
X-CRM114-Status: GOOD (  10.12  )
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
Cc: Rob Herring <robh@kernel.org>, Hanjie Lin <hanjie.lin@amlogic.com>,
 Victor Wan <victor.wan@amlogic.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Kevin Hilman <khilman@baylibre.com>,
 Michael Turquette <mturquette@baylibre.com>, Yixun Lan <yixun.lan@amlogic.com>,
 linux-kernel@vger.kernel.org, Boris Brezillon <boris.brezillon@bootlin.com>,
 Liang Yang <liang.yang@amlogic.com>, Jian Hu <jian.hu@amlogic.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Carlo Caione <carlo@caione.org>,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Qiufang Dai <qiufang.dai@amlogic.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Stephen,

On 2018/12/4 6:45, Stephen Boyd wrote:
> Quoting Jianxin Pan (2018-11-15 04:18:30)
>> diff --git a/include/dt-bindings/clock/amlogic,mmc-clkc.h b/include/dt-bindings/clock/amlogic,mmc-clkc.h
>> new file mode 100644
>> index 0000000..162b949
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/amlogic,mmc-clkc.h
>> @@ -0,0 +1,17 @@
>> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
>> +/*
>> + * Meson MMC sub clock tree IDs
>> + *
>> + * Copyright (c) 2018 Amlogic, Inc. All rights reserved.
>> + * Author: Yixun Lan <yixun.lan@amlogic.com>
>> + */
>> +
>> +#ifndef __MMC_CLKC_H
>> +#define __MMC_CLKC_H
>> +
>> +#define CLKID_MMC_DIV                          1
> 
> Why does the define numbering start with 1 instead of 0?
>
The Clock ID 0 is used by  CLKID_MMC_MUX.
CLKID_MMC_MUX is an internal clock which defined in drivers/clk/meson/mmc-clkc.c, and it's the parent of CLKID_MMC_DIV.
 
>> +#define CLKID_MMC_PHASE_CORE                   2
>> +#define CLKID_MMC_PHASE_TX                     3
>> +#define CLKID_MMC_PHASE_RX                     4
>> +
> 
> .
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
