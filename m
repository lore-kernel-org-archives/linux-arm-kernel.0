Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701C8C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:02:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30AEC20855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J/Zd8muz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IYESefHy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30AEC20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TwhdOq8uVmUAZIZGFq/ZMhDBoK88goIob5L+EVYAVHY=; b=J/Zd8muziQNqdc
	4BqPY3k7Le1Amhikk4EzJCDh2Cy7LJpp1DfHtT/3XG2DbARBraMhK52a6OIu85WyAGLONC+CUvWvi
	f1BVXv3Z9LrboRNJDGcsLdJOOB3dJntLnk90CByDAsRgtS8SBfpnNJpmIg9pz0CdkaKjzQE3wXJjE
	PJv8F1jNjYXcmsIiAstqfNMeWust151rH6M64RvyZGiz7zUmMAq4JMJ0Mj6BDwyjj/omT2uTZ34xc
	kx6yLxACY6M6WQ3YrHxNMH6tzYry6Z0bxivSBa1fs5KVg0n0h4FTdyGL+WZ3SwISVqS+xclQIMZtk
	5NeiWJzNj0xGj4UD9jqw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk3ZO-0006rX-2E; Thu, 17 Jan 2019 09:02:38 +0000
Received: from lelv0143.ext.ti.com ([198.47.23.248])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk3ZK-0006rB-KE
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 09:02:36 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0H92STX026197;
 Thu, 17 Jan 2019 03:02:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1547715748;
 bh=NxgcnM+Jzy5pQx4pfUAWdUrkK8Agpy/FVUdVOVlbPL0=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=IYESefHydpKlsKvsdggFS+FhIY436XuQUgDEKS2FZvUTltAIJM3cGowu1/CF11QIp
 YO9KDXd3trdHpDonHhtdLw8Ac6iyyqPhVomlGOQOn8VnMcJloCCDtEWw4mzLEKMYHp
 M4ueoENYEwzb/d5P5LI7s95sY2wrYccUOrE1YGw8=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0H92SNR015652
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 17 Jan 2019 03:02:28 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 17
 Jan 2019 03:02:28 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 17 Jan 2019 03:02:27 -0600
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0H92PGF029423;
 Thu, 17 Jan 2019 03:02:25 -0600
Subject: Re: [PATCH v2 0/2] Support for eMMC in AM65x-evm
To: Nishanth Menon <nm@ti.com>
References: <20190110073355.3382-1-faiz_abbas@ti.com>
 <20190115142948.3fq2i6vav7jn4ulq@kahuna>
From: Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <488c457b-efc0-1006-ad2d-a29cd455d979@ti.com>
Date: Thu, 17 Jan 2019 14:35:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190115142948.3fq2i6vav7jn4ulq@kahuna>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_010234_731176_55A8B77A 
X-CRM114-Status: GOOD (  14.25  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, t-kristo@ti.com, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Nishanth,

On 15/01/19 7:59 PM, Nishanth Menon wrote:
> On 13:03-20190110, Faiz Abbas wrote:
>> The following patches add eMMC support on TI's AM65x-evm.
>>
>> v2:
>>  1. The SD card node is under debug for some usecases.
>>     Only upstreaming eMMC support for now.
>>  2. Rebased to latest mainline.
>>  3. Removed status = "disabled" from dtsi patch
>>  4. Fixed node name to not include '_'s
>>
>> Faiz Abbas (2):
>>   arm64: dts: ti: k3-am654: Add Support for MMC/SD
>>   arm64: dts: ti: k3-am654-base-board: Add MMC/SD support
> 
> Once the $subject changes in the above two patches (should be emmc
> instead of MMC/SD):
> 
> Acked-by: Nishanth Menon <nm@ti.com>
> 

Ok. Sending next version with fixes.

Thanks,
Faiz

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
