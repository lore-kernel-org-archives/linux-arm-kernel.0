From: yegor_sub1@visionsystems.de (Yegor Yefremov)
Date: Mon, 27 Dec 2010 16:37:25 +0100
Subject: ks8695_gettimeoffset
In-Reply-To: <20101220193049.GI28157@n2100.arm.linux.org.uk>
References: <4D0FA9FB.3060309@softplc.com>
	<20101220193049.GI28157@n2100.arm.linux.org.uk>
Message-ID: <4D18B2B5.5000001@visionsystems.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 20.12.2010 20:30, schrieb Russell King - ARM Linux:
> On Mon, Dec 20, 2010 at 01:09:47PM -0600, Dick Hollenbeck wrote:
>> >From userspace, printing the return values from a rapid looping
>> sequence of calls to
>>
>>    clock_gettime( CLOCK_MONOTONIC, &now );
>>
>> leads me to believe that kernel function ks8695_gettimeoffset() is
>> not worth anything.
> 
> That'll be because clock_gettime(CLOCK_MONOTONIC) doesn't use the old
> gettimeoffset() method to correct the returned time - none of the POSIX
> timers use the old gettimeoffset() stuff, only gettimeofday() does.
> 
> Platforms really should be using the clocksource/clockevents code
> where ever possible, rather than selecting ARCH_USES_GETTIMEOFFSET.
> 
> Does someone with a KS8695-based platform want to have a go at
> converting it over to clocksource/clockevents?

Is it possible at all to implement clocksource/clockevents for KS8695? As Dick and "Register Description" already said you cannot read the time register, so clocksource->read cannot be implemented to return ticks elapsed. Or do I see it wrong? 

Is there any documentation for clocksource/clockevents? 

Best regards,
Yegor
