From: dick@softplc.com (Dick Hollenbeck)
Date: Mon, 20 Dec 2010 13:37:51 -0600
Subject: ks8695_gettimeoffset
In-Reply-To: <20101220193049.GI28157@n2100.arm.linux.org.uk>
References: <4D0FA9FB.3060309@softplc.com>
	<20101220193049.GI28157@n2100.arm.linux.org.uk>
Message-ID: <4D0FB08F.9060007@softplc.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/20/2010 01:30 PM, Russell King - ARM Linux wrote:
> On Mon, Dec 20, 2010 at 01:09:47PM -0600, Dick Hollenbeck wrote:
>> >From userspace, printing the return values from a rapid looping
>> sequence of calls to
>>
>>    clock_gettime( CLOCK_MONOTONIC, &now );
>>
>> leads me to believe that kernel function ks8695_gettimeoffset() is
>> not worth anything.
> That'll be because clock_gettime(CLOCK_MONOTONIC) doesn't use the old
> gettimeoffset() method to correct the returned time - none of the POSIX
> timers use the old gettimeoffset() stuff, only gettimeofday() does.
>
> Platforms really should be using the clocksource/clockevents code
> where ever possible, rather than selecting ARCH_USES_GETTIMEOFFSET.
>
> Does someone with a KS8695-based platform want to have a go at
> converting it over to clocksource/clockevents?

Thanks Russell. 

    As a quick aside, I posted the same question twice because web archive does not show the email
content getting through:

    http://lists.infradead.org/pipermail/linux-arm-kernel/2010-December/035978.html

If no one with more experience in this area steps up, I can do some work on this, but I would need
considerable hand holding since I have not been following the names of these major subsystems within
the kernel as of late. 

Let's wait, and then I may have to raise the issue again if no one steps up.

Dick
