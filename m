From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 6 Sep 2010 19:09:44 +0800
Subject: Colibri PXA320 Power management question
In-Reply-To: <20100906101320.GD10367@rakim.wolfsonmicro.main>
References: <AANLkTik_6ziPZwV9EuZwE4SMtJoc10JrBZZ_-mmsuy5a@mail.gmail.com>
	<20100902142203.GA8381@sirena.org.uk> <4C7FB7B5.2010301@compulab.co.il>
	<20100902152705.GC5809@rakim.wolfsonmicro.main>
	<4C7FC606.20904@compulab.co.il>
	<20100906101320.GD10367@rakim.wolfsonmicro.main>
Message-ID: <AANLkTin3=pVMpSjtof_mLtMQGL-84qJZMCnfb-0xKfab@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 6, 2010 at 6:13 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, Sep 02, 2010 at 06:43:02PM +0300, Mike Rapoport wrote:
>> Mark Brown wrote:
>
>> >Yes, exactly - what I'm saying is that Linux is set up to use cpufreq
>> >rather than rely on the built in stuff.
>
>> There's no contradiction here. The PXA3XX cpufreq implementation
>> could trigger automatic voltage scaling.
>
> That'd be slightly entertaining, though, since IIRC the hardware
> implementation isn't really set up for being constrained - it doesn't
> expect to be cooperating with software governors.
>

It doesn't need to. There is actually an internal command table, and
not really sure about the mapping scheme though, but when software
then has only to care about the frequencies, and voltages will be
adjusted accordingly.

In the other hand, such hardcoded mechanism won't work very well
with incompatible power management ICs, so if there is such a
platform, we do need a way to fall back to using regulators.

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
