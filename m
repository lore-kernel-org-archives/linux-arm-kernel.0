From: andre.przywara@arm.com (Andre Przywara)
Date: Tue, 13 Mar 2018 14:05:34 +0000
Subject: [PATCH 3/5] pwm: sun4i: Introduce (optional) reset support
In-Reply-To: <20180307074516.dbak7ztkua4p7mr5@flea.lan>
References: <20180307020719.6675-1-andre.przywara@arm.com>
 <20180307020719.6675-4-andre.przywara@arm.com>
 <20180307074516.dbak7ztkua4p7mr5@flea.lan>
Message-ID: <f001134a-987d-2491-a22e-d1d634f7b024@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

thanks for looking into this and for the Acks!

On 07/03/18 07:45, Maxime Ripard wrote:
> On Wed, Mar 07, 2018 at 02:07:17AM +0000, Andre Przywara wrote:
>> While the PWM IP in the Allwinner H6 SoC is fully compatible to those
>> used in older SoCs (H3, A64), it features a dedicated reset line which
>> needs to be de-asserted.
>> Add support for an optional "resets" DT property in our pwm-sun4i probe
>> routine, and assert and de-assert the reset line, where needed.
>> This allows to enable PWM support on the H6.
> 
> This isn't optional then. It's mandatory on the H6, and unneeded on
> everything else. This is what we should have.

So are you aiming at:
	if (of_device_is_compatible(np, "allwinner,sun50i-h6-pwm")) {
		... devm_reset_control_get() ...

I guess this is preferable over coding something based on a new member
in struct sun4i_pwm_data?

Cheers,
Andre.
