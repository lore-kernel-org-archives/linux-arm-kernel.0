From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 14 Jan 2015 16:37:49 +0100
Subject: [PATCH RESEND 1/4] ARM: dts: Add power and lid GPIO keys pinctrl
 for exynos5250-snow
In-Reply-To: <54B688A6.9090902@kernel.org>
References: <1420212257-22443-1-git-send-email-javier.martinez@collabora.co.uk>
 <1420212257-22443-2-git-send-email-javier.martinez@collabora.co.uk>
 <54B688A6.9090902@kernel.org>
Message-ID: <54B68D4D.2040309@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Kukjin,

On 01/14/2015 04:17 PM, Kukjin Kim wrote:
>>  
>>  &pinctrl_0 {
>> +	power_key_irq: power-key-irq {
>> +		samsung,pins = "gpx1-3";
>> +		samsung,pin-function = <0xf>;
> 
> I think, this setting should be same with exynos5250-spring but different.
> 
> from: arch/arm/boot/dts/exynos5250-spring.dts
> 491         power_key_irq: power-key-irq {
> 492                 samsung,pins = "gpx1-3";
> 493                 samsung,pin-function = <0>;
> 494                 samsung,pin-pud = <0>;
> 495                 samsung,pin-drv = <0>;
> 496         };
> 
> Hmm...0xf should be correct so need to fix the spring DT?
> 

Yes, the same problem has exynos5250-snow.dts. This is less relevant now
after commit f6a8249f9e55 ("pinctrl: exynos: Lock GPIOs as interrupts
when used as EINTs") that moved the pinmux reconfiguration to
.irq_{request,release}_resources() preventing the pads to be reconfigured
as regulator input/output.

But still for correctness we should audit spring / snow and change to 0xf.

Best regards,
Javier
