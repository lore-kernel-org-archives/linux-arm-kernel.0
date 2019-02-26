Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD93C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:30:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 472C42146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fHfr3o2u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 472C42146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=T/fd72uhBg94/gk4jfO6c4VkWaMlywObK+3DB6qPiYI=; b=fHfr3o2uyEgPbT
	2/Idhzux1gBF7Hnr25D/UjdGFck5Q6oN2jr6pV3qxmoJ38/b9Oxg62skoNBF/dV1iIAsH/9a8OVBu
	EPVr6+3yQKCYCnyEexBXTzF33mIH58iXeeKIHIIm4S4eU1n3TE0Jjb1PmDiRpH16wDSuFrJDVjdhV
	Kto5/SXnYy30NEuekWitxBm0xqLST01KBb10dWBAhGUXpMLZbCYliHq5K5PVlUse3cOlKBSBykVnV
	L02v6ohten0mTe6yKuQZ0r8UN5VxOSWhpjwLgrpeYRFfrA055tu8o+b89/Z4X5Yth+37OQk5K6g1p
	LM86gL26BMzPILoRp3Jg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gya0R-00031P-5t; Tue, 26 Feb 2019 10:30:35 +0000
Received: from mx08-00178001.pphosted.com ([91.207.212.93]
 helo=mx07-00178001.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gya0N-00030t-4c
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 10:30:32 +0000
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1QARn5D014088; Tue, 26 Feb 2019 11:30:17 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx08-00178001.pphosted.com with ESMTP id 2qtv6cqmrr-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Tue, 26 Feb 2019 11:30:17 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3F13F31;
 Tue, 26 Feb 2019 10:30:14 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag4node1.st.com [10.75.127.10])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C82AB2958;
 Tue, 26 Feb 2019 10:30:12 +0000 (GMT)
Received: from SFHDAG5NODE3.st.com (10.75.127.15) by SFHDAG4NODE1.st.com
 (10.75.127.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 26 Feb
 2019 11:30:12 +0100
Received: from SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47]) by
 SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47%20]) with mapi id
 15.00.1347.000; Tue, 26 Feb 2019 11:30:12 +0100
From: Christophe ROULLIER <christophe.roullier@st.com>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V2 3/8] dt-bindings: net: stmmac: add phys config
 properties
Thread-Topic: [PATCH V2 3/8] dt-bindings: net: stmmac: add phys config
 properties
Thread-Index: AQHUyoiWpExj405+ekOaRsfcLh6Cn6XsdFCAgAViVgA=
Date: Tue, 26 Feb 2019 10:30:12 +0000
Message-ID: <419f54c3-08a7-42be-4e1a-a7c0f61a4543@st.com>
References: <1550824089-19961-1-git-send-email-christophe.roullier@st.com>
 <1550824089-19961-4-git-send-email-christophe.roullier@st.com>
 <20190223001651.GA22381@bogus>
In-Reply-To: <20190223001651.GA22381@bogus>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.47]
Content-ID: <2F65357342655644ADC33EBEC8F06FC7@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-26_06:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_023031_460155_F9C42318 
X-CRM114-Status: GOOD (  15.58  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Alexandre TORGUE <alexandre.torgue@st.com>, "andrew@lunn.ch" <andrew@lunn.ch>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-stm32@st-md-mailman.stormreply.com"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "joabreu@synopsys.com" <joabreu@synopsys.com>,
 "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
 Peppe CAVALLARO <peppe.cavallaro@st.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2/23/19 1:16 AM, Rob Herring wrote:
> On Fri, Feb 22, 2019 at 09:28:04AM +0100, Christophe Roullier wrote:
>> Add properties to support all Phy config
>>   PHY_MODE	(MII,GMII, RMII, RGMII) and in normal, PHY wo crystal (25Mhz),
>>   PHY wo crystal (50Mhz), No 125Mhz from PHY config.
>>
>> Signed-off-by: Christophe Roullier <christophe.roullier@st.com>
>> ---
>>   Documentation/devicetree/bindings/net/stm32-dwmac.txt | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/net/stm32-dwmac.txt b/Documentation/devicetree/bindings/net/stm32-dwmac.txt
>> index 1341012..f42dc68 100644
>> --- a/Documentation/devicetree/bindings/net/stm32-dwmac.txt
>> +++ b/Documentation/devicetree/bindings/net/stm32-dwmac.txt
>> @@ -24,9 +24,9 @@ Required properties:
>>   	       encompases the glue register, and the offset of the control register.
>>   
>>   Optional properties:
>> -- clock-names:     For MPU family "mac-clk-ck" for PHY without quartz
>> -- st,int-phyclk (boolean) :  valid only where PHY do not have quartz and need to be clock
>> -	           by RCC
> 
> You can't just remove properties.

There is no risk to remove/rename these 2 properties, because it is 
specific board which is never deployed.
With new properties (renaming clock (eth-ck) + st,eth_clk_sel and 
st,eth_ref_clk_sel, we are managed all kind of specific boards stm32mp1
So no risk of backward compatible.

> 
>> +- clock-names:     For MPU family "eth-ck" for PHY without quartz
>> +- st,eth_clk_sel (boolean) : set this property in RGMII PHY when you do not want use 125Mhz
>> +- st,eth_ref_clk_sel (boolean) :  set this property in RMII mode when you have PHY without crystal 50MHz
> 
> s/_/-/
> 
> 'sel' I assume is short for select, but the naming here and description
> don't really tell me what I'm getting.
> 

Ok, Rob, I will update with your recommendations

> Rob
> 
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
