Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9DBC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:11:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A91B2080D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eYcvXInI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A91B2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=sil5YeMzsECojiwInBRNYTam6PvcPNxeAfT1uoXC6is=; b=eYcvXInI/+0pDsLYJFKFM2vQL
	BzN0C7ndtifdMj5DlihWy1agpPVKALLb9n+pNv7SkS5QEOBHMW0EmvN+gGItI04GktWllbAR80DLV
	hWFBPGQlnrlQX4aLko4fjbqfu1B3NHE71RLbd6k8bL4Ip02Xk6DjnOZ19Odq6LLTVwu7ozrZ2KlKx
	k4OPWEKNKjkT08QLeVIsi17pl/B7noejxDt6SOcKCLfUEWfxGRSGqjb/mD+nK8BPCFhKR1yWb7sm3
	cHeyo0rZ0UIhmITU2pzFIIfBNtL41uaNg1+rMEEwJnEr49oMIICLTBdsy9PE80ul7QFg4Z+NqF+AC
	oBQI+ozpA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqwkr-0003Tp-Hy; Tue, 05 Feb 2019 09:10:57 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqwkj-0003TS-Uj
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 09:10:55 +0000
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1597eXZ008909; Tue, 5 Feb 2019 10:10:41 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2qdjdnjqy7-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Tue, 05 Feb 2019 10:10:41 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4790948;
 Tue,  5 Feb 2019 09:10:41 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D55182499;
 Tue,  5 Feb 2019 09:10:40 +0000 (GMT)
Received: from [10.201.21.58] (10.75.127.49) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 5 Feb
 2019 10:10:40 +0100
Subject: Re: [PATCH v2 0/2] Add STM32MP157 discovery boards support
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>, <arnd@arndb.de>,
 <robh+dt@kernel.org>, <mark.rutland@arm.com>
References: <1549357625-7229-1-git-send-email-alexandre.torgue@st.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <b42eb57e-a413-d65a-e040-b380d859423f@st.com>
Date: Tue, 5 Feb 2019 10:10:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1549357625-7229-1-git-send-email-alexandre.torgue@st.com>
Content-Language: en-US
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-05_04:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_011050_289054_35E59CC8 
X-CRM114-Status: GOOD (  13.66  )
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

Typo in title, it's a v1 not a v2.

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

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
