Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5332C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:47:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8828620666
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qbTGlyuT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8828620666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=prsnzDQQnMk61EIuVQredws5GbDKR5uNRXxPdCaQewc=; b=qbTGlyuTAfpuoiVqOH+AqqVlJ
	QzIFqVTD8ei/fod+pwP5ybww/V/6g9KX8I4uphJBjdpNiscX8oSaGvH33/T4qb2DL0m+JNM2wp+BC
	L3GhX3djFO7iKaGIYwLEczhMs8XN0Yu7SrMOWMtlSJ9sY8rBaa9ZoJo9+r8KcxLOYLJex2SsJFnT4
	7Qn4itg5mIm6kVGCJqiQqx6+0dpbSCu4ifbW3pZrFxTEiqVbyUPtC2UcfbbFKXvYqAW7TT99CKt11
	maskQq3XGYkUwHOQy999oeXg11HaxeITZhVSDbnfyKRhDrA9I2QeoH5O3huRudVBUvWOykbi2UxmH
	1IeN0ARow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTkpV-0008At-2a; Mon, 03 Dec 2018 09:47:53 +0000
Received: from mx08-00178001.pphosted.com ([91.207.212.93]
 helo=mx07-00178001.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTkpR-0008AH-Mi
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 09:47:51 +0000
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 wB39kRiQ011781; Mon, 3 Dec 2018 10:47:30 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx08-00178001.pphosted.com with ESMTP id 2p3wt688m6-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Mon, 03 Dec 2018 10:47:30 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 476233A;
 Mon,  3 Dec 2018 09:47:29 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1020512AF;
 Mon,  3 Dec 2018 09:47:29 +0000 (GMT)
Received: from [10.201.21.58] (10.75.127.44) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 3 Dec
 2018 10:47:28 +0100
Subject: Re: [PATCH 3/3] ARM: dts: stm32: add thermal sensor support on
 STM32MP157c
To: David HERNANDEZ SANCHEZ <david.hernandezsanchez@st.com>, Zhang Rui
 <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
References: <1538734081-26585-1-git-send-email-david.hernandezsanchez@st.com>
 <1538734081-26585-4-git-send-email-david.hernandezsanchez@st.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <5feb7b44-aff0-1d53-bdf6-79e06dcb3a2f@st.com>
Date: Mon, 3 Dec 2018 10:47:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1538734081-26585-4-git-send-email-david.hernandezsanchez@st.com>
Content-Language: en-US
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-03_05:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_014750_031403_73C675EC 
X-CRM114-Status: GOOD (  13.70  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-stm32@st-md-mailman.stormreply.com"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi David,

On 10/5/18 12:08 PM, David HERNANDEZ SANCHEZ wrote:
> Add configuration on DT for thermal sensor driver
> 
> Signed-off-by: David Hernandez Sanchez <david.hernandezsanchez@st.com>
> 
> diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi 
> b/arch/arm/boot/dts/stm32mp157c.dtsi
> index 661be94..e90b9f6 100644
> --- a/arch/arm/boot/dts/stm32mp157c.dtsi
> +++ b/arch/arm/boot/dts/stm32mp157c.dtsi
> @@ -84,6 +84,31 @@

Applied on stm32-next.

Thanks.
Alex

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
