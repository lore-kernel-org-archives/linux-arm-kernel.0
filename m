Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBEAC6783B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:31:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F7AA20839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UNBhfa5s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F7AA20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cuajt0Ok1DJi7iZJ9wiVjxF48PLLmwBqdxDcdPCzeN4=; b=UNBhfa5s02pbFl
	4LP2EHJb/MY+ug4gh11KwYy/89JBqlYvmWPfM9GY+xcbvLGfVjk/lYSfku2cwQ4c5zlMaAGkBLjOn
	lPaKCO/R8wTBrANNCiaAZZdwQbHMEnoFWx8pBESvKm3BqjF1qN1CnjYoEbIQ6Q9TaDi2W1rbeXfD4
	CX5Kctqb2dmWiswIaI4jh6MWvcuzS/ai5g2rRtXELsLg/3yiO/1XI5Z5MBjAXu/xUGfWeZj5tkJTR
	Yb3NrfTsZw+QWqn+DsIk0XtFcbgczMoDHAU3vP/ap8oPS1kb689IwutC9nQG18G2sIAuAq7L3RK6t
	FzoWkAeqoFhkpYuCOHrg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWuJI-0004J9-Qh; Wed, 12 Dec 2018 02:31:40 +0000
Received: from mail-oi1-f196.google.com ([209.85.167.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWuJE-0004IP-SA; Wed, 12 Dec 2018 02:31:38 +0000
Received: by mail-oi1-f196.google.com with SMTP id i6so13828595oia.6;
 Tue, 11 Dec 2018 18:31:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=JSdQZJweWPk6BAdWHHcAkj2ssa0zPN7sDYIXlGWtClU=;
 b=lWav1Z4zBogHoFoRgwspGrdL+d4ByB+PA7FrmiNCWYF0bKUOrPcyNqHaQTqvfMJX/X
 1Y11CUjcgw77+JS7noIE2t5aFvZudHrGDbi0UTtHDexTJgFQ8pZJav/VxsM3dxfCYgma
 a2TR/Yj0Na8twziZLapECD9ciITxcIWEjD6fzZv89YJofo15tuv+Az5XnQ066EnfQN1g
 sSvrGgruchZLIeNRJ6zfC3vThgMJ91S6FStAClUIO1nil+t7sZJocHYeQa2imS4cNe4z
 9vCHDIf3v5hmSKYCyXVS1YsWYVDElsbOIj+AuapEJL2MTLEdYTOa6ejF06JEr6SXzB5s
 NaWg==
X-Gm-Message-State: AA+aEWYOX9A7+eYaK3dq3iputEKpo2z9v1PtyvAWKZ36lE1F896/foYx
 yjmo8jO08BW3ngECBusFyg==
X-Google-Smtp-Source: AFSGD/WUL+gr1+ZUmzzI/idm/8r5/q6w5+BAYiwGlY05OjIWeXzXSE+UTITJGjVxF5ZsAaRfqSn3vw==
X-Received: by 2002:aca:e3d3:: with SMTP id a202mr2551031oih.79.1544581883988; 
 Tue, 11 Dec 2018 18:31:23 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id f127sm9431995oia.19.2018.12.11.18.31.23
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 11 Dec 2018 18:31:23 -0800 (PST)
Date: Tue, 11 Dec 2018 20:31:22 -0600
From: Rob Herring <robh@kernel.org>
To: Atish Patra <atish.patra@wdc.com>
Subject: Re: [RFT PATCH v1 2/4] dt-binding: cpu-topology: Move cpu-map to a
 common binding.
Message-ID: <20181212023122.GB14213@bogus>
References: <1543534100-3654-1-git-send-email-atish.patra@wdc.com>
 <1543534100-3654-3-git-send-email-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1543534100-3654-3-git-send-email-atish.patra@wdc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_183136_953161_FC9A15DA 
X-CRM114-Status: GOOD (  25.84  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Albert Ou <aou@eecs.berkeley.edu>, Thomas Gleixner <tglx@linutronix.de>,
 Juri Lelli <juri.lelli@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Dmitriy Cherkasov <dmitriy@oss-tech.org>, Anup Patel <anup@brainfault.org>,
 Palmer Dabbelt <palmer@sifive.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Jeremy Linton <jeremy.linton@arm.com>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-riscv@lists.infradead.org,
 Ingo Molnar <mingo@kernel.org>,
 "moderated list:ARM64 PORT \(AARCH64 ARCHITECTURE\)"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 29, 2018 at 03:28:18PM -0800, Atish Patra wrote:
> cpu-map binding can be used to described cpu topology for both
> RISC-V & ARM. It makes more sense to move the binding to document
> to a common place.
> 
> The relevant discussion can be found here.
> https://lkml.org/lkml/2018/11/6/19
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  .../{arm/topology.txt => cpu/cpu-topology.txt}     | 81 ++++++++++++++++++----
>  1 file changed, 67 insertions(+), 14 deletions(-)
>  rename Documentation/devicetree/bindings/{arm/topology.txt => cpu/cpu-topology.txt} (86%)
> 
> diff --git a/Documentation/devicetree/bindings/arm/topology.txt b/Documentation/devicetree/bindings/cpu/cpu-topology.txt
> similarity index 86%
> rename from Documentation/devicetree/bindings/arm/topology.txt
> rename to Documentation/devicetree/bindings/cpu/cpu-topology.txt
> index 66848355..1de6fbce 100644
> --- a/Documentation/devicetree/bindings/arm/topology.txt
> +++ b/Documentation/devicetree/bindings/cpu/cpu-topology.txt
> @@ -1,12 +1,12 @@
>  ===========================================
> -ARM topology binding description
> +CPU topology binding description
>  ===========================================
>  
>  ===========================================
>  1 - Introduction
>  ===========================================
>  
> -In an ARM system, the hierarchy of CPUs is defined through three entities that
> +In a SMP system, the hierarchy of CPUs is defined through three entities that
>  are used to describe the layout of physical CPUs in the system:
>  
>  - socket
> @@ -14,9 +14,6 @@ are used to describe the layout of physical CPUs in the system:
>  - core
>  - thread
>  
> -The cpu nodes (bindings defined in [1]) represent the devices that
> -correspond to physical CPUs and are to be mapped to the hierarchy levels.
> -
>  The bottom hierarchy level sits at core or thread level depending on whether
>  symmetric multi-threading (SMT) is supported or not.
>  
> @@ -25,33 +22,37 @@ threads existing in the system and map to the hierarchy level "thread" above.
>  In systems where SMT is not supported "cpu" nodes represent all cores present
>  in the system and map to the hierarchy level "core" above.
>  
> -ARM topology bindings allow one to associate cpu nodes with hierarchical groups
> +CPU topology bindings allow one to associate cpu nodes with hierarchical groups
>  corresponding to the system hierarchy; syntactically they are defined as device
>  tree nodes.
>  
> -The remainder of this document provides the topology bindings for ARM, based
> -on the Devicetree Specification, available from:
> +Currently, only ARM/RISC-V intend to use this cpu topology binding but it may be
> +used for any other architecture as well.
>  
> -https://www.devicetree.org/specifications/
> +The remainder of this document provides the topology bindings for ARM/RISC-V, based

You already said who are current users, why restrict it to ARM and 
RISC-V here?

> +on the Devicetree Specification, available at [4].
> +
> +The cpu nodes (bindings defined in [1] for ARM or [2] for RISC-V) represent the devices that
> +correspond to physical CPUs and are to be mapped to the hierarchy levels.

The cpu topology isn't dependent on anything beyond what the DT spec 
says for cpu nodes so I think this can be simplified to just refer to 
the spec.

Plus, shouldn't [2] (numa) be [3] here.

>  If not stated otherwise, whenever a reference to a cpu node phandle is made its
>  value must point to a cpu node compliant with the cpu node bindings as
> -documented in [1].
> +documented in [1] or [3] for respective ISA.
>  A topology description containing phandles to cpu nodes that are not compliant
> -with bindings standardized in [1] is therefore considered invalid.
> +with bindings standardized in [1] or [3] is therefore considered invalid.
>  
>  ===========================================
>  2 - cpu-map node
>  ===========================================
>  
> -The ARM CPU topology is defined within the cpu-map node, which is a direct
> +The ARM/RISC-V CPU topology is defined within the cpu-map node, which is a direct
>  child of the cpus node and provides a container where the actual topology
>  nodes are listed.
>  
>  - cpu-map node
>  
> -	Usage: Optional - On ARM SMP systems provide CPUs topology to the OS.
> -			  ARM uniprocessor systems do not require a topology
> +	Usage: Optional - On SMP systems provide CPUs topology to the OS.
> +			  Uniprocessor systems do not require a topology
>  			  description and therefore should not define a
>  			  cpu-map node.
>  
> @@ -494,8 +495,60 @@ cpus {
>  	};
>  };
>  
> +Example 3: HiFive Unleashed (RISC-V 64 bit, 4 core system)
> +
> +cpus {
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +	compatible = "sifive,fu540g", "sifive,fu500";
> +	model = "sifive,hifive-unleashed-a00";

This is wrong. Looks like the root node, but called 'cpus'.

> +
> +	...
> +
> +	cpu-map {
> +		cluster0 {
> +			core0 {
> +				cpu = <&L12>;
> +		 	};

Mixed space and tabs.

> +			core1 {
> +				cpu = <&L15>;
> +			};
> +			core2 {
> +				cpu0 = <&L18>;
> +			};
> +			core3 {
> +				cpu0 = <&L21>;
> +			};
> +		};
> + 	};

Mixed space and tab.

> +
> +	L12: cpu@1 {
> +		device_type = "cpu";
> +		compatible = "sifive,rocket0", "riscv";
> +		reg = <0x1>;
> +	}
> +
> +	L15: cpu@2 {
> +		device_type = "cpu";
> +		compatible = "sifive,rocket0", "riscv";
> +		reg = <0x2>;
> +	}
> +	L18: cpu@3 {
> +		device_type = "cpu";
> +		compatible = "sifive,rocket0", "riscv";
> +		reg = <0x3>;
> +	}
> +	L21: cpu@4 {
> +		device_type = "cpu";
> +		compatible = "sifive,rocket0", "riscv";
> +		reg = <0x4>;
> +	}
> +};
>  ===============================================================================
>  [1] ARM Linux kernel documentation
>      Documentation/devicetree/bindings/arm/cpus.txt
>  [2] Devicetree NUMA binding description
>      Documentation/devicetree/bindings/numa.txt
> +[3] RISC-V Linux kernel documentation
> +    Documentation/devicetree/bindings/riscv/cpus.txt
> +[4] https://www.devicetree.org/specifications/
> -- 
> 2.7.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
