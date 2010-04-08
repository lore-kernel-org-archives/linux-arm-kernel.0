From: jakob.viketoft@bitsim.com (Jakob Viketoft)
Date: Thu, 08 Apr 2010 17:07:25 +0200
Subject: AC97 problems with pxa...
In-Reply-To: <20100408144414.GA29288@rakim.wolfsonmicro.main>
References: <201004070950.37809.marek.vasut@gmail.com>	<4BBC5254.7040200@bitsim.com>	<20100407095449.GA13576@rakim.wolfsonmicro.main>	<4BBD9F28.9080804@bitsim.com>	<20100408095415.GC6303@rakim.wolfsonmicro.main>	<4BBDD480.8020708@bitsim.com>	<20100408134946.GD30647@rakim.wolfsonmicro.main>	<4BBDE2BD.6000708@bitsim.com>	<20100408141247.GE30647@rakim.wolfsonmicro.main>	<4BBDE9B7.8080502@bitsim.com>
	<20100408144414.GA29288@rakim.wolfsonmicro.main>
Message-ID: <4BBDF12D.5030302@bitsim.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Mark Brown wrote:
> On Thu, Apr 08, 2010 at 04:35:35PM +0200, Jakob Viketoft wrote:
> 
>> I had moved the platform_add_devices call in the board init file
>> while tracking. Moving it back up a few lines in the code make my
>> machine driver pop up as the sound card. Is this the correct
> 
> You shouldn't be registering the soc-audio device in arch/arm at all.

I don't, so no worries there. I just register my colibri-v2-asoc machine 
driver device.

> 
>> behaviour? As suggested I have added the asoc device to my machine
>> driver to look more like the palmtx is doing things. Does this mean
>> I'm down to finding the right setting with amixer to get things
>> running? New debug output:
> 
> It appears so, yes.

I finally got it working, thanks for all the help! Will be posting a 
patch after cleanup and when the rest of the system is working.

> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
