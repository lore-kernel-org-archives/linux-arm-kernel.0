From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 6 Jul 2011 18:12:49 -0600
Subject: [RFC PATCH 1/5] OMAP3:I2C: Add device tree nodes for beagle board
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF049E21C203@HQMAIL01.nvidia.com>
References: <1309426647-31587-1-git-send-email-manjugk@ti.com>
	<1309426647-31587-2-git-send-email-manjugk@ti.com>
	<20110706185546.GJ4871@ponder.secretlab.ca>
	<74CDBE0F657A3D45AFBB94109FB122FF049E21C203@HQMAIL01.nvidia.com>
Message-ID: <CACxGe6u8qq7FA7kFXbU5uCk6m_GA8GWLqsdjFCXN+NMJfFKxmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 6, 2011 at 5:26 PM, Stephen Warren <swarren@nvidia.com> wrote:
> Grant Likely wrote at Wednesday, July 06, 2011 12:56 PM:
>> On Thu, Jun 30, 2011 at 03:07:23PM +0500, G, Manjunath Kondaiah wrote:
>> > Add I2C and it's child device nodes for beagle board.
>> > The I2C1 controller child devices are not populated and it
>> > should be handled along with OMAP clock changes.
> ...
>> > diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
> ...
>> > + ? i2c at 48070000 {
> ...
>> > + ? ? ? ? ? clock-frequency = <2600>;
>> > + ? ? ? ? ? status = "disabled";
>>
>> Drop 'status' when you move this node definition to
>> arch/arm/boot/dts/omap3.dtsi. ?Board overlay files that include the
>> omap3.dtsi should explicitly disable any devices that it does not use
>> (which is opposite to what tegra currently does, but I'm going to
>> change that).
>
> Purely out of idle curiosity: What's the benefit of one way over the other?

Mostly consistency.  Most of the experience we have with the flattened
device tree up to this point hasn't bothered with the 'status'
property.  It is only when AMP and hypervisors cam online that it
became important to use a status property, and that only when the
kernel needs to be told that the device does indeed exist, but it must
not be touched.  I'd like to continue that pattern for new DT users
with the default assumption that a device is enabled unless the board
.dts explicitly disables it.

g.
