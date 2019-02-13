Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48705C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:16:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 142972190A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p1tzJEd/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 142972190A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=x+R4lCwotoEybDp7Bj6mNb6oP4BIVfVAvLKszJalMMo=; b=p1tzJEd/5bm7GZ
	8NNgSlax37fZW3fkoGaOKyTgscgngUuQDFbZ0CpCb2VrLUN8OqPEZKHf/3WYNxS8+UtYP8rDHix+0
	rKrBJRuSwplAQAxe7EQ/7ORsJeGfx9l3aEdqQpEAubMCUtgw431Pimng08VcTBu/90pmZvHz2Km3Y
	Wvbjmr3ChwT0rJDLA+vS+aJWTeCGYjlXgZsBNeixGJrpfoCpZY+RPs0/SyvOvkyKx1aRlmhdTY4Dp
	XEX3Cqo3WJamIO+Ith5bjy/FngZCNDCz6+Hh2cSSO72lw2OYJ9M6Qi0Pq2d2DZDu6TDY1Y3tyKAS3
	BKSHfxPHwkVJdVEScvDg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtraG-0002gC-Gt; Wed, 13 Feb 2019 10:16:04 +0000
Received: from mx08-00178001.pphosted.com ([91.207.212.93]
 helo=mx07-00178001.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtraC-0002fi-T1
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 10:16:02 +0000
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1DAD72S004087; Wed, 13 Feb 2019 11:15:47 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx08-00178001.pphosted.com with ESMTP id 2qhv0m6fv8-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Wed, 13 Feb 2019 11:15:46 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8F3CE31;
 Wed, 13 Feb 2019 10:15:45 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 59EC12D3A;
 Wed, 13 Feb 2019 10:15:45 +0000 (GMT)
Received: from [10.48.0.167] (10.75.127.51) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 13 Feb
 2019 11:15:44 +0100
Subject: Re: [PATCH 0/4] Add nvmem support on STM32
To: <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
 <alexandre.torgue@st.com>
References: <1548866336-14765-1-git-send-email-fabrice.gasnier@st.com>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <4aaa83b2-35a6-e2c2-a3f4-6579b5d67038@st.com>
Date: Wed, 13 Feb 2019 11:15:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548866336-14765-1-git-send-email-fabrice.gasnier@st.com>
Content-Language: en-US
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-13_07:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_021601_220383_658A5CFE 
X-CRM114-Status: GOOD (  12.55  )
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
Cc: mark.rutland@arm.com, lionel.debieve@st.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, mcoquelin.stm32@gmail.com,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/30/19 5:38 PM, Fabrice Gasnier wrote:
> Non volatile memory area is available on STM32. It contains various
> factory programmed information such as unique device ID, analog calibration...
> This patchset adds NVMEM support to access these data.

Hello,

Gentle reminder for this new driver review

Best Regards,
Fabrice

> 
> Fabrice Gasnier (4):
>   dt-bindings: nvmem: Add STM32 factory-programmed romem
>   nvmem: Add driver for STM32 factory-programmed read only mem
>   nvmem: stm32: add support for STM32MP15 BSEC to control OTP data
>   ARM: dts: stm32: Add romem and temperature calibration on stm32mp157c
> 
>  .../devicetree/bindings/nvmem/st,stm32-romem.txt   |  31 ++++
>  arch/arm/boot/dts/stm32mp157c.dtsi                 |  13 ++
>  drivers/nvmem/Kconfig                              |  10 +
>  drivers/nvmem/Makefile                             |   2 +
>  drivers/nvmem/stm32-romem.c                        | 202 +++++++++++++++++++++
>  5 files changed, 258 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/st,stm32-romem.txt
>  create mode 100644 drivers/nvmem/stm32-romem.c
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
