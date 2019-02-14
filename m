Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87284C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:01:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48EC7222C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C0znU3yE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48EC7222C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Y/vG7w76Y+MFOb+N0xVlmt2i2ByN1U7lgUXGJM+UA3U=; b=C0znU3yEPalSwEg03ixISSTF1
	F8gL12NLJu+9cCeRR3egr6Sd+DjopYJQ+VQMWnBuBt/Nagl3/9dDSgXMirWwLvFo6iFJL0yyIPJkb
	E0fLb6hiBIck4fiMnDOTNn40KWfZPv+OgefiPIRQoFo3efdKLq9EpOhKLRhC5UMEs7kZwBWrx7Pkx
	3CnXEb0/skG9JiY5VUwyCFwMnTUUV0KudP1zK/67TfT3Z8YQvxwDYYjO84Zm5Vl6aDFsYaCCgUNdu
	XY2O+vmF+EGASn7UEGW3v5sCGfDoWXnHAEFObIpmvoERcJPlyG5VypBXslu/a13n6oqkeHmdyF8sS
	PpELywtgw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guIVe-0006Lm-Ch; Thu, 14 Feb 2019 15:01:06 +0000
Received: from mx08-00178001.pphosted.com ([91.207.212.93]
 helo=mx07-00178001.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guIVZ-0006Ko-ON
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 15:01:04 +0000
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1EEumXK025763; Thu, 14 Feb 2019 16:00:57 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx08-00178001.pphosted.com with ESMTP id 2qmwsum0k7-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Thu, 14 Feb 2019 16:00:57 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8A4AC3A;
 Thu, 14 Feb 2019 15:00:56 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 53E1B56C3;
 Thu, 14 Feb 2019 15:00:56 +0000 (GMT)
Received: from [10.201.21.58] (10.75.127.44) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 14 Feb
 2019 16:00:56 +0100
Subject: Re: [net-next, PATCH] net: stmmac: use correct define to get rx
 timestamp on GMAC4
To: Jose Abreu <jose.abreu@synopsys.com>, Giuseppe Cavallaro
 <peppe.cavallaro@st.com>, <davem@davemloft.net>
References: <1550153571-14404-1-git-send-email-alexandre.torgue@st.com>
 <7c03dff4-5185-dbd2-eeb4-867972512f2b@synopsys.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <a62c35de-7afa-14ec-5ca6-05bd61b6d09d@st.com>
Date: Thu, 14 Feb 2019 16:00:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <7c03dff4-5185-dbd2-eeb4-867972512f2b@synopsys.com>
Content-Language: en-US
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-14_07:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_070102_071988_728ECC03 
X-CRM114-Status: GOOD (  14.91  )
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
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Jose

On 2/14/19 3:18 PM, Jose Abreu wrote:
> Hi Alexandre,
> 
> On 2/14/2019 2:12 PM, Alexandre Torgue wrote:
>> In dwmac4_wrback_get_rx_timestamp_status we looking for a RX timestamp.
>> For that receive descriptors are handled and so we should use defines
>> related to receive descriptors. It'll no change the functional behavior
>> as RDES3_RDES1_VALID=TDES3_RS1V=BIT(26) but it makes code easier to read.
>>
>> Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
>> index 20299f6..9f062b3 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
>> @@ -268,7 +268,7 @@ static int dwmac4_wrback_get_rx_timestamp_status(void *desc, void *next_desc,
>>   	int ret = -EINVAL;
>>   
>>   	/* Get the status from normal w/b descriptor */
>> -	if (likely(p->des3 & TDES3_RS1V)) {
>> +	if (likely(p->des3 & RDES3_RDES1_VALID)) {
> 
> Shouldn't this also use le32_to_cpu() like bellow ?

I agree. I focused on cosmetic but yes you are right, we have to take 
car about endianness as this IP is used by different processors (using 
different endianness). I gonna send a v2.
I think dwmac4_rx_check_timestamp have the same kind of issue. Another 
patch should be sent for it. no ?

regards
Alex



> 
> Thanks,
> Jose Miguel Abreu
> 
>>   		if (likely(le32_to_cpu(p->des1) & RDES1_TIMESTAMP_AVAILABLE)) {
>>   			int i = 0;
>>   
>>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
