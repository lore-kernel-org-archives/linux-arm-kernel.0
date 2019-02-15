Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD80C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:17:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A4BA21A80
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aEI3zNaI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A4BA21A80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=avagLIBVax9LMUuxw7smEKUYc2NuW4yLH0+YvhJvU2g=; b=aEI3zNaI4yPO57QG64cxK/o7I
	YngRveoaRd+bgI8lcRurUbyplS9SfTJ8+WFmba7EIWWBDLEIgsHL0GibReaxroXKTRv7SYoA5NqeY
	o+qRRlTMBMAU0izrx9g+NO+Do3b4BEi8wNoNXvw5VxpwIU/OGAxWBE+BaWi9Akcd8LtwJmV5G1UK5
	TSFUz68hy8i+AxV2MntT2XHGv/DbAeI+SW4hyE8r76BU3qfqtbhrKzGmSa0YVdxM5/KL5Rr1G7QvC
	+Cb4WD7iwPxjKByGPI15Inhw5S9OVVvF4GEdNKUJnrsMoOVs1coDwifgr5Dew7W16+sXxGsvOHVc+
	VvbXpIezg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guaYG-0000Fc-SJ; Fri, 15 Feb 2019 10:17:00 +0000
Received: from mx08-00178001.pphosted.com ([91.207.212.93]
 helo=mx07-00178001.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guaYC-0000FH-QR
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 10:16:58 +0000
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1FAG0N9015339; Fri, 15 Feb 2019 11:16:49 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx08-00178001.pphosted.com with ESMTP id 2qmwsus558-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Fri, 15 Feb 2019 11:16:49 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CAE8F3A;
 Fri, 15 Feb 2019 10:16:48 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 860D02CD4;
 Fri, 15 Feb 2019 10:16:48 +0000 (GMT)
Received: from [10.201.21.58] (10.75.127.45) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 15 Feb
 2019 11:16:48 +0100
Subject: Re: [PATCH v2 0/2] Add STM32MP157 discovery boards support
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>, <arnd@arndb.de>,
 <robh+dt@kernel.org>, <mark.rutland@arm.com>
References: <1549357625-7229-1-git-send-email-alexandre.torgue@st.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <243cc4f0-6910-82ea-9c0a-929faee168a5@st.com>
Date: Fri, 15 Feb 2019 11:16:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1549357625-7229-1-git-send-email-alexandre.torgue@st.com>
Content-Language: en-US
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG7NODE1.st.com (10.75.127.19) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-15_07:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_021657_145470_3C6BEA31 
X-CRM114-Status: GOOD (  13.93  )
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
Cc: devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 2/5/19 10:07 AM, Alexandre Torgue wrote:
> This patch series add support of two new discovery boards based on
> STM32MP157 MPU: stm32mp157a-dk1 and stm32mp157c-dk2.
> 
> stm32mp157a-dk1 board embeds a STM32MP157a SOC with AC package (TFBGA361,
> 148 ios) and 512MB of DDR3. Several connections are available on this boards:
> 4*USB2.0, 1*USB2.0 typeC, SDcard, RJ45, HDMI, Arduino connector, ...
> 
> stm32mp157c-dk2 board complements stm32mp157a-dk1 board with a display panel
> (otm8009a) and a Murata Wifi/BT combo. It embeds a STM32MP157c SOC with AC
> package.
> 
> Those patches enable basic support for a kernel boot.
> 
> regards
> Alex
> 
> Alexandre Torgue (2):
>    ARM: dts: stm32: add initial support of stm32mp157a-dk1 board
>    ARM: dts: stm32: add initial support of stm32mp157c-dk2 board
> 
>   arch/arm/boot/dts/Makefile            |  2 +
>   arch/arm/boot/dts/stm32mp157a-dk1.dts | 77 +++++++++++++++++++++++++++++++++++
>   arch/arm/boot/dts/stm32mp157c-dk2.dts | 75 ++++++++++++++++++++++++++++++++++
>   3 files changed, 154 insertions(+)
>   create mode 100644 arch/arm/boot/dts/stm32mp157a-dk1.dts
>   create mode 100644 arch/arm/boot/dts/stm32mp157c-dk2.dts
> 

Series applied on stm32-next.

Regards
Alex

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
