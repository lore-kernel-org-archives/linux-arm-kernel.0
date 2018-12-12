Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138F5C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:19:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D74C52086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u4JtimUF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D74C52086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dAaLrIMnWZhGmxlaDRt1b6/v62xPdOCneUi/ABmNXo4=; b=u4JtimUFSaQwx8
	AfGxcN36ASqNbJXKYXlpeC6ytS6+GHh28nRmYlEVqT8ElU4NDiEa4z8Zx8gDchwUjIzpvm5+uLFkg
	sT8v0GwgrOAVRhMVXgAtia+0C3RUjEYLTmLa0sQFYmprn5aNEiLr9/PFPLuKOVXuZn6eJjGBCi8jj
	gfrgHqoD0U5sHGjks4z4PjxkcZ5SRhukdZuX5RAI9MbrsJjKOGbrQ85j8lhWutyuPsmJmW0vOwLln
	AVwEkTrSRCluCWziWmr8DWVjknNqA0GM5FE8IO730Szh7+l5+d7YpP4dD9Do0xMBP35HlaKDTmC9I
	o8btUKNqQy38CrbNoxyA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWzjr-0003CZ-27; Wed, 12 Dec 2018 08:19:27 +0000
Received: from mx08-00178001.pphosted.com ([91.207.212.93]
 helo=mx07-00178001.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWzjm-0003Ar-Kg
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 08:19:24 +0000
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 wBC8BjLs004383; Wed, 12 Dec 2018 09:18:59 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx08-00178001.pphosted.com with ESMTP id 2p85qk5hqq-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Wed, 12 Dec 2018 09:18:59 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 305BD38;
 Wed, 12 Dec 2018 08:18:58 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E0E192624;
 Wed, 12 Dec 2018 08:18:57 +0000 (GMT)
Received: from [10.48.0.167] (10.75.127.48) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 12 Dec
 2018 09:18:57 +0100
Subject: Re: [PATCH 1/3] dt-bindings: mfd: syscon: Add optional clock support
To: Rob Herring <robh@kernel.org>
References: <1543337297-21873-1-git-send-email-fabrice.gasnier@st.com>
 <1543337297-21873-2-git-send-email-fabrice.gasnier@st.com>
 <20181211221653.GA18104@bogus>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <79817f52-0430-acd9-857e-c53f358c87c2@st.com>
Date: Wed, 12 Dec 2018 09:18:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181211221653.GA18104@bogus>
Content-Language: en-US
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-12_02:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_001922_957043_20CECDBB 
X-CRM114-Status: GOOD (  14.86  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alexandre.torgue@st.com,
 arnd@arndb.de, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 lee.jones@linaro.org, gabriel.fernandez@st.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/11/18 11:16 PM, Rob Herring wrote:
> On Tue, Nov 27, 2018 at 05:48:15PM +0100, Fabrice Gasnier wrote:
>> Some system control registers need to be clocked, so the registers can
>> be accessed. Add an optional clock.
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>> ---
>>  Documentation/devicetree/bindings/mfd/syscon.txt | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/syscon.txt b/Documentation/devicetree/bindings/mfd/syscon.txt
>> index 25d9e9c..a9aaa51 100644
>> --- a/Documentation/devicetree/bindings/mfd/syscon.txt
>> +++ b/Documentation/devicetree/bindings/mfd/syscon.txt
>> @@ -17,6 +17,7 @@ Optional property:
>>  - reg-io-width: the size (in bytes) of the IO accesses that should be
>>    performed on the device.
>>  - hwlocks: reference to a phandle of a hardware spinlock provider node.
>> +- clocks: phandle to the syscon clock
> 
> No. Add clocks to specific bindings using syscon. If you have a node 
> with only 'syscon', then that should be fixed.

Hi Rob,

Thanks for reviewing, so I'll
- add it to Documentation/devicetree/bindings/arm/stm32/stm32-syscon.txt
- send a v2 with this change.

Best regards,
Fabrice
> 
> Rob
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
