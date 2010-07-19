From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Mon, 19 Jul 2010 19:57:52 +0900
Subject: [PATCH 5/5] ARM: S5PV210: Initial CPUFREQ Support
In-Reply-To: <20100719090914.GC15693@rakim.wolfsonmicro.main>
References: <1279184768-28971-5-git-send-email-myungjoo.ham@samsung.com>
	<1279184768-28971-6-git-send-email-myungjoo.ham@samsung.com>
	<20100715115942.GA15919@sirena.org.uk>
	<AANLkTinrrXlh1GQ178_NzwWt5luO_1mdfIGy6G2ZNbPH@mail.gmail.com>
	<20100716081707.GA9082@rakim.wolfsonmicro.main>
	<AANLkTikYX6N7q3lT5ZzXh3RQnGss39eGhSrfC9blqoF_@mail.gmail.com>
	<20100716084231.GF9082@rakim.wolfsonmicro.main>
	<AANLkTikNCOjOSVlcBv99DuJEdPtQHmKpC8Cs60rQz1r3@mail.gmail.com>
	<20100716093710.GH9082@rakim.wolfsonmicro.main>
	<AANLkTine-RPFqd1zp-vu4xRaidhngU0t3hC3SP_bXfWw@mail.gmail.com>
	<20100719090914.GC15693@rakim.wolfsonmicro.main>
Message-ID: <AANLkTilG55F4mGjckrq3tVzLMI88SSBX-FetqZxSEdTR@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 19, 2010 at 6:09 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Jul 19, 2010 at 09:40:24AM +0900, MyungJoo Ham wrote:
>
>> Uh oh.. I didn't mean that the default ramp time is the "required" or
>> "suggested" by the PMIC, but I meant that it is required by the CPU to
>> execute instructions without possible CPU lockups due to lower voltage
>
> You're still missing my point here. ?What I'm saying is that by using
> the slower default ramp rate of the PMIC you're making the length of the
> stall in execution introduced by waiting for the ramp to complete more
> severe than it needs to be, thus increasing the impact on the system and
> the need to do work in software to mitigate that. ?Reducing the ramp
> time should result in improved system performance.
>


Sure. reducing RAMP delay results in higher performance. I was only
stating that we need RAMP delay anyway. I'd let PMIC driver to set the
RAMP delay minimal or let the board file state the RAMP delay value
for the driver to initialise.


Thanks.


> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>



-- 
MyungJoo Ham (???), Ph.D.
Mobile Software Platform Lab,
Digital Media and Communications (DMC) Business
Samsung Electronics
cell: 82-10-6714-2858
