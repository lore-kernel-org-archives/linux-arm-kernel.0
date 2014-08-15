From: galak@codeaurora.org (Kumar Gala)
Date: Fri, 15 Aug 2014 08:35:34 -0500
Subject: [PATCH 3/6] Documentation: DT: Add entry for FSL Management
 Complex
In-Reply-To: <20140815110020.GC15621@leverpostej>
References: <1408096156-29772-1-git-send-email-bhupesh.sharma@freescale.com>
 <1408096156-29772-4-git-send-email-bhupesh.sharma@freescale.com>
 <20140815110020.GC15621@leverpostej>
Message-ID: <21CA0EC7-3711-4B13-991B-940EF576D2EF@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Aug 15, 2014, at 6:00 AM, Mark Rutland <mark.rutland@arm.com> wrote:

> [devicetree-discuss is no more, fixing up to devicetree at vger.kernel.org]
> 
> Hi,
> 
> On Fri, Aug 15, 2014 at 10:49:12AM +0100, Bhupesh Sharma wrote:
>> This patch adds a devicetree binding documentation for FSL's
>> Management Complex.
>> 
>> Management Complex is a hardware resource manager that manages
>> specialized hardware objects used in network-oriented packet
>> processing applications
>> 
>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
>> Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
>> Signed-off-by: J. German Rivera <German.Rivera@freescale.com>
>> ---
>> .../devicetree/bindings/misc/fsl,qoriq-mc.txt      |   40 ++++++++++++++++++++

I?d probably start this off in bindings/soc/fsl/

>> 1 file changed, 40 insertions(+)
>> create mode 100644 Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
>> 
>> diff --git a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
>> new file mode 100644
>> index 0000000..608529e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
>> @@ -0,0 +1,40 @@
>> +* Freescale Management Complex
>> +
>> +The Freescale Management Complex (fsl-mc) is a hardware resource
>> +manager that manages specialized hardware objects used in
>> +network-oriented packet processing applications.  After the fsl-mc
>> +block is enabled, pools of hardware resources are available, such as
>> +queues, buffer pools, I/O interfaces.  These resources are building
>> +blocks that can be used to create functional hardware objects/devices
>> +such as network interfaces, crypto accelerator instances, L2 switches,
>> +etc.
>> +
>> +Required properties:
>> +
>> +    - compatible
>> +        Value type: <string>
>> +        Definition: Must be "fsl,qoriq-mc".  A Freescale Management Complex
>> +                    compatible with this binding must have Block Revision
>> +                    Registers BRR1 and BRR2 at offset 0x0BF8 and 0x0BFC in
>> +                    the MC control register region.

Hmm, this BRR1/BRR2 comments are a little odd, if we keep those, we should probably
also state what value is BRR1 (I think that was the one that contented the IP ID).

>> +
>> +    - reg
>> +        Value type: <prop-encoded-array>
>> +        Definition: A standard property.  Specifies one or two regions
>> +                    defining the MC's registers:
>> +
>> +                       -the first region is the command portal for the
>> +                        this machine and must always be present
>> +
>> +                       -the second region is the MC control registers. This
>> +                        region may not be present in some scenarios, such
>> +                        as in the device tree presented to a virtual machine.

Should we distinguish the second case w/a different compat?  It seems like a major driver change if the second region isn?t there, or a different driver?

> 
> This looks extremely simple. Is this unit self-contained or does it
> relate to other blocks which will be described separately?
> 
>> +
>> +Example:
>> +
>> +        fsl_mc: fsl-mc at 80c000000 {
>> +                compatible = "fsl,qoriq-mc";
>> +                reg = <0x00000008 0x0c000000 0 0x40        // MC portal base
>> +                       0x00000000 0x08340000 0 0x40000 >;  // MC control reg
> 
> Nit: could we bracket list entries individually please?
> 
> Thanks,
> Mark.
> 
> _______________________________________________

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
