From: b-cousson@ti.com (Cousson, Benoit)
Date: Thu, 25 Aug 2011 15:57:34 +0200
Subject: [RFC PATCH 2/7] arm/dts: Add initial device tree support for
	OMAP4 SoC
In-Reply-To: <4E565004.9050806@gmail.com>
References: <1314181040-22807-1-git-send-email-b-cousson@ti.com>
	<1314181040-22807-3-git-send-email-b-cousson@ti.com>
	<4E565004.9050806@gmail.com>
Message-ID: <4E5654CE.4000303@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 8/25/2011 3:37 PM, Rob Herring wrote:
> Benoit,

[...]

>> +		gic: interrupt-controller at 48241000 {
>> +			compatible = "ti,omap4-gic", "arm,gic";
>
> The gic binding is still being hashed out. This needs binding
> documentation and handling of PPIs. I'm planning on posting an updated
> series today with this.
>
> "arm,gic" should be dropped or replaced with "arm,cortex-a9-gic".
> Non-specific DT bindings are not well received. Is OMAP4 gic different
> from standard Cortex-A9?

Not at all. We named it like that based on Grant's comment:
http://permalink.gmane.org/gmane.linux.ports.arm.omap/60393

I'll update it with the new binding.

>> +			interrupt-controller;
>> +			#interrupt-cells =<1>;
>> +			reg =<0x48241000 0x1000>,
>> +			<0x48240100 0x0200>;
>
> Isn't the cpu interface register space 0x100 bytes long?

I've just checked the spec, and this is indeed 256 bytes. I'll fix that.

Thanks for the comments.

Regards,
Benoit
