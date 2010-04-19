From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 19 Apr 2010 13:05:55 -0600
Subject: [PATCH v3 1/2] spi: implemented driver for Cirrus EP93xx SPI
	controller
In-Reply-To: <o2g56d259a01004191152w9c2245fdgaa2d4ac1b9e95ed7@mail.gmail.com>
References: <cover.1271156934.git.mika.westerberg@iki.fi>
	<e0e5dc30af89f0b65fd2e5e52f9e7fe9f162516b.1271156934.git.mika.westerberg@iki.fi>
	<n2jfa686aa41004162330qae611a0u87be76ca08bfb52a@mail.gmail.com>
	<20100417110036.GC19534@gw.healthdatacare.com>
	<q2pfa686aa41004191102qc93f09b6m941785b4cb4e32db@mail.gmail.com>
	<o2g56d259a01004191152w9c2245fdgaa2d4ac1b9e95ed7@mail.gmail.com>
Message-ID: <j2hfa686aa41004191205jf61e53ectc994ab0e5a2c4c53@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 19, 2010 at 12:52 PM, Martin Guy <martinwguy@gmail.com> wrote:
> On 4/19/10, Grant Likely <grant.likely@secretlab.ca> wrote:
>> ?>> > + ? ? ? /*
>> ?>> > + ? ? ? ?* Calculate divisors so that we can get speed according the
>> ?>> > + ? ? ? ?* following formula:
>> ?>> > + ? ? ? ?* ? ? ?rate = spi_clock_rate / (cpsr * (1 + scr))
>> ?>> > + ? ? ? ?*
>> ?>> > + ? ? ? ?* cpsr must be even number and starts from 2, scr can be any number
>> ?>> > + ? ? ? ?* between 0 and 255.
>> ?>> > + ? ? ? ?*/
>> ?>> > + ? ? ? for (cpsr = 2; cpsr <= 254; cpsr += 2) {
>> ?>> > + ? ? ? ? ? ? ? for (scr = 0; scr <= 255; scr++) {
>> ?>>
>> ?>> Non-deterministic.
> Eh? Some new meaning of "non-deterministic" that I wasn'f familiar with? :)
>
> Yes, it does look gross, but max clock rate is 3.7Mhz (7.4 in rev E2
> silicon), so if your slowest device is 400kHz, in practice it only
> runs the inner loop from 0 to less than 10.
> How slow do SPI devices go in reality? The 254*256 divisor gives 100Hz.

Fair enough.  s/non-deterministic/gross/  :-p  I just prefer to see
analytic solutions over numerical ones.  :-)  As I said, I won't
object to the driver because of these lines.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
