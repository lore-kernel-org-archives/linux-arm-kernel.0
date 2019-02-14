Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CE2C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:01:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6E1E222C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K0Kt+FhG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6E1E222C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ggMbDMSBo7FP5F6BWSUUeOpUl7oHjo0t8Klvb+VlyJI=; b=K0Kt+FhGvyNU84
	uSXhbfyVsen1VT9cdpcsE6hAtcXlsmlNANNXUL2T2+/xK4EJ7b+iE3u1wHsDXpK9LMO2MteFwqDFf
	jCg6yqOtqBPdZAaq2xYrzauCMol30hRAl3b2VtwBwgESttVKjIXAfA6lPA2vdNyN4D5bFBuzjCIoV
	ji9auWwjultfPktYztvxXb7GsWLsMCUnQ/fqz2r4WOQiI/onJUCqRJ7a1JLBoIOuHaqN8VsgAjeck
	OErREDQB+M4eejMUgWBbNlC67cA0UAtG/1U7vwGg+OE0zfRUj9JflHAgZiwz15yn3jiqEqAObdxWH
	x5kMip1zl2jUuSo+gWDg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guIVm-0006Vo-Vu; Thu, 14 Feb 2019 15:01:14 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guIVZ-0006Kp-TC
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 15:01:07 +0000
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1EEuAw2016316; Thu, 14 Feb 2019 16:00:50 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2qmy1nbkt5-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Thu, 14 Feb 2019 16:00:50 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BAA3638;
 Thu, 14 Feb 2019 15:00:49 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag4node1.st.com [10.75.127.10])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7863556BE;
 Thu, 14 Feb 2019 15:00:49 +0000 (GMT)
Received: from SFHDAG5NODE3.st.com (10.75.127.15) by SFHDAG4NODE1.st.com
 (10.75.127.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 14 Feb
 2019 16:00:48 +0100
Received: from SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47]) by
 SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47%20]) with mapi id
 15.00.1347.000; Thu, 14 Feb 2019 16:00:48 +0100
From: Christophe ROULLIER <christophe.roullier@st.com>
To: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 2/8] net: ethernet: stmmac: update to support all PHY
 config for stm32mp157c.
Thread-Topic: [PATCH 2/8] net: ethernet: stmmac: update to support all PHY
 config for stm32mp157c.
Thread-Index: AQHUxHYStTBKTIMizUiYISVPutO8+w==
Date: Thu, 14 Feb 2019 15:00:48 +0000
Message-ID: <02cd7773-899f-b28a-ff61-849b17cbe82d@st.com>
References: <1550126763-22669-1-git-send-email-christophe.roullier@st.com>
 <1550126763-22669-3-git-send-email-christophe.roullier@st.com>
 <20190214134040.GA5699@lunn.ch>
In-Reply-To: <20190214134040.GA5699@lunn.ch>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.51]
Content-ID: <B075AACED2AAD9479761DEBAEF570936@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-14_07:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_070102_234977_AA6BDFBC 
X-CRM114-Status: GOOD (  12.26  )
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
 "robh@kernel.org" <robh@kernel.org>,
 Alexandre TORGUE <alexandre.torgue@st.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
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

On 2/14/19 2:40 PM, Andrew Lunn wrote:
>   On Thu, Feb 14, 2019 at 07:45:57AM +0100, Christophe Roullier wrote:
>> @@ -131,19 +185,19 @@ static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
>>   	case PHY_INTERFACE_MODE_RGMII:
>>   		val = SYSCFG_PMCR_ETH_SEL_RGMII;
>> -		if (dwmac->int_phyclk)
>> +		if (dwmac->eth_clk_sel_reg)
>>   			val |= SYSCFG_PMCR_ETH_CLK_SEL;
>>   		pr_debug("SYSCFG init : PHY_INTERFACE_MODE_RGMII\n");
>>   		break;
> 
> Hi Christophe
> 
> This code should handle all 4 PHY_INTERFACE_MODE_RGMII* values.
> 
>       Andrew
> 


ReReHi Andrew,

Sorry, I've misunderstood your question ;-)

And you spoke about :

case PHY_INTERFACE_MODE_RGMII:
case PHY_INTERFACE_MODE_RGMII_ID:
case PHY_INTERFACE_MODE_RGMII_RXID:
case PHY_INTERFACE_MODE_RGMII_TXID:

So in my setup I've only RGMII interface, so I've never tested 3 others 
interfaces (_ID, _RXID, _TXID).

So do I need to add cases in my driver ?

Thanks

Christophe


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
