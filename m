Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E0FC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:01:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90D2220863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VHmryXfI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gbWYGJzc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90D2220863
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zOs0te0DxECNikfSgqNbyucE7VhzXXkmFi7BGraRdQw=; b=VHmryXfIXyiE5W8DVlVIBuydY
	Jv9QI0GrFdZ4ywJCyF+pqLusn2YATT520ddNBuV0pJicn8uujnX8YL7kYLZ1vpKmvnIYzmg6EHfeJ
	l7QhkvAIQ0vI1g0hzmwBl+TTzeILYTg8Vz795fES8SGs9VXo21Weia1OkXI40XnMr7UQQ91pIZQJ/
	QkBDGrL0Hya8NziQJlWw9eNiEhPwJRQSrz/OJUT+6H+G769+EKbpHLEMgx1Vzm/Ras8Pi4CTReLmk
	VLrg5kJ9E3cJa/r3R8rTpSpsRPw9Lgx5d9PlttpLrUSV7Rqpi4eI94n5T4nFJogq5sy8O1xqkJmNq
	X6ej6qk7g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpUhU-0007tv-T6; Fri, 01 Feb 2019 09:01:28 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpUhN-0007tH-EW
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 09:01:26 +0000
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1191FTc015742;
 Fri, 1 Feb 2019 03:01:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1549011675;
 bh=PiupDYNLi+A2kRmNuT+YvLxvZQb8xgtifrYg3aYPY/Y=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=gbWYGJzcSUzNWm2HV0G/GETu/N+d6iA+p6NzWFMslnq8avBeJS2gRlw533AxAo1G8
 BQ24M+lZ7WATtxziQq8mkrx17fmlZsSSd2B6S5q9xIEOMhfpaGgzGpgvDpXOGFAwW5
 wrAgQgJBNdu581IdH4Hr5OgBB2TuWMzIyKtcrs20=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1191Et8015512
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 1 Feb 2019 03:01:14 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 1
 Feb 2019 03:01:14 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 1 Feb 2019 03:01:14 -0600
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x119169M018121;
 Fri, 1 Feb 2019 03:01:11 -0600
Subject: Re: [PATCH v3 0/2] Support for eMMC in AM65x-evm
To: Nishanth Menon <nm@ti.com>, Faiz Abbas <faiz_abbas@ti.com>
References: <20190117094424.7683-1-faiz_abbas@ti.com>
 <d75a123b-9e97-a3d1-1e3c-41ef6942dffb@ti.com>
 <20190124124032.aqp4ctqkpozbttwl@kahuna>
From: Tero Kristo <t-kristo@ti.com>
Message-ID: <228cf5ac-b07e-bce7-6078-bbab94692d8d@ti.com>
Date: Fri, 1 Feb 2019 11:00:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190124124032.aqp4ctqkpozbttwl@kahuna>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_010121_581754_C91321A9 
X-CRM114-Status: GOOD (  14.89  )
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

Ok, queued up for 5.1.

I also pushed an am654-next branch to git.kernel.org. This is not 
tracked in linux-next yet though, I am not quite sure if anybody is 
doing any am654 testing with linux-next, and I only push DT patches via 
this branch anyway which are kind of special.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
