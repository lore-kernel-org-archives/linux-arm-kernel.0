From: Suravee.Suthikulpanit@amd.com (Suthikulpanit, Suravee)
Date: Fri, 21 Nov 2014 14:40:14 +0000
Subject: [PATCH V3] arm64: amd-seattle: Adding device tree for AMD
 Seattle platform
In-Reply-To: <546F36D3.4090008@arm.com>
Message-ID: <D0955C2B.9B22%suravee.suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/21/14, 19:57, "Marc Zyngier" <marc.zyngier@arm.com> wrote:

>>+	gic: interrupt-controller at e1101000 {
>>+		compatible = "arm,gic-400", "arm,cortex-a15-gic";
>>+		interrupt-controller;
>>+		#interrupt-cells = <3>;
>>+		#address-cells = <2>;
>>+		#size-cells = <2>;
>>+		reg = <0x0 0xe1110000 0 0x1000>,
>>+		      <0x0 0xe112f000 0 0x2000>,
>>+		      <0x0 0xe1140000 0 0x10000>,
>>+		      <0x0 0xe1160000 0 0x10000>;
>>+		interrupts = <1 8 0xf04>;
>
>Are you sure about this one? ARM systems usually have this wired on PPI9
>(interrupt 25)...
>
>Thanks,
>
>	M.

I think you might be right. GIC-400 TRM says that this is should be 25,
and used 
for virtual maintenance interrupts. How can I verify this in Linux? KVM?

Thanks,

Suravee
