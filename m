Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00847C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:40:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAFB82087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V1fTqTbM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TvTwawef"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAFB82087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=yJNhm8iqWspYPLvLdxheT3yJw7DOmBUu179jzmm8/5E=; b=V1fTqTbMBsmhwDciJylkFqUMq
	9GO4Xr8cYaQp6g0MU0GPwhwjlzLW95X2dvh+hHNqoiILsNzulEXf0sEhRoL2tM+c85IBb+wddoQO5
	hTUJiY6kgRZ1dX6kP/T8QTQNMwToILIPHZZxt2mIK3kwJIG96UHL7aTAmeJ5qBWgyUzz6sujtN+58
	95030eIWH7LnP4+3zW8z325BL5apzMV0PcM6DOhkHmk3HwIW696nzAZD2AZlINqunSAOLZWgUnm12
	lAKjW91Oo57XCF2pwoVVQF/s3g07Hb0RRoZdLQuVeW5TJ2GE+80mc3qxQmJLg9lccvEnVRIJUef6L
	fatU96bBw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTsD1-0001aT-Ne; Mon, 03 Dec 2018 17:40:39 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTsCx-0001UZ-IN; Mon, 03 Dec 2018 17:40:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1543858837; x=1575394837;
 h=subject:to:cc:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=Rn2Rbfa4Eh4tyqVWsQgb06EfJocC87bzjKhqvK8ZVoo=;
 b=TvTwawef/HflraQcEk9T5F+18AY/GtadonADVsEsb9swAGTlBDwPAERg
 bXZK07TkmdUfUN4H/g6hN0DHNI8SB9IHLCV2z1MrtmXb0CNt+ZZxgDiNb
 It2Wp73B7v2vmuUW2FNt+4l3ObEDT6A87CEgyPMQ3OhiHZSIfxk3R+399
 EIre3/+Q9XA6t9RWuK6xJXYlR6BpDWG7rEXTr1+ypEqTnbeJzp/m3Prr4
 weE5/UAnDWrh7GO5/lYENwEqWT7nLblUoFgZskdjxfjW5wcpebXzOAOv9
 v8/ncN+oqvkCrXyVE+52x/ajfn9iELaaOHcfK9D3HH0Hraoxvhv3isHvA w==;
X-IronPort-AV: E=Sophos;i="5.56,311,1539619200"; d="scan'208";a="97414800"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2018 01:40:25 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP; 03 Dec 2018 09:22:39 -0800
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.111.72.98])
 ([10.111.72.98])
 by uls-op-cesaip02.wdc.com with ESMTP; 03 Dec 2018 09:40:22 -0800
Subject: Re: [RFT PATCH v1 2/4] dt-binding: cpu-topology: Move cpu-map to a
 common binding.
To: Sudeep Holla <sudeep.holla@arm.com>
References: <1543534100-3654-1-git-send-email-atish.patra@wdc.com>
 <1543534100-3654-3-git-send-email-atish.patra@wdc.com>
 <20181203165521.GB17883@e107155-lin>
 <f902086b-09e1-ad85-d191-137708f5b105@wdc.com>
 <20181203173306.GF17883@e107155-lin>
From: Atish Patra <atish.patra@wdc.com>
Message-ID: <e983d74f-9671-a119-63a4-dd4e12fe0f96@wdc.com>
Date: Mon, 3 Dec 2018 09:40:21 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181203173306.GF17883@e107155-lin>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_094035_944778_FC001EAC 
X-CRM114-Status: GOOD (  19.88  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Albert Ou <aou@eecs.berkeley.edu>, Thomas Gleixner <tglx@linutronix.de>,
 Juri Lelli <juri.lelli@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Dmitriy Cherkasov <dmitriy@oss-tech.org>, Anup Patel <anup@brainfault.org>,
 Palmer Dabbelt <palmer@sifive.com>, Will Deacon <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jeremy Linton <jeremy.linton@arm.com>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
 Rob Herring <robh+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 "moderated list:ARM64 PORT \(AARCH64 ARCHITECTURE\)"
 <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/3/18 9:33 AM, Sudeep Holla wrote:
> On Mon, Dec 03, 2018 at 09:23:42AM -0800, Atish Patra wrote:
>> On 12/3/18 8:55 AM, Sudeep Holla wrote:
>>> On Thu, Nov 29, 2018 at 03:28:18PM -0800, Atish Patra wrote:
>>>> cpu-map binding can be used to described cpu topology for both
>>>> RISC-V & ARM. It makes more sense to move the binding to document
>>>> to a common place.
>>>>
>>>> The relevant discussion can be found here.
>>>> https://lkml.org/lkml/2018/11/6/19
>>>>
>>>
>>> Looks good to me apart from a minor query below in the example.
>>>
>>> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
>>>
>>>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>>>> ---
>>>>    .../{arm/topology.txt => cpu/cpu-topology.txt}     | 81 ++++++++++++++++++----
>>>>    1 file changed, 67 insertions(+), 14 deletions(-)
>>>>    rename Documentation/devicetree/bindings/{arm/topology.txt => cpu/cpu-topology.txt} (86%)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/arm/topology.txt b/Documentation/devicetree/bindings/cpu/cpu-topology.txt
>>>> similarity index 86%
>>>> rename from Documentation/devicetree/bindings/arm/topology.txt
>>>> rename to Documentation/devicetree/bindings/cpu/cpu-topology.txt
>>>> index 66848355..1de6fbce 100644
>>>> --- a/Documentation/devicetree/bindings/arm/topology.txt
>>>> +++ b/Documentation/devicetree/bindings/cpu/cpu-topology.txt
>>>
>>> [...]
>>>
>>>> +Example 3: HiFive Unleashed (RISC-V 64 bit, 4 core system)
>>>> +
>>>> +cpus {
>>>> +	#address-cells = <2>;
>>>> +	#size-cells = <2>;
>>>> +	compatible = "sifive,fu540g", "sifive,fu500";
>>>> +	model = "sifive,hifive-unleashed-a00";
>>>> +
>>>> +	...
>>>> +
>>>> +	cpu-map {
>>>> +		cluster0 {
>>>> +			core0 {
>>>> +				cpu = <&L12>;
>>>> +		 	};
>>>> +			core1 {
>>>> +				cpu = <&L15>;
>>>> +			};
>>>> +			core2 {
>>>> +				cpu0 = <&L18>;
>>>> +			};
>>>> +			core3 {
>>>> +				cpu0 = <&L21>;
>>>> +			};
>>>> +		};
>>>> + 	};
>>>> +
>>>> +	L12: cpu@1 {
>>>> +		device_type = "cpu";
>>>> +		compatible = "sifive,rocket0", "riscv";
>>>> +		reg = <0x1>;
>>>> +	}
>>>> +
>>>> +	L15: cpu@2 {
>>>> +		device_type = "cpu";
>>>> +		compatible = "sifive,rocket0", "riscv";
>>>> +		reg = <0x2>;
>>>> +	}
>>>> +	L18: cpu@3 {
>>>> +		device_type = "cpu";
>>>> +		compatible = "sifive,rocket0", "riscv";
>>>> +		reg = <0x3>;
>>>> +	}
>>>> +	L21: cpu@4 {
>>>> +		device_type = "cpu";
>>>> +		compatible = "sifive,rocket0", "riscv";
>>>> +		reg = <0x4>;
>>>> +	}
>>>> +};
>>>
>>> The labels for the CPUs drew my attention. Is it intentionally random
>>> (or even specific) or just chosen to show anything can be used as labels ?
>>
>> SiFive generates the device tree from RTL directly. So I am not sure if they
>> assign random numbers or a particular algorithm chooses the label. I tried
>> to put the exact ones that is available publicly.
>>
>> https://github.com/riscv/riscv-device-tree-doc/blob/master/examples/sifive-hifive_unleashed-microsemi.dts
> 
> Cool, love that. So you don't have the problem I was trying to explain.
> But I still see the possibility of some other RISC-V vendor copy-pasting
> from here ;). Anyways it's left to you.
> 

I am fine with either way. I hoped other vendors won't blindly copy as 
this example was specific to HiFive Unleashed board. But I get your 
point. As this DT entry is a generic architecture entry, we should have 
generic examples instead of platform specific examples.

I will change it to a generic one.


Regards,
Atish
> --
> Regards,
> Sudeep
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
