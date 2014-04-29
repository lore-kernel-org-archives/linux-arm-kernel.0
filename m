From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 29 Apr 2014 11:15:27 +0200
Subject: [PATCH RFC 0/5] Dove PMU support
In-Reply-To: <20140428083144.GB6650@lunn.ch>
References: <20140427132312.GC26756@n2100.arm.linux.org.uk>
 <535E079B.6010701@gmail.com> <20140428083144.GB6650@lunn.ch>
Message-ID: <535F6DAF.1010400@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/28/2014 10:31 AM, Andrew Lunn wrote:
>> Russell,
>>
>> thanks for dropping those patches. I know you are packed with a bunch
>> of other patch sets, so if you agree, I can pick up your Dove related
>> patches and finish them.
>>
>> One thing that comes into my mind is, that we moved Dove DT to
>> mach-mvebu starting with v3.15-rc1 so we need to find a better place
>> for the driver than mach-dove.
>
> Create drivers/pmu ?

Hmm, I see no other folder it could sit in. Maybe, yes.

> The cpufreq driver also needs access to registers within the pmu
> range. Should it be part of pmu.c, or should we export a regmap which
> cpufreq can use?

Not only cpufreq but also pinctrl as the first 16 mpps can have PMU
related functions mapped to them. Syscon should do the trick.

Sebastian
