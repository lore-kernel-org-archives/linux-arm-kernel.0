Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B0FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:21:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBA4420C01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RxouCHJr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBA4420C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jD/OLi3GNX4R6LUzERhk0s/8Nfu1XKkqMTS9Z2v1NXE=; b=RxouCHJrgFkg948ClWj/+3iuG
	8ymHhVrnm4DGab9Gn9iErjl47j5PEXU7fbTK0cD0mPVDLrrajGOvV199NMynZhx4RtAS/1VdqGj7w
	hIbwtdgOJceeQBEGCjPS+pkP9s7Bno1KDUEsMnRIplU5G+roqt9Ucr4Q9Qe0QnlTAe7el2FqV25H4
	c784KLDuj7AH8FIGdwd5z341IILgpkSn4QM2Dag0AQ7YmBL2wPA42nkXfRl2HMRoC+QXhbXV9MQMV
	D53h5okyeGkGUvLr+FdT8mMsiNnaSbMpZFmldjyi1C/pROJZZ42pHwefysPD0LKAFBiJ+uIoM09Bw
	6wZku8jpA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz1xK-0006l0-0B; Wed, 27 Feb 2019 16:21:14 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz1xG-0006ka-Np
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 16:21:12 +0000
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1RGBqXJ005085; Wed, 27 Feb 2019 17:20:58 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2qtvh3qnej-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Wed, 27 Feb 2019 17:20:58 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A8A4F3D;
 Wed, 27 Feb 2019 16:20:57 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6AD62A5FB;
 Wed, 27 Feb 2019 16:20:57 +0000 (GMT)
Received: from [10.48.0.204] (10.75.127.46) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 27 Feb
 2019 17:20:57 +0100
Subject: Re: [PATCH v2 0/2] ARM errata 814220
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>, <linux@armlinux.org.uk>, 
 <arnd@arndb.de>, Russell King - ARM Linux <linux@armlinux.org.uk>
References: <20190214083145.15148-1-benjamin.gaignard@linaro.org>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <e25b2626-231b-28d7-93b0-004a21a3685e@st.com>
Date: Wed, 27 Feb 2019 17:20:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190214083145.15148-1-benjamin.gaignard@linaro.org>
Content-Language: en-US
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-27_10:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_082111_069694_086664FC 
X-CRM114-Status: GOOD (  15.08  )
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
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


On 2/14/19 9:31 AM, Benjamin Gaignard wrote:
> Implement ARM errata 814220 for Cortex A7.
> 
> This patch has been wroten by Jason Liu years ago but never send upstream.
> I have tried to contact the author on multiple email addresses but I haven't
> found any valid one...
> I have keep Jason's sign-off and just rebase the patch on to v5-rc6.
> 
> version 2:
> - limite help lines to 80 columns.
> - Add  Arnd Bergmann acks.
>    
> Benjamin Gaignard (2):
>    ARM: errata 814220-B-Cache maintenance by set/way operations can
>      execute out of order.
>    ARM: stm32: select ARM errata 814220
> 
>   arch/arm/Kconfig            | 12 ++++++++++++
>   arch/arm/mach-stm32/Kconfig |  1 +
>   arch/arm/mm/cache-v7.S      |  3 +++
>   3 files changed, 16 insertions(+)
> 

Russel,

If you agree, can I take this series in my STM32 soc tree ?
If yes it will be part of my PR for v5.2.

regards
Alex

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
