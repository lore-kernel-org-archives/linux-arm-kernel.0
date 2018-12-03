Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAD2C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:46:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED95020851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SadK5Vdl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED95020851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=O+xbEkjlOpWGVQNzj00VbUEgOrWLKxOz3NRVSKz/kIw=; b=SadK5Vdlc6tweCdzvKK8/h1la
	UGdd6XWd7Rqwql8dncebVNWzTUdSPN8wst03xY/OroXikVDhjb6kKqwBO5sk/LTsKh2taLO60GLks
	Y8Li0lDIIQ9e91vgfK9x+ypSs5PQySTVC51b2/hu4bmbwVAVl+ZY48r5S2TMb3As7au3BlDHfnLOA
	tUOyWno6sQYNmwRzQZe7Z1E9cSREARsHy9JjdB0B3RR149Wj+W01Op0ZIRtghpB6lTydTZb7/kagl
	X3LOv69waURUWonRvP49E5CZZoH1qf0rY/Iig11BmZQyV58zrurbJ4kfCHOr10Oqmgvz8YIXHie7+
	s0k1gUr6w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTjs5-0003JM-Qg; Mon, 03 Dec 2018 08:46:29 +0000
Received: from mx08-00178001.pphosted.com ([91.207.212.93]
 helo=mx07-00178001.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTjs1-0003IQ-L9
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 08:46:27 +0000
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 wB38fMVq009068; Mon, 3 Dec 2018 09:46:07 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx08-00178001.pphosted.com with ESMTP id 2p3u7v8kad-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Mon, 03 Dec 2018 09:46:07 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E5A3734;
 Mon,  3 Dec 2018 08:46:05 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 860FEFCC;
 Mon,  3 Dec 2018 08:46:05 +0000 (GMT)
Received: from [10.201.21.58] (10.75.127.47) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 3 Dec
 2018 09:46:04 +0100
Subject: Re: [PATCH v3 0/4] Add support of STM32 hwspinlock
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>, <ohad@wizery.com>,
 <bjorn.andersson@linaro.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
References: <20181112152342.6561-1-benjamin.gaignard@st.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <5c137862-e8fa-abb4-d931-f5c63db50649@st.com>
Date: Mon, 3 Dec 2018 09:46:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181112152342.6561-1-benjamin.gaignard@st.com>
Content-Language: en-US
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-03_04:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_004625_988098_FFBF429E 
X-CRM114-Status: GOOD (  14.85  )
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
Cc: devicetree@vger.kernel.org, Benjamin Gaignard <benjamin.gaignard@st.com>,
 linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Benjamin,

On 11/12/18 4:23 PM, Benjamin Gaignard wrote:
> This serie adds the support of the hardware semaphore block for stm32mp1 SoC.
> 
> version 3:
> - fix clock name in properties description.
> - use postcore_initcall() instead of module_platform_driver()
> 
> version 2:
> - fix comments done by Bjorn about clock naming, license terms in header,
>    alphabetic ordering in Makefile and Kconfig and remove function
> - Do not push test module in this version while waiting for feedbacks about it
> 
> 
> Benjamin Gaignard (4):
>    dt-bindings: hwlock: Document STM32 hwspinlock bindings
>    hwspinlock: add STM32 hwspinlock device
>    ARM: dts: stm32: Add hwspinlock node for stm32mp157 SoC
>    ARM: dts: stm32: enable hwspinlock on stm32mp157c-ed1
> 
>   .../bindings/hwlock/st,stm32-hwspinlock.txt        |  23 +++
>   arch/arm/boot/dts/stm32mp157c-ed1.dts              |   4 +
>   arch/arm/boot/dts/stm32mp157c.dtsi                 |   9 ++
>   drivers/hwspinlock/Kconfig                         |   9 ++
>   drivers/hwspinlock/Makefile                        |   1 +
>   drivers/hwspinlock/stm32_hwspinlock.c              | 156 +++++++++++++++++++++
>   6 files changed, 202 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt
>   create mode 100644 drivers/hwspinlock/stm32_hwspinlock.c
> 

There is a (strong) dependency between pinctrl and hsem.
As our pin controller is enabled by default, it's better to enable also
your hwspinlock device by default. It will avoid pin controller probe 
defer and a no stable behavior. So, I gonna remove DT patches from 
stm32-next. Those Dt patches will not be included in my 4.20 pull-request.

regards
Alex

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
