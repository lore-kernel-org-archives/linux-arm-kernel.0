Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C430C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:38:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CC6E20651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K3In4iWe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CC6E20651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KuDkFXzC3FQdRId21eUi0U8pS9X/82aW8GeSL3iu8C0=; b=K3In4iWeO4k2jP/7Sh3542Bsf
	1WghUmXwf6XU85P2R78NHXOo/esFCJcBqYiOYXDq7tkRz2WPKmL6ZI9yhXjIfDCJUJdwnJawoLqe/
	A0nF2idHjCiWe4Ue85kaNDHEVq5DJrBj25pd6SXIP4gd20h/ZTnrSugIDC8MzJprXMPOouXVacwtL
	2gMntYddUOSgoyaL0cXpUlY76cz5LQCPkzqCtBnWa0FLif7UMpgzOi43Wk8XfGfH432jZ7mmWyYm3
	/uNUx/vua14CvLHwkDe4lvuV5zMWWBcx+Yq7g5xyfrPsOcPH/fcr8moJ02bZll2RP5OBtVmQFQ1ps
	+/hpI4NXA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwoYx-0001KD-RW; Thu, 21 Feb 2019 13:38:55 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwoYu-0001Jl-It
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 13:38:54 +0000
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1LDasPF017996; Thu, 21 Feb 2019 14:38:39 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2qsbm9cqy5-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Thu, 21 Feb 2019 14:38:39 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6689A3D;
 Thu, 21 Feb 2019 13:38:38 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 23CAC4DEA;
 Thu, 21 Feb 2019 13:38:38 +0000 (GMT)
Received: from [10.48.0.237] (10.75.127.47) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 21 Feb
 2019 14:38:37 +0100
Subject: Re: [PATCH 0/2] mmc: mmci: add quirk property to add stm32 transfer
 mode
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
References: <1550743851-13588-1-git-send-email-ludovic.Barre@st.com>
 <20190221102739.cc37au6elqu6gvfe@shell.armlinux.org.uk>
 <20190221103049.tspc5igoe6wmt3jd@shell.armlinux.org.uk>
From: Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <a736b773-d6e6-eb81-90d6-ebeab7b401cb@st.com>
Date: Thu, 21 Feb 2019 14:38:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190221103049.tspc5igoe6wmt3jd@shell.armlinux.org.uk>
Content-Language: en-US
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-21_07:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_053852_911503_3D0E5672 
X-CRM114-Status: GOOD (  20.07  )
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
Cc: devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
 Alexandre Torgue <alexandre.torgue@st.com>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 srinivas.kandagatla@linaro.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

hi Russell & Ulf

On 2/21/19 11:30 AM, Russell King - ARM Linux admin wrote:
> On Thu, Feb 21, 2019 at 10:27:39AM +0000, Russell King - ARM Linux admin wrote:
>> On Thu, Feb 21, 2019 at 11:10:49AM +0100, Ludovic Barre wrote:
>>> From: Ludovic Barre <ludovic.barre@st.com>
>>>
>>> This patch series introduces a bitmap of hardware quirks that require
>>> some special action. This should reduce the number of boolean
>>> into variant structure.
>>> And adds quirk bit to define sdmmc specific transfer modes.
>>
>> Please find some other way to deal with these differences.  As far as
>> I'm concerned, introducing a quirk bitmask such as what was done in
>> sdhci is a complete disaster and leads to long-term maintanability
>> problems.
>>
>> We already have a way to deal with variants in mmci.
> 
> ... to finish what I was saying ...
> 
> and I think that:
> 
>          if (variant->blksz_datactrl16)
>                  datactrl = variant->datactrl_dpsm_enable | (data->blksz << 16);
>          else if (variant->blksz_datactrl4)
>                  datactrl = variant->datactrl_dpsm_enable | (data->blksz << 4);
>          else
>                  datactrl = variant->datactrl_dpsm_enable | blksz_bits << 4;
> 
> ought to become a variant function call which returns the appropriate
> datactrl value.  This would shrink the amount of variant testing in this
> path, and also means that going forward we aren't facing an endlessly
> increasing number of tests here.

For blksz_datactrl case:
We could create an inline function for datactrl16 and blksz_datactrl4
which returns the appropriate datactrl value (specific for ux500v2 and 
qcom). This function could be register in mmci_host_ops structure.

in mmci_start_data function we could call a common function which call a
hook if defined.

int mmci_dblksz(struct mmci_host *host)
{
	if (host->ops && host->ops->dblksz)
		return host->ops->dblk(host);

	/* default data block size definition */
	blksz_bits = ffs(data->blksz) - 1;
	return blksz_bits << 4;
}

what do you think about it?
After, I'm afraid to multiply callback function in mmci_host_ops.

For stm32 transfer mode:
ditto, a callback function or I keep a boolean?

BR
Ludo

> 
>>
>>>
>>> Ludovic Barre (2):
>>>    mmc: mmci: introduce a quirks property into variant struct
>>>    mmc: mmci: add quirk property to add stm32 transfer mode
>>>
>>>   drivers/mmc/host/mmci.c | 11 +++++++++++
>>>   drivers/mmc/host/mmci.h |  9 +++++++++
>>>   2 files changed, 20 insertions(+)
>>>
>>> -- 
>>> 2.7.4
>>>
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>
>>
>> -- 
>> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
>> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
>> According to speedtest.net: 11.9Mbps down 500kbps up
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
