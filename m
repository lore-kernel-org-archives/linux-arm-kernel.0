Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5D0C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:28:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD0BD2084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jc5xYUx8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ycXOerql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD0BD2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=14ejkYpW9I81vZbbXkrac0QZepxeFMoBrexFNhAWLpI=; b=jc5xYUx8iezGlv
	PvhnfFlh8gSi5k4qirJ7Dh8EbzarcGbt8mbZsR5bBMnwaGmW2Zhm9UFO5MR674ON0DrhlypaBC/TM
	5sPyGNOSkSbMo9GnD7ansgR8Fvkwo3Sf3l/+h2Xd0Fm/+igzFlA9PuGyTkr9VCpOzuEfc3pk197/n
	FDqmGF5OxrfK3IkNoszrS4+nJKd583y2cTdw49veSbjwhSrF8Tk5Tk9KTOdkMV3f3139Yv9A5Vqk2
	H1CdP4KO5CvX+hhSqgnwOj/9D6HKrZAcbn8MPD+dkZLVyXgGjUZf2/b/V/8IVWjAuv004lyBVgARy
	NtX/tD+iQyF6kR9L8apA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWLbV-0007qG-EL; Mon, 10 Dec 2018 13:28:09 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWLbT-0007pU-0U
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 13:28:08 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBADRoEC007067;
 Mon, 10 Dec 2018 07:27:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1544448470;
 bh=JW4TH8hgq7AM1mcRb3UP0uz5sNmGSd6Mt0fB3WIi3pA=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=ycXOerqlibfLZ1TAeddcO8xCrqw8AwwogdTFKaAxLwro8QLwatnXOuJPwDJsMfHHz
 +Jgs6WZYF6XvWaIkcSW7uFGE0eSAZYRcq90SyFrjbi3QWaHhOdne2cjlQdPWtI0vvC
 WOSnjR2GXwXkuEx6Wx5jnpUGrxUnJag6WqtrUutw=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBADRobf031423
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 10 Dec 2018 07:27:50 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 10
 Dec 2018 07:27:50 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 10 Dec 2018 07:27:50 -0600
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBADRkNF030324;
 Mon, 10 Dec 2018 07:27:47 -0600
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-am654: Add Support for MMC/SD
To: Nishanth Menon <nm@ti.com>, Vignesh R <vigneshr@ti.com>
References: <20181207084233.13700-1-faiz_abbas@ti.com>
 <20181207084233.13700-2-faiz_abbas@ti.com>
 <a6aacd53-e1c4-fce0-7712-f276c80bbffc@ti.com>
 <20181208154526.ivbvwvcx6otg7lvh@akan>
From: Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <044fa725-9b6d-e331-ee10-664e59128e64@ti.com>
Date: Mon, 10 Dec 2018 19:00:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181208154526.ivbvwvcx6otg7lvh@akan>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_052807_131269_01330CF4 
X-CRM114-Status: GOOD (  18.91  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, ulf.hansson@linaro.org,
 linux-kernel@vger.kernel.org, adrian.hunter@intel.com, t-kristo@ti.com,
 robh+dt@kernel.org, kishon@ti.com, michal.simek@xilinx.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Nishanth,

On 08/12/18 9:15 PM, Nishanth Menon wrote:
> On 10:56-20181208, Vignesh R wrote:
>>
>>
>> On 07/12/18 2:12 PM, Faiz Abbas wrote:
>>> There are two MMC host controller instances present on the TI's
>>> Am654 SOCs. Add device tree nodes for the same.
>>>
>>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>>> ---
>>>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 28 ++++++++++++++++++++++++
>>>  1 file changed, 28 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>>> index 916434839603..d07212f16a81 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>>> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>>> @@ -129,4 +129,32 @@
>>>  		clocks = <&k3_clks 113 1>;
>>>  		power-domains = <&k3_pds 113>;
>>>  	};
>>> +
>>> +	sdhci0: sdhci@4f80000 {
>>> +		compatible = "ti,am654-sdhci-5.1";
>>> +		reg = <0x0 0x4f80000 0x0 0x260>, <0x0 0x4f90000 0x0 0x134>;
>>> +		power-domains = <&k3_pds 47>;
>>> +		clocks = <&k3_clks 47 0>, <&k3_clks 47 1>;
>>> +		clock-names = "clk_ahb", "clk_xin";
>>> +		interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
>>> +		sdhci-caps-mask = <0x80000007 0x0>;
>>> +		mmc-ddr-1_8v;
>>> +		ti,otap-del-sel = <0x2>;
>>> +		ti,trm-icp = <0x8>;
>>> +		status = "disabled";
>>> +	};
>>
>> Please drop "status=disabled" from dtsi. Can be disabled as required in
>> the board dts.
> 
> 
> yes - the standard in k3 is to disable the nodes that are'nt needed in
> board.dtsi.
> 
> This is different from "disabled by default" approach in DRA7 or OMAP4
> for example.
> 

Ok. Will fix in v2.

Thanks,
Faiz

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
