Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7842FC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:46:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 487C020663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OvV5D+eg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aLqMpat4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 487C020663
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9UvrueA4M+92hrb6MXuIEgK3otxy/B9toahXPYaRIIo=; b=OvV5D+egyXMUmk4csiO42kny4
	gcJidO+H5APz68Eg06WaQ985F99zDe6l9OfRYlHrzO+y4A0wSznI6jeoYUfh6piHuQWU+hkTC4cyT
	DjUIdbtxDBu2j5jOV50RwwqrRBSQM5ZZobgLniAy3i2Q4Y+t1RiCjWp1BXfH8pxfSw/sfitSJm3LQ
	BrhhH1FTZeJEAWgMtcT+W/HjKz0cKpDQt0yg3gWSdlPjFZ5KNU3t4b7j5xr1CXgi+swo5Z8BfLJDK
	5XISEBWZRctpgrI69/ge4Nldx6XuDs4B05BjmrZd6yos+HCiTG4/C9K3bj0uejFYFLa+6Wzjdj/WJ
	DXJ2Y4R/w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmkwq-0002Eb-Gd; Thu, 24 Jan 2019 19:46:00 +0000
Received: from lelv0142.ext.ti.com ([198.47.23.249])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmkwm-0002Di-Bc
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 19:45:57 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0OJjoKh102891;
 Thu, 24 Jan 2019 13:45:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1548359150;
 bh=ulVtxlJZrgCwtTt4+h2hKP/Vl8YdM4/V868dqjTfw+Q=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=aLqMpat4T307UR0HaqxEFE+ezGmTA4BGE1B6VaKlPFfjdx5/iTVcPuud10Y0Paw2N
 8sqSkBl2xNOit7lBm7ULvJkLZNnrTlFI1vpbg6u1lVcSM0G4Kdc+ng9rsCu7tHbfay
 LtpZXmIAwGRWDWngZ6AdG+ju3tol2QBewKJEY9uM=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0OJjomC023722
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 24 Jan 2019 13:45:50 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 24
 Jan 2019 13:45:49 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 24 Jan 2019 13:45:50 -0600
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0OJjlYK011820;
 Thu, 24 Jan 2019 13:45:47 -0600
Subject: Re: [PATCH v3 0/2] Support for eMMC in AM65x-evm
To: Nishanth Menon <nm@ti.com>, Faiz Abbas <faiz_abbas@ti.com>
References: <20190117094424.7683-1-faiz_abbas@ti.com>
 <d75a123b-9e97-a3d1-1e3c-41ef6942dffb@ti.com>
 <20190124124032.aqp4ctqkpozbttwl@kahuna>
From: Tero Kristo <t-kristo@ti.com>
Message-ID: <6b10e04d-47b7-09ed-9d03-d37732569b92@ti.com>
Date: Thu, 24 Jan 2019 21:45:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190124124032.aqp4ctqkpozbttwl@kahuna>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_114556_505527_2E2F58EC 
X-CRM114-Status: GOOD (  14.76  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, robh+dt@kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 24/01/2019 14:40, Nishanth Menon wrote:
> On 13:43-20190124, Faiz Abbas wrote:
>> Hi,
>>
>> On 17/01/19 3:14 PM, Faiz Abbas wrote:
>>> The following patches add eMMC support on TI's AM65x-evm.
>>>
>>> v3:
>>>   1. Fixed patch titles to only include eMMC
>>>   2. Added dma-coherent to the sdhci0 node.
>>>
>>> v2:
>>>   1. The SD card node is under debug for some usecases.
>>>      Only upstreaming eMMC support for now.
>>>   2. Rebased to latest mainline.
>>>   3. Removed status = "disabled" from dtsi patch
>>>   4. Fixed node name to not include '_'s
>>>
>>> Faiz Abbas (2):
>>>    arm64: dts: ti: k3-am654: Add Support for eMMC host controller
>>>    arm64: dts: ti: k3-am654-base-board: Add eMMC Support
>>>
>>>   arch/arm64/boot/dts/ti/k3-am65-main.dtsi      | 14 +++++++++++
>>>   .../arm64/boot/dts/ti/k3-am654-base-board.dts | 25 +++++++++++++++++++
>>>   2 files changed, 39 insertions(+)
>>>
>>
>> Gentle ping.
> 
> 
> OK With me. Tero: are you publishing a next branch? could you
> pick this up please?
> 

Yeah, series looks fine so I'll queue it up for 5.1.

I am not currently publishing -next branch, but I can start tracking one.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
