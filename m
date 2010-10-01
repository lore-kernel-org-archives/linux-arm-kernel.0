From: kmpark@infradead.org (Kyungmin Park)
Date: Fri, 1 Oct 2010 14:40:02 +0900
Subject: [PATCH 3/3] ARM: S5PV210: Add voltage consumer of WM8994 to the
	regulator framework
In-Reply-To: <20101001053139.GE30949@sirena.org.uk>
References: <4CA5623D.3000002@samsung.com>
	<20101001053139.GE30949@sirena.org.uk>
Message-ID: <AANLkTinRgTJdPowTEZX0nix2FR31A-8cVmBUf7n8zdE7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 1, 2010 at 2:31 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, Oct 01, 2010 at 01:23:25PM +0900, Chanwoo Choi wrote:
>
>> Additionally, I explain the constraints of the regulator of WM8994 codec.
>> All these consumer supply of WM8994 codec connected the regulator(VCC_1.8V)
>> on a circuit diagram. "VCC_1.8V" regulator is always enabled, because it is
>> used to many devices on Goni/Aquila board. This is required especially
>
> It would be nicer to connect this to the regulator on the PMIC (I'm
> assuming there is one), even if it is always enabled. ?That said, is the
> PMIC on these boards supported by Linux yet?

FYI: now wm8994 codec is connected to I/O power directly. and there's
no connection with PMIC.
Maybe you mean the I/O power LDO and use it. but it's always on in
case of s5pc110.
and can't turn off the this LDO on max8998 except the sleep.

Thank you,
Kyungmin Park
>
>> when there are many devices physically attached to "VCC_1.8V" and some of
>> they did not "register" as consumers to "VCC_1.8V". "VCC_1.8V" might be
>> turned off by those who are registered while "unregistered" are still active
>
> You can set the always_on flag in the regulator constraints to prevent
> this happening - if that flag is set the supply will be kept active even
> if all consumers are disabled.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
