Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9746C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 10:49:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88D9C20842
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 10:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E6/eTwsq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88D9C20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tUlUlaNiZLk2YtjIY7RwvlhEjKGn2bClHII0gp2mFwc=; b=E6/eTwsqqcvY5nRs+UdK8cg4z
	sN/MTutib2OWZLUeHkUfNv3x7ye4G1IbbUBxgQhxqMJaKTkRO3OxhroYdIMtI0j0Ksr54h4iR5owg
	lvICN/2S16Saa/PmEmgULXyhSSL7XT3/5JxOLMUPm/HUwpWD5K8n0ISSCjHaYaLDmINjKJCmdnjXF
	gyt6HRRGoEz4hBgNkuy8ov3aamsasCK2FGvnoN/eT2MRWNcaFhV/JD4phuoINeoYvjkKZHrRc2kJh
	bk82HhFFJ0ayC7xS0Ko9bpZC+SAaL78skNCFM7EcuOh7fDnJNrtI4cRna+PYh5qce2AdBTuHV4grF
	dM1XlvoJA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyDp0-00058X-LZ; Mon, 25 Feb 2019 10:49:18 +0000
Received: from mx08-00178001.pphosted.com ([91.207.212.93]
 helo=mx07-00178001.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyDow-000586-PR
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 10:49:16 +0000
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1PAkgUo024029; Mon, 25 Feb 2019 11:48:59 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx08-00178001.pphosted.com with ESMTP id 2qtv6chp8w-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Mon, 25 Feb 2019 11:48:59 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5C9FD3F;
 Mon, 25 Feb 2019 10:48:58 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1BE202867;
 Mon, 25 Feb 2019 10:48:58 +0000 (GMT)
Received: from [10.48.0.237] (10.75.127.49) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 25 Feb
 2019 11:48:57 +0100
Subject: Re: [PATCH 0/2] mmc: mmci: add quirk property to add stm32 transfer
 mode
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
References: <1550743851-13588-1-git-send-email-ludovic.Barre@st.com>
 <20190221102739.cc37au6elqu6gvfe@shell.armlinux.org.uk>
 <20190221103049.tspc5igoe6wmt3jd@shell.armlinux.org.uk>
 <a736b773-d6e6-eb81-90d6-ebeab7b401cb@st.com>
 <20190221140300.y3tunrvsh3gyig5f@shell.armlinux.org.uk>
From: Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <9c88d76c-2080-71b1-c9c6-c24d0f0aeb91@st.com>
Date: Mon, 25 Feb 2019 11:48:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190221140300.y3tunrvsh3gyig5f@shell.armlinux.org.uk>
Content-Language: en-US
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-25_06:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_024915_109757_68689986 
X-CRM114-Status: GOOD (  21.60  )
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

On 2/21/19 3:03 PM, Russell King - ARM Linux admin wrote:
> On Thu, Feb 21, 2019 at 02:38:36PM +0100, Ludovic BARRE wrote:
>> hi Russell & Ulf
>>
>> On 2/21/19 11:30 AM, Russell King - ARM Linux admin wrote:
>>> On Thu, Feb 21, 2019 at 10:27:39AM +0000, Russell King - ARM Linux admin wrote:
>>>> On Thu, Feb 21, 2019 at 11:10:49AM +0100, Ludovic Barre wrote:
>>>>> From: Ludovic Barre <ludovic.barre@st.com>
>>>>>
>>>>> This patch series introduces a bitmap of hardware quirks that require
>>>>> some special action. This should reduce the number of boolean
>>>>> into variant structure.
>>>>> And adds quirk bit to define sdmmc specific transfer modes.
>>>>
>>>> Please find some other way to deal with these differences.  As far as
>>>> I'm concerned, introducing a quirk bitmask such as what was done in
>>>> sdhci is a complete disaster and leads to long-term maintanability
>>>> problems.
>>>>
>>>> We already have a way to deal with variants in mmci.
>>>
>>> ... to finish what I was saying ...
>>>
>>> and I think that:
>>>
>>>           if (variant->blksz_datactrl16)
>>>                   datactrl = variant->datactrl_dpsm_enable | (data->blksz << 16);
>>>           else if (variant->blksz_datactrl4)
>>>                   datactrl = variant->datactrl_dpsm_enable | (data->blksz << 4);
>>>           else
>>>                   datactrl = variant->datactrl_dpsm_enable | blksz_bits << 4;
>>>
>>> ought to become a variant function call which returns the appropriate
>>> datactrl value.  This would shrink the amount of variant testing in this
>>> path, and also means that going forward we aren't facing an endlessly
>>> increasing number of tests here.
>>
>> For blksz_datactrl case:
>> We could create an inline function for datactrl16 and blksz_datactrl4
>> which returns the appropriate datactrl value (specific for ux500v2 and
>> qcom). This function could be register in mmci_host_ops structure.
> 
> Yes, this is what I'm proposing (except for the "inline" bit which
> seems meaningless if it's called via the mmci_host_ops structure.)
> I'm also proposing that it shouldn't just be the blksz that's
> returned but anything that the variant needs to take account of,
> including the stm transfer mode.

Ulf, are you alright with this callback approach (just to be sure that 
every body is align, before send a patch)?

This mmci_host_ops callback could return datactrl config to
start data (defined by variant).

> 
>> in mmci_start_data function we could call a common function which call a
>> hook if defined.
>>
>> int mmci_dblksz(struct mmci_host *host)
> 
> As this is returning a register value, "u32" would be more appropriate
> than "int".
> 
>> {
>> 	if (host->ops && host->ops->dblksz)
>> 		return host->ops->dblk(host);
>>
>> 	/* default data block size definition */
>> 	blksz_bits = ffs(data->blksz) - 1;
>> 	return blksz_bits << 4;
>> }
>>
>> what do you think about it?
> 
> I don't see any reason not to make the call unconditional and have every
> variant supply an appropriate function pointer.  IMHO that keeps stuff
> cleaner.
> 
>> After, I'm afraid to multiply callback function in mmci_host_ops.
>>
>> For stm32 transfer mode:
>> ditto, a callback function or I keep a boolean?
>>
>> BR
>> Ludo
>>
>>>
>>>>
>>>>>
>>>>> Ludovic Barre (2):
>>>>>     mmc: mmci: introduce a quirks property into variant struct
>>>>>     mmc: mmci: add quirk property to add stm32 transfer mode
>>>>>
>>>>>    drivers/mmc/host/mmci.c | 11 +++++++++++
>>>>>    drivers/mmc/host/mmci.h |  9 +++++++++
>>>>>    2 files changed, 20 insertions(+)
>>>>>
>>>>> -- 
>>>>> 2.7.4
>>>>>
>>>>>
>>>>> _______________________________________________
>>>>> linux-arm-kernel mailing list
>>>>> linux-arm-kernel@lists.infradead.org
>>>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>>>
>>>>
>>>> -- 
>>>> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
>>>> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
>>>> According to speedtest.net: 11.9Mbps down 500kbps up
>>>>
>>>> _______________________________________________
>>>> linux-arm-kernel mailing list
>>>> linux-arm-kernel@lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>>
>>>
>>
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
