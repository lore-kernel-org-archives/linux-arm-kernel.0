Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1887DC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:23:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDCBE2084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NbkDj4Y4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oSZlbHBF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDCBE2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=TdoMBe8Zq0v5o4iM32lKqX9mNA68Xc3e0/WYoJLWBpg=; b=NbkDj4Y4eMODZbOPS2ugwKcuo
	KanxcAe5CwHXnkkyJWGsPxWgWQj2FCHfyA1Y+YTCN2R4e5+sODvrSMp/FkbQiAxIZ5ntxHxlqalQQ
	qalK9eYHZoIaf4/jkUYN433gX7aRKXISW2z5mv9K+GgC9aDZKsG3R7jUf2TMMXLRv3YYO+JJoaYj3
	t/F+qNpm/ZJJgsdjem48BTHku7t554FWnO2nHtJBGMZtDVs2P123VeLbvdJCMtDuYXHJggV/+0rvM
	Walw5by/+xQxYtFXAS2Cux3VGfSyAMh6KMyqeK+izNSWiBNUzpyz+Ivlr1DhaZjZ3utJvlbkPv4z4
	aM4PfVvtg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX9Ac-0005Q0-3T; Wed, 12 Dec 2018 18:23:42 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX9AX-0005HR-Bn; Wed, 12 Dec 2018 18:23:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1544639017; x=1576175017;
 h=subject:to:cc:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=SLV3PnG5YgMBKspuZwkpx52OMenw9jzNoMWZSMQ8SEc=;
 b=oSZlbHBFtRcKi5LeAZ00anNIdCsD8MCm9kecjF9imh7S255WofecjWLE
 PI5LKkjHE7IjAiI96sdktof/TG/mrhhaJTgGcZbubjwKhDNi78GrPJJQA
 uYvWLm74VT89HJsmtbxBg0J2RvmvkYcLRwEjuznHffg02NB8LHmhK+PYD
 iM9D/GZXIm75FNcw/wXWT28XlqgirbXktJrHnzl7J5ls2ZlQNUL12+cn4
 nKW1s1ylAYLNdGis8/YvMafYp9UcZOnpxOhm/hO+iNuhp7BW3kKnZFck+
 qyISAPbPAPYgaJfTqguTvrXx2VqF/QogZCHSi3ulEJ2PIazaFDIKGrl9O g==;
X-IronPort-AV: E=Sophos;i="5.56,345,1539619200"; d="scan'208";a="97659819"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2018 02:23:26 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP; 12 Dec 2018 10:05:02 -0800
Received: from 48dctz1.ad.shared (HELO [10.86.57.164]) ([10.86.57.164])
 by uls-op-cesaip02.wdc.com with ESMTP; 12 Dec 2018 10:23:25 -0800
Subject: Re: [RFT PATCH v1 2/4] dt-binding: cpu-topology: Move cpu-map to a
 common binding.
To: Rob Herring <robh@kernel.org>
References: <1543534100-3654-1-git-send-email-atish.patra@wdc.com>
 <1543534100-3654-3-git-send-email-atish.patra@wdc.com>
 <20181212023122.GB14213@bogus>
From: Atish Patra <atish.patra@wdc.com>
Message-ID: <1d8fffe7-824e-9c2b-1444-491abe9056a4@wdc.com>
Date: Wed, 12 Dec 2018 10:23:24 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181212023122.GB14213@bogus>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_102337_528776_BAFDB94C 
X-CRM114-Status: GOOD (  25.38  )
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 "moderated list:ARM64 PORT \(AARCH64 ARCHITECTURE\)"
 <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/11/18 6:31 PM, Rob Herring wrote:
> On Thu, Nov 29, 2018 at 03:28:18PM -0800, Atish Patra wrote:
>> cpu-map binding can be used to described cpu topology for both
>> RISC-V & ARM. It makes more sense to move the binding to document
>> to a common place.
>>
>> The relevant discussion can be found here.
>> https://lkml.org/lkml/2018/11/6/19
>>
>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>> ---
>>   .../{arm/topology.txt => cpu/cpu-topology.txt}     | 81 ++++++++++++++++++----
>>   1 file changed, 67 insertions(+), 14 deletions(-)
>>   rename Documentation/devicetree/bindings/{arm/topology.txt => cpu/cpu-topology.txt} (86%)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/topology.txt b/Documentation/devicetree/bindings/cpu/cpu-topology.txt
>> similarity index 86%
>> rename from Documentation/devicetree/bindings/arm/topology.txt
>> rename to Documentation/devicetree/bindings/cpu/cpu-topology.txt
>> index 66848355..1de6fbce 100644
>> --- a/Documentation/devicetree/bindings/arm/topology.txt
>> +++ b/Documentation/devicetree/bindings/cpu/cpu-topology.txt
>> @@ -1,12 +1,12 @@
>>   ===========================================
>> -ARM topology binding description
>> +CPU topology binding description
>>   ===========================================
>>   
>>   ===========================================
>>   1 - Introduction
>>   ===========================================
>>   
>> -In an ARM system, the hierarchy of CPUs is defined through three entities that
>> +In a SMP system, the hierarchy of CPUs is defined through three entities that
>>   are used to describe the layout of physical CPUs in the system:
>>   
>>   - socket
>> @@ -14,9 +14,6 @@ are used to describe the layout of physical CPUs in the system:
>>   - core
>>   - thread
>>   
>> -The cpu nodes (bindings defined in [1]) represent the devices that
>> -correspond to physical CPUs and are to be mapped to the hierarchy levels.
>> -
>>   The bottom hierarchy level sits at core or thread level depending on whether
>>   symmetric multi-threading (SMT) is supported or not.
>>   
>> @@ -25,33 +22,37 @@ threads existing in the system and map to the hierarchy level "thread" above.
>>   In systems where SMT is not supported "cpu" nodes represent all cores present
>>   in the system and map to the hierarchy level "core" above.
>>   
>> -ARM topology bindings allow one to associate cpu nodes with hierarchical groups
>> +CPU topology bindings allow one to associate cpu nodes with hierarchical groups
>>   corresponding to the system hierarchy; syntactically they are defined as device
>>   tree nodes.
>>   
>> -The remainder of this document provides the topology bindings for ARM, based
>> -on the Devicetree Specification, available from:
>> +Currently, only ARM/RISC-V intend to use this cpu topology binding but it may be
>> +used for any other architecture as well.
>>   
>> -https://www.devicetree.org/specifications/
>> +The remainder of this document provides the topology bindings for ARM/RISC-V, based
> 
> You already said who are current users, why restrict it to ARM and
> RISC-V here?
> 
I will remove that. The examples are only for ARM/RISC-V specific.


>> +on the Devicetree Specification, available at [4].
>> +
>> +The cpu nodes (bindings defined in [1] for ARM or [2] for RISC-V) represent the devices that
>> +correspond to physical CPUs and are to be mapped to the hierarchy levels.
> 
> The cpu topology isn't dependent on anything beyond what the DT spec
> says for cpu nodes so I think this can be simplified to just refer to
> the spec.
> 

ok sure.

> Plus, shouldn't [2] (numa) be [3] here.
> 

My bad.

>>   If not stated otherwise, whenever a reference to a cpu node phandle is made its
>>   value must point to a cpu node compliant with the cpu node bindings as
>> -documented in [1].
>> +documented in [1] or [3] for respective ISA.
>>   A topology description containing phandles to cpu nodes that are not compliant
>> -with bindings standardized in [1] is therefore considered invalid.
>> +with bindings standardized in [1] or [3] is therefore considered invalid.
>>   
>>   ===========================================
>>   2 - cpu-map node
>>   ===========================================
>>   
>> -The ARM CPU topology is defined within the cpu-map node, which is a direct
>> +The ARM/RISC-V CPU topology is defined within the cpu-map node, which is a direct
>>   child of the cpus node and provides a container where the actual topology
>>   nodes are listed.
>>   
>>   - cpu-map node
>>   
>> -	Usage: Optional - On ARM SMP systems provide CPUs topology to the OS.
>> -			  ARM uniprocessor systems do not require a topology
>> +	Usage: Optional - On SMP systems provide CPUs topology to the OS.
>> +			  Uniprocessor systems do not require a topology
>>   			  description and therefore should not define a
>>   			  cpu-map node.
>>   
>> @@ -494,8 +495,60 @@ cpus {
>>   	};
>>   };
>>   
>> +Example 3: HiFive Unleashed (RISC-V 64 bit, 4 core system)
>> +
>> +cpus {
>> +	#address-cells = <2>;
>> +	#size-cells = <2>;
>> +	compatible = "sifive,fu540g", "sifive,fu500";
>> +	model = "sifive,hifive-unleashed-a00";
> 
> This is wrong. Looks like the root node, but called 'cpus'.
> 
Yeah it got mixed up. I will fix it in v2.

>> +
>> +	...
>> +
>> +	cpu-map {
>> +		cluster0 {
>> +			core0 {
>> +				cpu = <&L12>;
>> +		 	};
> 
> Mixed space and tabs.
> 
>> +			core1 {
>> +				cpu = <&L15>;
>> +			};
>> +			core2 {
>> +				cpu0 = <&L18>;
>> +			};
>> +			core3 {
>> +				cpu0 = <&L21>;
>> +			};
>> +		};
>> + 	};
> 
> Mixed space and tab.
> 

Sorry. I will fix this.

Thanks for the review.

Regards,
Atish

>> +
>> +	L12: cpu@1 {
>> +		device_type = "cpu";
>> +		compatible = "sifive,rocket0", "riscv";
>> +		reg = <0x1>;
>> +	}
>> +
>> +	L15: cpu@2 {
>> +		device_type = "cpu";
>> +		compatible = "sifive,rocket0", "riscv";
>> +		reg = <0x2>;
>> +	}
>> +	L18: cpu@3 {
>> +		device_type = "cpu";
>> +		compatible = "sifive,rocket0", "riscv";
>> +		reg = <0x3>;
>> +	}
>> +	L21: cpu@4 {
>> +		device_type = "cpu";
>> +		compatible = "sifive,rocket0", "riscv";
>> +		reg = <0x4>;
>> +	}
>> +};
>>   ===============================================================================
>>   [1] ARM Linux kernel documentation
>>       Documentation/devicetree/bindings/arm/cpus.txt
>>   [2] Devicetree NUMA binding description
>>       Documentation/devicetree/bindings/numa.txt
>> +[3] RISC-V Linux kernel documentation
>> +    Documentation/devicetree/bindings/riscv/cpus.txt
>> +[4] https://www.devicetree.org/specifications/
>> -- 
>> 2.7.4
>>
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
