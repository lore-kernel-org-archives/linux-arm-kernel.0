From: eric@anholt.net (Eric Anholt)
Date: Fri, 04 Mar 2016 10:55:03 -0800
Subject: [PATCH 2/2] ARM: bcm2835: Add devicetree for the Raspberry Pi 3.
In-Reply-To: <20160304184136.GB5033@leverpostej>
References: <1457116769-8567-1-git-send-email-eric@anholt.net>
 <1457116769-8567-2-git-send-email-eric@anholt.net>
 <20160304184136.GB5033@leverpostej>
Message-ID: <874mcm3wfs.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Rutland <mark.rutland@arm.com> writes:

> On Fri, Mar 04, 2016 at 10:39:29AM -0800, Eric Anholt wrote:
>> For now this doesn't support the new hardware present on the Pi 3 (BT,
>> wifi, GPIO expander).  Since the GPIO expander isn't supported, we
>> also don't have the LEDs like the other board files do.
>> 
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>> ---
>>  arch/arm/boot/dts/Makefile            |  3 +-
>>  arch/arm/boot/dts/bcm2837-rpi-3-b.dts | 22 ++++++++++++
>>  arch/arm/boot/dts/bcm2837.dtsi        | 68 +++++++++++++++++++++++++++++++++++
>>  3 files changed, 92 insertions(+), 1 deletion(-)
>>  create mode 100644 arch/arm/boot/dts/bcm2837-rpi-3-b.dts
>>  create mode 100644 arch/arm/boot/dts/bcm2837.dtsi
>
>> +	timer {
>> +		compatible = "arm,armv7-timer";
>> +		interrupt-parent = <&local_intc>;
>> +		interrupts = <0>, // PHYS_SECURE_PPI
>> +			     <1>, // PHYS_NONSECURE_PPI
>> +			     <3>, // VIRT_PPI
>> +			     <2>; // HYP_PPI
>> +		always-on;
>> +	};
>
> Are the CPUs in an always-on power domain? Or is it jsut that the kernel
> doesn't perform power management of CPUs?
>
> The always-on proeprty is only intended for the former.

The kernel doesn't get to do power management of CPUs.  We only have
control of power domains through the firmware, and the firmware's
keeping the CPU domain on.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160304/c7198bc2/attachment.sig>
