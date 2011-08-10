From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 10 Aug 2011 09:08:56 +0100
Subject: [RFC PATCH 3/3] ARM: gic: add OF based initialization
In-Reply-To: <1312921020-6820-4-git-send-email-robherring2@gmail.com>
References: <1312921020-6820-1-git-send-email-robherring2@gmail.com>
	<1312921020-6820-4-git-send-email-robherring2@gmail.com>
Message-ID: <4E423C98.3040305@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/08/11 21:17, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> This adds gic initialization using device tree data. An example device tree
> binding looks like this:
> 
> intc: interrupt-controller at fff11000 {
>         compatible = "arm,cortex-a9-gic";
>         #interrupt-cells = <1>;
>         interrupt-controller;
>         reg = <0xfff11000 0x1000>,
>               <0xfff10100 0x100>;
> };

I'm afraid I still object to this. PPIs are an important part of the
GIC, and this binding totally ignores the per-cpu aspect.

How do you represent the connection between a CPU local timer and the
GIC? Even worse, how to represent a device connected to only *one* of
the CPUs? PPIs are difficult to represent on the Linux side. But we
shouldn't ignore them in the DT binding.

Cheers,

	M.
-- 
Jazz is not dead. It just smells funny...
