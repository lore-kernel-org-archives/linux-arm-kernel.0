From: wmb@firmworks.com (Mitch Bradley)
Date: Wed, 19 Sep 2012 22:40:40 +0800
Subject: [PATCH V6 1/2] of: Add generic device tree DMA helpers
In-Reply-To: <201209191109.16529.arnd@arndb.de>
References: <1347662517-4210-1-git-send-email-jon-hunter@ti.com>
 <201209172042.11860.arnd@arndb.de> <5058F35A.8040702@firmworks.com>
 <201209191109.16529.arnd@arndb.de>
Message-ID: <5059D968.4010709@firmworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/19/2012 7:09 PM, Arnd Bergmann wrote:
> On Tuesday 18 September 2012, Mitch Bradley wrote:
>> There is a delicious irony here with respect to Shark.  Shark has real
>> Open Firmware.  It's the platform that I used for the first OFW port to
>> ARM.  We (the Shark design team) had a version of NetBSD that would run
>> on Shark without any native drivers, calling into the Open Firmware
>> drivers.  It was very useful for bringup.
> 
> Very interesting, thanks for sharing this bit of history. Are you aware
> of other ARM systems using open firmware that we still support in Linux
> (besides the XO-1.75)?

There is the successor to the XO-1.75 that we working on now.  I don't
know of any others.  We just did a big push to convert a bunch of
drivers to DT so we will able to use the same kernel on XO-1.75 and
XO-4.  The conversion went pretty smoothly, but there is still a fair
amount of testing, integration, and coordination to do.  When things get
a bit less hectic, we'll start submitting patches.

> 
>> Is there ever a point when old architectures leave the Linux tree, or
>> will people have to see grep hits from them until the end of time?
> 
> As long as someone is interested in keeping an architecture or driver
> alive, it stays. If something is causing problems and we have reason
> to assume it will never be used again with current kernels, we toss
> them out. Russell has recently removed support for ARMv3 CPUs, but
> some of the StrongARM targets (especially SA-1100) are still being
> actively used, so the CPU support is not going away any time soon.
> 
> If you have a bunch of Shark machines for testing and would like to
> port it over to device tree passing from its open firmware, you are
> definitely welcome ;-)

I'm too busy working on new machines :-)  Old machines are an exercise
in frustration, due to hardware that stops working over time and
insufficient hardware resources to meet the expectations of modern
software.  Not to mention the financial advantages of doing work that
someone cares about ...

> 
> 	Arnd
> 
