Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8CAC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:33:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1DB82087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="azuL6dfG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1DB82087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=obveOgYX1c1jnLsWfWIDr8IukJjO7BwyyxccGUapE8c=; b=azuL6dfGWn+9+m
	62d5Tuqhfmz6pcOnljwICci3xxioK50MuFV7djhZ7a3+aqRY7plpNOwwHXxukjwZJL21anQbJuExU
	xw2TKQrajJUQmRrSDidnBPMR+uhMOxK6qoE8ClEgfBQ4PzsdFENN7YuqelXU+S6A1t9uuL0xPvXZL
	aJRryZnKOCK68+LzppXk5lYjVzIRPvG2MrFEJD4ccOlvzN5eOQosJTG5LKNc4mWu8uJyx37dHOhUG
	G0Bi7K3TMqf/X/M1l+L7VirDrjYFyAkaf8P3sxzHwCjlEa+GaC6WjcqpuEl5+q4BKlvEhh2wEeLs4
	rhdsSYTXBcFk/RPRvsAA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTs69-0005V9-9D; Mon, 03 Dec 2018 17:33:33 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTs65-0005NP-0A; Mon, 03 Dec 2018 17:33:31 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D96311682;
 Mon,  3 Dec 2018 09:33:17 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 56F5D3F59C;
 Mon,  3 Dec 2018 09:33:09 -0800 (PST)
Date: Mon, 3 Dec 2018 17:33:06 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Atish Patra <atish.patra@wdc.com>
Subject: Re: [RFT PATCH v1 2/4] dt-binding: cpu-topology: Move cpu-map to a
 common binding.
Message-ID: <20181203173306.GF17883@e107155-lin>
References: <1543534100-3654-1-git-send-email-atish.patra@wdc.com>
 <1543534100-3654-3-git-send-email-atish.patra@wdc.com>
 <20181203165521.GB17883@e107155-lin>
 <f902086b-09e1-ad85-d191-137708f5b105@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f902086b-09e1-ad85-d191-137708f5b105@wdc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_093329_056818_A4DCB5CC 
X-CRM114-Status: GOOD (  23.11  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 03, 2018 at 09:23:42AM -0800, Atish Patra wrote:
> On 12/3/18 8:55 AM, Sudeep Holla wrote:
> > On Thu, Nov 29, 2018 at 03:28:18PM -0800, Atish Patra wrote:
> > > cpu-map binding can be used to described cpu topology for both
> > > RISC-V & ARM. It makes more sense to move the binding to document
> > > to a common place.
> > > 
> > > The relevant discussion can be found here.
> > > https://lkml.org/lkml/2018/11/6/19
> > > 
> > 
> > Looks good to me apart from a minor query below in the example.
> > 
> > Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> > 
> > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > > ---
> > >   .../{arm/topology.txt => cpu/cpu-topology.txt}     | 81 ++++++++++++++++++----
> > >   1 file changed, 67 insertions(+), 14 deletions(-)
> > >   rename Documentation/devicetree/bindings/{arm/topology.txt => cpu/cpu-topology.txt} (86%)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/arm/topology.txt b/Documentation/devicetree/bindings/cpu/cpu-topology.txt
> > > similarity index 86%
> > > rename from Documentation/devicetree/bindings/arm/topology.txt
> > > rename to Documentation/devicetree/bindings/cpu/cpu-topology.txt
> > > index 66848355..1de6fbce 100644
> > > --- a/Documentation/devicetree/bindings/arm/topology.txt
> > > +++ b/Documentation/devicetree/bindings/cpu/cpu-topology.txt
> > 
> > [...]
> > 
> > > +Example 3: HiFive Unleashed (RISC-V 64 bit, 4 core system)
> > > +
> > > +cpus {
> > > +	#address-cells = <2>;
> > > +	#size-cells = <2>;
> > > +	compatible = "sifive,fu540g", "sifive,fu500";
> > > +	model = "sifive,hifive-unleashed-a00";
> > > +
> > > +	...
> > > +
> > > +	cpu-map {
> > > +		cluster0 {
> > > +			core0 {
> > > +				cpu = <&L12>;
> > > +		 	};
> > > +			core1 {
> > > +				cpu = <&L15>;
> > > +			};
> > > +			core2 {
> > > +				cpu0 = <&L18>;
> > > +			};
> > > +			core3 {
> > > +				cpu0 = <&L21>;
> > > +			};
> > > +		};
> > > + 	};
> > > +
> > > +	L12: cpu@1 {
> > > +		device_type = "cpu";
> > > +		compatible = "sifive,rocket0", "riscv";
> > > +		reg = <0x1>;
> > > +	}
> > > +
> > > +	L15: cpu@2 {
> > > +		device_type = "cpu";
> > > +		compatible = "sifive,rocket0", "riscv";
> > > +		reg = <0x2>;
> > > +	}
> > > +	L18: cpu@3 {
> > > +		device_type = "cpu";
> > > +		compatible = "sifive,rocket0", "riscv";
> > > +		reg = <0x3>;
> > > +	}
> > > +	L21: cpu@4 {
> > > +		device_type = "cpu";
> > > +		compatible = "sifive,rocket0", "riscv";
> > > +		reg = <0x4>;
> > > +	}
> > > +};
> > 
> > The labels for the CPUs drew my attention. Is it intentionally random
> > (or even specific) or just chosen to show anything can be used as labels ?
> 
> SiFive generates the device tree from RTL directly. So I am not sure if they
> assign random numbers or a particular algorithm chooses the label. I tried
> to put the exact ones that is available publicly.
> 
> https://github.com/riscv/riscv-device-tree-doc/blob/master/examples/sifive-hifive_unleashed-microsemi.dts

Cool, love that. So you don't have the problem I was trying to explain.
But I still see the possibility of some other RISC-V vendor copy-pasting
from here ;). Anyways it's left to you.

--
Regards,
Sudeep

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
