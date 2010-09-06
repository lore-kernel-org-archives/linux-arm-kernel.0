From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 6 Sep 2010 19:42:18 +0800
Subject: Colibri PXA320 Power management question
In-Reply-To: <20100906113036.GG10367@rakim.wolfsonmicro.main>
References: <AANLkTik_6ziPZwV9EuZwE4SMtJoc10JrBZZ_-mmsuy5a@mail.gmail.com>
	<20100902142203.GA8381@sirena.org.uk>
	<4C7FB7B5.2010301@compulab.co.il>
	<20100902152705.GC5809@rakim.wolfsonmicro.main>
	<4C7FC606.20904@compulab.co.il>
	<20100906101320.GD10367@rakim.wolfsonmicro.main>
	<AANLkTin3=pVMpSjtof_mLtMQGL-84qJZMCnfb-0xKfab@mail.gmail.com>
	<20100906113036.GG10367@rakim.wolfsonmicro.main>
Message-ID: <AANLkTinoHZJTjGTAciiTwuEALiL9GmU9phRO9CgrcgXa@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 6, 2010 at 7:30 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Sep 06, 2010 at 07:09:44PM +0800, Eric Miao wrote:
>> On Mon, Sep 6, 2010 at 6:13 PM, Mark Brown
>
>> > That'd be slightly entertaining, though, since IIRC the hardware
>> > implementation isn't really set up for being constrained - it doesn't
>> > expect to be cooperating with software governors.
>
>> It doesn't need to. There is actually an internal command table, and
>> not really sure about the mapping scheme though, but when software
>> then has only to care about the frequencies, and voltages will be
>> adjusted accordingly.
>
> Ah, I'm misremembering the PXA implementation for the i.MX one - the
> i.MX version of this feature had a governor rather than just doing a
> lookup from the frequency to a voltage.
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

I think that the key isn't scaling voltage. We can enable both
auto-scaling (hardware) and software-scaling voltage in cpufreq
driver. The key point is that device may occur fails while scaling
frequency in device working mode. I remember that cpufreq doesn't care
about this behavior.
