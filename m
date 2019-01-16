Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772C7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:52:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45FAE206C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fWpSBWdC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Sa7uSJYv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45FAE206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gFa5pnulbmOQFggxBKvgNSOl107pDbIRX+UPtYgEa+Y=; b=fWpSBWdCwX48jO
	vO0le6b3GWUjJWZIHrNFU4vfQf4AEjgpRqDGmWoB1AKaU2ZGoBsaXHuqUHRGnLBWIpFPkE46ZvJIr
	UVNzjL/qYHFrEJF1XU/By9ZKVJXxpUbQ57S9wKM+HpqekBL/t+HpRiqmnXFyXenLFCmJW4UYfuH9D
	hP3ue6ez+QDalgvUUNYLm8RnfzYTJLzU1Mlil/x8/5sa3jkMdT2FLk+wsdX6eNROwXNiTPicSUZja
	d5yD2tLDAkpbFLmILeVrU2ZfI/hMowLX59ik3HQDbA6h8NTDDa1NjLOpEEq65VAK4qxh52CKZosJs
	HytUsxtgefKXwlaT3d1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjioD-0006wD-MR; Wed, 16 Jan 2019 10:52:33 +0000
Received: from fllv0015.ext.ti.com ([198.47.19.141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjioA-0006v3-NF
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 10:52:32 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0GAqNu8046317;
 Wed, 16 Jan 2019 04:52:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1547635943;
 bh=Mlm37ln3TJslVWZf4kJfX6ItmvNfSxYsEENt3smz5lA=;
 h=Subject:To:References:CC:From:Date:In-Reply-To;
 b=Sa7uSJYvL1PEhfvKsnGSr/+Q9BED40JJHxixLkAOO3RUKLDlh+OS1sexlJgNvjLZT
 b4z5mb6OjdfHI5tM7lWpZ+lYZ6zYjqAEQ8VSm1iNLY9CTzeE9ZSGemPKJB5dy+8B1Q
 1vPDqh2qISzqjis0XrShjtnQMGwZ0RBcn+LXKquY=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0GAqNa2040642
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 16 Jan 2019 04:52:23 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 16
 Jan 2019 04:52:23 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 16 Jan 2019 04:52:23 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0GAqKEo003210;
 Wed, 16 Jan 2019 04:52:21 -0600
Subject: Re: [PATCH 1/3] arm64: dts: ti: am654: Add Main System Control Module
 node
To: Nishanth Menon <nm@ti.com>
References: <1547200861-17795-1-git-send-email-rogerq@ti.com>
 <1547200861-17795-2-git-send-email-rogerq@ti.com>
 <20190115143355.immsdfkyulx5j6o7@kahuna>
From: Roger Quadros <rogerq@ti.com>
Message-ID: <5C3F0CE4.9010504@ti.com>
Date: Wed, 16 Jan 2019 12:52:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20190115143355.immsdfkyulx5j6o7@kahuna>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_025230_833453_19DCCEDE 
X-CRM114-Status: GOOD (  15.52  )
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
Cc: devicetree@vger.kernel.org, vigneshr@ti.com, nsekhar@ti.com,
 linux-kernel@vger.kernel.org, Jyri Sarha <jsarha@ti.com>, t-kristo@ti.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 15/01/19 16:33, Nishanth Menon wrote:
> On 12:00-20190111, Roger Quadros wrote:
>> From: Jyri Sarha <jsarha@ti.com>
>>
>> Main System control module support is added to the device tree to allow
>> driver to access to their control module registers.
>>
>> Signed-off-by: Jyri Sarha <jsarha@ti.com>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>> index 272cf8f..8b55108 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>> @@ -191,4 +191,12 @@
>>  		#address-cells = <1>;
>>  		#size-cells = <0>;
>>  	};
>> +
>> +	scm_conf: scm_conf@100000 {
>> +		compatible = "syscon", "simple-mfd";
>> +		reg = <0 0x00100000 0 0x1c000>;
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges = <0x0 0x0 0x00100000 0x1c000>;
> 
> Who handles the MMR region unlock?

u-boot.

> 
>> +	};
>>  };
>> -- 
>> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>>
> 

cheers,
-roger

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
