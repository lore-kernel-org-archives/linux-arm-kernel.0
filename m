From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 8 Jun 2017 13:07:59 +0100
Subject: [PATCH v2 1/6] dt-bindings: interrupt-controller: add DT binding
 for the Marvell GICP
In-Reply-To: <20170607222420.perbnsnmizhyl42f@rob-hp-laptop>
References: <1496398017-6487-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1496398017-6487-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20170607222420.perbnsnmizhyl42f@rob-hp-laptop>
Message-ID: <aee1c1d9-eb59-b17f-27b8-e0529d69945f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/06/17 23:24, Rob Herring wrote:
> On Fri, Jun 02, 2017 at 12:06:52PM +0200, Thomas Petazzoni wrote:
>> This commit adds the Device Tree binding documentation for the Marvell
>> GICP, an extension to the GIC that allows to trigger GIC SPI interrupts
>> using memory transactions. It is used by the ICU unit in the Marvell
>> CP110 block to turn wired interrupts inside the CP into SPI interrupts
>> at the GIC level in the AP.
> 
> Sounds like an MSI block?

Almost. It also allows to deal with level interrupts, which a classic
MSI controller cannot manage. This looks like it has been lifted from
the GICv3 spec, which offers the exact same mechanism for SPIs.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
