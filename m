From: mike@compulab.co.il (Mike Rapoport)
Date: Mon, 06 Sep 2010 14:06:36 +0300
Subject: Colibri PXA320 Power management question
In-Reply-To: <20100906101320.GD10367@rakim.wolfsonmicro.main>
References: <AANLkTik_6ziPZwV9EuZwE4SMtJoc10JrBZZ_-mmsuy5a@mail.gmail.com>
	<20100902142203.GA8381@sirena.org.uk>
	<4C7FB7B5.2010301@compulab.co.il>
	<20100902152705.GC5809@rakim.wolfsonmicro.main>
	<4C7FC606.20904@compulab.co.il>
	<20100906101320.GD10367@rakim.wolfsonmicro.main>
Message-ID: <4C84CB3C.2020704@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> On Thu, Sep 02, 2010 at 06:43:02PM +0300, Mike Rapoport wrote:
>> Mark Brown wrote:
> 
>>> Yes, exactly - what I'm saying is that Linux is set up to use cpufreq
>>> rather than rely on the built in stuff.
> 
>> There's no contradiction here. The PXA3XX cpufreq implementation
>> could trigger automatic voltage scaling.
> 
> That'd be slightly entertaining, though, since IIRC the hardware
> implementation isn't really set up for being constrained - it doesn't
> expect to be cooperating with software governors.

As far as I remember, PXA3xx power I2C can be setup to automatically send I2C 
command sequence to PMIC upon certain events, such as frequency change, power 
state transition and probably something else. You can enable this behavior and 
then when cpufreq decides to change frequency the voltage should be scaled 
appropriately. No idea, though, if anybody made it work.
Maybe Eric had tried it when he was with Marvell :)

-- 
Sincerely yours,
Mike.
