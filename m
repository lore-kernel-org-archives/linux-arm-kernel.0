Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46511C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 04:20:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14FD92080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 04:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tFZ6dCYA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14FD92080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4TV1ehgtFfUHNLQ8phBZecGon0qxrGYJExSEdg2Ko+Q=; b=tFZ6dCYAe2ALRr
	k8QHvocgEU0okuuAHK796x9fi7N36BLmqmA57/4vmnim8s1KRinAHRUB/OKHW14UoLfzpXLBrkv1H
	AQqKo/0r72mtcLSkSd68o10p6TIk1x/v7xM+evZbLk2m+U2ID2BMdAr+YyuX+PKh5QTrxAZoVCwPg
	QF6UzeN/oopEXpkkOUN0JR9uV6zRs88sr6rH0Lgvfx0CmAr4D9Fit9R0Bc/XyYnQmNCGlGPQ0bQwt
	umkY8rgE41iYyutXwMaFgHQiNBzdKNDtqe+97XtmcAJzOAmXamrdXm78gZ7B9sT7Ewamf1o6XaehY
	I+xYVFpmCr6HyWDjfz+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXexJ-0003SD-ET; Fri, 14 Dec 2018 04:20:05 +0000
Received: from mail-sh2.amlogic.com ([58.32.228.45])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXexE-00039a-AB; Fri, 14 Dec 2018 04:20:01 +0000
Received: from [10.18.29.207] (10.18.29.207) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Fri, 14 Dec
 2018 12:19:59 +0800
Subject: Re: [PATCH RESEND v7 3/4] clk: meson: add sub MMC clock controller
 driver
To: Jerome Brunet <jbrunet@baylibre.com>, Neil Armstrong
 <narmstrong@baylibre.com>
References: <1544457877-51301-1-git-send-email-jianxin.pan@amlogic.com>
 <1544457877-51301-4-git-send-email-jianxin.pan@amlogic.com>
 <10f2875c9724d9d9dd4bd32eab1fa3f8e42a809c.camel@baylibre.com>
 <11bb5068-2c93-a415-b295-6ca994621280@amlogic.com>
 <2ed764a1c6a0fea5cb3e16dd48577c930ae28ca9.camel@baylibre.com>
From: Jianxin Pan <jianxin.pan@amlogic.com>
Message-ID: <510be84d-5c47-cf94-254f-55dba6977f7e@amlogic.com>
Date: Fri, 14 Dec 2018 12:19:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <2ed764a1c6a0fea5cb3e16dd48577c930ae28ca9.camel@baylibre.com>
Content-Language: en-US
X-Originating-IP: [10.18.29.207]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_202000_358013_4E00CBE3 
X-CRM114-Status: UNSURE (   7.53  )
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
Cc: Rob Herring <robh@kernel.org>, Hanjie Lin <hanjie.lin@amlogic.com>,
 Victor Wan <victor.wan@amlogic.com>, Stephen Boyd <sboyd@kernel.org>,
 Kevin Hilman <khilman@baylibre.com>,
 Michael Turquette <mturquette@baylibre.com>, Yixun Lan <yixun.lan@amlogic.com>,
 linux-kernel@vger.kernel.org, Boris Brezillon <boris.brezillon@bootlin.com>,
 Liang Yang <liang.yang@amlogic.com>, Jian Hu <jian.hu@amlogic.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Carlo Caione <carlo@caione.org>,
 linux-amlogic@lists.infradead.org,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Qiufang Dai <qiufang.dai@amlogic.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2018/12/13 17:01, Jerome Brunet wrote:
> On Thu, 2018-12-13 at 12:55 +0800, Jianxin Pan wrote:
>> On 2018/12/12 0:59, Jerome Brunet wrote:
>>> On Tue, 2018-12-11 at 00:04 +0800, Jianxin Pan wrote:
>>>> From: Yixun Lan <yixun.lan@amlogic.com>
>>>>
>> [...]
>>>>  
>>>> +config COMMON_CLK_MMC_MESON
>>>> +	tristate "Meson MMC Sub Clock Controller Driver"
>>>> +	select MFD_SYSCON
>>>> +	select COMMON_CLK_AMLOGIC
>>>> +	select COMMON_CLK_AMLOGIC_AUDIO
>>>
>>> No it is wrong for the mmc to select AUDIO clocks.
>>> If as a result of your patch sclk is needed for things, make the necessary
>>> change in the Makefile.
>> OK, I will add COMMON_CLK_AMLOGIC_SCLKDIV for sclk-div.
> 
> No! There is no reason to create a specific configuration for this.
> please put it under COMMON_CLK_AMLOGIC
OK, I will use COMMON_CLK_AMLOGIC and clkc.h for sclk-div in the next version. Thank you.
> 
>> [...]>> +#include <linux/clk.h>
>>>> +#include <linux/clk-provider.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/regmap.h>
>>>> +#include <linux/slab.h>
>>>> +#include <linux/of_device.h>
>>>> +#include <linux/mfd/syscon.h>
[...]



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
