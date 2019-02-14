Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03E3C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:52:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CB0F222DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E5TVLg0Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CB0F222DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=O/YFGCGFor7dpVfKzi8RtEETSBTO0JIpBP031CDaNmA=; b=E5TVLg0YSzN2F8
	FcKbkKoVqXZV8jvwS/v5B1MmbDsJjTwurzRGUeH1xa3OH5WAHQPrU3VwuESmRadM6JYo1PXTFxGVb
	op8NscBTkSVRwIbD9usvtHBHfgjlEYk0+wGrhyHgdHsfFUcOesK5ujGwMrNMC+TWUe7zHb5AbVmRg
	E7pjmsQVlKcqm1F6ekHV05twIdeDUgRT26K/zcb7401TaMolFSAbpUjpmQ0QyOb0dX3S3ein/JDnp
	qWD0SBC4qs/GrHOWO5yx2jKAE41dZGFsWYWteUpi2/62WO+Zin//ygppWncP+2C8nI/GC0M/mq+0j
	za5T7w5IbD164dc4Hm2A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guJJ9-0004yj-ET; Thu, 14 Feb 2019 15:52:15 +0000
Received: from mx08-00178001.pphosted.com ([91.207.212.93]
 helo=mx07-00178001.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guJIv-0004h1-4J
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 15:52:06 +0000
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1EFUdm8018329; Thu, 14 Feb 2019 16:51:51 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx08-00178001.pphosted.com with ESMTP id 2qmwsum8ty-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Thu, 14 Feb 2019 16:51:51 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 386E738;
 Thu, 14 Feb 2019 15:51:50 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag4node3.st.com [10.75.127.12])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 041AF587B;
 Thu, 14 Feb 2019 15:51:50 +0000 (GMT)
Received: from SFHDAG5NODE3.st.com (10.75.127.15) by SFHDAG4NODE3.st.com
 (10.75.127.12) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 14 Feb
 2019 16:51:49 +0100
Received: from SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47]) by
 SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47%20]) with mapi id
 15.00.1347.000; Thu, 14 Feb 2019 16:51:49 +0100
From: Christophe ROULLIER <christophe.roullier@st.com>
To: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 2/8] net: ethernet: stmmac: update to support all PHY
 config for stm32mp157c.
Thread-Topic: [PATCH 2/8] net: ethernet: stmmac: update to support all PHY
 config for stm32mp157c.
Thread-Index: AQHUxHYStTBKTIMizUiYISVPutO8+6XfVpoAgAAKGoA=
Date: Thu, 14 Feb 2019 15:51:49 +0000
Message-ID: <66e5d183-6952-44a2-926a-91f4ff363024@st.com>
References: <1550126763-22669-1-git-send-email-christophe.roullier@st.com>
 <1550126763-22669-3-git-send-email-christophe.roullier@st.com>
 <20190214134040.GA5699@lunn.ch> <02cd7773-899f-b28a-ff61-849b17cbe82d@st.com>
 <20190214151540.GG708@lunn.ch>
In-Reply-To: <20190214151540.GG708@lunn.ch>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.51]
Content-ID: <9E112A135F78B34A8FB7B9DA49282314@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-14_07:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_075201_798933_622D6C0B 
X-CRM114-Status: GOOD (  11.07  )
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

On 2/14/19 4:15 PM, Andrew Lunn wrote:
>> Sorry, I've misunderstood your question ;-)
>>
>> And you spoke about :
>>
>> case PHY_INTERFACE_MODE_RGMII:
>> case PHY_INTERFACE_MODE_RGMII_ID:
>> case PHY_INTERFACE_MODE_RGMII_RXID:
>> case PHY_INTERFACE_MODE_RGMII_TXID:
>>
>> So in my setup I've only RGMII interface, so I've never tested 3 others
>> interfaces (_ID, _RXID, _TXID).
>>
>> So do I need to add cases in my driver ?
> 
> Yes. They all indicate the MAC should be using RGMII.
> 
> This appears to be an old issue, but now would be a good time to fix
> it.
> 
>       Andrew
> 
Ok Andrew, I will update with these

Thanks

Christophe
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
